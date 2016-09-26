unit uActivities;

interface

uses
  uActivity;

const
  MAX_ACTIVITIES = 100;

type
  TActivities = class(TObject)
    private
      // Stores an array of all the activities
      FActivities : Array[1..MAX_ACTIVITIES] of TActivity;
      // Stores the number of activities in the array
      FActivityCount : shortint;
    public
      // Initialises the array count
      constructor Create;
      // Adds an activity to the array
      procedure AddActivity(Activity : TActivity);
      // Deletes an activity from the array if it exists
      procedure DeleteActivity(Activity : TActivity);
      // Returns the total number of activities in the array
      function GetActivityCount : shortint;
      // Gets the activity at a specified index
      function GetActivity(Index : shortint) : TActivity;
      // Searches for the index of an activity in the array
      function SearchForActivity(Activity : TActivity) : shortint;
      // Shows all the activities in a string format
      function ToString : string;
  end; // class

implementation

{ TActivities }

procedure TActivities.AddActivity(Activity: TActivity);
begin
  // Increase the number of activities in the array
  Inc(FActivityCount);
  // Add the activity to the end of the array
  FActivities[FActivityCount] := Activity;
end;

constructor TActivities.Create;
begin
  // Initialises the array count
  FActivityCount := 0;
end;

procedure TActivities.DeleteActivity(Activity: TActivity);
var
  K, iPos : shortint;
begin
  // Gets the position of the activity in the array
  iPos := SearchForActivity(Activity);

  // If the activity is in the array
  if iPos > -1 then
  begin
    // Deletes the activity from the array
    for K := iPos to FActivityCount - 1 do
      FActivities[K] := FActivities[K + 1];

    Dec(FActivityCount);
  end; // if
end;

function TActivities.GetActivity(Index: shortint): TActivity;
begin
  // Returns the activity at the specified index
  Result := FActivities[Index];
end;

function TActivities.GetActivityCount: shortint;
begin
  // Returns the total number of activities in the array
  Result := FActivityCount;
end;

function TActivities.SearchForActivity(Activity: TActivity): shortint;
var
  bFound : boolean;
  K : shortint;
begin
  // Initially the activity wasn't found
  bFound := False;
  Result := -1;

  // Go through the array and only stop when an activity has been found or 
  // when the end of the array has been reached
  K := 0;
  while (K < FActivityCount) AND (not bFound) do
  begin
    Inc(K);
    bFound := FActivities[K] = Activity;
  end; // while

  // If a result was found, then return the index, else -1 is returned
  if bFound then
    Result := K;
end;

function TActivities.ToString: string;
var
  K : shortint;
begin
  Result := '';

  // Loops through each activity and calls its ToString method
  for K := 1 to FActivityCount do
    Result := Result + '=============================' + #13 +
              FActivities[K].ToString + #13;

  Result := Result + '=============================';
end;

end.
