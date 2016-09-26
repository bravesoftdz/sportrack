unit uNavigationManager;

interface
  uses
    ComCtrls, Dialogs, uUser, SysUtils, uActivity;

  const
    MAX_SCREENS = 200;

  type
    TNavigationManager = class(TObject)
      private
        // Array to store a stack of all the screen visited
        FScreens : Array[1..MAX_SCREENS] of TTabSheet;
        // Stores the number of screens in the stack
        FScreenCount : byte;

        // Stores whether the main screen needs to be refreshed
        FMainScreenRefreshed : boolean;
        // Stores whether the search screen needs to be refreshed
        FSearchScreenRefreshed : boolean;
        // Stores whether the profile screen needs to be refreshed
        FProfileScreenRefreshed : boolean;
        // Stores whether the view activity screen needs to be refreshed
        FViewActivityScreenRefreshed : boolean;

        // Stores the last user profile that was viewed
        FLastViewedProfile : TUser;
        // Stores the last search term the user used
        FLastUsedSearchTerm : string;
        // Stores the last activity that the user viewed
        FLastViewedActivity : TActivity;
      public
        // Initialises the navigation manager
        constructor Create;

        // Adds a screen to the stack
        procedure PushScreen(Screen : TTabSheet);
        // Removes the last added screen from the stack and returns it
        function PopScreen : TTabSheet;
 
        // Used in debugging.  Lists all the names of all the screens in the
        // stack
        function ListScreenNames : string;

        // Returns FMainScreenRefreshed
        function GetMainScreenRefreshed : boolean;
        // Returns FSearchScreenRefreshed
        function GetSearchScreenRefreshed : boolean;
        // Returns FProfileScreenRefreshed
        function GetProfileScreenRefreshed : boolean;
        // Returns FViewActivityScreenRefreshed
        function GetViewActivityScreenRefreshed : boolean;
        // Returns FLastViewedActivity
        function GetLastViewedProfile : TUser;
        // Returns FLastUsedSearchTerm
        function GetLastUsedSearchTerm : string;
        // Returns FLastViewedActivity
        function GetLastViewedActivity : TActivity;

        // Sets FMainScreenRefreshed
        procedure SetMainScreenRefreshed(Refreshed : boolean);
        // Sets FSearchScreenRefreshed
        procedure SetSearchScreenRefreshed(Refreshed : boolean);
        // Sets FProfileScreenRefreshed
        procedure SetProfileScreenRefreshed(Refreshed : boolean);
        // Sets FViewActivityScreenRefreshed
        procedure SetViewActivityScreenRefreshed(Refreshed : boolean);
        // Sets FLastViewedProfile
        procedure SetLastViewedProfile(User : TUser);
        // Sets FLastUsedSearchTerm
        procedure SetLastUsedSearchTerm(SearchTerm : string);
        // Sets FLastViewedActivity
        procedure SetLastViewedActivity(Activity : TActivity);

        // Informs the navigation manager that an activity causes some pages
        // to need to be refreshed
        procedure NeedToRefreshActivityChanges;
        // Informs the navigation manager that a user causes some pages to
        // need to be refreshed
        procedure NeedToRefreshUserChanges;
    end; // class

implementation

{ TNavigationManager }

procedure TNavigationManager.PushScreen(Screen: TTabSheet);
begin
  // Increase the number of screens in the array
  Inc(FScreenCount);
  // Add the new screen to the end of the array
  FScreens[FScreenCount] := Screen;
end;

constructor TNavigationManager.Create;
begin
  // Set the number of screens in the array to 0
  FScreenCount := 0;

  // None of the screens need to be refreshed
  FMainScreenRefreshed := True;
  FSearchScreenRefreshed := True;
  FProfileScreenRefreshed := True;
  FViewActivityScreenRefreshed := True;
end;

function TNavigationManager.PopScreen: TTabSheet;
begin
  // Return the last screen in the array
  Result := FScreens[FScreenCount - 1];
  // Remove the last screen from the array
  Dec(FScreenCount, 1);
end;

function TNavigationManager.ListScreenNames: string;
var
  K : byte;
begin
  Result := '';

  // Loop through each screen and output its name on a new line
  for K := 1 to FScreenCount do
    Result := Result + FScreens[K].Name + #13;
end;

function TNavigationManager.GetMainScreenRefreshed: boolean;
begin
  // Returns FMainScreenRefreshed
  Result := FMainScreenRefreshed;
end;

function TNavigationManager.GetProfileScreenRefreshed: boolean;
begin
  // Returns FProfileScreenRefreshed
  Result := FProfileScreenRefreshed;
end;

function TNavigationManager.GetSearchScreenRefreshed: boolean;
begin
  // Returns FSearchScreenRefreshed
  Result := FSearchScreenRefreshed;
end;

procedure TNavigationManager.SetMainScreenRefreshed(Refreshed: boolean);
begin
  // Sets FMainScreenRefreshed
  FMainScreenRefreshed := Refreshed;
end;

procedure TNavigationManager.SetProfileScreenRefreshed(Refreshed: boolean);
begin
  // Sets FProfileScreenRefreshed
  FProfileScreenRefreshed := Refreshed;
end;

procedure TNavigationManager.SetSearchScreenRefreshed(Refreshed: boolean);
begin
  // Sets FSearchScreenRefreshed
  FSearchScreenRefreshed := Refreshed;
end;

procedure TNavigationManager.NeedToRefreshActivityChanges;
begin
  // Sets the relevant screens that need to be refreshed
  FMainScreenRefreshed := False;
  FSearchScreenRefreshed := False;
  FProfileScreenRefreshed := False;
  FViewActivityScreenRefreshed := False;
end;

function TNavigationManager.GetLastUsedSearchTerm: string;
begin
  // Returns FLastUsedSearchTerm
  Result := FLastUsedSearchTerm;
end;

function TNavigationManager.GetLastViewedProfile: TUser;
begin
  // Returns FLastViewedProfile
  Result := FLastViewedProfile;
end;

procedure TNavigationManager.SetLastUsedSearchTerm(SearchTerm: string);
begin
  // Sets FLastUsedSearchTerm
  FLastUsedSearchTerm := SearchTerm;
end;

procedure TNavigationManager.SetLastViewedProfile(User: TUser);
begin
  // Sets FLastViewedProfile
  FLastViewedProfile := User;
end;

function TNavigationManager.GetLastViewedActivity: TActivity;
begin
  // Returns FLastViewedActivity
  Result := FLastViewedActivity;
end;

function TNavigationManager.GetViewActivityScreenRefreshed: boolean;
begin
  // Returns FViewActivityScreenRefreshed
  Result := FViewActivityScreenRefreshed;
end;

procedure TNavigationManager.SetLastViewedActivity(Activity: TActivity);
begin
  // Sets FLastViewedActivity
  FLastViewedActivity := Activity;
end;

procedure TNavigationManager.SetViewActivityScreenRefreshed(
  Refreshed: boolean);
begin
  // Sets FViewActivityScreenRefreshed
  FViewActivityScreenRefreshed := Refreshed;
end;

procedure TNavigationManager.NeedToRefreshUserChanges;
begin
  // Sets the relevant screens that need to be refreshed
  FProfileScreenRefreshed := False;
  FMainScreenRefreshed := False;
end;

end.
