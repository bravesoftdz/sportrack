unit uUserFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, uUser, uGlobalConstants;

type
  TfrmUserFrame = class(TFrame)
    pnlMain: TPanel;
    imgProfilePicture: TImage;
    lblUsername: TLabel;
  private
    // Stores the user associated with the frame
    FUser : TUser;

    // Refreshes the frame to show the user's details
    procedure RefreshPanel;
  public
    // Returns the user associated with the object
    function GetUser : TUser;
    // Sets the user associated with the object
    procedure SetUser (User : TUser);
  end;

implementation

{$R *.dfm}

{ TfrmUserFrame }

function TfrmUserFrame.GetUser: TUser;
begin
  // Returns the associated user
  Result := FUser;
end;

procedure TfrmUserFrame.RefreshPanel;
begin
  // Checks if the user has a profile picture or not
  if FUser.GetProfilePicture = '' then
    // If no profile picture is found, the default one is shown
    imgProfilePicture.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + PROFILEPICTURE_DEFAULT)
  else
    // If the user has a profile picture, it is shown
    imgProfilePicture.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + PROFILE_FOLDER + 
      FUser.GetProfilePicture);

  // Sets the username label
  lblUsername.Caption := FUser.GetUsername;
end;

procedure TfrmUserFrame.SetUser(User: TUser);
begin
  // Sets the associated user
  FUser := User;

  // Refreshes the panel to show the user's details
  RefreshPanel;
end;

end.
