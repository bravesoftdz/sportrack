  unit uDatabaseManager;

interface

uses
  DB, ADODB, uDatabaseAccess, uUser, uUserIDs, uGender, uClubStatistics,
  uActivities, uActivity, uActivityType, uTags, uComments, uComment, StrUtils,
  uActivityTypes, uUsers, Dialogs, Windows, uGlobalConstants, Forms;

type
  TDatabaseManager = class(TObject)
    private
      // File Operations

      // Copies a file from one location to another
      procedure CopyFileFromTo(Source, Destination : string);
      // Manages the copying of a user's profile picture
      procedure CopyProfilePicture(var User : TUser);
      // Manages the copying of a user's cover photo
      procedure CopyCoverPhoto(var User : TUser);
      // Gets the file extension from a filename
      function GetFileExtension(FileName : string) : string;

      // Activities

      // Uses a SQL query to return multiple activities
      function QueryMultipleActivities(SQL : string) : TActivities;
      // Uses a SQL query to return a single activity
      function QuerySingleActivity(SQL : string) : TActivity;
      // Uses a few fields from the Activities table to complete the
      // activity object
      function CompleteActivityObject(Fields : TADOQuery) : TActivity;
      // Parses all the data associated with an activity into a single object
      function ParseActivity(Fields : TADOQuery; Tags : TTags;
                             Comments : TComments; Favourites : TUserIDs;
                             ActivityType : TActivityType) : TActivity;

      // ActivityType

      // Uses a SQL query to return a single activity type object
      function QuerySingleActivityType(SQL : string) : TActivityType;
      // Uses a SQL query to return multiple activity types
      function QueryMultipleActivityTypes(SQL : string) : TActivityTypes;

      // Comments

      // Uses a SQL query to return multiple comment objects
      function QueryMultipleComments(SQL : string) : TComments;
      // Uses data inside a TADOQuery object to contstruct a comment
      function ParseComment(Fields : TADOQuery) : TComment;
      // Returns a list of comments belonging to a single activity
      function SelectCommentsByActivityID(ID : integer) : TComments;

      // Favourites

      // Selects a list of UserIDs who liked a certain activity
      function SelectFavouritesByActivityID(ID : integer) : TUserIDs;
      // Uses a SQL query to return multiple UserIDs
      function QueryMultipleUserIDs(SQL : string) : TUserIDs;
      // Checks if a user has liked an activity
      function CheckFavouriteExists(ActivityID, UserID : integer): boolean;

      // UserIDs

      // Uses the values in a TADOQuery to construct an array of TUserIDs
      function ParseUserIDs(Fields : TADOQuery) : TUserIDs;

      // Users

      // Uses a SQL query to return a single user object
      function QuerySingleUserDetails(SQL : string) : TUser;
      // Uses a SQL query to return multiple user objects
      function QueryMultipleUserDetails(SQL : string) : TUsers;
      // Uses fields in a TADOQuery to complete a user object
      function CompleteUserObject(Fields : TADOQuery) : TUser;
      // Takes all the data belonging to a user in parameters and parses them
      // into a user object
      function ParseUser (Fields: TADOQuery; Gender:TGender; Following,
                          Followers : TUserIDs): TUser;

      // Following

      // Checks if a user is following another user
      function CheckFollowing(BusyFollowingUserID, BeingFollowedUserID
                              : integer) : boolean;

      // Tags

      // Uses a SQL query to return multiple tags
      function QueryMultipleTags(SQL : string) : TTags;
      // Inserts a list of tags for a certain activity
      procedure InsertMultipleTags(Tags : TTags; ActivityID : integer);
      // Checks if an activity has a certain tag
      function CheckTagExists(ActivityID : integer; Tag : string) : boolean;

      // Club Statistics
      
      // Uses the fields in a TADOQuery to complete a club statistics object
      function ParseClubStatistics(Fields : TADOQuery) : TClubStatistics;
    public
      // Activities

      // Selects a list of activities from users a user is following or that
      // the user has posted
      function SelectActivitiesByUsersBeingFollowed(User : TUser) : TActivities;
      // Selects N activities that a user has posted
      function SelectNActivitiesByUser(User : TUser; N : byte) : TActivities;
      // Selects activities with tags or titles matching a search term
      function SelectActivitiesByTagOrTitle(SearchTerm : string) : TActivities;
      // Selects an activity with a certain ID
      function SelectActivityByActivityID(ID : integer) : TActivity;
      // Inserts an activity into the database
      procedure InsertActivity(var Activity : TActivity);
      // Updates an existing activity in the database
      procedure UpdateActivity(var Activity : TActivity);
      // Deletes an activity from the database
      procedure DeleteActivity(Activity : TActivity);

      // ActivityType

      // Selects an activity type by its ID
      function SelectActivityTypeByActivityTypeID(ID : integer) : TActivityType;
      // Selects an activity type by its description
      function SelectActivityTypeByDescription(Description : string) 
        : TActivityType;
      // Selects all the activity types in the database
      function SelectAllActivityTypes : TActivityTypes;

      // Users

      // Selects a user by their ID
      function SelectUserByID(ID : integer) : TUser;
      // Selects a user by their email address
      function SelectUserByEmailAddress(EmailAddress : string) : TUser;
      // Selects a user by their username
      function SelectUserByUsername(Username : string) : TUser;
      // Selects a list of users by parts of their username
      function SelectUsersByPartialUsername(PartialUsername : string) : TUsers;
      // Inserts a user into the database
      procedure InsertUser(var User : TUser);
      // Updates a user in the database
      procedure UpdateUser(var User : TUser);

      // Tags

      // Selects tags belonging to an activity
      function SelectTagsByActivityID(ID : integer) : TTags;

      // Club Statistics

      // Selects club statistics from the database
      function SelectClubStatistics : TClubStatistics;

  end; // class  

implementation

uses SysUtils;

{ TDatabaseManager }

function TDatabaseManager.CheckFavouriteExists(ActivityID,
  UserID: integer): boolean;
var
  objDatabaseAccess : TDatabaseAccess;
  sSQL : string;
begin
  // Construct a SQL query to return a result if the favourite exists
  sSQL := 'SELECT 1 FROM Favourites WHERE [ActivityID] = ' + 
          IntToStr(ActivityID) + ' AND [UserID] = ' + IntToStr(UserID);

  // Creates a new instance of the database access
  objDatabaseAccess := TDatabaseAccess.Create;
  // Checks to see if any results were returned
  Result := objDatabaseAccess.RecordExists(sSQL);
  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

