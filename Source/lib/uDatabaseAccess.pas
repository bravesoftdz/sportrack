unit uDatabaseAccess;

interface

uses
  ADODB, forms, uGlobalConstants, dialogs;

const
  //DB_PROVIDER = 'Microsoft.Jet.OLEDB.4.0';
  DB_PROVIDER = 'Microsoft.ACE.OLEDB.12.0';
  DB_PERSIST_SECURITY_INFO = 'False';

type
  TDatabaseAccess = class(TObject)
    private
      // Stores the connection object used to query the database
      FADOQuery : TADOQuery;
    public
      // Initialises the connection object
      constructor Create;
      // Executes a query and returns no results
      procedure Exec(SQLQuery : string);
      // Executes a query and returns the results
      function ExecWithResults(SQLQuery : string): TADOQuery;
      // Queries for the last ID that was inserted into the database
      function QueryLastIDUsed : integer;
      // Checks whether any results were returned
      function RecordExists(SQLQuery : string): boolean;
      // Releases the connection object from memory so as not to overload the
      // database
      destructor Destroy; override;
  end; // class

implementation

uses DB, SysUtils;

{ TDatabaseAccess }

constructor TDatabaseAccess.Create;
begin
  // Create a new TADOQuery object and set its connection string
  FADOQuery := TADOQuery.Create(Application);
  FADOQuery.ConnectionString := 'Provider=' + DB_PROVIDER + ';' +
                                'Data Source=' + ExtractFilePath(
                                                   Application.ExeName) + 
                                                   DATABASE_FILENAME + ';' +
                                'Persist Security Info=' +
                                DB_PERSIST_SECURITY_INFO;
end;

destructor TDatabaseAccess.Destroy;
begin
  // Close the connection
  FADOQuery.Close;
  // Destroy the object
  FADOQuery.Destroy;

  inherited;
end;

procedure TDatabaseAccess.Exec(SQLQuery: string);
begin
  // Set the SQL text
  FADOQuery.SQL.Text := SQLQuery;
  // Execute the SQL
  FADOQuery.ExecSQL;
end;

function TDatabaseAccess.ExecWithResults(SQLQuery: string): TADOQuery;
begin
  // Execute the query
  Exec(SQLQuery);
  // Return the results
  Result := FADOQuery;
end;

function TDatabaseAccess.QueryLastIDUsed: integer;
var
  sSQL : string;
begin
  // Using Access syntax, retrieve the last used ID
  sSQL := 'SELECT @@IDENTITY';

  // Execute the query
  Exec(sSQL);

  // Open the results, get the results and close it again
  FADOQuery.Open;
  FADOQuery.First;

  Result := FADOQuery.Fields[0].AsInteger;

  FADOQuery.Close;
end;

function TDatabaseAccess.RecordExists(SQLQuery: string): boolean;
begin
  // Execute the query
  Exec(SQLQuery);

  // Check to see if any results were returned and close the object again
  FADOQuery.Open;
  FADOQuery.First;
  Result := not FADOQuery.Eof;
  FADOQuery.Close;
end;

end.
