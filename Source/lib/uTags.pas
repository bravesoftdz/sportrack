unit uTags;

interface

const
  MAX_TAGS = 20;

type
  TTags = class (TObject)
    private
      // Stores an array of all the tags
      FTags : Array[1..MAX_TAGS] of string;
      // Stores the number of tags in each array
      FTagCount : shortint;
    public
      // Initialises a blank array of tags
      constructor Create; overload;
      // Creates a new array of tags from an existing list
      constructor Create(StringOfTags : string); overload;
      // Adds a single tag to the array
      procedure AddTag(Tag : string);
      // Removes a tag from the array if it exists
      procedure DeleteTag(Tag : string);
      // Gets the number of tags in the array
      function GetTagCount : shortint;
      // Gets the tag at the specified Index
      function GetTag(Index : shortint): string;
      // Searches for the index of a tag in the array
      function SearchForTag(Tag : string) : shortint;
      // Adds a list of tags to the array
      procedure ExtractTags(StringOfTags : string);
      // Returns the tags as a string with optional string prepending and 
      // appending each tag
      function ToString(PrependTags, AppendTags : string;Quote:boolean) : string;
  end; // class

implementation

uses SysUtils;

{ TTags }

procedure TTags.AddTag(Tag: string);
begin
  // Check if the tag is not already inside the array
  if SearchForTag(Tag) = -1 then
  begin
    // If the tag is not already in the array, increase the numbe of tags and
    // insert the new tag
    Inc(FTagCount);
    FTags[FTagCount] := Tag;
  end; // if
end;

constructor TTags.Create;
begin
  // Set the number of tags in the array to 0
  FTagCount := 0;
end;

constructor TTags.Create(StringOfTags: string);
begin
  // Set the number of tags in the array to 0
  FTagCount := 0;

  // Insert the list of tags into the array
  ExtractTags(StringOfTags);
end;

procedure TTags.DeleteTag(Tag: string);
var
  iPos, K : shortint;
begin
  // Look for the position of the tag to delete
  iPos := SearchForTag(Tag);

  // Check to see the tag actually exists in the array
  if iPos > -1 then
  begin
    // If the tag does exist, delete it
    for K := iPos to FTagCount - 1 do
      FTags[K] := FTags[K + 1];

    Dec(FTagCount);
  end; // if
end;

procedure TTags.ExtractTags(StringOfTags: string);
var
  iPos : byte;
begin
  // Get the position of the first comma in the list of tags
  iPos := Pos(',', StringOfTags);

  // Keep looping until all the tags have been read
  while iPos <> 0 do
  begin
    // Add the tag to the array of tags
    AddTag(Copy(StringOfTags, 1, iPos - 1));
    // Delete that tag from the provided list of tags
    Delete(StringOfTags, 1, iPos);

    // Get the position of the next comma in the list of tags
    iPos := Pos(',', StringOfTags);
  end; // while

  // Add the last tag to the array
  AddTag(StringOfTags);
end;

function TTags.GetTag(Index: shortint): string;
begin
  // Return the tag at the specified index
  Result := FTags[Index];
end;

function TTags.GetTagCount: shortint;
begin
  // Return the number of tags in the array
  Result := FTagCount;
end;

function TTags.SearchForTag(Tag: string): shortint;
var
  bFound : boolean;
  K : shortint;
begin
  // The tag has not been found yet
  bFound := False;
  Result := -1;

  // Keep looping until the tag has been found or the end of the array has been
  // reached
  K := 0;
  while (K < FTagCount) AND (not bFound) do
  begin
    Inc(K);
    bFound := FTags[K] = Tag;
  end; // while

  // If the tag was found, return its position otherwise -1 is returned
  if bFound then
    Result := K;
end;

function TTags.ToString(PrependTags, AppendTags : string;Quote:boolean): string;
var
  K : shortint;
  sTag : string;
begin
  Result := '';

  // Loop through each tag and add it to a string
  for K := 1 to FTagCount - 1 do
  begin
    sTag := FTags[K];

    if Quote then
      sTag := QuotedStr(sTag);
      
    Result := Result + PrependTags + sTag + AppendTags + ',';
  end;

  sTag := FTags[FTagCount];

  if Quote then
    sTag := QuotedStr(sTag);
    
  Result := Result + PrependTags + sTag + AppendTags;
end;

end.
