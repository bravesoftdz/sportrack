unit uSporTrack;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Spin, jpeg, uActivityFrame,
  uGlobalConstants, uUser, uDatabaseManager, uClubStatistics, uGender,
  uActivities, uActivity, uTags, uActivityTypes,
  uNavigationManager, uUsers, uUserFrame, uComment, uComments, uCommentFrame,
  ShellApi;

type
  TfrmMain = class(TForm)
    pgcMain: TPageControl;
    tstMainScreen: TTabSheet;
    shpMainScreenTopBar: TShape;
    tstLoginRegister: TTabSheet;
    shpLoginRegisterDivider: TShape;
    shpLoginRegisterTopBar: TShape;
    lblLoginRegisterClubStatistics: TLabel;
    lblLoginRegisterSignUp: TLabel;
    imgLoginRegisterTimeSpent: TImage;
    imgLoginRegisterDistance: TImage;
    lblLoginRegisterTimeSpent: TLabel;
    lblLoginRegisterDistance: TLabel;
    btnLoginRegisterLogIn: TButton;
    btnLoginRegisterRegister: TButton;
    lblLoginRegisterLoginUsernameEmailAddress: TLabel;
    edtLoginRegisterLoginUsernameEmailAddress: TEdit;
    lblLoginRegisterLoginPassword: TLabel;
    edtLoginRegisterLoginPassword: TEdit;
    lblLoginRegisterRegisterEmailAddress: TLabel;
    edtLoginRegisterRegisterEmailAddress: TEdit;
    edtLoginRegisterRegisterUsername: TEdit;
    lblLoginRegisterRegisterUsername: TLabel;
    edtLoginRegisterRegisterConfirmPassword: TEdit;
    lblLoginRegisterRegisterConfirmPassword: TLabel;
    edtLoginRegisterRegisterPassword: TEdit;
    lblLoginRegisterRegisterPassword: TLabel;
    lblLoginRegisterRegisterGender: TLabel;
    lblLoginRegisterRegisterDateOfBirth: TLabel;
    lblLoginRegisterRegisterWeight: TLabel;
    lblLoginRegisterRegisterHeight: TLabel;
    dtpLoginRegisterRegisterDateOfBirth: TDateTimePicker;
    cbxLoginRegisterRegisterGender: TComboBox;
    sedLoginRegisterRegisterHeight: TSpinEdit;
    lblMainScreenHello: TLabel;
    btnMainScreenLogOut: TButton;
    btnMainScreenMyProfile: TButton;
    btnMainScreenPost: TButton;
    btnMainScreenSearch: TButton;
    tstPostActivity: TTabSheet;
    imgPostActivityPlusIcon: TImage;
    lblPostActivityPostActivity: TLabel;
    btnPostActivityImport: TButton;
    lblPostActivityTitle: TLabel;
    edtPostActivityTitle: TEdit;
    lblPostActivityActivityType: TLabel;
    cbxPostActivityActivityType: TComboBox;
    lblPostActivityDateAndTime: TLabel;
    dtpPostActivityTime: TDateTimePicker;
    dtpPostActivityDate: TDateTimePicker;
    lblPostActivityDuration: TLabel;
    sedPostActivityHours: TSpinEdit;
    lblPostActivityH: TLabel;
    lblPostActivityM: TLabel;
    sedPostActivityMinutes: TSpinEdit;
    lblPostActivityS: TLabel;
    sedPostActivitySeconds: TSpinEdit;
    lblPostActivityDistance: TLabel;
    sedPostActivityDistance: TSpinEdit;
    pnlPostActivityDistanceUnitContainer: TPanel;
    rbtnPostActivityDistanceMetres: TRadioButton;
    rbtnPostActivityDistanceKilometres: TRadioButton;
    lblPostActivityTags: TLabel;
    edtPostActivityTags: TEdit;
    btnPostActivityPost: TButton;
    btnPostActivityCancel: TButton;
    tstSearch: TTabSheet;
    shpSearchTopBar: TShape;
    btnSearchSearch: TButton;
    edtSearchTerm: TEdit;
    btnSearchBack: TButton;
    pnlSearchSearchOptionsContainer: TPanel;
    rbtnSearchSearchUsers: TRadioButton;
    rbtnSearchSearchActivities: TRadioButton;
    tstProfileScreen: TTabSheet;
    sbxProfileScreenMain: TScrollBox;
    imgProfileScreenCoverPhoto: TImage;
    btnProfileScreenBack: TButton;
    btnProfileScreenEdit: TButton;
    shpProfileScreenProfilePictureBackground: TShape;
    imgProfileScreenProfilePicture: TImage;
    lblProfileScreenDisplayName: TLabel;
    lblProfileScreenUsername: TLabel;
    lblProfileScreenLabelAge: TLabel;
    lblProfileScreenAge: TLabel;
    lblProfileScreenLabelGender: TLabel;
    lblProfileScreenGender: TLabel;
    lblProfileScreenLabelFollowers: TLabel;
    lblProfileScreenFollowers: TLabel;
    lblProfileScreenLabelFollowing: TLabel;
    lblProfileScreenFollowing: TLabel;
    shpProfileScreenDivider: TShape;
    lblProfileScreenRecentActivities: TLabel;
    sbxMainScreenActivities: TScrollBox;
    tstEditUserProfile: TTabSheet;
    imgMainScreenLogo: TImage;
    imgLoginRegisterLogo: TImage;
    imgSearchLogo: TImage;
    lblLoginRegisterRegisterEmailErrorMessage: TLabel;
    lblLoginRegisterRegisterUsernameErrorMessage: TLabel;
    lblLoginRegisterRegisterPasswordErrorMessage: TLabel;
    lblLoginRegisterRegisterConfirmPasswordErrorMessage: TLabel;
    lblLoginRegisterRegisterGenderErrorMessage: TLabel;
    sbxEditUserProfileMain: TScrollBox;
    imgEditUserProfileCoverPhoto: TImage;
    shpProfilePicture: TShape;
    imgEditUserProfileProfilePicture: TImage;
    lblEditUserProfileUsername: TLabel;
    btnEditUserProfileChangeCoverPhoto: TButton;
    btnEditUserProfileChangeProfilePicture: TButton;
    edtEditUserProfileDisplayName: TEdit;
    edtEditUserProfileMotto: TEdit;
    lblEditUserProfileDateOfBirth: TLabel;
    dtpEditUserProfileDateOfBirth: TDateTimePicker;
    lblEditUserProfileGender: TLabel;
    cbxEditUserProfileGender: TComboBox;
    lblEditUserProfileWeight: TLabel;
    sedEditUserProfileHeight: TSpinEdit;
    lblEditUserProfileHeight: TLabel;
    lblEditUserProfileKG: TLabel;
    lblEditUserProfileCM: TLabel;
    gbxEditUserProfileAccount: TGroupBox;
    lblEditUserProfileEmailAddress: TLabel;
    edtEditUserProfileEmailAddress: TEdit;
    gbxEditUserProfileChangePassword: TGroupBox;
    lblEditUserProfileOldPassword: TLabel;
    edtEditUserProfileOldPassword: TEdit;
    edtEditUserProfileNewPassword: TEdit;
    lblEditUserProfileNewPassword: TLabel;
    edtEditUserProfileNewPasswordConfirm: TEdit;
    btnEditUserProfileSave: TButton;
    btnEditUserProfileCancel: TButton;
    lblEditUserProfileEmailAddressError: TLabel;
    lblEditUserProfileOldPasswordError: TLabel;
    lblEditUserProfileNewPasswordError: TLabel;
    sedEditUserProfileWeightTrunc: TSpinEdit;
    sedEditUserProfileWeightFrac: TSpinEdit;
    Label1: TLabel;
    lblPostActivityTitleError: TLabel;
    lblPostActivityActivityTypeError: TLabel;
    lblPostActivityDistanceError: TLabel;
    lblPostActivityDurationError: TLabel;
    tstViewIndividualActivity: TTabSheet;
    sbxViewIndividualActivityMain: TScrollBox;
    imgViewIndividualActivityActivityTypeIcon: TImage;
    lblViewIndividualActivityTitle: TLabel;
    lblViewIndividualActivityUsername: TLabel;
    imgViewIndividualActivityDateTime: TImage;
    lblViewIndividualActivityDateTime: TLabel;
    imgViewIndividualActivityDistance: TImage;
    lblViewIndividualActivityDistance: TLabel;
    imgViewIndividualActivityRate: TImage;
    lblViewIndividualActivityRate: TLabel;
    imgViewIndividualActivityDuration: TImage;
    lblViewIndividualActivityDuration: TLabel;
    imgViewIndividualActivityTags: TImage;
    lblViewIndividualActivityTags: TLabel;
    btnViewIndividualActivityBack: TButton;
    sbxSearchMain: TScrollBox;
    tstLoading: TTabSheet;
    odlgImportFile: TOpenDialog;
    aniLoading: TAnimate;
    redViewIndividualActivityComment: TRichEdit;
    btnViewIndividualActivityComment: TButton;
    imgViewIndividualActivityLike: TImage;
    lblViewIndividualActivityLikes: TLabel;
    btnViewIndividualActivityEdit: TButton;
    tstEditActivity: TTabSheet;
    btnEditActivityCancel: TButton;
    btnEditActivityUpdate: TButton;
    edtEditActivityTags: TEdit;
    pnlEditActivityDistanceUnitsContainer: TPanel;
    rbtnEditActivityDistanceMetres: TRadioButton;
    rbtnEditActivityDistanceKilometre: TRadioButton;
    sedEditActivityDistance: TSpinEdit;
    sedEditActivityDurationSeconds: TSpinEdit;
    sedEditActivityDurationMinutes: TSpinEdit;
    sedEditActivityDurationHours: TSpinEdit;
    dtpEditActivityDateTimeDate: TDateTimePicker;
    dtpEditActivityDateTimeTime: TDateTimePicker;
    cbxEditActivityActivityType: TComboBox;
    edtEditActivityTitle: TEdit;
    lblEditActivityDurationError: TLabel;
    imgEditActivityEditIcon: TImage;
    lblEditActivityEditActivity: TLabel;
    lblEditActivityTitle: TLabel;
    lblEditActivityTitleError: TLabel;
    lblEditActivityActivityType: TLabel;
    lblEditActivityActivityTypeError: TLabel;
    lblEditActivityDateAndTime: TLabel;
    lblEditActivityDuration: TLabel;
    lblEditActivityDurationM: TLabel;
    lblEditActivityDurationH: TLabel;
    lblEditActivityDurationS: TLabel;
    lblEditActivityDistance: TLabel;
    lblEditActivityDistanceError: TLabel;
    lblEditActivityTags: TLabel;
    btnEditActivityDelete: TButton;
    btnProfileScreenFollowUnfollow: TButton;
    lblLoginRegisterRegisterCM: TLabel;
    lblLoginRegisterRegisterKG: TLabel;
    sedLoginRegisterRegisterWeightTrunc: TSpinEdit;
    lblLoginRegisterRegisterWeightComma: TLabel;
    sedLoginRegisterRegisterWeightFrac: TSpinEdit;
    odlgProfilePicture: TOpenDialog;
    odlgCoverPhoto: TOpenDialog;
    lblProfileScreenMotto: TLabel;
    pnlHelp: TPanel;
    imgHelp: TImage;
    procedure btnLoginRegisterLogInClick(Sender: TObject);
    procedure btnPostActivityImportClick(Sender: TObject);
    procedure btnPostActivityPostClick(Sender: TObject);
    procedure btnPostActivityCancelClick(Sender: TObject);
    procedure btnSearchBackClick(Sender: TObject);
    procedure btnMainScreenSearchClick(Sender: TObject);
    procedure btnProfileScreenBackClick(Sender: TObject);
    procedure btnMainScreenPostClick(Sender: TObject);
    procedure btnMainScreenMyProfileClick(Sender: TObject);
    procedure btnMainScreenLogOutClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnLoginRegisterRegisterClick(Sender: TObject);
    procedure btnEditUserProfileCancelClick(Sender: TObject);
    procedure btnProfileScreenEditClick(Sender: TObject);
    procedure btnEditUserProfileSaveClick(Sender: TObject);
    procedure btnSearchSearchClick(Sender: TObject);
    procedure tstLoadingShow(Sender: TObject);
    procedure btnViewIndividualActivityCommentClick(Sender: TObject);
    procedure imgViewIndividualActivityLikeClick(Sender: TObject);
    procedure btnViewIndividualActivityEditClick(Sender: TObject);
    procedure btnEditActivityUpdateClick(Sender: TObject);
    procedure btnEditActivityDeleteClick(Sender: TObject);
    procedure btnProfileScreenFollowUnfollowClick(Sender: TObject);
    procedure lblViewIndividualActivityUsernameClick(Sender: TObject);
    procedure btnEditUserProfileChangeCoverPhotoClick(Sender: TObject);
    procedure btnEditUserProfileChangeProfilePictureClick(Sender: TObject);
    procedure imgHelpClick(Sender: TObject);
  private
    { Private declarations }
    // Navigates to a tab sheet and optionally resets the page
    procedure GoToTabSheet(TheSheet : TTabSheet; Reset : Boolean);
    // Navigates to the profile tab sheet and loads a user's profile
    procedure GoToProfileTabSheet(Profile : TUser);
    // Navigates to the individual activity screen and loads an activity
    procedure GoToViewIndividualActivitySheet(Activity : TActivity);
    // Navigates to the edit activity screen and loads an activity
    procedure GoToEditActivitySheet(Activity : TActivity);
    // Loads all the images at runtime to reduce the executable's size
    procedure LoadImages;
    // Refreshes the tstLoginRegister sheet
    procedure RefreshLoginRegister;
    // Refreshes the tstMainScreen sheet
    procedure RefreshMainScreen;
    // Refreshes the tstEditUserProfile sheet
    procedure RefreshEditUserProfile;
    // Refreshes the tstPostActivity sheet
    procedure RefreshPostActivity;
    // Refreshes the tstSearch sheet
    procedure RefreshSearch;

    // Loads a list of all the activity types into the specified combobox
    procedure LoadActivityTypes(ComboBox : TComboBox);

    // Handles navigating to the previous page using objNavigationManager
    procedure NavigateToPreviousPage;

    // Method that is run everytime the title of an activity is clicked
    procedure OnFrmActivityClick(Sender: TObject);
    // Method that is run everytime the username of a user is clicked
    procedure OnFrmUserClick(Sender: TObject);
    // Method that is run everytime the username of a user is clicked on an
    // activity
    procedure OnFrmActivityUsernameClick(Sender : TObject);
    // Method that is run everytime the username of a user is clicked on a
    // comment
    procedure OnFrmCommentUsernameClick(Sender : TObject);
    // Method that is responsible for rendering a list of activities in
    // some sort of container.  The distance of the first activity from the top
    // of the container can be specified.
    procedure DisplayActivities(Activities : TActivities;
                                FrameParent : TWinControl; Top : word);
    // Method that is responsible for rendering a list of users in some sort of
    // container.  The distance of the first user from the top of the container
    // can be specified
    procedure DisplayUsers(Users : TUsers; FrameParent : TWinControl;
                           Top : word);
    // Method that is responsible for rendering a list of comments in some sort
    // of container.  The distance of the first comment from the top of the
    // container can be specified.
    procedure DisplayComments(Comments : TComments; FrameParent : TWinControl;
                              Top : word);

    // Clears any elements that can be inside a container
    procedure EmptyContainer(Container : TWinControl);
    // Clears all comments inside a container
    procedure EmptyContainerComments(Container : TWinControl);
    // Clears all activities inside a container
    procedure EmptyContainerActivities(Container : TWinControl);
    // Clears all users inside a container
    procedure EmptyContainerUsers(Container : TWinControl);

    // Validates registration fields and displays the suitable error messages.
    // Returns true if all the data is valid
    function ValidateRegistrationFields : boolean;
    // Validates the fields on tstEditUserProfile sheet and displays suitable
    // error messages. Returns true if all data is valid
    function ValidateEditUserProfileFields : boolean;
    // Validates the fields on tstPostActivity sheet and displays suitable error
    // messages. Returns true if all data is valid
    function ValidatePostActivityFields : boolean;
    // Validates the fields on tstEditActivity sheet and displats suitable error
    // messages. Returns true if all data is valid
    function ValidateEditActivityFields : boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  // Contains the current logged in user
  objLoggedInUser : TUser;
  // Used to query data from the database
  objDatabaseManager : TDatabaseManager;
  // Used to manage all the navigation between sheets
  objNavigationManager : TNavigationManager;
  // Used to store the current activities being viewed and edited
  objCurrentlyViewedActivity, objCurrentlyEditedActivity : TActivity;
  // Used to store the current user being viewed
  objCurrentlyViewedUser : TUser;
  // Used to store the paths to the cover photo and profile picture when they
  // are being chosen on the edit user profile screen
  sCoverPhotoPath, sProfilePicturePath : string;

