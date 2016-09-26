unit uUserIDs;

interface

const
  MAX_USERIDS = 1000;

type
  TUserIDs = class(TObject)
    private
      // Stores a list of UserIDs
      FUserIDs : Array[1..MAX_USERIDS] of integer;
      // Stores the number of UserIDs in the array
      FUserIDCount : smallint;
    public
      // Initialises the count to 0
      constructor Create;
      // Adds a single user ID to the array
      procedure AddUserID(UserID : integer);
      // Deletes a single user ID from the array
      procedure DeleteUserID(UserID : integer);
      // Returns FUserIDCount
      function GetUserIDCount : smallint;
      // Gets the index of the specified UserID in the array or -1 if not found
      function SearchForUserID(UserID : integer) : smallint;
      // Gets the UserID at the specified Index
      function GetUserID(Index : smallint) : integer;
      // Returns all the UserIDs in a single string
      function ToString : string;
  end; // class

implementation

uses SysUtils;

{ TUser }

{ TUserIDs }

procedure TUserIDs.AddUserID(UserID: integer);
begin
  // Check if the UserID already exists in the array
  if SearchForUserID(UserID) = -1 then
  begin
    // If it doesn't, increase the number of items in the array
    Inc(FUserIDCount);
    // Add the new user ID to the array
    FUserIDs[FUserIDCount] := UserID;
  end; // if
end;

constructor TUserIDs.Create;
begin
  // Initialise the number of items in the array to 0
  FUserIDCount := 0;
end;

procedure TUserIDs.DeleteUserID(UserID: integer);
var
  iPos, K : smallint;
begin
  // Get the position of the specified UserID
  iPos := SearchForUserID(UserID);

  // Check if the UserID actually exists in the array
  if iPos > -1 then
  begin
    // If it does exist, delete it
    for K := iPos to FUserIDCount - 1 do
      FUserIDs[K] := FUserIDs[K + 1];

    Dec(FUserIDCount);
  end; // if
end;

function TUserIDs.GetUserID(Index: smallint): integer;
begin
  // Returns the UserID at the specified Index
  Result := FUserIDs[Index];
end;

function TUserIDs.GetUserIDCount: smallint;
begin
  // Returns FUserIDCount
  Result := FUserIDCount;
end;

function TUserIDs.SearchForUserID(UserID: integer): smallint;
var
  bFound : boolean;
  K : smallint;
begin
  // The UserID has not been found yet
  bFound := False;
  Result := -1;

  // Keep looping until the UserID has been found or the end of the array has
  // been reached
  K := 0;
  while (K < FUserIDCount) AND (not bFound) do
  begin
    Inc(K);
    bFound := FUserIDs[K] = UserID;
  end; // while

  // If the UserID was found, return the Index else return -1
  if bFound then
    Result := K;
end;

function TUserIDs.ToString: string;
var
  K : smallint;
begin
  Result := '';

  // Loop through each UserID and add it to a string
  for K := 1 to FUserIDCount - 1 do
    Result := Result + IntToStr(FUserIDs[K]) + ', ';

  Result := Result + IntToStr(FUserIDs[FUserIDCount]);
end;

end.
