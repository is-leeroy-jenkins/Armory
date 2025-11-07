Option Compare Database
Option Explicit


Private m_BudgetExecution As DAO.Workspace
Private m_Database As DAO.Database
Private m_DataSet As DAO.Recordset
Private m_Error As String
Private m_Notification As String
Private m_SQL As String







'----------------------------------------------------------------------------------
'   Type        Contructor/Finalizer
'   Name        Class_Initialize()/Class_Terminate
'   Parameters  Void
'   Retval      AccessData
'   Purpose
'---------------------------------------------------------------------------------
Private Sub Class_Initialize()
    Set m_Database = CurrentDb
    Set m_BudgetExecution = DBEngine.Workspaces(0)
End Sub

Private Sub Class_Terminate()
    If Not IsNull(m_Database) Then
        Set m_Database = Nothing
    End If
    If Not IsNull(m_BudgetExecution) Then
        Set m_BudgetExecution = Nothing
    End If
End Sub





'----------------------------------------------------------------------------------
'   Type:        Property Get
'   Name:        IsConnected
'   Parameters:  Void
'   RetVal:      Boolean
'   Purpose:     Function returns boolean value indicating if Workspace is open
'---------------------------------------------------------------------------------
Public Property Get IsConnected() As Boolean
    On Error GoTo ErrorHandler:
    If Not IsObject(m_Database) Then
        IsConnected = True
    End If
    If IsObject(m_Database) Then
        IsConnected = False
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="IsConnected()"
    Exit Property
End Property





'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name        IsOpen
'   Parameters  Void
'   RetVal      Boolean
'   Purpose     Function returns boolean value indicating if Workspace is open
'---------------------------------------------------------------------------------
Public Property Get IsOpen() As Boolean
    On Error GoTo ErrorHandler:
    If Not IsObject(m_BudgetExecution) Then
        IsOpen = True
    End If
    If IsObject(m_BudgetExecution) Then
        IsOpen = False
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="IsOpen()"
    Exit Property
End Property





'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetDataSet
'   Parameters  String - table;
'   RetVal      DAO.Recordset
'   Purpose     Function returns the records from the Data Table using the table's
'               name or a sql select query
'---------------------------------------------------------------------------------
Public Function GetDataSet(pTable As String) As DAO.Recordset
    On Error GoTo ErrorHandler:
    Set m_Database = CurrentDb
    If Not pTable & "" = "" Then
        Set m_DataSet = m_Database.OpenRecordset(pTable, dbOpenDynaset)
        Set GetDataSet = m_DataSet
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="GetDataSet()"
    Exit Function
End Function





'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetRecord
'   Parameters  String - pTable;
'   RetVal      DAO.Recordset
'   Purpose     Function returns record using pIndex parameter and Primary Key
'               defined in a sql select query
'---------------------------------------------------------------------------------
Public Function GetDataRecord(pTable As String, pKey As String, pIndex As Integer) As DAO.Recordset
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" And _
        Not pKey & "" = "" And _
        Not pIndex < 0 Then
            Set m_Database = CurrentDb
            m_SQL = "SELECT * FROM " & pTable _
                & " WHERE " & pKey _
                & " = '" & pIndex & "'" & ""
            If Not m_SQL & "" = "" Then
                Set m_DataSet = m_Database.OpenRecordset(m_SQL, dbOpenDynaset)
                Set GetDataRecord = m_DataSet
            End If
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="GetDataRecord()"
    Exit Function
End Function