implementation

uses Math, StrUtils;

{$R *.dfm}

procedure TfrmMain.btnLoginRegisterLogInClick(Sender: TObject);
var
  objTempUser : TUser;
begin
  // Check if the user entered an email address or username
  if Pos('@', edtLoginRegisterLoginUsernameEmailAddress.Text) > 0 then
    // If the user entered an email address, retrieve the user with that
    // email address in the database
    objTempUser := objDatabaseManager.SelectUserByEmailAddress(
                     LowerCase(edtLoginRegisterLoginUsernameEmailAddress.Text))
  else
    // If the user entered a username, retrieve the user with that username
    // in the database
    objTempUser := objDatabaseManager.SelectUserByUsername(
                     LowerCase(edtLoginRegisterLoginUsernameEmailAddress.Text));

  // Check to see if the user that was queried actually exists
  if objTempUser <> nil then
  begin
    // If the user exists, check that the password they entered matches the
    // encrypted password in the database
    if objTempUser.CheckPassword(edtLoginRegisterLoginPassword.Text) then
    begin
      // If the passwords match, set the current logged in user to the user
      // queried from the database
      objLoggedInUser := objTempUser;
      // Redirect the user to the main screen and refresh it
      GoToTabSheet(tstMainScreen, True);
    end
    else
      // If the user did not enter the correct password, notify them
      MessageDlg('Incorrect login credentials.', mtError, [mbOK], 0);
  end
  else
    // If the user does not exist in the database, notify them that they may
    // have entered the wrong credentials
    MessageDlg('Incorrect login credentials.', mtError, [mbOK], 0);
end;

procedure TfrmMain.btnPostActivityImportClick(Sender: TObject);
var
  tFile : TextFile;
  sActivityType, sDateTimeOfActivity, sDuration, sDistance : string;
  dtDateTime : TDateTime;
  iDuration, iDistance : integer;
  K : byte;
  bFound : boolean;
