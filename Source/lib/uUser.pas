unit uUser;

interface

uses
  uUserIDs, SysUtils, DateUtils, uGender;

type
  TUser = class(TObject)
    private
      // Stores the ID of the user
      FUserID : integer;
      // Stores the user's username
      FUsername : string;
      // Stores the user's email address
      FEmailAddress : string;
      // Stores the user's ENCRYPTED password
      FPassword : string;
      // Stores the user's display name
      FDisplayName : string;
      // Stores the user's motto
      FMotto : string;
      // Stores the user's date of birth
      FDateOfBirth : TDateTime;
      // Stores the user's gender
      FGender : TGender;
      // Stores the user's weight (kg)
      FWeight : real;
      // Stores the user's height (cm)
      FHeight : word;
      // Stores the filename of the user's profile picture
      FProfilePicture : string;
      // Stores the filename of the user's cover photo
      FCoverPhoto : string;
      // Stores an array of all users following the current user
      FFollowers : TUserIDs;
      // Stores an array of all users the current user is busy following
      FFollowing : TUserIDs;
      // Encrypts a plain text password
      function EncryptPassword(Password : string) : string;
    public
      // Creates a new user using values from the database
      constructor Create(UserID : integer; Username, EmailAddress, Password,
                         DisplayName, Motto : string; DateOfBirth : TDateTime;
                         Gender : TGender; Weight : real; Height : word;
                         ProfilePicture, CoverPhoto : string; Following,
                         Followers : TUserIDs); overload;
      // Creates a new user using values from the app to be saved to the 
      // database
      constructor Create(Username, EmailAddress, Password, DisplayName,
                         Motto : string; DateOfBirth : TDateTime;
                         Gender : TGender; Weight : real; Height : word;
                         ProfilePicture, CoverPhoto : string); overload;
      // Returns FUserID
      function GetUserID : integer;
      // Returns FUsername
      function GetUsername : string;
      // Returns FEmailAddress
      function GetEmailAddress : string;
      // Returns FDisplayName
      function GetDisplayName : string;
      // Returns FMotto
      function GetMotto : string;
      // Returns FDateOfBirth
      function GetDateOfBirth : TDateTime;
      // Returns FGender
      function GetGender : TGender;
      // Returns FPassword (ENCRYPTED)
      function GetPassword : string;
      // Returns FWeight
      function GetWeight : real;
      // Returns FHeight
      function GetHeight : word;
      // Returns FProfilePicture
      function GetProfilePicture : string;
      // Returns FCoverPhoto
      function GetCoverPhoto : string;
      // Returns FFollowing
      function GetFollowing : TUserIDs;
      // Returns FFollowers
      function GetFollowers : TUserIDs;
      // Sets FUsername
      procedure SetUsername(Username : string);
      // Sets FEmailAddress
      procedure SetEmailAddress(EmailAddress : string);
      // Sets FPassword
      procedure SetPassword(Password : string);
      // Sets FDisplayName
      procedure SetDisplayName(DisplayName : string);
      // Sets FMotto
      procedure SetMotto(Motto : string);
      // Sets FDateOfBirth
      procedure SetDateOfBirth(DateOfBirth : TDateTime);
      // Sets FGender
      procedure SetGender(Gender : TGender);
      // Sets FWeight
      procedure SetWeight(Weight : real);
      // Sets FHeight
      procedure SetHeight(Height : word);
      // Sets FProfilePicture
      procedure SetProfilePicture(ProfilePicture : string);
      // Sets FCoverPhoto
      procedure SetCoverPhoto(CoverPhoto : string);
      // Returns FGender as a character (M)ale or (F)emale
      function GetGenderAsString : string;
      // Calculates the user's age from their date of birth
      function CalculateAge : byte;
      // Adds a user that is busy following the current user
      procedure AddUserBusyFollowing(UserID : integer);
      // Deletes a user that was following the current user
      procedure DeleteUserBusyFollowing(UserID : integer);
      // Checks if the user is being followed by another specified user
      function IsUserBeingFollowedBy(UserID : integer) : boolean;
      // Checks to see if a provided password is the same as the encrypted
      // password
      function CheckPassword(PlainTextPassword : string) : boolean;
      // Returns all the user's data as a string
      function ToString : string;
  end; // class

implementation

{ TUser }

procedure TUser.AddUserBusyFollowing(UserID: integer);
begin
  // Adds UserID to FFollowers
  FFollowers.AddUserID(UserID);
end;

function TUser.CalculateAge: byte;
begin
  // Calculates the age in years
  Result := Trunc(DaysBetween(Date, FDateOfBirth) / 365.25);
end;

function TUser.CheckPassword(PlainTextPassword: string): boolean;
begin
  // Encrypts a plain text password and compares it
  Result := EncryptPassword(PlainTextPassword) = FPassword;
end;

constructor TUser.Create(Username, EmailAddress, Password, DisplayName,
  Motto: string; DateOfBirth: TDateTime; Gender: TGender; Weight: real;
  Height: word; ProfilePicture, CoverPhoto: string);
begin
  // Sets the fields with data provided from the app
  FUserID         := -1;
  FUsername       := Username;
  FEmailAddress   := EmailAddress;
  FPassword       := EncryptPassword(Password);
  FDisplayName    := DisplayName;
  FMotto          := Motto;
  FDateOfBirth    := DateOfBirth;
  FGender         := Gender;
  FWeight         := Weight;
  FHeight         := Height;
  FProfilePicture := ProfilePicture;
  FCoverPhoto     := CoverPhoto;
  FFollowing      := TUserIDs.Create;
  FFollowers      := TUserIDs.Create;
end;

