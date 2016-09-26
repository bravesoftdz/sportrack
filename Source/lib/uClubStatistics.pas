unit uClubStatistics;

interface

type
  TClubStatistics = class(TObject)
    private
      // Stores the total distance travelled in metres
      FDistance : integer;
      // Stores the total time spent in seconds
      FTimeSpent : integer;
    public
      // Creates a new object with values from the database
      constructor Create(Distance, TimeSpent : integer);
      // Returns the distance as a formatted string
      function GetFormattedDistance : string;
      // Returns the time spent as a formatted string
      function GetFormattedTimeSpent : string;
  end; // class

implementation

uses SysUtils;

{ TClubStatistics }

constructor TClubStatistics.Create(Distance, TimeSpent: integer);
begin
  // Sets the fields with values from the database
  FDistance := Distance;
  FTimeSpent := TimeSpent;
end;

function TClubStatistics.GetFormattedDistance: string;
var
  iKilometres : integer;
  iMetres : word;
begin
  // Gets the distance in kilometres and metres
  iKilometres := FDistance DIV 1000;
  iMetres := FDistance MOD 1000;

  // Combines the two into a single string:
  // 00km 00m
  Result := IntToStr(iKilometres) + 'km ' + IntToStr(iMetres) + 'm';
end;

function TClubStatistics.GetFormattedTimeSpent: string;
var
  iDays : integer;
  iHours, iMinutes : byte;
begin
  // Gets the number of days spent
  iDays := FTimeSpent DIV 86400;
  // Gets the number of hours spent
  iHours := (FTimeSpent MOD 86400) DIV 3600;
  // Gets the number of minutes spent
  iMinutes := ((FTimeSpent MOD 86400) MOD 3600) DIV 60;

  // Combines all the times into a single string:
  // 00d 00h 00m
  Result := IntToStr(iDays) + 'd ' + IntToStr(iHours) + 'h ' +
            IntToStr(iMinutes) + 'm';
end;

end.
