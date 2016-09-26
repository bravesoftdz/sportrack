unit uActivityFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, uActivity, uGlobalConstants, uUser,
  uDatabaseManager;

type
  TfrmActivity = class(TFrame)
    pnlContent: TPanel;
    shpActivityTypeCircle: TShape;
    lblUsername: TLabel;
    lblTitle: TLabel;
    lblRate: TLabel;
    lblDuration: TLabel;
    lblDistance: TLabel;
    lblDateTime: TLabel;
    imgActivityType: TImage;
  private
    { Private declarations }
    // Stores the activity that the frame shows
    FActivity : TActivity;

    // Refreshes the frame with the current activity
    procedure RefreshPanel;
  public
    { Public declarations }
    // Sets the activity belonging to the frame
    procedure SetActivity(Activity : TActivity);
    // Returns the activity belonging to the frame
    function GetActivity : TActivity;
  end;

var
  // Used to query the activity details
  objDatabaseManager : TDatabaseManager;

implementation

{$R *.dfm}

{ TfrmActivity }

function TfrmActivity.GetActivity: TActivity;
begin
  // Returns the activity belonging to the frame
  Result := FActivity;
end;

procedure TfrmActivity.RefreshPanel;
var
  objCurrentUser : TUser;
begin
  // Gets the activity type icon
  imgActivityType.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 
    ICON_FOLDER + FActivity.GetActivityType.GetIcon);

  // Sets the title, distance, duration, rate and date time fields
  lblTitle.Caption := FActivity.GetTitle;
  lblDistance.Caption := FActivity.GetFormattedDistance;
  lblDuration.Caption := FActivity.GetFormattedDuration;
  lblRate.Caption := FActivity.CalculateRate;
  lblDateTime.Caption := FActivity.GetFormattedDateTime;

  // Creates a new database manager object and uses it to query for the username
  // belonging to the user of the activity
  objDatabaseManager := TDatabaseManager.Create;
  objCurrentUser := objDatabaseManager.SelectUserByID(FActivity.GetUserID);
  lblUsername.Caption := '@' + objCurrentUser.GetUsername;
end;

procedure TfrmActivity.SetActivity(Activity: TActivity);
begin
  FActivity := Activity;

  RefreshPanel;
end;

end.