begin
  // Check if the user clicked OK on the dialog
  if odlgImportFile.Execute then
  begin
    // If they chose to import a file, assign it and reset it
    AssignFile(tFile, odlgImportFile.FileName);
    Reset(tFile);

    // Check that we aren't at the end of the file (error handling)
    if not Eof(tFile) then
    begin
      // If there is a line, read it as the activity type
      Readln(tFile, sActivityType);

      // Search for the activity in the combobox of activity types and set
      // ItemIndex to the correct index
      bFound := False;
      K := 1;
      while (K <= cbxPostActivityActivityType.Items.Count) AND (not bFound) do
      begin
        if cbxPostActivityActivityType.Items[K] = sActivityType then
        begin
          cbxPostActivityActivityType.ItemIndex := K;
          bFound := True;
        end;

        Inc(K);
      end;
    end;

    // Check if we are at the end of the file yet (error handling)
    if not Eof(tFile) then
    begin
      // Read the next line as the datetime of the activity
      Readln(tFile, sDateTimeOfActivity);

      // Try and parse the datetime of the activity
      if TryStrToDateTime(sDateTimeOfActivity, dtDateTime) then
      begin
        // If it could be parsed, set the relevant fields
        dtpPostActivityDate.DateTime := dtDateTime;
        dtpPostActivityTime.DateTime := dtDateTime;
      end
      else
        // State that the DateTime could not be read
        ShowMessage('Could not read the DateTime.');
    end;

    // Check if we are at the end of the file yet (error handling)
    if not Eof(tFile) then
    begin
      // Read the next line as the duration of the activity
      Readln(tFile, sDuration);

      // Try and parse the line that was read to an integer
      if TryStrToInt(sDuration, iDuration) then
      begin
        // Split the duration(seconds) into hours, minutes and seconds
        sedPostActivityHours.Value := iDuration DIV 3600;
        sedPostActivityMinutes.Value := Math.Floor(((iDuration / 3600) -
                                        (iDuration DIV 3600)) * 60);
        sedPostActivitySeconds.Value := iDuration -
                                        (sedPostActivityHours.Value * 3600) -
                                        (sedPostActivityMinutes.Value * 60);
      end
      else
        // State that the duration coul not be read
        ShowMessage('Could not read duration of activity');
    end;

    // Check if we are at the end of the file yet (error handling)
    if not Eof(tFile) then
    begin
      // Read the next line as the distance travelled
      Readln(tFile, sDistance);

      // Try and parse the distance travelled as an integer
      if TryStrToInt(sDistance, iDistance) then
      begin
        // If it is valid, set the field and change the units to metres
        sedPostActivityDistance.Value := iDistance;
        rbtnPostActivityDistanceMetres.Checked := True;
      end
      else
        // State that the distance was not read
        ShowMessage('Distance could not be read');
    end
    else
      // If we were already at the end of the file, display an error message
      // informing the user that the file was in the wrong format
      ShowMessage('File could not be read');

    // Close our file when we are done with it
    CloseFile(tFile);
  end;
end;

procedure TfrmMain.btnPostActivityPostClick(Sender: TObject);
var
  objActivity : TActivity;
  iDuration, iDistance : integer;
begin
  // Check to see that all the fields contain valid data
  if ValidatePostActivityFields then
  begin
    // If they did, start getting the values
    // Get the duration from the hours, minutes and seconds numeric boxes
    iDuration := sedPostActivityHours.Value * 3600 +
                 sedPostActivityMinutes.Value * 60 +
                 sedPostActivitySeconds.Value;

    // Check what unit the distance was entered in and convert it to metres
    // if necessary
    if rbtnPostActivityDistanceKilometres.Checked then
      iDistance := sedPostActivityDistance.Value * 1000
    else
      iDistance := sedPostActivityDistance.Value;

    // Create a new activity object to be inserted into the database
    objActivity := TActivity.Create(
                      objLoggedInUser.GetUserID,
                      objDatabaseManager.SelectActivityTypeByDescription(
                        cbxPostActivityActivityType.Text),
                      iDuration,
                      iDistance,
                      edtPostActivityTitle.Text,
                      // Gets the date from the one DateTimePicker and the
                      // time from the other DateTimePicker
                      VarToDateTime(FormatDateTime('yyyy/mm/dd',
                                    dtpPostActivityDate.DateTime) + ' ' +
                                    FormatDateTime('hh:nn:ss',
                                    dtpPostActivityTime.DateTime)),
                      TTags.Create(edtPostActivityTags.Text));

    // Executes an insert statement to insert the activity into the database
    objDatabaseManager.InsertActivity(objActivity);

    // Inform the navigation manager that certain sheets need to be refreshed
    // to reflect the new activity
    objNavigationManager.NeedToRefreshActivityChanges;

    // Go back to the previous page
    NavigateToPreviousPage;
  end;
end;

procedure TfrmMain.btnPostActivityCancelClick(Sender: TObject);
begin
  // If the user cancelled posting a new activity, simply go back to the
  // previous page
  NavigateToPreviousPage;
end;

procedure TfrmMain.btnSearchBackClick(Sender: TObject);
begin
  // Navigates the user to the previous page from the tstSearch sheet
  NavigateToPreviousPage;
end;

procedure TfrmMain.btnMainScreenSearchClick(Sender: TObject);
begin
  // Navigates the user to the search screen and refreshes the screen
  GoToTabSheet(tstSearch, True);
end;

procedure TfrmMain.btnProfileScreenBackClick(Sender: TObject);
begin
  // Navigates the user to the previous page after clicking back on the profile
  // screen
  NavigateToPreviousPage;
end;

procedure TfrmMain.btnMainScreenPostClick(Sender: TObject);
begin
  // Navigates the user to the post activity screen and refreshes it
  GoToTabSheet(tstPostActivity, True);
end;

procedure TfrmMain.btnMainScreenMyProfileClick(Sender: TObject);
begin
  // Navigates the user to the profile tab sheet and shows them their own
  // profile
  GoToProfileTabSheet(objLoggedInUser);
end;

procedure TfrmMain.btnMainScreenLogOutClick(Sender: TObject);
begin
  // Resets the navigation manager
  objNavigationManager := TNavigationManager.Create;

  // Redirect the user to the login screen when they log out
  GoToTabSheet(tstLoginRegister, True);

  // Signs the user out of the application
  objLoggedInUser := nil;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  // Show the loading page
  pgcMain.ActivePage := tstLoading;

  // Create a new instance of the database manager class so that communication
  // with the database can occur
  objDatabaseManager := TDatabaseManager.Create;

  // Create a new instance of our navigation manager class to handle the
  // navigation between the different pages
  objNavigationManager := TNavigationManager.Create;

  // Load all the images at runtime to reduce the size of the executable
  LoadImages;

  // Redirect the user to the login/register screen the moment they start
  // the application
  GoToTabSheet(tstLoginRegister, True);
end;

procedure TfrmMain.GoToTabSheet(TheSheet: TTabSheet; Reset: Boolean);
begin
  // Check if the page being redirected to should be reset/refreshed;
  if Reset then
  begin
    pgcMain.ActivePage := tstLoading;
    // Check which page is being navigated to and refresh the appropriate page
    if TheSheet = tstLoginRegister then
      RefreshLoginRegister
    else if TheSheet = tstMainScreen then
      RefreshMainScreen
    else if TheSheet = tstEditUserProfile then
      RefreshEditUserProfile
    else if TheSheet = tstPostActivity then
      RefreshPostActivity
    else if TheSheet = tstSearch then
      RefreshSearch;
  end;

  // Add the page to our navigation manager
  objNavigationManager.PushScreen(TheSheet);

  // Redirect the user to the destination page
  pgcMain.ActivePage := TheSheet;
end;

procedure TfrmMain.LoadImages;
var
  sLogoPath : string;
begin
  // Set the logos
  sLogoPath := ExtractFilePath(Application.ExeName) + LOGO_FILENAME;

  imgLoginRegisterLogo.Picture.LoadFromFile(sLogoPath);
  imgMainScreenLogo.Picture.LoadFromFile(sLogoPath);
  imgSearchLogo.Picture.LoadFromFile(sLogoPath);

  // Set the registration screen icons
  imgLoginRegisterTimeSpent.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                                 TIMESPENT_FILENAME);
  imgLoginRegisterDistance.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                                DISTANCE_FILENAME);
end;

procedure TfrmMain.RefreshLoginRegister;
var
  objClubStatistics : TClubStatistics;
begin
  // Set all the input fields to their default values
  edtLoginRegisterLoginUsernameEmailAddress.Clear;
  edtLoginRegisterLoginPassword.Clear;
  edtLoginRegisterRegisterEmailAddress.Clear;
  edtLoginRegisterRegisterUsername.Clear;
  edtLoginRegisterRegisterPassword.Clear;
  edtLoginRegisterRegisterConfirmPassword.Clear;
  sedLoginRegisterRegisterHeight.Value := 0;
  sedLoginRegisterRegisterWeightTrunc.Value := 0;
  sedLoginRegisterRegisterWeightFrac.Value := 0;
  dtpLoginRegisterRegisterDateOfBirth.DateTime := Now;
  cbxLoginRegisterRegisterGender.ItemIndex := -1;

  // Reset all the error messages
  lblLoginRegisterRegisterEmailErrorMessage.Caption := '';
  lblLoginRegisterRegisterUsernameErrorMessage.Caption := '';
  lblLoginRegisterRegisterPasswordErrorMessage.Caption := '';
  lblLoginRegisterRegisterConfirmPasswordErrorMessage.Caption := '';
  lblLoginRegisterRegisterGenderErrorMessage.Caption := '';

  // Query the latest club statistics
  objClubStatistics := objDatabaseManager.SelectClubStatistics;

  // Display out club statistics
  lblLoginRegisterTimeSpent.Caption := objClubStatistics.GetFormattedTimeSpent;
  lblLoginRegisterDistance.Caption := objClubStatistics.GetFormattedDistance;
end;

function TfrmMain.ValidateRegistrationFields: boolean;
var
  sEmailAddress, sUsername, sPassword, sConfirmPassword : string;
