unit uActivity;

interface

uses
  uActivityType, uTags, uComment, uComments, uUserIDs;

type
  TActivity = class(TObject)
    private
      // Stores the activity ID associated with the activity
      FActivityID : integer;
      // Stores the user ID the activity belongs to
      FUserID : integer;
      // Stores the type of activity
      FActivityType : TActivityType;
      // Stores the duration of the activity in seconds
      FDuration : integer;
      // Stores the distance of the activity in metres
      FDistance : integer;
      // Stores the title of the activity
      FTitle : string;
      // Stores the date and time of the activity
      FDateTimeOfActivity : TDateTime;
      // Stores the tags associated with the activity
      FTags : TTags;
      // Stores the comments belonging to the activity
      FComments : TComments;
      // Stores the UserIDs of the users who have liked the activity
      FFavourites : TUserIDs;
    public
      // Creates a new activity using an activity ID from the database
      constructor Create(ActivityID, UserID : integer; ActivityType :
                         TActivityType; Duration, Distance : integer;
                         Title : string; DateTimeOfActivity : TDateTime;
                         Tags : TTags; Comments : TComments; Favourites :
                         TUserIDs); overload;
      // Creates a new activity to be inserted into the database without an
      // activity ID
      constructor Create(UserID : integer; ActivityType :
                         TActivityType; Duration, Distance : integer;
                         Title : string; DateTimeOfActivity : TDateTime;
                         Tags : TTags); overload;
      // Returns FActivityID
      function GetActivityID : integer;
      // Returns FUserID
      function GetUserID : integer;
      // Returns FActivityType
      function GetActivityType : TActivityType;
      // Returns FDuration
      function GetDuration : integer;
      // Returns FDistance
      function GetDistance : integer;
      // Returns FTitle
      function GetTitle : string;
      // Returns FDateTimeOfActivity
      function GetDateTimeOfActivity : TDateTime;
      // Returns FTags
      function GetTags : TTags;
      // Returns FComments
      function GetComments : TComments;
      // Returns FFavourites
      function GetFavourites : TUserIDs;
      // Sets the activity type
      procedure SetActivityType(ActivityType : TActivityType);
      // Sets the duration in seconds
      procedure SetDuration(Duration : integer); overload;
      // Sets the duration in hours, minutes and seconds
      procedure SetDuration(Hours, Minutes, Seconds : byte); overload;
      // Sets the distance in metres
      procedure SetDistance(Distance : integer);
      // Sets FTitle
      procedure SetTitle(Title : string);
      // Sets FDateTimeOfActivity
      procedure SetDateTimeOfActivity(DateTimeOfActivity : TDateTime);
      // Sets the tags associated with the activity
      procedure SetStringOfTags(StringOfTags : string);
      // Adds a comment to the activity
      procedure AddComment(Comment : TComment);
      // Deletes a comment from the activity
      procedure DeleteComment(Comment : TComment);
      // Adds a userID to FFavourites
      procedure AddFavourite(UserID : integer);
      // Deletes a UserID from FFavourites
      procedure DeleteFavourite(UserID : integer);
      // Converts the whole activity to a string
      function ToString : string;
      // Calculates the duration of the activity in hours
      function CalculateDurationHours : byte;
      // Calculates the remaining duration in minutes
      function CalculateDurationMinutes : byte;
      // Calculates the remaining duration in seconds
      function CalculateDurationSeconds : byte;
      // Returns the distance as a formatted string depening on activity type
      function GetFormattedDistance : string;
      // Returns the duration as a formatted string
      function GetFormattedDuration : string;
      // Returns the date and time as a formatted string
      function GetFormattedDateTime : string;
      // Calculates the rate of the activity and formats it as a string
      // depending on the activity type
      function CalculateRate : string;
  end; // class

implementation

uses SysUtils;

{ TActivity }

{ TActivity }

procedure TActivity.AddComment(Comment: TComment);
begin
  // Adds a comment to FComments
  FComments.AddComment(Comment);
end;

procedure TActivity.AddFavourite(UserID: integer);
begin
  // Adds a UserID to FFavourites
  FFavourites.AddUserID(UserID);
end;

procedure TActivity.SetStringOfTags(StringOfTags: string);
begin
  // Sets the string of tags associated with the activity
  FTags := TTags.Create(StringOfTags);
end;

constructor TActivity.Create(ActivityID, UserID: integer;
  ActivityType: TActivityType; Duration, Distance: integer; Title: string;
  DateTimeOfActivity: TDateTime; Tags: TTags; Comments: TComments;
  Favourites: TUserIDs);
begin
  // Assigns all the fields with values from the database
  FActivityID := ActivityID;
  FUserID := UserID;
  FActivityType := ActivityType;
  FDuration := Duration;
  FDistance := Distance;
  FTitle := Title;
  FDateTimeOfActivity := DateTimeOfActivity;
  FTags := Tags;
  FComments := Comments;
  FFavourites := Favourites;
end;

function TActivity.CalculateRate: string;
var
  rTimeTaken : real;
begin
  // Determines the activity type
  if FActivityType.GetDescription = 'Swimming' then
    // If the activity type is swimming, it returns in the format 0.00m/s
    // (metres per second)
    Result := FloatToStrF(FDistance / FDuration, ffGeneral, 3, 1)+'m/s'
  else if FActivityType.GetDescription = 'Running' then
  begin
    // If the activity type is running, it returns in the format 00:00min/km
    // (minutes per kilometre)
    rTimeTaken := (FDuration / 60) / (FDistance / 1000);
    Result := IntToStr(Trunc(rTimeTaken)) + ':' +
              IntToStr(Round(Frac(rTimeTaken) * 60)) + 'min/km';
  end
  else if FActivityType.GetDescription = 'Cycling' then
    // If the activity type is cycling, it returns in the format 0.00km/h
    // (kilomtres per hour)
    Result := FloatToStrF((FDistance / 1000) / (FDuration / 3600), ffGeneral, 3,
              1) + 'km/h';