constructor TUser.Create(UserID: integer; Username, EmailAddress, Password,
  DisplayName, Motto: string; DateOfBirth: TDateTime; Gender: TGender;
  Weight: real; Height: word; ProfilePicture, CoverPhoto: string;
  Following, Followers: TUserIDs);
begin
  // Sets the fields with data provided by the database
  FUserID         := UserID;
  FUsername       := Username;
  FEmailAddress   := EmailAddress;
  FPassword       := Password;
  FDisplayName    := DisplayName;
  FMotto          := Motto;
  FDateOfBirth    := DateOfBirth;
  FGender         := Gender;
  FWeight         := Weight;
  FHeight         := Height;
  FProfilePicture := ProfilePicture;
  FCoverPhoto     := CoverPhoto;
  FFollowing      := Following;
  FFollowers      := Followers;
end;

procedure TUser.DeleteUserBusyFollowing(UserID: integer);
begin
  // Deletes a user that was following the current user
  FFollowers.DeleteUserID(UserID);
end;

function TUser.EncryptPassword(Password: string): string;
var
  K : byte;
begin
  Result := '';

  // Goes through each character and performs a customised Caesar Cipher
  for K := 1 to Length(Password) do
  begin
    Result := Result + Chr(Ord(Password[K]) + K);
  end;
end;

function TUser.GetCoverPhoto: string;
begin
  // Returns FCoverPhoto
  Result := FCoverPhoto;
end;

function TUser.GetDateOfBirth: TDateTime;
begin
  // Returns FDateOfBirth
  Result := FDateOfBirth;
end;

function TUser.GetDisplayName: string;
begin
  // Returns FDisplayName
  Result := FDisplayName;
end;

function TUser.GetEmailAddress: string;
begin
  // Returns FEmailAddress
  Result := FEmailAddress;
end;

function TUser.GetFollowers: TUserIDs;
begin
  // Returns FFollowers
  Result := FFollowers;
end;

function TUser.GetFollowing: TUserIDs;
begin
  // Returns FFollowing
  Result := FFollowing;
end;

function TUser.GetGender: TGender;
begin
  // Returns FGender
  Result := FGender;
end;

function TUser.GetGenderAsString: string;
begin
  // Returns FGender as a single character
  if FGender = GenderMale then
    Result := 'M'
  else
    Result := 'F';
end;

function TUser.GetHeight: word;
begin
  // Returns FHeight
  Result := FHeight;
end;

function TUser.GetMotto: string;
begin
  // Returns FMotto
  Result := FMotto;
end;

function TUser.GetPassword: string;
begin
  // Returns FPassword (ENCRYPTED)
  Result := FPassword;
end;

function TUser.GetProfilePicture: string;
begin
  // Returns FProfilePicture
  Result := FProfilePicture;
end;

function TUser.GetUserID: integer;
begin
  // Returns FUserID
  Result := FUserID;
end;

function TUser.GetUsername: string;
begin
  // Returns FUsername
  Result := FUsername;
end;

function TUser.GetWeight: real;
begin
  // Returns FWeight
  Result := FWeight;
end;

function TUser.IsUserBeingFollowedBy(UserID: integer): boolean;
begin
  // Determines whether the current user is being followed by another user
  Result := FFollowers.SearchForUserID(UserID) >= 0;
end;

procedure TUser.SetCoverPhoto(CoverPhoto: string);
begin
  // Sets FCoverPhoto
  FCoverPhoto := CoverPhoto;
end;

procedure TUser.SetDateOfBirth(DateOfBirth: TDateTime);
begin
  // Sets FDateOfBirth
  FDateOfBirth := DateOfBirth;
end;

procedure TUser.SetDisplayName(DisplayName: string);
begin
  // Sets FDisplayName
  FDisplayName := DisplayName;
end;

procedure TUser.SetEmailAddress(EmailAddress: string);
begin
  // Sets FEmailAddress
  FEmailAddress := EmailAddress;
end;

procedure TUser.SetGender(Gender: TGender);
begin
  // Sets FGender
  FGender := Gender;
end;

procedure TUser.SetHeight(Height: word);
begin
  // Sets FHeight
  FHeight := Height;
end;

procedure TUser.SetMotto(Motto: string);
begin
  // Sets FMotto
  FMotto := Motto;
end;

procedure TUser.SetPassword(Password: string);
begin
  // Sets FPassword (first encrypts it)
  FPassword := EncryptPassword(Password);
end;

procedure TUser.SetProfilePicture(ProfilePicture: string);
begin
  // Sets FProfilePicture
  FProfilePicture := ProfilePicture;
end;

procedure TUser.SetUsername(Username: string);
begin
  // Sets FUsername
  FUsername := Username;
end;

procedure TUser.SetWeight(Weight: real);
begin
  // Sets FWeight
  FWeight := Weight;
end;

function TUser.ToString: string;
begin
  // Returns all the fields in a single string
  Result := 'UserID: ' + IntToStr(FUserID) + #13 +
            'Username: ' + FUsername + #13 +
            'Email Address: ' + FEmailAddress + #13 +
            'Password: ********' + #13 +
            'Display Name: ' + FDisplayName + #13 +
            'Motto: ' + FMotto + #13 +
            'Date Of Birth: ' + FormatDateTime('d mmmm yyyy', FDateOfBirth) +
            #13 +
            'Gender: ' + GetGenderAsString + #13 +
            'Weight: ' + FloatToStrF(FWeight, ffGeneral, 4, 2) + 'kg' + #13 +
            'Height: ' + IntToStr(FHeight) + 'cm' + #13 +
            'Profile Picture (path): ' + FProfilePicture + #13 +
            'Cover Photo (path): ' + FCoverPhoto + #13 +
            'Number Followers: ' + IntToStr(FFollowers.GetUserIDCount) + #13 +
            'Number Following: ' + IntToStr(FFollowing.GetUserIDCount);

end;

end.
 