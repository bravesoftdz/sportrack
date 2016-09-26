program pSporTrack;

uses
  Forms,
  SysUtils,
  uActivities in 'lib\uActivities.pas',
  uActivity in 'lib\uActivity.pas',
  uActivityType in 'lib\uActivityType.pas',
  uActivityTypes in 'lib\uActivityTypes.pas',
  uClubStatistics in 'lib\uClubStatistics.pas',
  uComment in 'lib\uComment.pas',
  uComments in 'lib\uComments.pas',
  uDatabaseAccess in 'lib\uDatabaseAccess.pas',
  uDatabaseManager in 'lib\uDatabaseManager.pas',
  uGender in 'lib\uGender.pas',
  uGlobalConstants in 'lib\uGlobalConstants.pas',
  uNavigationManager in 'lib\uNavigationManager.pas',
  uTags in 'lib\uTags.pas',
  uUser in 'lib\uUser.pas',
  uUserIDs in 'lib\uUserIDs.pas',
  uUsers in 'lib\uUsers.pas',
  uSplashScreen in 'lib\Forms\uSplashScreen.pas' {frmSplashScreen},
  uSporTrack in 'lib\Forms\uSporTrack.pas' {frmMain},
  uCommentFrame in 'lib\Frames\uCommentFrame.pas' {frmCommentFrame: TFrame},
  uUserFrame in 'lib\Frames\uUserFrame.pas' {frmUserFrame: TFrame},
  uActivityFrame in 'lib\Frames\uActivityFrame.pas' {frmActivity: TFrame};

{$R *.res}

var
  objSplashScreen : TfrmSplashScreen;
begin
  Application.Initialize;

  // Create a new instance of the splash screen
  objSplashScreen := TfrmSplashScreen.Create(nil);
  // Show the splash screen
  objSplashScreen.Show;
  objSplashScreen.Update;
  // Wait 4 seconds
  Sleep(4000);
  // Hide the splash screen
  objSplashScreen.Hide;
  objSplashScreen.Free;
  // Show the actual application
  Application.Title := 'SporTrack';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