end;

constructor TActivity.Create(UserID: integer; ActivityType: TActivityType;
  Duration, Distance: integer; Title: string;
  DateTimeOfActivity: TDateTime; Tags: TTags);
begin
  // Sets all the fields with values from the app (user)
  FActivityID := -1;
  FUserID := UserID;
  FActivityType := ActivityType;
  FDuration := Duration;
  FDistance := Distance;
  FTitle := Title;
  FDateTimeOfActivity := DateTimeOfActivity;
  FTags := Tags;
  FComments := TComments.Create;
  FFavourites := TUserIDs.Create;
end;

procedure TActivity.DeleteComment(Comment: TComment);
begin
  // Removes a comment from FComments
  FComments.DeleteComment(Comment);
end;

procedure TActivity.DeleteFavourite(UserID: integer);
begin
  // Deletes a user from FFavourites
  FFavourites.DeleteUserID(UserID);
end;

function TActivity.GetActivityID: integer;
begin
  // Return FActivityID
  Result := FActivityID;
end;

function TActivity.GetActivityType: TActivityType;
begin
  // Returns FActivityType
  Result := FActivityType;
end;

function TActivity.GetComments: TComments;
begin
  // Returns FComments
  Result := FComments;
end;

function TActivity.GetDateTimeOfActivity: TDateTime;
begin
  // Returns FDateTimeOfActivity
  Result := FDateTimeOfActivity;
end;

function TActivity.GetDistance: integer;
begin
  // Returns FDistance
  Result := FDistance;
end;

function TActivity.GetDuration: integer;
begin
  // Returns FDuration
  Result := FDuration;
end;

function TActivity.GetFormattedDistance: string;
begin
  // Checks the activity type
  if FActivityType.GetDescription = 'Swimming' then
    // If the activity type is swimming, return the distance in metres
    Result := IntToStr(FDistance) + 'm'
  else
    // If the activity type is running or cycling, return the distance in
    // kilometres
    Result := FloatToStrF(FDistance / 1000, ffGeneral, 4, 1) + 'km';
end;

function TActivity.GetFormattedDuration: string;
begin
  // Formats the duration into hours and minutes
  Result := IntToStr(CalculateDurationHours) + 'h ' + 
            IntToStr(CalculateDurationMinutes) + 'm';
end;

function TActivity.GetTags: TTags;
begin
  // Returns FTags
  Result := FTags;
end;

function TActivity.GetTitle: string;
begin
  // Returns FTitle
  Result := FTitle;
end;

function TActivity.GetUserID: integer;
begin
  // Returns FUserID
  Result := FUserID;
end;

procedure TActivity.SetActivityType(ActivityType: TActivityType);
begin
  // Sets FActivityType
  FActivityType := ActivityType;
end;

procedure TActivity.SetDateTimeOfActivity(DateTimeOfActivity: TDateTime);
begin
  // Sets FDateTimeOfActivity
  FDateTimeOfActivity := DateTimeOfActivity;
end;

procedure TActivity.SetDistance(Distance: integer);
begin
  // Sets FDistance
  FDistance := Distance;
end;

procedure TActivity.SetDuration(Duration: integer);
begin
  // Sets FDuration
  FDuration := Duration;
end;

procedure TActivity.SetTitle(Title: string);
begin
  // Sets FTitle
  FTitle := Title;
end;

function TActivity.ToString: string;
begin
  // Returns all the activity's details in a string
  Result := 'ActivityID: ' + IntToStr(FActivityID) + #13 +
            'UserID: ' + IntToStr(FUserID) + #13 +
            'ActivityType: ' + FActivityType.ToString + #13 +
            'Duration: ' + IntToStr(FDuration) + #13 +
            'Distance: ' + IntToStr(FDistance) + #13 +
            'Title: ' + FTitle + #13 +
            'DateTimeOfActivity: ' +
            FormatDateTime('dd/mm/yyyy hh:nn', FDateTimeOfActivity) + #13 +
            'Tags: ' + FTags.ToString('', '', False) + #13 +
            'Comments: ' + FComments.ToString + #13 +
            'Favourites ' + FFavourites.ToString;
end;

function TActivity.GetFormattedDateTime: string;
begin 
  // Returns FDateTimeOfActivity as a formatted string
  Result := FormatDateTime('yyyy/mm/dd hh:nn', FDateTimeOfActivity);
end;

function TActivity.GetFavourites: TUserIDs;
begin
  // Returns FFavourites
  Result := FFavourites;
end;

function TActivity.CalculateDurationHours: byte;
begin
  // Returns the duration in hours
  Result := FDuration DIV 3600;
end;

function TActivity.CalculateDurationMinutes: byte;
begin
  // Returns the remaining duration in minutes
  Result := (FDuration MOD 3600) DIV 60;
end;

function TActivity.CalculateDurationSeconds: byte;
begin
  // Returns the remaining duration in seconds
  Result := FDuration - (3600 * CalculateDurationHours) - 
            (60 * CalculateDurationMinutes);
end;

procedure TActivity.SetDuration(Hours, Minutes, Seconds: byte);
begin
  // Sets FDuration from hours, minutes and seconds
  FDuration := (Hours * 3600) + (Minutes * 60) + Seconds;
end;

end.