begin
  // Retrieve all fields that need to be validated
  sEmailAddress := LowerCase(edtLoginRegisterRegisterEmailAddress.Text);
  sUsername := LowerCase(edtLoginRegisterRegisterUsername.Text);
  sPassword := edtLoginRegisterRegisterPassword.Text;
  sConfirmPassword := edtLoginRegisterRegisterConfirmPassword.Text;

  // Clear all the error messages
  lblLoginRegisterRegisterEmailErrorMessage.Caption := '';
  lblLoginRegisterRegisterUsernameErrorMessage.Caption := '';
  lblLoginRegisterRegisterPasswordErrorMessage.Caption := '';
  lblLoginRegisterRegisterConfirmPasswordErrorMessage.Caption := '';
  lblLoginRegisterRegisterGenderErrorMessage.Caption := '';

  // Check that all the fields are valid
  Result := True;

  // Check that the email address is not empty
  if Length(sEmailAddress) > 0 then
  begin
    // Check if it is an email address by making sure that it contains an "@"
    // sign
    if Pos('@', sEmailAddress) = 0 then
    begin
      // If it is not an email address then set the appropriate error message
      lblLoginRegisterRegisterEmailErrorMessage.Caption := 'Please enter in a ' +
                                                           'valid email address';

      // The data is no longer valid so set the Result to False
      Result := False;
    end
    else
    begin
      // If a valid email address was entered, check to see if the email
      // already exists in the database
      if objDatabaseManager.SelectUserByEmailAddress(sEmailAddress) <> nil then
      begin
        // If the email address already exists, set the appropriate error
        // message
        lblLoginRegisterRegisterEmailErrorMessage.Caption := 'Email address '+
                                                             'already taken';

        // The data is no longer valid so set Result to False
        Result := False;
      end;
    end;
  end
  else
  begin
    // If the input field is empty, set the appropriate error message
    lblLoginRegisterRegisterEmailErrorMessage.Caption := 'Email address required';

    // The data is no longer valid so set Result to False
    Result := False;
  end;

  // Check that the username field contains text
  if Length(sUsername) > 0 then
  begin
    // If the username is not blank, check if it already exists in the database
    if objDatabaseManager.SelectUserByUsername(sUsername) <> nil then
    begin
      // If the username already exists, set the appropriate error message
      lblLoginRegisterRegisterUsernameErrorMessage.Caption := 'Username is ' +
                                                              'already taken';

      // The data is no longer valid so set Result to False
      Result := False;
    end;
  end
  else
  begin
    // If the field was left blank, set the appropriate error message
    lblLoginRegisterRegisterUsernameErrorMessage.Caption := 'Username required';

    // The data is no longer valid so set Result to False
    Result := False;
  end;

  // Check the password is long enough
  if Length(sPassword) < 8 then
  begin
    // If the password is not long enough, set the appropriate error message
    lblLoginRegisterRegisterPasswordErrorMessage.Caption := 'Password must be ' +
                                                            'at least 8 ' +
                                                            'characters long';

    // The data is no longer valid so set Result to False
    Result := False;
  end;

  // Check to make sure the passwords are the same
  if sPassword <> sConfirmPassword then
  begin
    // If the passwords do not match, set the appropriate error message
    lblLoginRegisterRegisterConfirmPasswordErrorMessage.Caption := 'Passwords ' +
                                                                   'do not ' +
                                                                   'match';

    // The data is no longer valid so set Result to False
    Result := False;
  end;

  // Check to see if a gender was not selected
  if cbxLoginRegisterRegisterGender.ItemIndex = -1 then
  begin
    // If no gender was selected, set the appropriate error message
    lblLoginRegisterRegisterGenderErrorMessage.Caption := 'Please select your '+
                                                          'gender';

    // The data is no longer valid so set Result to False
    Result := False;
  end;
end;

procedure TfrmMain.btnLoginRegisterRegisterClick(Sender: TObject);
var
  sEmailAddress, sUsername, sPassword : string;
  dtDateOfBirth : TDateTime;
  objGender : TGender;
  rWeight : real;
  iHeight : word;
  objUserToInsert : TUser;
begin
  // Check that the fields are all valid
  if ValidateRegistrationFields then
  begin
    pgcMain.ActivePage := tstLoading;

    // If all the fields are valid, retrieve all the data
    sEmailAddress := LowerCase(edtLoginRegisterRegisterEmailAddress.Text);
    sUsername := LowerCase(edtLoginRegisterRegisterUsername.Text);
    sPassword := edtLoginRegisterRegisterPassword.Text;
    dtDateOfBirth := dtpLoginRegisterRegisterDateOfBirth.DateTime;
    rWeight := StrToFloat(IntToStr(sedLoginRegisterRegisterWeightTrunc.Value) +
                          DecimalSeparator +
                          IntToStr(sedLoginRegisterRegisterWeightFrac.Value));
    iHeight := sedLoginRegisterRegisterHeight.Value;

    // Check which gender was selected in the combobox so that we can correctly
    // asssign the gender variable
    if cbxLoginRegisterRegisterGender.ItemIndex = 0 then
      objGender := GenderMale
    else
      objGender := GenderFemale;

    // Create a new user object to insert into the database
    objUserToInsert := TUser.Create(
                          sUsername,
                          sEmailAddress,
                          sPassword,
                          sUsername,
                          '',
                          dtDateOfBirth,
                          objGender,
                          rWeight,
                          iHeight,
                          '',
                          '');

    // Insert the user into the database
    objDatabaseManager.InsertUser(objUserToInsert);

    // Logs the new user it
    objLoggedInUser := objUserToInsert;
    // Redirects the user to their main screen and refreshes it
    GoToTabSheet(tstMainScreen, True);
  end;
end;

procedure TfrmMain.RefreshMainScreen;
begin
  // Sets the label at the top of the main screen to show their username
  lblMainScreenHello.Caption := 'Hello, ' + objLoggedInUser.GetUsername;

  // Displays all the activities from users the current user is following as
  // well as their own activities
  DisplayActivities(objDatabaseManager
    .SelectActivitiesByUsersBeingFollowed(objLoggedInUser),
    sbxMainScreenActivities, 8);
end;

procedure TfrmMain.GoToProfileTabSheet(Profile: TUser);
var
  objActivities : TActivities;
begin
  // Shows the user the loading page
  pgcMain.ActivePage := tstLoading;

  // Checks if the user has a cover photo yet
  if Profile.GetCoverPhoto = '' then
    // If the user has not cover photo, the app shows the default one
    imgProfileScreenCoverPhoto.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + COVERPHOTO_DEFAULT)
  else
    // If the user has a cover photo, the app shows that one
    imgProfileScreenCoverPhoto.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + COVER_FOLDER +
      Profile.GetCoverPhoto);

  // Checks if the user has a profile picture yet
  if Profile.GetProfilePicture = '' then
    // If the user has no profile picture, the app shows the default one
    imgProfileScreenProfilePicture.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + PROFILEPICTURE_DEFAULT)
  else
    // If the user has a profile picture, the app shows it
    imgProfileScreenProfilePicture.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + PROFILE_FOLDER +
      Profile.GetProfilePicture);

  // Sets all the relevant fields on the screen to the user's details
  lblProfileScreenDisplayName.Caption := Profile.GetDisplayName;
  lblProfileScreenUsername.Caption := '@' + Profile.GetUsername;
  lblProfileScreenMotto.Caption := Profile.GetMotto;
  lblProfileScreenAge.Caption := IntToStr(Profile.CalculateAge);
  lblProfileScreenGender.Caption := Profile.GetGenderAsString;
  lblProfileScreenFollowers.Caption := IntToStr(Profile.GetFollowers.GetUserIDCount);
  lblProfileScreenFollowing.Caption := IntToStr(Profile.GetFollowing.GetUserIDCount);

  // Determines if the user should be able to edit the profile
  btnProfileScreenEdit.Visible := Profile.GetUserID = objLoggedInUser.GetUserID;
  // Determines if the user should be able to follow/unfollow the profile
  btnProfileScreenFollowUnfollow.Visible := Profile.GetUserID
                                            <> objLoggedInUser.GetUserID;

  // Determines if the logged in user is following the viewed profile or not
  if Profile.IsUserBeingFollowedBy(objLoggedInUser.GetUserID) then
    // If the user is following the profile, let them unfollow it
    btnProfileScreenFollowUnfollow.Caption := 'Unfollow'
  else
    // If the user if not following the profile, let them follow it
    btnProfileScreenFollowUnfollow.Caption := 'Follow';

  // Gets the user's last three posted activities
  objActivities := objDatabaseManager.SelectNActivitiesByUser(Profile, 3);

  // Displays the user's last three activities
  DisplayActivities(objActivities, sbxProfileScreenMain, 497);

  // Add the page to our navigation manager
  objNavigationManager.PushScreen(tstProfileScreen);

  // Sets the currently being viewed profile to the current profile
  objCurrentlyViewedUser := Profile;

  // Informs the navigation manager of the profile being viewed
  objNavigationManager.SetLastViewedProfile(Profile);

  // Redirects the user to the profile screen
  pgcMain.ActivePage := tstProfileScreen;
end;