'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        CloseDatabase
'   Parameters  Void
'   RetVal      Void
'   Purpose     Method used to close the database
'---------------------------------------------------------------------------------
Public Sub CloseDatabase()
    On Error GoTo ErrorHandler:
    If Not m_Database Is Nothing Then
        Set m_Database = Nothing
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="CloseDatabase()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        CloseWorkspace
'   Parameters  Void
'   RetVal      Void
'   Purpose     Method used to close the database
'---------------------------------------------------------------------------------
Public Sub CloseWorkspace()
    On Error GoTo ErrorHandler:
    If Not IsNull(m_BudgetExecution) Then
        Set m_BudgetExecution = Nothing
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="CloseWorkspace()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        UpdateDate
'   Parameters  pTable - String, pField - String, value - Variant
'   RetVal      Void
'   Purpose     Method used to update data in current recordset
'---------------------------------------------------------------------------------
Public Sub UpdateData(pTable As String, pField As String, pValue As Variant)
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" And _
        Not pField & "" = "" And _
        Not IsNull(pValue) Then
            Set m_Database = CurrentDb
            Set m_DataSet = CurrentDb.OpenRecordset(pTable)
            m_DataSet.Edit
            m_DataSet.Fields(pField) = pValue
            m_DataSet.Update
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="UpdateData()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        AddRecord
'   Parameters  pTable - String, pField- String, value - Variant
'   RetVal      Void
'   Purpose     Method used to add data to recordset
'---------------------------------------------------------------------------------
Public Sub AddRecord(pTable As String, pField As String, pValue As Variant)
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" And _
        Not pField & "" = "" And _
        Not IsNull(pValue) Then
            Set m_Database = CurrentDb
            Set m_DataSet = CurrentDb.OpenRecordset(pTable)
            With m_DataSet
              .AddNew
              !Fields(pField) = pValue
              .Update
            End With
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="AddRecord()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        UpdateRecord
'   Parameters  pTable - String, pField - String, value - Variant
'   RetVal      Void
'   Purpose     Method used to add data to recordset
'---------------------------------------------------------------------------------
Public Sub UpdateRecord(pTable As String, pField As String, pNewValue As Variant, pID As Integer)
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" And _
        Not pField & "" = "" And _
        Not pNewValue Is Nothing And _
        Not pID < 0 Then
            Dim p_Database As DAO.Database
            Dim p_DataSet As DAO.Recordset
            Set p_Database = m_Database
            Set p_DataSet = GetDataRecord(pTable, pField, pID)
            If Not IsNull(p_DataSet) Then
                With p_DataSet
                  .AddNew
                  !Fields(pField) = pNewValue
                  .Update
                End With
            End If
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="UpdateRecord()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        DeleteRecord
'   Parameters  pTable - String, pKey - String, id - integer
'   RetVal      Void
'   Purpose     Method used to delete records from the data set
'---------------------------------------------------------------------------------
Public Sub DeleteRecord(pTable As String, pKey As String, pID As Integer)
    On Error GoTo ErrorHandler:
    Dim p_Database As DAO.Database
    Dim p_DataSet As DAO.Recordset
    Set p_Database = m_Database
    Dim SQL As String
    SQL = "DELETE FROM " & pTable & " WHERE " & pKey & "' = '" & pID & "'" & ""
    Set p_DataSet = p_Database.OpenRecordset(SQL)
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="DeleteRecord()"
    Exit Sub
End Sub






Option Compare Database
Option Explicit


Private m_BudgetExecution As DAO.Workspace
Private m_Database As DAO.Database
Private m_DataSet As DAO.Recordset
Private m_Error As String
Private m_Notification As String
Private m_SQL As String







'----------------------------------------------------------------------------------
'   Type        Contructor/Finalizer
'   Name        Class_Initialize()/Class_Terminate
'   Parameters  Void
'   Retval      AccessData
'   Purpose
'---------------------------------------------------------------------------------
Private Sub Class_Initialize()
    Set m_Database = CurrentDb
    Set m_BudgetExecution = DBEngine.Workspaces(0)
End Sub

Private Sub Class_Terminate()
    If Not IsNull(m_Database) Then
        Set m_Database = Nothing
    End If
    If Not IsNull(m_BudgetExecution) Then
        Set m_BudgetExecution = Nothing
    End If
End Sub





'----------------------------------------------------------------------------------
'   Type:        Property Get
'   Name:        IsConnected
'   Parameters:  Void
'   RetVal:      Boolean
'   Purpose:     Function returns boolean value indicating if Workspace is open
'---------------------------------------------------------------------------------
Public Property Get IsConnected() As Boolean
    On Error GoTo ErrorHandler:
    If Not IsObject(m_Database) Then
        IsConnected = True
    End If
    If IsObject(m_Database) Then
        IsConnected = False
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="IsConnected()"
    Exit Property
