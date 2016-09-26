unit uSplashScreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MPlayer, ExtCtrls, OleCtnrs, ComCtrls, uGlobalConstants;

type
  TfrmSplashScreen = class(TForm)
    aniAnimation: TAnimate;
    pnlEmail: TPanel;
    pnlCredit: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplashScreen: TfrmSplashScreen;

implementation

{$R *.dfm}

procedure TfrmSplashScreen.FormCreate(Sender: TObject);
begin
  // Loads the animation to display
  aniAnimation.FileName := ExtractFilePath(Application.ExeName) + 
                           SPLASHSCREEN_FILENAME;
  // Plays the animation once
  aniAnimation.Play(1, 60, 1);
end;

end.