procedure TfrmMain.RefreshEditUserProfile;
begin
  // Gets the user's cover photo and assigns it to the global variable so it
  // can be retrieved later if the photo isn't changed
  sCoverPhotoPath := objLoggedInUser.GetCoverPhoto;

  // Checks to see if the user already has a cover photo assigned or not
  if objLoggedInUser.GetCoverPhoto = '' then
    // If the user has no cover photo, show the default one
    imgEditUserProfileCoverPhoto.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + COVERPHOTO_DEFAULT)
  else
    // If the user has a cover photo, show it
    imgEditUserProfileCoverPhoto.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + COVER_FOLDER +
      objLoggedInUser.GetCoverPhoto);

  // Gets the user's profile picture and assigns it to the global variable so it
  // can be retrieved later if the picture isn't changed
  sProfilePicturePath := objLoggedInUser.GetProfilePicture;

  // Checks to see if the user already has a profile picture assigned or not
  if objLoggedInUser.GetProfilePicture = '' then
    // If the user has no profile picture, show the default one
    imgEditUserProfileProfilePicture.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + PROFILEPICTURE_DEFAULT)
  else
    // If the user has a profile picture, show it
    imgEditUserProfileProfilePicture.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + PROFILE_FOLDER +
      objLoggedInUser.GetProfilePicture);

  // Sets the display name, motto and date of birth fields
  edtEditUserProfileDisplayName.Text := objLoggedInUser.GetDisplayName;
  edtEditUserProfileMotto.Text := objLoggedInUser.GetMotto;
  dtpEditUserProfileDateOfBirth.DateTime := objLoggedInUser.GetDateOfBirth;

  // Sets the username label
  lblEditUserProfileUsername.Caption := '@' + objLoggedInUser.GetUsername;

  // Checks if the user is male or female and sets the correct combobox item
  if objLoggedInUser.GetGender = GenderMale then
    cbxEditUserProfileGender.ItemIndex := 0
  else
    cbxEditUserProfileGender.ItemIndex := 1;

  // Splits the user's weight into its trunc and frac parts and assigns
  // each to its own combobox
  sedEditUserProfileWeightTrunc.Value := Trunc(objLoggedInUser.GetWeight);
  sedEditUserProfileWeightFrac.Value := Floor(
                                          (Frac(objLoggedInUser.GetWeight) *
                                          100) + 0.499999);

  // Sets the height and email address fields
  sedEditUserProfileHeight.Value := objLoggedInUser.GetHeight;
  edtEditUserProfileEmailAddress.Text := objLoggedInUser.GetEmailAddress;
end;

procedure TfrmMain.OnFrmActivityClick(Sender: TObject);
begin
  // Gets the activity object from the frame and redirects the user to the
  // activity
  GoToViewIndividualActivitySheet(
    ((Sender as TLabel).Parent.Parent as TfrmActivity).GetActivity);
end;

procedure TfrmMain.btnEditUserProfileCancelClick(Sender: TObject);
begin
  // Navigates the user to the previous page when the cancel editing their
  // profile
  NavigateToPreviousPage;
end;

procedure TfrmMain.btnProfileScreenEditClick(Sender: TObject);
begin
  // Navigates the user to the edit profile sheet and resets it
  GoToTabSheet(tstEditUserProfile, True);
end;

procedure TfrmMain.btnEditUserProfileSaveClick(Sender: TObject);
begin
  // Checks that all the fields contain valid data
  if ValidateEditUserProfileFields then
  begin
    // Shows the loading screen
    pgcMain.ActivePage := tstLoading;

    // Sets the user's cover photo and profile picture
    objLoggedInUser.SetCoverPhoto(sCoverPhotoPath);
    objLoggedInUser.SetProfilePicture(sProfilePicturePath);

    // Retrieves the display name, motto and date of birth and sets them
    objLoggedInUser.SetDisplayName(edtEditUserProfileDisplayName.Text);
    objLoggedInUser.SetMotto(edtEditUserProfileMotto.Text);
    objLoggedInUser.SetDateOfBirth(dtpEditUserProfileDateOfBirth.DateTime);

    // Checks what index the user selected and set the appropriate gender enum
    if cbxEditUserProfileGender.ItemIndex = 0 then
      objLoggedInUser.SetGender(GenderMale)
    else if cbxEditUserProfileGender.ItemIndex = 1 then
      objLoggedInUser.SetGender(GenderFemale);

    // Joins the weight numeric boxes and sets the user's weight
    objLoggedInUser.SetWeight(StrToFloat(
      IntToStr(sedEditUserProfileWeightTrunc.Value) + DecimalSeparator +
      IntToStr(sedEditUserProfileWeightFrac.Value)));

    // Sets the user's height and email address
    objLoggedInUser.SetHeight(sedEditUserProfileHeight.Value);
    objLoggedInUser.SetEmailAddress(edtEditUserProfileEmailAddress.Text);

    // Checks if the user intended to change their password by checking if
    // they entered their old one
    if edtEditUserProfileOldPassword.Text <> '' then
    begin
      // If they did, set the user's password to the new password
      objLoggedInUser.SetPassword(edtEditUserProfileNewPassword.Text)
    end;

    // Sends an UPDATE query to the database
    objDatabaseManager.UpdateUser(objLoggedInUser);

    // Removes the current screen from the navigation manager
    objNavigationManager.PopScreen;
    // Refreshes the view user page that the user came from
    GoToProfileTabSheet(objLoggedInUser);
    // The GoToProfileTabSheet adds that screen to the navigation manager
    // so remove it
    objNavigationManager.PopScreen;
  end;
end;

function TfrmMain.ValidateEditUserProfileFields: boolean;
var
  sEmailAddress, sOldPassword, sNewPassword, sNewPasswordConfirm : string;
  objUser : TUser;
begin
  // All the fields are valid until we specify otherwise
  Result := True;

  // Resets all the error labels
  lblEditUserProfileEmailAddressError.Caption := '';
  lblEditUserProfileOldPasswordError.Caption := '';
  lblEditUserProfileNewPasswordError.Caption := '';

  // Retrieves all the values from the fields
  sEmailAddress := edtEditUserProfileEmailAddress.Text;
  sOldPassword := edtEditUserProfileOldPassword.Text;
  sNewPassword := edtEditUserProfileNewPassword.Text;
  sNewPasswordConfirm := edtEditUserProfileNewPasswordConfirm.Text;

  // Checks to make sure the email address is not blank
  if sEmailAddress <> '' then
  begin
    // Checks the validity of the email address by ensuring it has a "@" sign
    if Pos('@', sEmailAddress) > 0 then
    begin
      // If the email address is valid, query the user and make sure that the
      // email address isn't already in use
      objUser := objDatabaseManager.SelectUserByEmailAddress(sEmailAddress);
      if (objUser <> nil) then
        // If the email address is already in use, make sure it isn't the
        // current user
        if (objUser.GetUserID <> objLoggedInUser.GetUserID) then
        begin
          // If another user is using the same email address, inform the user
          // that they need another one and mark the form as invalid
          lblEditUserProfileEmailAddressError.Caption := 'Email address is ' +
                                                         'already in use';
          Result := False;
        end;
    end
    else
    begin
      // If the email address entered isn't valid, ask for another one and mark
      // the form as invalid
      lblEditUserProfileEmailAddressError.Caption := 'Please enter in a valid '+
                                                     'email address';
      Result := False;
    end;
  end
  else
  begin
    // If the user didn't enter in an email address, ask for one and mark the
    // form as invalid
    lblEditUserProfileEmailAddressError.Caption := 'Please enter in an email ' +
                                                   'address';
    Result := False;
  end;

  // Only check the passwords if the old password field isn't blank because then
  // we know that the user wants to change their password
  if Length(sOldPassword) <> 0 then
  begin
    // Checks to see if the old password matches the user's current password
    if not objLoggedInUser.CheckPassword(sOldPassword) then
    begin
      // If the passwords do not match, inform the user and mark the form as
      // invalid
      lblEditUserProfileOldPasswordError.Caption := 'Password is incorrect';

      Result := False;
    end;

    // Check to make sure the new password has been entered the same
    if sNewPassword <> sNewPasswordConfirm then
    begin
      // If the new passwords do not match, inform the user and mark the form
      // as invalid
      lblEditUserProfileNewPasswordError.Caption := 'Passwords do not match';

      Result := False;
    end
    // If the passwords are the same, check to make sure that they are 8 or more
    // characters long
    else if Length(sNewPassword) < 8 then
    begin
      // If the password is not long enough, inform the user and mark the form
      // as invalid
      lblEditUserProfileNewPasswordError.Caption := 'Password must be at least ' +
                                                  '8 characters long';

      Result := False;
    end;
  end;
end;

procedure TfrmMain.DisplayActivities(Activities: TActivities;
  FrameParent: TWinControl; Top: word);
var
  objCurrentActivity : TActivity;
  objFrmActivities : Array[1..MAX_ACTIVITIES] of TfrmActivity;
  K : byte;
begin
  // Clear any activities that may already be in the container
  EmptyContainerActivities(FrameParent);

  // There is a bug with the scrollbox that requires you to scroll to the
  // very top otherwise the Top value doesn't work
  if FrameParent is TScrollBox then
    (FrameParent as TScrollBox).VertScrollBar.Position := 0;

  // Loops through each activity and creates activity frames for each of them
  for K := 1 to Activities.GetActivityCount do
  begin
    // Creates a new activity frame
    objFrmActivities[K] := TfrmActivity.Create(nil);

    // Gets the current activity being used
    objCurrentActivity := Activities.GetActivity(K);
    // Sets the activity frame's activity
    objFrmActivities[K].SetActivity(objCurrentActivity);

    // Assigns OnClick events to the various components on the frame
    objFrmActivities[K].lblUsername.OnClick := OnFrmActivityUsernameClick;
    objFrmActivities[K].lblTitle.OnClick := OnFrmActivityClick;

    // Positions the activity in the container
    objFrmActivities[K].Parent := FrameParent;
    objFrmActivities[K].Left := 200;
    objFrmActivities[K].Top := Top + (125 * (K - 1));
    objFrmActivities[K].Height := 121;
    objFrmActivities[K].Width := 374;
  end;
end;