End Property





'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name        IsOpen
'   Parameters  Void
'   RetVal      Boolean
'   Purpose     Function returns boolean value indicating if Workspace is open
'---------------------------------------------------------------------------------
Public Property Get IsOpen() As Boolean
    On Error GoTo ErrorHandler:
    If Not IsObject(m_BudgetExecution) Then
        IsOpen = True
    End If
    If IsObject(m_BudgetExecution) Then
        IsOpen = False
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="IsOpen()"
    Exit Property
End Property





'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetDataSet
'   Parameters  String - table;
'   RetVal      DAO.Recordset
'   Purpose     Function returns the records from the Data Table using the table's
'               name or a sql select query
'---------------------------------------------------------------------------------
Public Function GetDataSet(pTable As String) As DAO.Recordset
    On Error GoTo ErrorHandler:
    Set m_Database = CurrentDb
    If Not pTable & "" = "" Then
        Set m_DataSet = m_Database.OpenRecordset(pTable, dbOpenDynaset)
        Set GetDataSet = m_DataSet
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="GetDataSet()"
    Exit Function
End Function





'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetRecord
'   Parameters  String - pTable;
'   RetVal      DAO.Recordset
'   Purpose     Function returns record using pIndex parameter and Primary Key
'               defined in a sql select query
'---------------------------------------------------------------------------------
Public Function GetDataByIndex(pTable As String, pIndex As Integer) As DAO.Recordset
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" And _
        Not pIndex < 0 Then
            Set m_Database = CurrentDb
            m_SQL = "SELECT * FROM " & pTable & ";"
            Set m_DataSet = m_Database.OpenRecordset(m_SQL, dbOpenDynaset)
            Dim p_Column As New DAO.field
            Dim p_Filter As String
            Set p_Column = m_DataSet.Fields(0)
            p_Filter = p_Column.Name & " = '" & pIndex & "'" & ""
            Dim p_Record As DAO.Recordset
            m_DataSet.filter = p_Filter
            Set GetDataByIndex = m_DataSet
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="GetDataRecord()"
    Exit Function
End Function




'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetDatabase()
'   Parameters  Void
'   RetVal      Void
'   Purpose     Method used to close the database
'---------------------------------------------------------------------------------
Public Function CreateDatabase(pFilePath As String) As DAO.Database
    On Error GoTo ErrorHandler:
    If Not pFilePath & "" = "" Then
        Set m_Database = DBEngine.CreateDatabase(pFilePath, dbLangGeneral)
        Set CreateDatabase = m_Database
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="GetDatabase()"
    Exit Function
End Function




'----------------------------------------------------------------------------------
'   Type        Function
'   Name        CreateTable()
'   Parameters  Void
'   RetVal      Void
'   Purpose     Method used to close the database
'---------------------------------------------------------------------------------
Public Function CreateTable(pTable As String, pName() As String) As DAO.TableDef
    On Error GoTo ErrorHandler:
    If Not m_Database Is Nothing And _
        IsArray(pName) Then
            Dim p_Table As DAO.TableDef
            Set p_Table = New DAO.TableDef
            Set p_Table = m_Database.CreateTableDef(pTable)
            Dim i As Integer
            For i = 0 To i = UBound(pName) - 1
                Dim p_Field As New DAO.field
                With p_Field
                    .Name = pName(i)
                    .OrdinalPosition = i
                End With
                p_Table.Fields.Append (p_Field)
            Next i
            m_Database.TableDefs.Append (p_Table)
            Set CreateTable = m_Database.TableDefs(p_Table)
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="CreateTable()"
    Exit Function
End Function







'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetDatabase()
'   Parameters  Void
'   RetVal      Void
'   Purpose     Method used to close the database
'---------------------------------------------------------------------------------
Public Function GetRecords(pTable) As DAO.Recordset
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" Then
        Set m_DataSet = CurrentDb.OpenRecordset(pTable)
        Set GetRecords = m_DataSet
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="GetDataSet()"
    Exit Function
