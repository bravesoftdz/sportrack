unit uUsers;

interface

uses
  uUser;

const
  MAX_USERS = 1000;

type
  TUsers = class(TObject)
    private
      // Stores an array of users
      FUsers : Array [1..MAX_USERS] of TUser;
      // Stores the number of users in the array
      FUserCount : smallint;
    public
      // Initialises the array count to 0
      constructor Create;
      // Adds a single user to the array
      procedure AddUser(User : TUser);
      // Deletes a single user from the array
      procedure DeleteUser(User : TUser);
      // Returns FUserCount
      function GetUserCount : smallint;
      // Gets the user at the specified Index
      function GetUser(Index : smallint) : TUser;
      // Returns the index of the specified user
      function SearchForUser(User : TUser) : smallint;
      // Returns all the users in a single string
      function ToString : string;
  end; // class

implementation

{ TUsers }

procedure TUsers.AddUser(User: TUser);
begin
  // Increase the number of users in the array
  Inc(FUserCount);
  // Add the new user to the end of the array
  FUsers[FUserCount] := User;
end;

constructor TUsers.Create;
begin
  // Initialise the number of users in the array to 0
  FUserCount := 0;
end;

procedure TUsers.DeleteUser(User: TUser);
var
  iPos, K : smallint;
begin
  // Gets the position of the user to be deleted in the array
  iPos := SearchForUser(User);

  // Checks to make sure the user exists in the array
  if iPos > -1 then
  begin
    // If the user exists, it deletes them
    for K := iPos to FUserCount - 1 do
      FUsers[K] := FUsers[K + 1];

    Dec(FUserCount);
  end; // if
end;

function TUsers.GetUser(Index: smallint): TUser;
begin
  // Returns the user at the specified index in the array
  Result := FUsers[Index];
end;

function TUsers.GetUserCount: smallint;
begin
  // Returns FUserCount
  Result := FUserCount;
end;

function TUsers.SearchForUser(User: TUser): smallint;
var
  bFound : boolean;
  K : smallint;
begin
  // The user has not been found yet
  bFound := False;
  Result := -1;

  // Keep looping through the users until the user has been found or the end
  // of the array has been reached
  K := 0;
  while (K < FUserCount) AND (not bFound) do
  begin
    Inc(K);
    bFound := FUsers[K].GetUserID = User.GetUserID;
  end; // while

  // If the user was found, return its index else return -1
  if bFound then
    Result := K;
end;

function TUsers.ToString: string;
var
  K : smallint;
begin
  Result := '';

  // Loop through all the users and call each one's ToString object
  for K := 1 to FUserCount do
    Result := Result + '=============================' + #13 +
              FUsers[K].ToString + #13;
              
  Result := Result + '============================='
end;

end.