function TfrmMain.ValidatePostActivityFields: boolean;
begin
  // All fields are valid until we state otherwise
  Result := True;

  // Reset all the error labels
  lblPostActivityTitleError.Caption := '';
  lblPostActivityActivityTypeError.Caption := '';
  lblPostActivityDistanceError.Caption := '';
  lblPostActivityDurationError.Caption := '';

  // Check to see if a title was entered for the activity
  if edtPostActivityTitle.Text = '' then
  begin
    // If no title was entered, inform the user and mark the form as invalid
    lblPostActivityTitleError.Caption := 'Please enter in a title';
    Result := False;
  end;

  // Check to make sure the user selected an activity type
  if cbxPostActivityActivityType.ItemIndex = -1 then
  begin
    // If no activity type was entered, inform the user and mark the form as
    // invalid
    lblPostActivityActivityTypeError.Caption := 'Please select an activity type';
    Result := False;
  end;

  // Check to make sure that the duration is not all 0
  if (sedPostActivityHours.Value = 0) AND (sedPostActivityMinutes.Value = 0) AND
     (sedPostActivitySeconds.Value = 0) then
  begin
    // If no duration was entered, inform the user and mark the form as invalid
    lblPostActivityDurationError.Caption := 'Please enter in a suitable duration';
    Result := False;
  end;

  // Check to make sure a distance was supplied
  if sedPostActivityDistance.Value = 0 then
  begin
    // If no distance was entered, inform the user and mark the form as invalid
    lblPostActivityDistanceError.Caption := 'Please enter in a suitable distance';
    Result := False;
  end;
end;

procedure TfrmMain.RefreshPostActivity;
var
  objActivityTypes : TActivityTypes;
  K : byte;
begin
  // Reset all the error labels
  lblPostActivityTitleError.Caption := '';
  lblPostActivityActivityTypeError.Caption := '';
  lblPostActivityDistanceError.Caption := '';
  lblPostActivityDurationError.Caption := '';

  // Reset the post title field
  edtPostActivityTitle.Text := '';

  // Select all the different activity types from the database
  objActivityTypes := objDatabaseManager.SelectAllActivityTypes;
  // Reset the activity type combobox
  cbxPostActivityActivityType.Items.Clear;

  // Add each activity type to the combobox
  for K := 1 to objActivityTypes.GetActivityTypeCount do
    cbxPostActivityActivityType.Items.Add(
      objActivityTypes.GetActivityType(K).GetDescription);

  // Sets the date and time fields to the current date and time
  dtpPostActivityDate.DateTime := Date;
  dtpPostActivityTime.DateTime := Date;

  // Sets the duration of the activity to 0
  sedPostActivityHours.Value := 0;
  sedPostActivityMinutes.Value := 0;
  sedPostActivitySeconds.Value := 0;

  // Sets the distance of the activity to 0
  sedPostActivityDistance.Value := 0;

  // Clears the tags field
  edtPostActivityTags.Text := '';
end;

procedure TfrmMain.GoToViewIndividualActivitySheet(Activity: TActivity);
var
  objUser : TUser;
begin
  // Shows the loading sheet
  pgcMain.ActivePage := tstLoading;

  // Clears the comment textbox
  redViewIndividualActivityComment.Lines.Clear;
  // Clears the container of any existing comments
  EmptyContainerComments(sbxViewIndividualActivityMain);

  // Sets the current activity being viewed
  objCurrentlyViewedActivity := Activity;

  // Sets the title of the activity
  lblViewIndividualActivityTitle.Caption := Activity.GetTitle;
  // Shows the appropriate icon for the activity type
  imgViewIndividualActivityActivityTypeIcon.Picture.LoadFromFile(
    ExtractFilePath(Application.ExeName) + ICON_FOLDER +
    Activity.GetActivityType.GetIcon);

  // Selects the user that the activity belongs to
  objUser := objDatabaseManager.SelectUserByID(Activity.GetUserID);

  // Sets the username, datetime, distance, duration, rate and tag fields
  lblViewIndividualActivityUsername.Caption := '@' + objUser.GetUsername;
  lblViewIndividualActivityDateTime.Caption := Activity.GetFormattedDateTime;
  lblViewIndividualActivityDistance.Caption := Activity.GetFormattedDistance;
  lblViewIndividualActivityDuration.Caption := Activity.GetFormattedDuration;
  lblViewIndividualActivityRate.Caption := Activity.CalculateRate;
  lblViewIndividualActivityTags.Caption := Activity.GetTags.ToString('','',False);

  // Checks to see if the current logged in user has liked the activity
  if Activity.GetFavourites.SearchForUserID(objLoggedInUser.GetUserID) >= 0 then
    // If the user has liked the activity, then set the icon to the liked icon
    imgViewIndividualActivityLike.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + THUMBSUP_FILENAME)
  else
    // If the user hasn't liked the activity, then set the icon to the unliked
    // icon
    imgViewIndividualActivityLike.Picture.LoadFromFile(
      ExtractFilePath(Application.ExeName) + THUMBSUPOUTLINE_FILENAME);

  // Shows the number of likes the activity has
  lblViewIndividualActivityLikes.Caption :=
    IntToStr(Activity.GetFavourites.GetUserIDCount);

  // Displays the comments that the activity has
  DisplayComments(Activity.GetComments, sbxViewIndividualActivityMain, 580);

  // Determines whether the user can edit the activity or not
  btnViewIndividualActivityEdit.Visible :=
    Activity.GetUserID = objLoggedInUser.GetUserID;

  // Shows the current activity sheet
  pgcMain.ActivePage := tstViewIndividualActivity;

  // Add the page to our navigation manager
  objNavigationManager.PushScreen(tstViewIndividualActivity);
  // Informs the navigation manager of the last activity viewed
  objNavigationManager.SetLastViewedActivity(Activity);
end;

procedure TfrmMain.btnSearchSearchClick(Sender: TObject);
var
  objUsers : TUsers;
  objActivities : TActivities;
begin
  // Shows the loading sheet
  pgcMain.ActivePage := tstLoading;

  // Clears the search container of any activity or user frames that may be
  // present
  EmptyContainer(sbxSearchMain);

  // Check to see if the user wants to search for users
  if rbtnSearchSearchUsers.Checked then
  begin
    // If the user wants to search for users, select users by partial usernames
    objUsers := objDatabaseManager.SelectUsersByPartialUsername(
                  edtSearchTerm.Text);

    // Display the results in frames
    DisplayUsers(objUsers, sbxSearchMain, 8);
  end
  else
  begin
    // If the user wants to search for activities, query for activities by tags
    // or titles
    objActivities := objDatabaseManager.SelectActivitiesByTagOrTitle(
                       edtSearchTerm.Text);

    // Inform the navigation manager of the last used search term. This only
    // needs to be updated when we search for activities
    objNavigationManager.SetLastUsedSearchTerm(edtSearchTerm.Text);

    // Displays the results
    DisplayActivities(objActivities, sbxSearchMain, 8);
  end;

  // Shows the search page again
  pgcMain.ActivePage := tstSearch;
end;

procedure TfrmMain.DisplayUsers(Users: TUsers; FrameParent: TWinControl;
  Top: word);
var
  objCurrentUser : TUser;
  objFrmUsers : Array[1..MAX_USERS] of TfrmUserFrame;
  K : word;
begin
  // Empties the container of any user frames it may already have
  EmptyContainerUsers(FrameParent);

  // Bug with the scrollbox.  Have to reset the scroll position otherwise Top
  // doesn't work correctly
  if FrameParent is TScrollBox then
    (FrameParent as TScrollBox).VertScrollBar.Position := 0;

  // Loop through each user and create a frame for each one
  for K := 1 to Users.GetUserCount do
  begin
    // Create a new user frame
    objFrmUsers[K] := TfrmUserFrame.Create(nil);

    // Gets the current user from the array
    objCurrentUser := Users.GetUser(K);
    // Sets the frame's user
    objFrmUsers[K].SetUser(objCurrentUser);

    // Adds an OnClick listener for when the username is clicked
    objFrmUsers[K].lblUsername.OnClick := OnFrmUserClick;

    // Positions the user frame in the container
    objFrmUsers[K].Parent := FrameParent;
    objFrmUsers[K].Left := 200;
    objFrmUsers[K].Top := Top + (87 * (K - 1));
    objFrmUsers[K].Width := 374;
    objFrmUsers[K].Height := 83;
  end;
end;

procedure TfrmMain.OnFrmUserClick(Sender: TObject);
begin
  // Navigates to a user when the username in a user frame is clicked
  GoToProfileTabSheet(
    ((Sender As TLabel).Parent.Parent As TfrmUserFrame).GetUser);
end;

procedure TfrmMain.RefreshSearch;
begin
  // Reset the search term field
  edtSearchTerm.Text := '';

  // Set the search type to the default, users
  rbtnSearchSearchUsers.Checked := True;

  // Empty the search container of any existing results
  EmptyContainer(sbxSearchMain);
end;

procedure TfrmMain.EmptyContainer(Container: TWinControl);
var
  K : smallint;
begin
  // Loop through each component in the container
  for K := Container.ControlCount - 1 downto 0 do
    // Delete the component
    Container.Controls[K].Destroy;
end;

procedure TfrmMain.tstLoadingShow(Sender: TObject);
begin
  // Sets the path to the animation of the loading spinner file
  aniLoading.FileName := ExtractFilePath(Application.ExeName) + LOADING_ANIMATION;

  // Simply plays the loading animation A LOT of times
  aniLoading.Play(1, 10, 320000);
end;

procedure TfrmMain.DisplayComments(Comments: TComments;
  FrameParent: TWinControl; Top: word);