End Function




'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        UpdateDate
'   Parameters  pTable - String, pField - String, value - Variant
'   RetVal      Void
'   Purpose     Method used to update data in current recordset
'---------------------------------------------------------------------------------
Public Sub UpdateData(pTable As String, pIndex As Integer, pColumn As String, pValue As Variant)
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" And _
        Not pColumn & "" = "" And _
        Not IsNull(pValue) Then
            Set m_DataSet = CurrentDb.OpenRecordset(pTable)
            m_DataSet.Edit
            m_DataSet.Fields(pColumn).Value = pValue
            m_DataSet.Update
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="UpdateData()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        AddRecord
'   Parameters  pTable - String, pField- String, value - Variant
'   RetVal      Void
'   Purpose     Method used to add data to recordset
'---------------------------------------------------------------------------------
Public Sub AddRecord(pTable As String, pColumnName As String, pValue As Variant)
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" Then
        Set m_DataSet = CurrentDb.OpenRecordset(pTable)
        m_DataSet.AddNew
        m_DataSet.Fields(pColumnName).Value = pValue
        m_DataSet.Update
        Set m_DataSet = Nothing
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="AddRecord()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        UpdateRecord
'   Parameters  pTable - String, pField - String, value - Variant
'   RetVal      Void
'   Purpose     Method used to add data to recordset
'---------------------------------------------------------------------------------
Public Sub UpdateRecord(pTable As String, pField As String, pNewValue As Variant)
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" And _
        Not pField & "" = "" And _
        Not pNewValue Is Nothing Then
            Set m_DataSet = CurrentDb.OpenRecordset(pTable)
            With m_DataSet
                .Edit
                .Fields(pField) = pNewValue
                .Update
            End With
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="UpdateRecord()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        DeleteRecord
'   Parameters  pTable - String, pKey - String, id - integer
'   RetVal      Void
'   Purpose     Method used to delete records from the data set
'---------------------------------------------------------------------------------
Public Sub DeleteRecord(pTableName As String, pKey As String, pID As Integer)
    On Error GoTo ErrorHandler:
    If Not pTableName & "" = "" And _
        Not pKey & "" = "" And _
        Not pID < 0 Then
            Set m_Database = CurrentDb
            m_SQL = "DELETE FROM " _
                & pTableName & " WHERE " & pKey & "' = '" & pID & "'" & ""
            Set m_DataSet = CurrentDb.OpenRecordset(pTableName)
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="DeleteRecord()"
    Exit Sub
End Sub











'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Process
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ProcessError(Optional Name As String, Optional Member As String)
    If Err.Number <> 0 And _
        Not IsMissing(Name) And _
        Not IsMissing(Member) Then
            m_Error = "Source:      " & Err.Source _
                & vbCrLf & "Number:     " & Err.Number _
                & vbCrLf & "Issue:      " & Err.Description _
                & vbCrLf & "Class:      " & Name _
                & vbCrLf & "Member:     " & Member
    End If
    If Err.Number <> 0 And _
        IsMissing(Name) And _
        IsMissing(Member) Then
            m_Error = "Source:      " & Err.Source _
                & vbCrLf & "Number:     " & Err.Number _
                & vbCrLf & "Issue:      " & Err.Description
    End If
    MessageFactory.ShowError (m_Error)
    Err.Clear
End Sub





Option Compare Database
Option Explicit


Private m_BudgetExecution As DAO.Workspace
Private m_Database As DAO.Database
Private m_DataSet As DAO.Recordset
Private m_Error As String
Private m_Notification As String
Private m_SQL As String







'----------------------------------------------------------------------------------
'   Type        Contructor/Finalizer
'   Name        Class_Initialize()/Class_Terminate
'   Parameters  Void
'   Retval      AccessData
'   Purpose
'---------------------------------------------------------------------------------
Private Sub Class_Initialize()
    Set m_Database = CurrentDb
    Set m_BudgetExecution = DBEngine.Workspaces(0)
End Sub