function TDatabaseManager.CheckFollowing(BusyFollowingUserID,
  BeingFollowedUserID: integer): boolean;
var
  sSQL : string;
  objDatabaseAccess : TDatabaseAccess;
begin
  // Construct a SQL query to return a result if one user is following another
  sSQL := 'SELECT 1 FROM Following WHERE [BusyFollowingUserID] = ' +
          IntToStr(BusyFollowingUserID) + ' AND [BeingFollowedUserID] = ' +
          IntToStr(BeingFollowedUserID);

  // Creates a new instance of the database access
  objDatabaseAccess := TDatabaseAccess.Create;
  // Checks to see if any results were returned
  Result := objDatabaseAccess.RecordExists(sSQL);
  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

function TDatabaseManager.CheckTagExists(ActivityID: integer;
  Tag: string): boolean;
var
  objDatabaseAccess : TDatabaseAccess;
  sSQL : string;
begin
  // Construct a SQL query to return a result if an activity has a tag. We
  // make use of QuotedStr to escape any ' that may exist in the string
  sSQL := 'SELECT 1 FROM ActivityTags WHERE [ActivityID] = ' + 
          IntToStr(ActivityID) + ' AND [Tag] = ' + QuotedStr(Tag);
  
  // Creates a new instance of the database access
  objDatabaseAccess := TDatabaseAccess.Create;
  // Check to see if any results were returned
  Result := objDatabaseAccess.RecordExists(sSQL);
  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

function TDatabaseManager.CompleteActivityObject(
  Fields: TADOQuery): TActivity;
var
  objActivityType : TActivityType;
  objTags : TTags;
  objComments : TComments;
  objFavourites : TUserIDs;
  iID : integer;
begin
  // Query the activity type using the activity type ID field
  objActivityType := SelectActivityTypeByActivityTypeID(
                       Fields.FieldByName('ActivityTypeID').AsInteger);

  // Get the ID of the activity we are working with
  iID := Fields.FieldByName('ActivityID').AsInteger;

  // Get the tags belonging to the activity
  objTags := SelectTagsByActivityID(iID);

  // Get the comments of the activity
  objComments := SelectCommentsByActivityID(iID);

  // Get the UserIDs who favourited/liked the activity
  objFavourites := SelectFavouritesByActivityID(iID);

  // Use all the data above to construct an activity object and return it
  Result := ParseActivity(Fields, objTags, objComments, objFavourites,
                          objActivityType);
end;

function TDatabaseManager.CompleteUserObject(Fields: TADOQuery): TUser;
var
  objFollowingDatabaseAccess, objFollowersDatabaseAccess : TDatabaseAccess;
  objFollowingResults, objFollowersResults : TADOQuery;
  sFollowingSQL, sFollowersSQL : string;
  objFollowing, objFollowers : TUserIDs;
  objGender : TGender;
begin
  // Create a new instance of the database access class to query users a user
  // is following
  objFollowingDatabaseAccess := TDatabaseAccess.Create;

  // Construct a SQL query to select the UserIDs of all users a user is busy
  // following
  sFollowingSQL := 'SELECT [BeingFollowedUserID] AS [UserID] ' +
                   'FROM Following ' +
                   'WHERE [BusyFollowingUserID] = ' +
                   Fields.FieldByName('UserID').AsString;
  // Execute the query and keep the results
  objFollowingResults:=objFollowingDatabaseAccess.ExecWithResults(sFollowingSQL);
  // Parse the results into an array of UserIDs
  objFollowing := ParseUserIDs(objFollowingResults);

  // Create a new instance of the database access class to query users that
  // are busy following a user
  objFollowersDatabaseAccess := TDatabaseAccess.Create;

  // Construct a SQL query to select the UserIDs of all users following a user
  sFollowersSQL := 'SELECT [BusyFollowingUserID] AS [UserID] ' +
                   'FROM Following ' +
                   'WHERE [BeingFollowedUserID] = ' +
                   Fields.FieldByName('UserID').AsString;
  // Execute the query and keep the results
  objFollowersResults:=objFollowersDatabaseAccess.ExecWithResults(sFollowersSQL);
  // Parse the results into an array of UserIDs
  objFollowers := ParseUserIDs(objFollowersResults);

  // Determine whether the user is male or female and set the enum accordingly
  if Fields.FieldByName('IsMale').AsBoolean then
    objGender := GenderMale
  else
    objGender := GenderFemale;

  // Use the queried data to create a single user object and return it
  Result := ParseUser(Fields, objGender, objFollowing, objFollowers);

  // Clean up our database access
  objFollowingDatabaseAccess.Destroy;
  objFollowersDatabaseAccess.Destroy;
end;

procedure TDatabaseManager.DeleteActivity(Activity: TActivity);
var
  sSQL : string;
  objDatabaseAccess : TDatabaseAccess;
begin
  // Construct a SQL query to delete an activity from the database. Since
  // cascade delete is enabled we only need to delete the activity
  sSQL := 'DELETE FROM Activities WHERE [ActivityID] = ' +
          IntToStr(Activity.GetActivityID);
  
  // Create a database access object to query the database
  objDatabaseAccess := TDatabaseAccess.Create;
  // Execute the delete query
  objDatabaseAccess.Exec(sSQL);
  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

procedure TDatabaseManager.InsertActivity(var Activity: TActivity);
var
  objDatabaseAccess : TDatabaseAccess;
  iID : integer;
  sSQL : string;
begin
  // Construct a SQL query to insert a new activity into the Activities table.
  // We make use of QuotedStr to escape any ' that may be in the string
  sSQL := 'INSERT INTO Activities ([UserID], [ActivityTypeID], ' + 
          '[DateTimeOfActivity], [Duration], [Distance], [Title]) VALUES ' +
          '(' + IntToStr(Activity.GetUserID) + ', ' +
          IntToStr(Activity.GetActivityType.GetActivityTypeID) + ', "' +
          FormatDateTime('yyyy/mm/dd hh:nn:ss', Activity.GetDateTimeOfActivity)+
          '", ' + IntToStr(Activity.GetDuration) + ', ' +
          IntToStr(Activity.GetDistance) + ', ' + QuotedStr(Activity.GetTitle)
          + ')';

  // Create a new instance of our database access class
  objDatabaseAccess := TDatabaseAccess.Create;
  // Execute the insert statement
  objDatabaseAccess.Exec(sSQL);

  // Get the ID that was assigned to the newly inserted activity
  iID := objDatabaseAccess.QueryLastIDUsed;

  // Insert the tags belonging to the activity
  InsertMultipleTags(Activity.GetTags, iID);

  // Create a new activity object that now contains the ID assigned to the
  // activity
  Activity := TActivity.Create(
                iID,
                Activity.GetUserID,
                Activity.GetActivityType,
                Activity.GetDuration,
                Activity.GetDistance,
                Activity.GetTitle,
                Activity.GetDateTimeOfActivity,
                Activity.GetTags,
                TComments.Create,
                TUserIDs.Create);

  // Clean up our database access
  objDatabaseAccess.Destroy;