var
  objCurrentComment : TComment;
  objFrmComments : Array[1..MAX_COMMENTS] of TfrmCommentFrame;
  K : byte;
begin
  // Empties the container of any comments it may contain
  EmptyContainerComments(FrameParent);

  // Bug with scrollbox.  Have to scroll to the top otherwise the Top value
  // is wrong
  if FrameParent is TScrollBox then
    (FrameParent as TScrollBox).VertScrollBar.Position := 0;

  // Loop through each comment and create a comment frame for it
  for K := 1 to Comments.GetCommentCount do
  begin
    // Create a new comment frame
    objFrmComments[K] := TfrmCommentFrame.Create(nil);

    // Get the current comment from the array
    objCurrentComment := Comments.GetComment(K);
    // Set the frame's comment object
    objFrmComments[K].SetComment(objCurrentComment);

    // Add an OnClick handler to the comment frame's label
    objFrmComments[K].lblUsername.OnClick := OnFrmCommentUsernameClick;

    // Position the comment frame inside the container
    objFrmComments[K].Parent := FrameParent;
    objFrmComments[K].Left := 208;
    objFrmComments[K].Top := Top + ((K - 1) * 133);
    objFrmComments[K].Width := 377;
    objFrmComments[K].Height := 129;
  end;
end;

procedure TfrmMain.EmptyContainerComments(Container: TWinControl);
var
  K : smallint;
begin
  // Loop through all the components in the container
  for K := Container.ControlCount - 1 downto 0 do
    // Check to see if the component is a comment frame and delete it
    if (Container.Controls[K] is TfrmCommentFrame) then
      Container.Controls[K].Destroy;
end;

procedure TfrmMain.btnViewIndividualActivityCommentClick(Sender: TObject);
begin
  // Show the loading page
  pgcMain.ActivePage := tstLoading;

  // Adds the comment to the activity
  objCurrentlyViewedActivity.GetComments.AddComment(TComment.Create(
                                              objLoggedInUser.GetUserID,
                                              objCurrentlyViewedActivity
                                                .GetActivityID,
                                              Now,
                                              redViewIndividualActivityComment
                                                .Lines.Text));

  // Sends an UPDATE query to the database
  objDatabaseManager.UpdateActivity(objCurrentlyViewedActivity);
  // Refreshes the View Activity Screen to show the comments
  GoToViewIndividualActivitySheet(objCurrentlyViewedActivity);
  // Our navigation manager now has the view activity screen twice so remove
  // the second one
  objNavigationManager.PopScreen;
end;

procedure TfrmMain.imgViewIndividualActivityLikeClick(Sender: TObject);
begin
  // Show the loading sheet
  pgcMain.ActivePage := tstLoading;

  // Check if the user likes the activity already
  if objCurrentlyViewedActivity.GetFavourites
       .SearchForUserID(objLoggedInUser.GetUserID) >= 0 then
  begin
    // If the user already liked it, delete that favourite
    objCurrentlyViewedActivity.DeleteFavourite(objLoggedInUser.GetUserID);
  end
  else
    // If the user hasn't already liked it, add a favourite to the activity
    objCurrentlyViewedActivity.AddFavourite(objLoggedInUser.GetUserID);

  // Sends an UPDATE query to the database
  objDatabaseManager.UpdateActivity(objCurrentlyViewedActivity);
  // Refreshes the view activity sheet by navigating to it again
  GoToViewIndividualActivitySheet(objCurrentlyViewedActivity);
  // Since we now have the sheet appearing twice in our navigation manager,
  // pop the last one off the stack
  objNavigationManager.PopScreen;
end;

procedure TfrmMain.NavigateToPreviousPage;
var
  tstLastPage : TTabSheet;
  bWasSearchingActivities : boolean;
begin
  // Save the previous page that we want to navigate to
  tstLastPage := objNavigationManager.PopScreen;

  // Show the loading page
  pgcMain.ActivePage := tstLoading;

  // Check if the page is tstMainScreen and whether that page needs to be
  // refreshed first
  if (not objNavigationManager.GetMainScreenRefreshed) AND
     (tstLastPage = tstMainScreen) then
  begin
    // If it needs to be refreshed, refresh the page
    GoToTabSheet(tstMainScreen, True);
    // Since we refreshed, we want to remove the last page from our navigation
    // manager
    objNavigationManager.PopScreen;

    // Tell our navigation manager that our main screen has beeen refreshed
    objNavigationManager.SetMainScreenRefreshed(True);
  end
  // Check if the page is tstSearch and whether the page needs to be refreshed
  // first
  else if (not objNavigationManager.GetSearchScreenRefreshed) AND 
          (tstLastPage = tstSearch) then
  begin
    // Check if the user was originally search activities
    bWasSearchingActivities := rbtnSearchSearchActivities.Checked;

    // Refresh the search sheet
    GoToTabSheet(tstSearch, True);
    // Since we refreshed the screen, pop the last one off
    objNavigationManager.PopScreen;

    // Check if the user was originally searching activities
    if bWasSearchingActivities then
    begin
      // If the user was searching activities, we want to refresh his search
      // so that any changes to the activity will show up
      pgcMain.ActivePage := tstLoading;
      rbtnSearchSearchActivities.Checked := True;
      edtSearchTerm.Text := objNavigationManager.GetLastUsedSearchTerm;
      btnSearchSearchClick(nil);
    end;

    // Inform the navigation manager that we have refreshed the search screen
    objNavigationManager.SetSearchScreenRefreshed(True);
  end
  // Check if the page is tstProfileScreen and whether the page needs to be
  // refreshed first
  else if (not objNavigationManager.GetProfileScreenRefreshed) AND 
          (tstLastPage = tstProfileScreen) then
  begin
    // Navigate to the page again and refresh it
    GoToProfileTabSheet(objNavigationManager.GetLastViewedProfile);
    // Since we refreshed the page, remove the last page in the navigation
    // manager
    objNavigationManager.PopScreen;

    // Inform the navigation manager that we have handled the profile screen
    objNavigationManager.SetProfileScreenRefreshed(True);
  end
  // Check if the tstViewIndividualActivity is the last page and whether it
  // needs to be refreshed
  else if (not objNavigationManager.GetViewActivityScreenRefreshed) AND
          (tstLastPage = tstViewIndividualActivity) then
  begin
    // Navigate to the tstViewIndividualActivity page to refresh it
    GoToViewIndividualActivitySheet(objNavigationManager.GetLastViewedActivity);
    // Since we refreshed the page, pop it off the navigation manager
    objNavigationManager.PopScreen;

    // Inform the navigation manager that we have handled the refresh
    objNavigationManager.SetViewActivityScreenRefreshed(True);
  end
  else
    // If the previous page does not need to be refreshed, simply go to the
    // last page
    pgcMain.ActivePage := tstLastPage;
end;

procedure TfrmMain.GoToEditActivitySheet(Activity: TActivity);
var
  bFoundItem : boolean;
  K : byte;
begin
  // Show the loading screen
  pgcMain.ActivePage := tstLoading;

  // Set the current activity being edited
  objCurrentlyEditedActivity := Activity;

  // Reset the error labels
  lblEditActivityTitleError.Caption := '';
  lblEditActivityActivityTypeError.Caption := '';
  lblEditActivityDistanceError.Caption := '';
  lblEditActivityDurationError.Caption := '';

  // Sets the title field
  edtEditActivityTitle.Text := objCurrentlyEditedActivity.GetTitle;

  // Loads the different activity types from the database
  LoadActivityTypes(cbxEditActivityActivityType);

  // Finds the activity type in the combobox and sets its ItemIndex accordingly
  bFoundItem := False;
  K := 0;
  while (K < cbxEditActivityActivityType.Items.Count) AND (not bFoundItem) do
  begin
    if cbxEditActivityActivityType.Items[K] = objCurrentlyEditedActivity
         .GetActivityType.GetDescription then
    begin
      bFoundItem := True;
      cbxEditActivityActivityType.ItemIndex := K;
    end;

    Inc(K);
  end;

  // Set the date and time fields
  dtpEditActivityDateTimeDate.DateTime := 
    objCurrentlyEditedActivity.GetDateTimeOfActivity;
  dtpEditActivityDateTimeTime.DateTime := 
    objCurrentlyEditedActivity.GetDateTimeOfActivity;

  // Set the duration fields
  sedEditActivityDurationHours.Value := objCurrentlyEditedActivity
                                          .CalculateDurationHours;
  sedEditActivityDurationMinutes.Value := objCurrentlyEditedActivity
                                            .CalculateDurationMinutes;
  sedEditActivityDurationSeconds.Value := objCurrentlyEditedActivity
                                            .CalculateDurationSeconds;

  // Set the distance field
  sedEditActivityDistance.Value := objCurrentlyEditedActivity.GetDistance;
  // Set the distance units to metres
  rbtnEditActivityDistanceMetres.Checked := True;

  // Set the tags field
  edtEditActivityTags.Text:= objCurrentlyEditedActivity.GetTags.ToString('','',
                               False);

  // Inform the navigation manager of our navigation
  objNavigationManager.PushScreen(tstEditActivity);
  // Set the active tabsheet
  pgcMain.ActivePage := tstEditActivity;
end;

procedure TfrmMain.LoadActivityTypes(ComboBox: TComboBox);
var
  objActivityTypes : TActivityTypes;
  K : byte;
begin
  // Queries all the activity types
  objActivityTypes := objDatabaseManager.SelectAllActivityTypes;

  // Clears any existing items in the combobox
  ComboBox.Items.Clear;
  // Adds each activity type to the combobox
  for K := 1 to objActivityTypes.GetActivityTypeCount do
    ComboBox.Items.Add(objActivityTypes.GetActivityType(K).GetDescription);
end;