Private Sub Class_Terminate()
    If Not IsNull(m_Database) Then
        Set m_Database = Nothing
    End If
    If Not IsNull(m_BudgetExecution) Then
        Set m_BudgetExecution = Nothing
    End If
End Sub





'----------------------------------------------------------------------------------
'   Type:        Property Get
'   Name:        IsConnected
'   Parameters:  Void
'   RetVal:      Boolean
'   Purpose:     Function returns boolean value indicating if Workspace is open
'---------------------------------------------------------------------------------
Public Property Get IsConnected() As Boolean
    On Error GoTo ErrorHandler:
    If Not IsObject(m_Database) Then
        IsConnected = True
    End If
    If IsObject(m_Database) Then
        IsConnected = False
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="IsConnected()"
    Exit Property
End Property





'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name        IsOpen
'   Parameters  Void
'   RetVal      Boolean
'   Purpose     Function returns boolean value indicating if Workspace is open
'---------------------------------------------------------------------------------
Public Property Get IsOpen() As Boolean
    On Error GoTo ErrorHandler:
    If Not IsObject(m_BudgetExecution) Then
        IsOpen = True
    End If
    If IsObject(m_BudgetExecution) Then
        IsOpen = False
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="IsOpen()"
    Exit Property
End Property





'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetDataSet
'   Parameters  String - table;
'   RetVal      DAO.Recordset
'   Purpose     Function returns the records from the Data Table using the table's
'               name or a sql select query
'---------------------------------------------------------------------------------
Public Function GetDataSet(pTable As String) As DAO.Recordset
    On Error GoTo ErrorHandler:
    Set m_Database = CurrentDb
    If Not pTable & "" = "" Then
        Set m_DataSet = m_Database.OpenRecordset(pTable, dbOpenDynaset)
        Set GetDataSet = m_DataSet
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="GetDataSet()"
    Exit Function
End Function





'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetRecord
'   Parameters  String - pTable;
'   RetVal      DAO.Recordset
'   Purpose     Function returns record using pIndex parameter and Primary Key
'               defined in a sql select query
'---------------------------------------------------------------------------------
Public Function GetDataByIndex(pTable As String, pIndex As Integer) As DAO.Recordset
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" And _
        Not pIndex < 0 Then
            Set m_Database = CurrentDb
            m_SQL = "SELECT * FROM " & pTable & ";"
            Set m_DataSet = m_Database.OpenRecordset(m_SQL, dbOpenDynaset)
            Dim p_Column As New DAO.field
            Dim p_Filter As String
            Set p_Column = m_DataSet.Fields(0)
            p_Filter = p_Column.Name & " = '" & pIndex & "'" & ""
            Dim p_Record As DAO.Recordset
            m_DataSet.filter = p_Filter
            Set GetDataByIndex = m_DataSet
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="GetDataRecord()"
    Exit Function
End Function




'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetDatabase()
'   Parameters  Void
'   RetVal      Void
'   Purpose     Method used to close the database
'---------------------------------------------------------------------------------
Public Function CreateDatabase(pFilePath As String) As DAO.Database
    On Error GoTo ErrorHandler:
    If Not pFilePath & "" = "" Then
        Set m_Database = DBEngine.CreateDatabase(pFilePath, dbLangGeneral)
        Set CreateDatabase = m_Database
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="GetDatabase()"
    Exit Function
End Function




'----------------------------------------------------------------------------------
'   Type        Function
'   Name        CreateTable()
'   Parameters  Void
'   RetVal      Void
'   Purpose     Method used to close the database
'---------------------------------------------------------------------------------
Public Function CreateTable(pTable As String, pName() As String) As DAO.TableDef
    On Error GoTo ErrorHandler:
    If Not m_Database Is Nothing And _
        IsArray(pName) Then
            Dim p_Table As DAO.TableDef
            Set p_Table = New DAO.TableDef
            Set p_Table = m_Database.CreateTableDef(pTable)
            Dim i As Integer
            For i = 0 To i = UBound(pName) - 1
                Dim p_Field As New DAO.field
                With p_Field
                    .Name = pName(i)
                    .OrdinalPosition = i
                End With
                p_Table.Fields.Append (p_Field)
            Next i
            m_Database.TableDefs.Append (p_Table)
            Set CreateTable = m_Database.TableDefs(p_Table)
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="CreateTable()"
    Exit Function
