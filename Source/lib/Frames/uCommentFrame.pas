unit uCommentFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, StdCtrls, uComment, uUser, uDatabaseManager,
  uGlobalConstants;

type
  TfrmCommentFrame = class(TFrame)
    pnlMain: TPanel;
    lblComment: TLabel;
    lblUsername: TLabel;
    imgProfilePicture: TImage;
  private
    // Stores the comment associated with the frame
    FComment : TComment;

    // Refreshes the panel to show the comment's details
    procedure RefreshPanel;
  public
    // Returns the current comment associated with the frame
    function GetComment : TComment;
    // Sets the comment associated with the frame
    procedure SetComment (Comment : TComment);
  end;

implementation

{$R *.dfm}

{ TfrmCommentFrame }

function TfrmCommentFrame.GetComment: TComment;
begin
  // Returns the associated comment
  Result := FComment;
end;

procedure TfrmCommentFrame.RefreshPanel;
var
  objUser: TUser;
  objDatabaseManager : TDatabaseManager;
begin
  // Sets the comment content
  lblComment.Caption := FComment.GetComment;

  // Creates a new database manager to fetch the username of the user who made
  // the comment
  objDatabaseManager := TDatabaseManager.Create;
  objUser := objDatabaseManager.SelectUserByID(FComment.GetUserID);

  lblUsername.Caption := '@' + objUser.GetUsername;

  // Checks if the user has a profile picture
  if objUser.GetProfilePicture = '' then
    // If there is no profile picture, the default is shown
    imgProfilePicture.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + PROFILEPICTURE_DEFAULT)
  else
    // If the user has a profile picture, display it
    imgProfilePicture.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + PROFILE_FOLDER + 
      objUser.GetProfilePicture);
end;

procedure TfrmCommentFrame.SetComment(Comment: TComment);
begin
  // Sets the current comment associated with the frame
  FComment := Comment;

  // Refreshes the frame to show the comment details
  RefreshPanel;
end;

end.