procedure TfrmMain.btnViewIndividualActivityEditClick(Sender: TObject);
begin
  // Loads the Edit Activity Sheet when the user chooses to edit an activity
  GoToEditActivitySheet(objCurrentlyViewedActivity);
end;

function TfrmMain.ValidateEditActivityFields: boolean;
begin
  // The form is valid until we state otherwise
  Result := True;

  // Reset all the error labels
  lblEditActivityTitleError.Caption := '';
  lblEditActivityActivityTypeError.Caption := '';
  lblEditActivityDistanceError.Caption := '';
  lblEditActivityDurationError.Caption := '';

  // Check to make sure the title is not blank
  if edtEditActivityTitle.Text = '' then
  begin
    // If the title is blank, inform the user and mark the form as invalid
    lblEditActivityTitleError.Caption := 'Please enter in a title';
    Result := False;
  end;

  // Check to make sure that an activity type has been selected
  if cbxEditActivityActivityType.ItemIndex = -1 then
  begin
    // If no activity type has been selected, inform the user and mark the form
    // as invalid
    lblEditActivityActivityTypeError.Caption := 'Please select an activity type';
    Result := False;
  end;

  // Check to make sure that the duration is not 0
  if (sedEditActivityDurationHours.Value = 0) AND 
     (sedEditActivityDurationMinutes.Value = 0) AND
     (sedEditActivityDurationSeconds.Value = 0) then
  begin
    // If it is 0, inform the user and mark the form as invalid
    lblEditActivityDurationError.Caption := 'Please enter in a suitable duration';
    Result := False;
  end;

  // Check to make sure the distance is not 0
  if sedEditActivityDistance.Value = 0 then
  begin
    // If the distance is 0, inform the user and mark the form as invalid
    lblEditActivityDistanceError.Caption := 'Please enter in a suitable distance';
    Result := False;
  end;
end;

procedure TfrmMain.btnEditActivityUpdateClick(Sender: TObject);
begin
  // Check to make sure all the fields are valid
  if ValidateEditActivityFields then
  begin
    // Show the loading page
    pgcMain.ActivePage := tstLoading;

    // Set the title, activity type, datetime and duration properties
    objCurrentlyEditedActivity.SetTitle(edtEditActivityTitle.Text);
    objCurrentlyEditedActivity.SetActivityType(
      objDatabaseManager.SelectActivityTypeByDescription(
        cbxEditActivityActivityType
          .Items[cbxEditActivityActivityType.ItemIndex]));
    objCurrentlyEditedActivity
      .SetDateTimeOfActivity(
        VarToDateTime(FormatDateTime('yyyy/mm/dd', 
                        dtpEditActivityDateTimeDate.DateTime) + ' ' +
                      FormatDateTime('hh:nn:ss', 
                        dtpEditActivityDateTimeTime.DateTime)));
    objCurrentlyEditedActivity.SetDuration(sedEditActivityDurationHours.Value,
                                           sedEditActivityDurationMinutes.Value,
                                           sedEditActivityDurationSeconds.Value);

    // Check what units the distance was entered in and convert it if needed
    if (rbtnEditActivityDistanceKilometre.Checked) then
      objCurrentlyEditedActivity.SetDistance(sedEditActivityDistance.Value * 1000)
    else
      objCurrentlyEditedActivity.SetDistance(sedEditActivityDistance.Value);

    // Set the strings of the activity
    objCurrentlyEditedActivity.SetStringOfTags(edtEditActivityTags.Text);

    // Sends an UPDATE query to the database
    objDatabaseManager.UpdateActivity(objCurrentlyEditedActivity);
    // Informs the navigation manager that changes may need to be refreshed on
    // other sheets
    objNavigationManager.NeedToRefreshActivityChanges;

    // Navigates the user to the last page they were at
    NavigateToPreviousPage;
  end;
end;

procedure TfrmMain.btnEditActivityDeleteClick(Sender: TObject);
begin
  // Confirms that the user wants to delete the activity
  if MessageDlg('Are you sure you want to delete the current activity?',
                mtWarning, [mbYes,mbNo], 0) = mrYes then
  begin
    // If they do want to delete it, show the loading screen
    pgcMain.ActivePage := tstLoading;

    // Sends a DELETE query to the database
    objDatabaseManager.DeleteActivity(objCurrentlyEditedActivity);

    // Informs the navigation manager that changes may cause certain pages
    // to be refreshed
    objNavigationManager.NeedToRefreshActivityChanges;
    // Since we do not need to view the activity we just deleted, we tell the
    // navigation manager not to worry about the sheet     
    objNavigationManager.SetViewActivityScreenRefreshed(False);
    // We need to delete the view activity screen because we just deleted the 
    // activity it was showing
    objNavigationManager.PopScreen;
    // Navigate to the previous page
    NavigateToPreviousPage;
  end;
end;

procedure TfrmMain.btnProfileScreenFollowUnfollowClick(Sender: TObject);
begin
  // Show the loading page
  pgcMain.ActivePage := tstLoading;

  // Checks if the logged in user was already following the viewed user
  if objCurrentlyViewedUser.IsUserBeingFollowedBy(objLoggedInUser.GetUserID)then
    // If the user was already following the viewed user, unfollow them
    objCurrentlyViewedUser.DeleteUserBusyFollowing(objLoggedInUser.GetUserID)
  else
    // If the user wasn't already following the viewed user, follow them
    objCurrentlyViewedUser.AddUserBusyFollowing(objLoggedInUser.GetUserID);

  // Updates the user being viewed
  objDatabaseManager.UpdateUser(objCurrentlyViewedUser);
  // Since the logged in user changed their following, they need to be refreshed
  objLoggedInUser:=objDatabaseManager.SelectUserByID(objLoggedInUser.GetUserID);
  // Inform the navigation manager that changes may mean that some pages need
  // to be refreshed
  objNavigationManager.NeedToRefreshUserChanges;
  // Takes the user back to the profile sheet
  GoToProfileTabSheet(objCurrentlyViewedUser);
  // Since we refreshed the sheet, we pop it off the navigation manager
  objNavigationManager.PopScreen;
end;

procedure TfrmMain.lblViewIndividualActivityUsernameClick(Sender: TObject);
var
  objUser : TUser;
  sUsername : string;
begin
  // Shows the loading screen
  pgcMain.ActivePage := tstLoading;

  // Get the uername from the label that was clicked
  sUsername := lblViewIndividualActivityUsername.Caption;
  sUsername := Copy(sUsername, 2, Length(sUsername) - 1);

  // Query the database for the user object
  objUser := objDatabaseManager.SelectUserByUsername(sUsername);

  // Shows the user's profile 
  GoToProfileTabSheet(objUser);
end;

procedure TfrmMain.OnFrmActivityUsernameClick(Sender: TObject);
var
  sUsername : string;
  objUser : TUser;
begin
  // Shows the loading page
  pgcMain.ActivePage := tstLoading;

  // Gets the username from the label
  sUsername := (Sender as TLabel).Caption;
  sUsername := Copy(sUsername, 2, Length(sUsername) - 1);

  // Queries the user in the database
  objUser := objDatabaseManager.SelectUserByUsername(sUsername);

  // Shows the queried user's profile
  GoToProfileTabSheet(objUser);
end;

procedure TfrmMain.EmptyContainerActivities(Container: TWinControl);
var
  K : smallint;
begin
  // Loop through all the components in the container
  for K := Container.ControlCount - 1 downto 0 do
    // If the component is a activity frame, delete it
    if (Container.Controls[K] is TfrmActivity) then
      Container.Controls[K].Destroy;
end;

procedure TfrmMain.EmptyContainerUsers(Container: TWinControl);
var
  K : smallint;
begin
  // Loop through all the components in the container
  for K := Container.ControlCount - 1 downto 0 do
    // If the component is a user frame, delete it
    if (Container.Controls[K] is TfrmUserFrame) then
      Container.Controls[K].Destroy;
end;

procedure TfrmMain.btnEditUserProfileChangeCoverPhotoClick(
  Sender: TObject);
begin
  // Check if the user confirmed they want to change their cover photo
  if odlgCoverPhoto.Execute then
  begin
    // Get the filename of the newly selected cover photo
    sCoverPhotoPath := odlgCoverPhoto.FileName;
    // Display the cover photo
    imgEditUserProfileCoverPhoto.Picture.LoadFromFile(sCoverPhotoPath);
  end;
end;

procedure TfrmMain.btnEditUserProfileChangeProfilePictureClick(
  Sender: TObject);
begin
  // Check if the user confirmed they want to change their profile picture
  if odlgProfilePicture.Execute then
  begin
    // Get the filename of the newly selected profile picture
    sProfilePicturePath := odlgProfilePicture.FileName;
    // Display the profile picture
    imgEditUserProfileProfilePicture.Picture.LoadFromFile(sProfilePicturePath);
  end;
end;

procedure TfrmMain.imgHelpClick(Sender: TObject);
var
  sPathToHelp : string;
begin
  // Gets the path to the help file
  sPathToHelp := ExtractFilePath(Application.ExeName) + HELP_FILE;

  // Opens the Windows Help File
  ShellExecute(Handle, 'open', PChar(sPathToHelp), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.OnFrmCommentUsernameClick(Sender: TObject);
var
  sUsername : string;
  objUser : TUser;
begin
  // Shows the loading page
  pgcMain.ActivePage := tstLoading;

  // Gets the username from the label that was clicked
  sUsername := (Sender as TLabel).Caption;
  sUsername := Copy(sUsername, 2, Length(sUsername) - 1);

  // Queries the user object
  objUser := objDatabaseManager.SelectUserByUsername(sUsername);

  // Shows the user's profile
  GoToProfileTabSheet(objUser);
end;

end.