End Function







'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetDatabase()
'   Parameters  Void
'   RetVal      Void
'   Purpose     Method used to close the database
'---------------------------------------------------------------------------------
Public Function GetRecords(pTable) As DAO.Recordset
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" Then
        Set m_DataSet = CurrentDb.OpenRecordset(pTable)
        Set GetRecords = m_DataSet
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="GetDataSet()"
    Exit Function
End Function




'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        UpdateDate
'   Parameters  pTable - String, pField - String, value - Variant
'   RetVal      Void
'   Purpose     Method used to update data in current recordset
'---------------------------------------------------------------------------------
Public Sub UpdateData(pTable As String, pIndex As Integer, pColumn As String, pValue As Variant)
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" And _
        Not pColumn & "" = "" And _
        Not IsNull(pValue) Then
            Set m_DataSet = CurrentDb.OpenRecordset(pTable)
            m_DataSet.Edit
            m_DataSet.Fields(pColumn).Value = pValue
            m_DataSet.Update
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="UpdateData()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        AddRecord
'   Parameters  pTable - String, pField- String, value - Variant
'   RetVal      Void
'   Purpose     Method used to add data to recordset
'---------------------------------------------------------------------------------
Public Sub AddRecord(pTable As String, pColumnName As String, pValue As Variant)
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" Then
        Set m_DataSet = CurrentDb.OpenRecordset(pTable)
        m_DataSet.AddNew
        m_DataSet.Fields(pColumnName).Value = pValue
        m_DataSet.Update
        Set m_DataSet = Nothing
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="AddRecord()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        UpdateRecord
'   Parameters  pTable - String, pField - String, value - Variant
'   RetVal      Void
'   Purpose     Method used to add data to recordset
'---------------------------------------------------------------------------------
Public Sub UpdateRecord(pTable As String, pField As String, pNewValue As Variant)
    On Error GoTo ErrorHandler:
    If Not pTable & "" = "" And _
        Not pField & "" = "" And _
        Not pNewValue Is Nothing Then
            Set m_DataSet = CurrentDb.OpenRecordset(pTable)
            With m_DataSet
                .Edit
                .Fields(pField) = pNewValue
                .Update
            End With
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="UpdateRecord()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type        Subprocedure
'   Name        DeleteRecord
'   Parameters  pTable - String, pKey - String, id - integer
'   RetVal      Void
'   Purpose     Method used to delete records from the data set
'---------------------------------------------------------------------------------
Public Sub DeleteRecord(pTableName As String, pKey As String, pID As Integer)
    On Error GoTo ErrorHandler:
    If Not pTableName & "" = "" And _
        Not pKey & "" = "" And _
        Not pID < 0 Then
            Set m_Database = CurrentDb
            m_SQL = "DELETE FROM " _
                & pTableName & " WHERE " & pKey & "' = '" & pID & "'" & ""
            Set m_DataSet = CurrentDb.OpenRecordset(pTableName)
    End If
ErrorHandler:
    ProcessError Name:="DataAccess", _
        Member:="DeleteRecord()"
    Exit Sub
End Sub











'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Process
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ProcessError(Optional Name As String, Optional Member As String)
    If Err.Number <> 0 And _
        Not IsMissing(Name) And _
        Not IsMissing(Member) Then
            m_Error = "Source:      " & Err.Source _
                & vbCrLf & "Number:     " & Err.Number _
                & vbCrLf & "Issue:      " & Err.Description _
                & vbCrLf & "Class:      " & Name _
                & vbCrLf & "Member:     " & Member
    End If
    If Err.Number <> 0 And _
        IsMissing(Name) And _
        IsMissing(Member) Then
            m_Error = "Source:      " & Err.Source _
                & vbCrLf & "Number:     " & Err.Number _
                & vbCrLf & "Issue:      " & Err.Description
    End If
    MessageFactory.ShowError (m_Error)
    Err.Clear
End Sub









