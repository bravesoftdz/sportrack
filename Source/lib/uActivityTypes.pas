unit uActivityTypes;

interface

uses
  uActivityType;

const
  MAX_ACTIVITYTYPES = 3;

type
  TActivityTypes = class(TObject)
    private
      // Stores the array of activity types
      FActivityTypes : Array [1..MAX_ACTIVITYTYPES] of TActivityType;
      // Stores the number of activity type in the array
      FActivityTypeCount : byte;
    public
      // Initialises the object
      constructor Create;
      // Adds an activity type to the array
      procedure AddActivityType(ActivityType : TActivityType);
      // Gets the activity type at the specified index
      function GetActivityType(Index : byte) : TActivityType;
      // Returns FActivityTypeCount
      function GetActivityTypeCount : byte;
      // Returns all the activity types in a single string
      function ToString : string;
  end; // class

implementation

{ TActivityTypes }

procedure TActivityTypes.AddActivityType(ActivityType: TActivityType);
begin
  // Increases the number of activity types
  Inc(FActivityTypeCount);
  // Adds the new activity type to the end of the array
  FActivityTypes[FActivityTypeCount] := ActivityType;
end;

constructor TActivityTypes.Create;
begin
  // Initialises the number of activity types to 0
  FActivityTypeCount := 0;
end;

function TActivityTypes.GetActivityType(Index: byte): TActivityType;
begin
  // Returns the activity type at the specified index
  Result := FActivityTypes[Index];
end;

function TActivityTypes.GetActivityTypeCount: byte;
begin
  // Returns FActivityTypeCount
  Result := FActivityTypeCount;
end;

function TActivityTypes.ToString: string;
var
  K : byte;
begin
  Result := '';

  // Loops through each activity type and calls its ToString
  for K := 1 to FActivityTypeCount - 1 do
    Result := Result + FActivityTypes[K].ToString + #13;

  Result := Result + FActivityTypes[FActivityTypeCount].ToString;
end;

end.