end;
          
procedure TDatabaseManager.InsertMultipleTags(Tags: TTags;
  ActivityID: integer);
var
  sSQL : string;
  K : shortint;
  objDatabaseAccess : TDatabaseAccess;
begin
  // Creates a new instance of the database access class
  objDatabaseAccess := TDatabaseAccess.Create;

  // Loop through each tag
  for K := 1 to Tags.GetTagCount do
  begin
    // Construct a SQL query to insert the tag into the database. We use
    // QuotedStr to escape any ' that may exist in the string
    sSQL := 'INSERT INTO ActivityTags ([ActivityID], [Tag]) VALUES (' +
            IntToStr(ActivityID) + ', ' + QuotedStr(Tags.GetTag(K)) + ')';
    // Execute the SQL query
    objDatabaseAccess.Exec(sSQL);
  end;

  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

procedure TDatabaseManager.InsertUser(var User: TUser);
var
  sSQL, sGenderToInsert : string;
  iLastID : integer;
  objDatabaseAccess : TDatabaseAccess;
begin
  // Get the gender and assign a string representing true (1) or false (0) 
  // according to Access
  if User.GetGender = GenderMale then
    sGenderToInsert := '1'
  else
    sGenderToInsert := '0';

  // Construct a SQL query to insert a user into the database
  sSQL := 'INSERT INTO Users ([Username], [EmailAddress], [Password], ' +
                             '[DisplayName], [Motto], [DateOfBirth], [IsMale], '+
                             '[Weight], [Height], [ProfilePicture], [CoverPhoto]) '+
          'VALUES (' + QuotedStr(User.GetUsername) +
                   ', ' + QuotedStr(User.GetEmailAddress) + ', ' +
                   QuotedStr(User.GetPassword) +
                   ', ' + QuotedStr(User.GetDisplayName) + ', ' +
                   QuotedStr(User.GetMotto) +
                   ', #' + FormatDateTime('yyyy/mm/dd', User.GetDateOfBirth) +
                   '#, ' + sGenderToInsert +
                   ', ''' + FloatToStr(User.GetWeight) +
                   ''', ' + FloatToStr(User.GetHeight) +
                   ', "", "")';

  // Creates a new instance of the database access class
  objDatabaseAccess := TDatabaseAccess.Create;
  // Executes the insert statement
  objDatabaseAccess.Exec(sSQL);

  // Get the ID that was assigned to the newly inserted user
  iLastID := objDatabaseAccess.QueryLastIDUsed;
  // Clean up our database access
  objDatabaseAccess.Destroy;
  // Refresh the user object with their new user ID
  User := SelectUserByID(iLastID);
end;

function TDatabaseManager.ParseActivity(Fields: TADOQuery; Tags: TTags;
  Comments:TComments;Favourites:TUserIDs;ActivityType:TActivityType): TActivity;
begin
  // Use the data passed as parameters to create a new activity object
  Result := TActivity.Create(
              Fields.FieldByName('ActivityID').AsInteger,
              Fields.FieldByName('UserID').AsInteger,
              ActivityType,
              Fields.FieldByName('Duration').AsInteger,
              Fields.FieldByName('Distance').AsInteger,
              Fields.FieldByName('Title').AsString,
              Fields.FieldByName('DateTimeOfActivity').AsDateTime,
              Tags,
              Comments,
              Favourites);
end;

function TDatabaseManager.ParseClubStatistics(
  Fields: TADOQuery): TClubStatistics;
begin
  // Open our TADOQuery object and navigate to the beginning
  Fields.Open;
  Fields.First;                                                        

  // Create a new club statistics object using the derived fields
  Result := TClubStatistics.Create(Fields.FieldByName('TotalDistance').AsInteger,
                                   Fields.FieldByName('TotalDuration').AsInteger);

  // Close our TADOQuery
  Fields.Close;
end;

function TDatabaseManager.ParseComment(Fields: TADOQuery): TComment;
begin
  // Use data passed as parameters to construct a single comment object
  Result := TComment.Create(
              Fields.FieldByName('CommentID').AsInteger,
              Fields.FieldByName('UserID').AsInteger,
              Fields.FieldByName('ActivityID').AsInteger,
              Fields.FieldByName('DateTimeOfComment').AsDateTime,
              Fields.FieldByName('Comment').AsString);
end;

function TDatabaseManager.ParseUser(Fields: TADOQuery; Gender:TGender;
                                    Following, Followers : TUserIDs): TUser;
begin
  // Use data passed as parameters to construct a single user object
  Result := TUser.Create(Fields.FieldByName('UserID').AsInteger,
                         Fields.FieldByName('Username').AsString,
                         Fields.FieldByName('EmailAddress').AsString,
                         Fields.FieldByName('Password').AsString,
                         Fields.FieldByName('DisplayName').AsString,
                         Fields.FieldByName('Motto').AsString,
                         Fields.FieldByName('DateOfBirth').AsDateTime,
                         Gender,
                         Fields.FieldByName('Weight').AsFloat,
                         Fields.FieldByName('Height').AsInteger,
                         Fields.FieldByName('ProfilePicture').AsString,
                         Fields.FieldByName('CoverPhoto').AsString,
                         Following,
                         Followers
                         );
end;

function TDatabaseManager.ParseUserIDs(Fields: TADOQuery): TUserIDs;
begin
  // Create a new array of UserIDs
  Result := TUserIDs.Create;

  // Open our TADOQuery and navigate to the first record
  Fields.Open;
  Fields.First;

  // Loop through each record in the results
  while not Fields.Eof do
  begin
    // Add each ID to our array
    Result.AddUserID(Fields.FieldByName('UserID').AsInteger);
    // Navigate to the next record
    Fields.Next;
  end;

  // Close our TADOQuery
  Fields.Close;
end;

function TDatabaseManager.QueryMultipleActivities(
  SQL: string): TActivities;
var
  objDatabaseAccess : TDatabaseAccess;
  objResults : TADOQuery;
begin
  // Creates a new instance of our database access class
  objDatabaseAccess := TDatabaseAccess.Create;
  // Creates a new array to store our activities in
  Result := TActivities.Create;

  // Executes our query and keeps the results
  objResults := objDatabaseAccess.ExecWithResults(SQL);

  // Opens our TADOQuery and navigates to the first record
  objResults.Open;
  objResults.First;

  // Loops through each activity result
  while not objResults.Eof do
  begin 
    // Uses the fields to complete the activity object and add it to the array
    Result.AddActivity(CompleteActivityObject(objResults));
    // Navigate to the next record
    objResults.Next;
  end; // while

  // Close our TADOQuery object
  objResults.Close;

  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

function TDatabaseManager.QueryMultipleActivityTypes(
  SQL: string): TActivityTypes;
var
  objDatabaseAccess : TDatabaseAccess;
  objResults : TADOQuery;
begin
  // Create a new instance of the database access class
  objDatabaseAccess := TDatabaseAccess.Create;
  // Create a new array to store all our activity types
  Result := TActivityTypes.Create;

  // Execcute the SQL query provided and keep the results
  objResults := objDatabaseAccess.ExecWithResults(SQL);

  // Open our TADOQuery object and navigate to the first record
  objResults.Open;
  objResults.First;

  // Loop through each record
  while not objResults.Eof do
  begin
    // Create a new activity type from each record and add it to the array
    Result.AddActivityType(TActivityType.Create(
                              objResults.FieldByName('ActivityTypeID').AsInteger,
                              objResults.FieldByName('Description').AsString,
                              objResults.FieldByName('Icon').AsString));
    // Navigate to the next record
    objResults.Next;
  end;

  // Close our TADOQuery object
  objResults.Close;

  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

function TDatabaseManager.QueryMultipleComments(SQL: string): TComments;
var
  objDatabaseAccess : TDatabaseAccess;
  objResults : TADOQuery;
begin
  // Create a new instance of our database access class
  objDatabaseAccess := TDatabaseAccess.Create;
  // Create a new array to store all our comments
  Result := TComments.Create;

  // Execute the provided SQL query and keep the results
  objResults := objDatabaseAccess.ExecWithResults(SQL);

  // Open our TADOQuery object and navigate to the first record
  objResults.Open;
  objResults.First;

  // Loop through each comment returned in the query
  while not objResults.Eof do
  begin
    // Parse the comment and add it to the array
    Result.AddComment(ParseComment(objResults));
    // Navigate to the next record
    objResults.Next;
  end;

  // Close our TADOQuery object
  objResults.Close;

  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

function TDatabaseManager.QueryMultipleUserIDs(SQL: string): TUserIDs;
var
  objDatabaseAccess : TDatabaseAccess;
begin
  // Create a new instance of our database access class
  objDatabaseAccess := TDatabaseAccess.Create;

  // Query all the UserIDs using the provided SQL query and parse them into
  // a list of UserIDs
  Result := ParseUserIDs(objDatabaseAccess.ExecWithResults(SQL));

  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

function TDatabaseManager.QueryMultipleTags(SQL: string): TTags;
var
  objDatabaseAccess : TDatabaseAccess;
  objResults : TADOQuery;
begin
  // Create a new instance of our database access class
  objDatabaseAccess := TDatabaseAccess.Create;
  // Create an array to store all the tags
  Result := TTags.Create;

  // Use the SQL query to query the database and keep the results
  objResults := objDatabaseAccess.ExecWithResults(SQL);

  // Open our TADOQuery object and navigate to the first record
  objResults.Open;
  objResults.First;

  // Loop through each tag returned
  while not objResults.Eof do
  begin
    // Add each tag to the array
    Result.AddTag(objResults.FieldByName('Tag').AsString);
    // Navigate to the next record
    objResults.Next;
  end;

  // Close our TADOQuery object
  objResults.Close;

  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

function TDatabaseManager.QueryMultipleUserDetails(SQL: string): TUsers;
var
  objDatabaseAccess : TDatabaseAccess;
  objResults : TADOQuery;
begin
  // Create a new instance of our database access class
  objDatabaseAccess := TDatabaseAccess.Create;
  // Create an array to store our list of users
  Result := TUsers.Create;

  // Executes the query and keeps the results
  objResults := objDatabaseAccess.ExecWithResults(SQL);

  // Open our TADOQuery object and navigate to the first record
  objResults.Open;
  objResults.First;

  // Loop through each user record
  while not objResults.Eof do
  begin
    // Complete each user object and add it to our array
    Result.AddUser(CompleteUserObject(objResults));
    // Navigate to the next record
    objResults.Next;
  end;

  // Close our TADOQuery object
  objResults.Close;
  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

function TDatabaseManager.QuerySingleActivity(SQL: string): TActivity;
var
  objDatabaseAccess : TDatabaseAccess;
  objResults : TADOQuery;
begin
  // Create a new instance of our database access class
  objDatabaseAccess := TDatabaseAccess.Create;

  // Check if the activity exists
  if objDatabaseAccess.RecordExists(SQL) then
  begin
    // If the activity exists, query it and return the results
    objResults := objDatabaseAccess.ExecWithResults(SQL);

    // Open our TADOQuery object and navigate to the first record
    objResults.Open;
    objResults.First;

    // Create an activity object from the fields and return it
    Result := CompleteActivityObject(objResults);

    // Close our TADOQuery object
    objResults.Close;
  end
  else
    // If no activity exists, return nil
    Result := nil;

  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

function TDatabaseManager.QuerySingleActivityType(
  SQL: string): TActivityType;
var
  objDatabaseAccess : TDatabaseAccess;
  objResults : TADOQuery;
begin
  // Create a new instance of our database access class
  objDatabaseAccess := TDatabaseAccess.Create;

  // Check if the activity type exists in the database
  if objDatabaseAccess.RecordExists(SQL) then
  begin
    // If it exists, query for the details and keep the results
    objResults := objDatabaseAccess.ExecWithResults(SQL);

    // Open our TADOQuery object and navigate to the first record
    objResults.Open;
    objResults.First;

    // Create a new activity type object using the fields
    Result := TActivityType.Create(
                objResults.FieldByName('ActivityTypeID').AsInteger,
                objResults.FieldByName('Description').AsString,
                objResults.FieldByName('Icon').AsString);

    // Close our TADOQuery object
    objResults.Close;
  end
  else
    // If not activity type was found, return nil
    Result := nil;
  
  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

function TDatabaseManager.QuerySingleUserDetails(SQL: string): TUser;
var
  objDatabaseAccess : TDatabaseAccess;
  objUserDetailsResult : TADOQuery;
begin
  // Create a new instance of our database access class
  objDatabaseAccess := TDatabaseAccess.Create;

  // Check if the user object exists in the database
  if objDatabaseAccess.RecordExists(SQL) then
  begin
    // If it exists, query it and keep the results
    objUserDetailsResult := objDatabaseAccess.ExecWithResults(SQL);

    // Open our TADOQuery object and navigate to the first record
    objUserDetailsResult.Open;
    objUserDetailsResult.First;

    // Use the fields to create a user object and return it
    Result := CompleteUserObject(objUserDetailsResult);

    // Close our TADOQuery object
    objUserDetailsResult.Close;
  end
  else
    // If the user was not found, return nil
    Result := nil;

  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

function TDatabaseManager.SelectActivitiesByTagOrTitle(
  SearchTerm: string): TActivities;
var
  sSQL : string;
begin
  // Construct a SQL query to select activities with matching tags or similar
  // titles. Note that I use INSTR as I found that in Access the LIKE operator
  // operates slightly differently depending on the database driver version
  sSQL := 'SELECT [ActivityID], [UserID], [ActivityTypeID], ' + 
                 '[DateTimeOfActivity], [Duration], [Distance], [Title] ' +
          'FROM Activities ' +
          'WHERE [ActivityID] IN (SELECT [ActivityID] FROM ActivityTags WHERE '+
          '[Tag] = ' + QuotedStr(SearchTerm) + ') OR INSTR([Title], ' +
          QuotedStr(SearchTerm) + ') ORDER BY [DateTimeOfActivity] DESC';

  // Use the query to return an array of activities
  Result := QueryMultipleActivities(sSQL);
end;

function TDatabaseManager.SelectActivitiesByUsersBeingFollowed(
  User: TUser): TActivities;
var
  sSQL : string;
begin
  // Construct a SQL query to select activities from users a user is following
  // as well as the user's own activities
  sSQL := 'SELECT [ActivityID], [UserID], [ActivityTypeID], ' +
                 '[DateTimeOfActivity], [Duration], [Distance], [Title] ' +
          'FROM Activities ' +
          'WHERE [UserID] IN (SELECT [BeingFollowedUserID] FROM Following ' +
          'WHERE [BusyFollowingUserID] = ' + IntToStr(User.GetUserID) + ') OR '+
          '[UserID] = ' + IntToStr(User.GetUserID) + ' ORDER BY ' +
          '[DateTimeOfActivity] DESC';

  // Use the query to return an array of activities
  Result := QueryMultipleActivities(sSQL);
end;

function TDatabaseManager.SelectActivityByActivityID(
  ID: integer): TActivity;
var
  sSQL : string;
begin
  // Construct a SQL query to select a single activity based on its activity ID
  sSQL := 'SELECT [ActivityID], [UserID], [ActivityTypeID], ' +
                 '[DateTimeOfActivity], [Duration], [Distance], [Title] ' +
          'FROM Activities ' +
          'WHERE [ActivityID] = ' + IntToStr(ID);

  // Use the query to return a single activity object
  Result := QuerySingleActivity(sSQL);
end;

function TDatabaseManager.SelectActivityTypeByActivityTypeID(
  ID: integer): TActivityType;
var
  sSQL : string;
begin
  // Construct a SQL query to select an activity type based on an ID
  sSQL := 'SELECT [ActivityTypeID], [Description], [Icon] FROM ActivityTypes ' +
          'WHERE [ActivityTypeID] = ' + IntToStr(ID);

  // Use the query to return a single activity type object
  Result := QuerySingleActivityType(sSQL);
end;

function TDatabaseManager.SelectActivityTypeByDescription(
  Description: string): TActivityType;
var
  sSQL : string;
begin
  // Construct a query to select a single activity type based on a provided
  // description
  sSQL := 'SELECT [ActivityTypeID], [Description], [Icon] FROM ActivityTypes ' +
          'WHERE [Description] = ' + QuotedStr(Description);

  // Use the query to return a single activity type object
  Result := QuerySingleActivityType(sSQL);
end;

function TDatabaseManager.SelectAllActivityTypes: TActivityTypes;
var
  sSQL : string;
begin
  // Construct a query to select all the activity types in the database
  sSQL := 'SELECT [ActivityTypeID], [Description], [Icon] FROM ActivityTypes';

  // Use the query to return a list of activity types
  Result := QueryMultipleActivityTypes(sSQL);
end;

function TDatabaseManager.SelectClubStatistics: TClubStatistics;
var
  objDatabaseAccess : TDatabaseAccess;
  sSQL : string;
begin
  // Create a new instace of our database access class
  objDatabaseAccess := TDatabaseAccess.Create;

  // Construct a query to select two derived fields for our club statistics
  sSQL := 'SELECT SUM(Duration) AS [TotalDuration], ' +
                 'SUM(Distance) AS [TotalDistance] ' +
          'FROM Activities';

  // Use the SQL query to get the derived fields, parse them into an object and
  // return the object
  Result := ParseClubStatistics(objDatabaseAccess.ExecWithResults(sSQL));

  // Clean up our database access
  objDatabaseAccess.Destroy;
end;

function TDatabaseManager.SelectCommentsByActivityID(
  ID: integer): TComments;
var
  sSQL : string;
begin
  // Construct a SQL query to select all comments belonging to an activity
  sSQL := 'SELECT [CommentID], [ActivityID], [UserID], [Comment], ' +
                 '[DateTimeOfComment] ' +
          'FROM Comments ' +
          'WHERE [ActivityID] = ' + IntToStr(ID) +
          ' ORDER BY [DateTimeOfComment] DESC';

  // Use the query to return a list of comments
  Result := QueryMultipleComments(sSQL);
end;

function TDatabaseManager.SelectFavouritesByActivityID(
  ID: integer): TUserIDs;
var
  sSQL : string;
  objFavouritesAccess : TDatabaseAccess;
begin
  // Create a new instance of our database access class
  objFavouritesAccess := TDatabaseAccess.Create;

  // Construct a SQL query to select all the user IDs of users who have 
  // favourited/liked an activity
  sSQL := 'SELECT [UserID] FROM Favourites ' +
          'WHERE [ActivityID] = ' + IntToStr(ID);

  // Use the SQL query to return a list of UserIDs which is then parsed and 
  // returned
  Result := ParseUserIDs(objFavouritesAccess.ExecWithResults(sSQL));

  // Clean up our database access
  objFavouritesAccess.Destroy;
end;

function TDatabaseManager.SelectNActivitiesByUser(User: TUser;
  N: byte): TActivities;
var
  sSQL : string;
begin
  // Construct a SQL query to select the top N recent activities by a user
  sSQL := 'SELECT TOP ' + IntToStr(N) + ' [ActivityID], [UserID], ' +
            '[ActivityTypeID], [DateTimeOfActivity], [Duration], [Distance], ' +
            '[Title] ' +
          'FROM Activities ' +
          'WHERE [UserID] = ' + IntToStr(User.GetUserID) +
          ' ORDER BY [DateTimeOfActivity] DESC';

  // Use the query to select a list of activities and return it
  Result := QueryMultipleActivities(sSQL);
end;

function TDatabaseManager.SelectTagsByActivityID(ID: integer): TTags;
var
  sSQL : string;
begin
  // Construct a SQL query to select all the tags belonging to an activity
  sSQL := 'SELECT [Tag] FROM ActivityTags WHERE [ActivityID] = ' + IntToStr(ID);

  // Use the query to return a list of tags
  Result := QueryMultipleTags(sSQL);
end;

function TDatabaseManager.SelectUserByEmailAddress(
  EmailAddress: string): TUser;
var
  sSQL : string;
begin
  // Construct a SQL query to select a user with a specific email address
  sSQL := 'SELECT [UserID], [Username], [EmailAddress], [Password], ' +
                 '[DisplayName], [Motto], [DateOfBirth], [IsMale], [Weight], '+
                 '[Height], [ProfilePicture], [CoverPhoto] ' +
          'FROM Users ' +
          'WHERE [EmailAddress] = ' + QuotedStr(EmailAddress);

  // Use the query to return a single user object
  Result := QuerySingleUserDetails(sSQL);
end;
function TDatabaseManager.SelectUserByID(ID: integer): TUser;
var
  sSQL : string;
begin
  // Construct a SQL query to select a user with a specific UserID
  sSQL := 'SELECT [UserID], [Username], [EmailAddress], [Password], ' +
                 '[DisplayName], [Motto], [DateOfBirth], [IsMale], [Weight], '+
                 '[Height], [ProfilePicture], [CoverPhoto] ' +
          'FROM Users ' +
          'WHERE [UserID] = ' + IntToStr(ID);

  // Use the query to return a single user object
  Result := QuerySingleUserDetails(sSQL);
end;

function TDatabaseManager.SelectUserByUsername(Username: string): TUser;
var
  sSQL : string;
begin
  // Construct a SQL query to select a user with a specific username
  sSQL := 'SELECT [UserID], [Username], [EmailAddress], [Password], ' +
                 '[DisplayName], [Motto], [DateOfBirth], [IsMale], [Weight], '+
                 '[Height], [ProfilePicture], [CoverPhoto] ' +
          'FROM Users ' +
          'WHERE [Username] = ' + QuotedStr(Username);

  // Use the query to return a single user object
  Result := QuerySingleUserDetails(sSQL);
end;

function TDatabaseManager.SelectUsersByPartialUsername(
  PartialUsername: string): TUsers;
var
  sSQL : string;
begin
  // Construct a SQL query to select all users with parts of their usernames
  // matching a search term
  sSQL := 'SELECT [UserID], [Username], [EmailAddress], [Password], ' +
                 '[DisplayName], [Motto], [DateOfBirth], [IsMale], [Weight], '+
                 '[Height], [ProfilePicture], [CoverPhoto] ' +
          'FROM Users ' +
          'WHERE INSTR([Username], ' + QuotedStr(PartialUsername) + ')';

  // Use the query to return a list of user objects matching the query
  Result := QueryMultipleUserDetails(sSQL);
end;

procedure TDatabaseManager.UpdateActivity(var Activity: TActivity);
var
  sSQL : string;
  objActivitiesAccess, objCommentsAccess, objTagsAccess, objFavouritesAccess
  : TDatabaseAccess;
  objCurrentComment : TComment;
  objTags : TTags;
  objFavourites : TUserIDs;
  K : smallint;
begin
  // Construct a SQL query to update the Activities table
  sSQL := 'UPDATE Activities SET ' +
            '[ActivityTypeID] = ' + IntToStr(
                                      Activity.GetActivityType.GetActivityTypeID) 
                                    + ', ' +
            '[DateTimeOfActivity] = "' + FormatDateTime('yyyy/mm/dd hh:nn:ss', 
                                           Activity.GetDateTimeOfActivity) 
                                           + '", ' +
            '[Duration] = ' + IntToStr(Activity.GetDuration) + ', ' +
            '[Distance] = ' + IntToStr(Activity.GetDistance) + ', ' +
            '[Title] = ' + QuotedStr(Activity.GetTitle) + ' ' +
          'WHERE [ActivityID] = ' + IntToStr(Activity.GetActivityID);

  // Create a new instance of our database access class
  objActivitiesAccess := TDatabaseAccess.Create;
  // Execute the update statement
  objActivitiesAccess.Exec(sSQL);
  // Clean up our database access
  objActivitiesAccess.Destroy;

  // Create a new instance of our database access class
  objCommentsAccess := TDatabaseAccess.Create;
  
  // Loop through each comment in the activity
  for K := 1 to Activity.GetComments.GetCommentCount do
  begin
    // Get the current comment from the array
    objCurrentComment := Activity.GetComments.GetComment(K);
    
    // Check if the current comment has been inserted into the database or not
    if objCurrentComment.GetCommentID = -1 then
    begin
      // If it has not been inserted, construct a SQL query to insert the
      // comment into the database
      sSQL := 'INSERT INTO Comments ([ActivityID], [UserID], [Comment], ' +
                                    '[DateTimeOfComment]) ' +
              'VALUES (' + IntToStr(objCurrentComment.GetActivityID) + ', '
                         + IntToStr(objCurrentComment.GetUserID) + ', '
                         + QuotedStr(objCurrentComment.GetComment) + ', "'
                         + FormatDateTime('yyyy/mm/dd hh:nn:ss', 
                             objCurrentComment.GetDateTimeOfComment) + '")';

      // Execute the insert statement
      objCommentsAccess.Exec(sSQL);
    end;
  end;

  // Clean up our database access
  objCommentsAccess.Destroy;

  // Create a new instance of our database access class
  objTagsAccess := TDatabaseAccess.Create;

  // Loop through each of the tags in the activity object
  for K := 1 to Activity.GetTags.GetTagCount do
  begin
    // Check if the current tag exists in the database or not
    if not CheckTagExists(Activity.GetActivityID,Activity.GetTags.GetTag(K))then
    begin
      // If the tag is not in the database, construct a SQL query to insert it
      sSQL := 'INSERT INTO ActivityTags ([ActivityID], [Tag]) VALUES ' +
              '(' + IntToStr(Activity.GetActivityID) + ', ' +
              QuotedStr(Activity.GetTags.GetTag(K)) + ')';

      // Execute our insert statement
      objTagsAccess.Exec(sSQL);
    end;
  end;

  // Construct a SQL query to select all the tags that exist in the database
  // and NOT in the activity object (i.e. tags have been removed in the app)
  sSQL := 'SELECT [Tag] FROM ActivityTags WHERE [ActivityID] = ' +
          IntToStr(Activity.GetActivityID) + ' AND [Tag] NOT IN (' +
          Activity.GetTags.ToString('', '', True) + ')';

  // Create an array of all the tags to be deleted in the database
  objTags := QueryMultipleTags(sSQL);

  // Loop through all the tags that need to be deleted
  for K := 1 to objTags.GetTagCount do
  begin
    // Construct a SQL query to delete the tag from the database
    sSQL := 'DELETE FROM ActivityTags WHERE [ActivityID] = ' +
            IntToStr(Activity.GetActivityID) + ' AND [Tag] = ' +
            QuotedStr(objTags.GetTag(K));

    // Execute the delete statement
    objTagsAccess.Exec(sSQL);
  end;

  // Clean up our database access
  objTagsAccess.Destroy;

  // Create a new instance of our database access class
  objFavouritesAccess := TDatabaseAccess.Create;

  // Loop through all the favourites/likes in an activity
  for K := 1 to Activity.GetFavourites.GetUserIDCount do
  begin
    // Check if the user ID exists in the database
    if not CheckFavouriteExists(Activity.GetActivityID, 
             Activity.GetFavourites.GetUserID(K)) then
    begin
      // Construct a SQL query to insert the UserID if it does not exist
      sSQL := 'INSERT INTO Favourites ([ActivityID], [UserID]) VALUES ' +
              '(' + IntToStr(Activity.GetActivityID) + ', ' +
              IntToStr(Activity.GetFavourites.GetUserID(K)) + ')';

      // Execute the insert statement
      objFavouritesAccess.Exec(sSQL);
    end;
  end;

  // Construct a SQL query to select all the user IDs that exist in the database
  // but not in the activity (i.e. select people who unliked an activity)
  sSQL := 'SELECT [UserID] FROM Favourites WHERE [ActivityID] = ' +
          IntToStr(Activity.GetActivityID) + ' AND [UserID] NOT IN (' +
          Activity.GetFavourites.ToString + ')';

  // Use the query to construct an array of UserIDs who need to be deleted
  objFavourites := QueryMultipleUserIDs(sSQL);

  // Loop through each of the UserIDs to be deleted
  for K := 1 to objFavourites.GetUserIDCount do
  begin
    // Construct a SQL query to delete the user ID from the database
    sSQL := 'DELETE FROM Favourites WHERE [ActivityID] = ' +
            IntToStr(Activity.GetActivityID) + ' AND [UserID] = ' +
            IntToStr(objFavourites.GetUserID(K));

    // Execute the delete statement
    objFavouritesAccess.Exec(sSQL);
  end;

  // Clean up our database access
  objFavouritesAccess.Destroy;

  // Return a new instance of the activity with all the new comments, likes etc
  // that have been inserted
  Activity := SelectActivityByActivityID(Activity.GetActivityID);
end;

procedure TDatabaseManager.UpdateUser(var User: TUser);
var
  sSQL : string;
  objUsersAccess, objFollowingAccess, objFollowersAccess : TDatabaseAccess;
  K : smallint;
  objFollowing, objFollowers : TUserIDs;
  sGenderToInsert : string;
begin
  // Construct a string from the user's gender with 1 (male) or 0 (female)
  if User.GetGender = GenderMale then
    sGenderToInsert := '1'
  else
    sGenderToInsert := '0';

  // Copy the user's profile picture to the data folder if they changed it
  CopyProfilePicture(User);
  // Copy the user's cover photo to the data folder if they changed it
  CopyCoverPhoto(User);

  // Construct a query to update the Users table
  sSQL := 'UPDATE Users SET ' +
            '[Username] = ' + QuotedStr(User.GetUsername) + ', ' +
            '[EmailAddress] = ' + QuotedStr(User.GetEmailAddress) + ', ' +
            '[Password] = ' + QuotedStr(User.GetPassword) + ', ' +
            '[DisplayName] = ' + QuotedStr(User.GetDisplayName) + ', ' +
            '[Motto] = ' + QuotedStr(User.GetMotto) + ', ' +
            '[DateOfBirth] = #' + FormatDateTime('yyyy/mm/dd',
                                    User.GetDateOfBirth) + '#, ' +
            '[IsMale] = ' + sGenderToInsert + ', ' +
            '[Weight] = ''' + FloatToStr(User.GetWeight) + ''', ' +
            '[Height] = ' + IntToStr(User.GetHeight) + ', ' +
            '[ProfilePicture] = ' + QuotedStr(User.GetProfilePicture) + ', ' +
            '[CoverPhoto] = ' + QuotedStr(User.GetCoverPhoto) + ' ' +
          'WHERE [UserID] = ' + IntToStr(User.GetUserID);

  // Create a new instance of our database access class
  objUsersAccess := TDatabaseAccess.Create;
  // Execute our update statement
  objUsersAccess.Exec(sSQL);
  // Clean up our database access
  objUsersAccess.Destroy;

  // Create a new instance of our database access class
  objFollowingAccess := TDatabaseAccess.Create;
  // Loop through each of the UserIDs that the user is busy following
  for K := 1 to User.GetFollowing.GetUserIDCount do
  begin
    // Check if the follow exists in the database
    if not CheckFollowing(User.GetUserID, User.GetFollowing.GetUserID(K)) then
    begin
      // If it doesn't exist, construct a SQL query to insert it
      sSQL := 'INSERT INTO Following (BusyFollowingUserID, BeingFollowedUserID) '+
              'VALUES (' + IntToStr(User.GetUserID) + ', ' +
              IntToStr(User.GetFollowing.GetUserID(K)) + ')';

      // Execute the insert statement
      objFollowingAccess.Exec(sSQL);
    end;
  end;

  // Construct a SQL query to select all the users that the user is following
  // that is not in the user object (i.e. select people they have unfollowed)
  sSQL := 'SELECT [BeingFollowedUserID] AS [UserID] FROM Following ' +
          'WHERE ' +
            '[BusyFollowingUserID] = ' + IntToStr(User.GetUserID) + ' AND ' +
            '[BeingFollowedUserID] NOT IN (' + User.GetFollowing.ToString + ')';

  // Execute the query and keep all the user IDs
  objFollowing := QueryMultipleUserIDs(sSQL);

  // Loop through each user ID that needs to be deleted
  for K := 1 to objFollowing.GetUserIDCount do
  begin
    // Construct a SQL query to delete the user ID from the database
    sSQL := 'DELETE FROM Following ' +
            'WHERE ' +
              '[BusyFollowingUserID] = ' + IntToStr(User.GetUserID) + ' AND ' +
              '[BeingFollowedUserID] = ' + IntToStr(objFollowing.GetUserID(K));

    // Execute the delete statement
    objFollowingAccess.Exec(sSQL);
  end;

  // Clean up our database access
  objFollowingAccess.Destroy;

  // Create a new instance of the database access class
  objFollowersAccess := TDatabaseAccess.Create;
  // Loop through all the user IDs of users who are busy following the current
  // user
  for K := 1 to User.GetFollowers.GetUserIDCount do
  begin
    // Check if the follow exists in the database
    if not CheckFollowing(User.GetFollowers.GetUserID(K), User.GetUserID) then
    begin
      // If the follow does not exist, construct a SQL query to insert it into
      // the database
      sSQL := 'INSERT INTO Following (BusyFollowingUserID, BeingFollowedUserID) ' +
              'VALUES (' + IntToStr(User.GetFollowers.GetUserID(K)) + ', ' +
              IntToStr(User.GetUserID) + ')';

      // Execute the insert statement
      objFollowersAccess.Exec(sSQL);
    end;
  end;

  // Construct a SQL query to select users in the database who are following a
  // user but are not following them in the user object (i.e. select all the 
  // user IDs that have unfollowed the current user so they can be deleted)
  sSQL := 'SELECT [BusyFollowingUserID] AS [UserID] FROM Following ' +
          'WHERE ' +
            '[BusyFollowingUserID] NOT IN ( ' + User.GetFollowers.ToString + 
            ') AND ' +
            '[BeingFollowedUserID] = ' + IntToStr(User.GetUserID);

  // Execute the query and keep the results
  objFollowers := QueryMultipleUserIDs(sSQL);

  // Loop through each UserID to be deleted
  for K := 1 to objFollowers.GetUserIDCount do
  begin
    // Construct a SQL query to delete the UserID from the database
    sSQL := 'DELETE FROM Following ' +
            'WHERE ' +
              '[BusyFollowingUserID] = ' + IntToStr(objFollowers.GetUserID(K)) + 
              ' AND ' +
              '[BeingFollowedUserID] = ' + IntToStr(User.GetUserID);

    // Execute the delete statement
    objFollowersAccess.Exec(sSQL);
  end;

  // Clean up our database access
  objFollowersAccess.Destroy;
end;

procedure TDatabaseManager.CopyCoverPhoto(var User: TUser);
var
  sSource, sDestination : string;
  iPos : byte;
begin
  // Check if the cover photo is a full filename with the path or just a 
  // filename.  A full path indicates that the user selected another cover 
  // photo
  if Pos('\', User.GetCoverPhoto) > 0 then
  begin
    // If the user selected a new cover photo, get the source
    sSource := User.GetCoverPhoto;
    // Construct a destination for copying the new cover photo into the app's
    // data folder
    sDestination := ExtractFilePath(Application.ExeName) + COVER_FOLDER +
                   User.GetUsername + '.' + GetFileExtension(User.GetCoverPhoto);

    // Copy the file from the source to the destination
    CopyFileFromTo(sSource, sDestination);

    // Get the name of the file from the path and set the cover photo field
    iPos := LastDelimiter('\', sDestination);
    User.SetCoverPhoto(Copy(sDestination, iPos + 1,Length(sDestination)-iPos));
  end;
end;

procedure TDatabaseManager.CopyProfilePicture(var User: TUser);
var
  sSource, sDestination : string;
  iPos : byte;
begin
  // Check if the profile picture is a full filename with a path or just a 
  // filename.  A full path indicates that the user selected a new profile
  // picture
  if Pos('\', User.GetProfilePicture) > 0 then
  begin
    // If the user selected a new profile picture, get the source filename
    sSource := User.GetProfilePicture;
    // Construct a destination for copying the new profile picture into the 
    // app's data folder
    sDestination := ExtractFilePath(Application.ExeName) + PROFILE_FOLDER +
                   User.GetUsername + '.' + GetFileExtension(User.GetProfilePicture);

    // Copy the file from the source to the destination
    CopyFileFromTo(sSource, sDestination);

    // Get the name of the file from the path and set the profile picture field
    iPos := LastDelimiter('\', sDestination);
    User.SetProfilePicture(Copy(sDestination, iPos + 1, Length(sDestination) - iPos));
  end;
end;

procedure TDatabaseManager.CopyFileFromTo(Source, Destination: string);
begin
  // Check if the file already exists
  if FileExists(Destination) then
    // If it does, it's old and can be deleted
    DeleteFile(Destination);
  
  // Copy the new file
  CopyFile(PChar(Source), PChar(Destination), false);
end;

function TDatabaseManager.GetFileExtension(FileName: string): string;
var
  iPos : byte;
begin
  // Get the position of the last . in the filename
  iPos := LastDelimiter('.', FileName);

  // Copy the end of the string (i.e. the file extension)
  Result := Copy(FileName, iPos + 1, Length(FileName) - iPos);
end;

end.
