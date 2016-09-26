unit uComments;

interface

uses
  uComment;

const
  MAX_COMMENTS = 200;

type
  TComments = class(TObject)
    private
      // Stores the array of comments
      FComments : Array[1..MAX_COMMENTS] of TComment;
      // Stores the number of comments in the array
      FCommentCount : smallint;
    public
      // Sets the number of comments to 0
      constructor Create;
      // Adds a comment to the array
      procedure AddComment (Comment : TComment);
      // Deletes a comments from the array
      procedure DeleteComment (Comment : TComment);
      // Gets the comment at the specified Index
      function GetComment(Index : smallint): TComment;
      // Gets the index of the specified comment or -1 if it was not found
      function SearchForComment(Comment : TComment) : smallint;
      // Gets the total number of comments
      function GetCommentCount : smallint;
      // Sets the comment at the specified index
      procedure SetComment (Comment : TComment; Index : smallint);
      // Sorts the comments by their datetime from most recent to oldest
      procedure SortCommentsDescByDateTime;
      // Returns all the comments as a single string
      function ToString : string;
  end; // class

implementation

{ TComments }

procedure TComments.AddComment(Comment: TComment);
begin
  // Increase the number of comments in the array
  Inc(FCommentCount);
  // Add the new comment to the end of the array
  FComments[FCommentCount] := Comment;
end;

constructor TComments.Create;
begin
  // Set the number of comments in the array to 0
  FCommentCount := 0;
end;

procedure TComments.DeleteComment(Comment: TComment);
var
  iPos, K : smallint;
begin
  // Search for the position of the comment
  iPos := SearchForComment(Comment);

  // Check if the comment was found
  if iPos > -1 then
  begin
    // If the comment was found, delete it from the array
    for K := iPos to FCommentCount - 1 do
      FComments[K] := FComments[K + 1];

    Dec(FCommentCount);
  end; // if
end;

function TComments.GetComment(Index: smallint): TComment;
begin
  // Returns the comment at the specified index
  Result := FComments[Index];
end;

function TComments.GetCommentCount: smallint;
begin
  // Returns FCommentCount
  Result := FCommentCount;
end;

function TComments.SearchForComment(Comment: TComment): smallint;
var
  bFound : boolean;
  K : smallint;
begin
  // We haven't found the comment yet
  bFound := False;
  Result := -1;

  // Keep searching for the comment until it is found or we reach the end of
  // the array
  K := 0;
  while (K < FCommentCount) AND (not bFound) do
  begin
    Inc(K);
    bFound := FComments[K].GetCommentID = Comment.GetCommentID;
  end; // while

  // If we did find the comment, change Result from -1 to the index it was
  // found at
  if bFound then
    Result := K;
end;

procedure TComments.SetComment(Comment: TComment; Index: smallint);
begin
  // Sets the comment at the specified Index
  FComments[Index] := Comment;
end;

procedure TComments.SortCommentsDescByDateTime;
var
  K, J : smallint;
  objTempComment : TComment;
begin
  // Using selection sort to sort all the comments from most recent to oldest
  for K := 1 to FCommentCount - 1 do
    for J := K + 1 to FCommentCount do
      if FComments[K].GetDateTimeOfComment < FComments[J].GetDateTimeOfComment then
      begin
        objTempComment := FComments[K];
        FComments[K] := FComments[J];
        FComments[J] := objTempComment;
      end;
end;

function TComments.ToString: string;
var
  K : smallint;
begin
  Result := '';

  // Loop through each comment and call its ToString method
  for K := 1 to FCommentCount do
    Result := Result + '=============================' + #13 +
              FComments[K].ToString + #13;

  Result := Result + '=============================';
end;

end.
