unit uActivityType;

interface

type
  TActivityType = class(TObject)
    private
      // Stores the id of the activity type
      FActivityTypeID : integer;
      // Stores the activity type description
      FDescription : string;
      // Stores the name of the icon associated with the activity type
      FIcon : string;
    public
      // Creates a new activity type object using values from the database
      constructor Create(ActivityTypeID : integer; Description, Icon : string);
      // Returns FActivityTypeID
      function GetActivityTypeID : integer;
      // Returns FDescription
      function GetDescription : string;
      // Returns FIcon
      function GetIcon : string;
      // Returns all the details in a string
      function ToString : string;
  end; // class

implementation

{ TActivityType }

uses SysUtils;

constructor TActivityType.Create(ActivityTypeID : integer; Description,
                                 Icon: string);
begin
  // Sets all the fields with values from the database
  FActivityTypeID := ActivityTypeID;
  FDescription := Description;
  FIcon := Icon;
end;

function TActivityType.GetActivityTypeID: integer;
begin
  // Returns FActivityTypeID
  Result := FActivityTypeID;
end;

function TActivityType.GetDescription: string;
begin
  // Returns FDescription
  Result := FDescription;
end;

function TActivityType.GetIcon: string;
begin
  // Returns FIcon
  Result := FIcon;
end;

function TActivityType.ToString: string;
begin
  // Returns all the fields in a single string:
  // [ActivityTypeID]: [Description] (Icon)
  Result := IntToStr(FActivityTypeID) + ': ' + FDescription + ' (' +
            FIcon + ')';
end;

end.
