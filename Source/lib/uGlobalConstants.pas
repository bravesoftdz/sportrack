unit uGlobalConstants;

interface

const
  // Path to the app's base data folder
  PATH_TO_DATA = '\data\';
  // Path to the folder containing icons for each activity type
  ACTIVITYTYPE_FOLDER = PATH_TO_DATA + 'activity_types\';
  // Path to the folder containing any user data
  USER_FOLDER = PATH_TO_DATA + 'user\';
  // Path to the folder containing all the app icons
  ICON_FOLDER = PATH_TO_DATA + 'icons\';
  // Path to the folder containing the default cover photo and profile picture
  FILLER_FOLDER = PATH_TO_DATA + 'fillers\';
  // Path to the folder containing the animations
  ANIMATION_FOLDER = PATH_TO_DATA + 'animations\';

  // Path to the timespent icon
  TIMESPENT_FILENAME = ICON_FOLDER + 'time_spent.bmp';
  // Path to the distance icon
  DISTANCE_FILENAME = ICON_FOLDER + 'distance.bmp';
  // Path to the thumbs up outline icon
  THUMBSUPOUTLINE_FILENAME = ICON_FOLDER + 'thumb-up-outline.bmp';
  // Path to the thumbs up filled icon
  THUMBSUP_FILENAME = ICON_FOLDER + 'thumb-up.bmp';

  // Path to the default cover photo file
  COVERPHOTO_DEFAULT = FILLER_FOLDER + 'cover_photo.jpg';
  // Path to the default profile picture file
  PROFILEPICTURE_DEFAULT = FILLER_FOLDER + 'profile_picture.jpg';

  // Path to the database file to use
  DATABASE_FILENAME = PATH_TO_DATA + 'db\SporTrack.accdb';
  
  // Path to the logo image to use
  LOGO_FILENAME = PATH_TO_DATA + 'logos\White_On_Black.bmp';

  // Path to the splashscreen animation file
  SPLASHSCREEN_FILENAME = PATH_TO_DATA + 'splash\splash.avi';

  // Path to the loading spinner animation file
  LOADING_ANIMATION = ANIMATION_FOLDER + 'loading.avi';

  // Path to the folder containing user profile picures
  PROFILE_FOLDER = USER_FOLDER + 'profiles\';
  // Path to the folder containing user cover photos
  COVER_FOLDER = USER_FOLDER + 'covers\';

  // Path to the windows help file for the application
  HELP_FILE = '\help\SporTrack.chm';

implementation

end.
