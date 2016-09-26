unit uComment;

interface

uses
  SysUtils;

type
  TComment = class(TObject)
    private
      // Stores the id of the comment in the database
      FCommentID : integer;
      // Stores the user id of the user who made the comment
      FUserID : integer;
      // Stores the activity id the comment belongs to
      FActivityID : integer;
      // Stores the date and time the comment was made
      FDateTimeOfComment : TDateTime;
      // Stores the contents of the comment
      FComment : string;
    public
      // Creates a new comment object using values from the database
      constructor Create(CommentID, UserID, ActivityID : integer;
                         DateTimeOfComment : TDateTime; Comment : string);
                         overload;
      // Creates a new comment object using values from the app (user) to begin
      // inserted into the database
      constructor Create(UserID, ActivityID : integer;
                         DateTimeOfComment : TDateTime; Comment : string);
                         overload;
      // Returns FCommentID
      function GetCommentID : integer;
      // Returns FUserID
      function GetUserID : integer;
      // Returns FActivityID
      function GetActivityID : integer;
      // Returns FActivityID
      function GetDateTimeOfComment : TDateTime;
      // Returns FComment
      function GetComment : string;
      // Sets the date and time the comment was made
      procedure SetDateTimeOfComment(DateTimeOfComment : TDateTime);
      // Sets the contents of the comment
      procedure SetComment(Comment : string);
      // Returns the comment's fields in a single string
      function ToString : string;
  end; // class

implementation

{ TComment }

constructor TComment.Create(CommentID, UserID, ActivityID: integer;
  DateTimeOfComment: TDateTime; Comment: string);
begin
  // Sets the fields using values from the database
  FCommentID          := CommentID;
  FUserID             := UserID;
  FActivityID         := ActivityID;
  FDateTimeOfComment  := DateTimeOfComment;
  FComment            := Comment;
end;

constructor TComment.Create(UserID, ActivityID: integer;
  DateTimeOfComment: TDateTime; Comment: string);
begin
  // Sets the fields using values from the app
  FCommentID          := -1;
  FUserID             := UserID;
  FActivityID         := ActivityID;
  FDateTimeOfComment  := DateTimeOfComment;
  FComment            := Comment;
end;

function TComment.GetActivityID: integer;
begin
  // Returns FActivityID
  Result := FActivityID;
end;

function TComment.GetComment: string;
begin
  // Returns FComment
  Result := FComment;
end;

function TComment.GetCommentID: integer;
begin
  // Returns FCommentID
  Result := FCommentID;
end;

function TComment.GetDateTimeOfComment: TDateTime;
begin
  // Returns FDateTimeOfComment
  Result := FDateTimeOfComment;
end;

function TComment.GetUserID: integer;
begin
  // Returns FUserID
  Result := FUserID;
end;

procedure TComment.SetComment(Comment: string);
begin
  // Sets FComment
  FComment := Comment;
end;

procedure TComment.SetDateTimeOfComment(DateTimeOfComment: TDateTime);
begin
  // Sets FDateTimeOfComment
  FDateTimeOfComment := DateTimeOfComment;
end;

function TComment.ToString: string;
begin
  // Returns all the fields in the comment as a single string
  Result := 'Comment ID: ' + IntToStr(FCommentID) + #13 +
            'User ID: ' + IntToStr(FUserID) + #13 +
            'Activity ID: ' + IntToStr(FActivityID) + #13 +
            'Date and Time of Comment: ' +
            FormatDateTime('dd/mm/yyyy hh:nn', FDateTimeOfComment) + #13 +
            'Comment: ' + FComment;
end;

end.
