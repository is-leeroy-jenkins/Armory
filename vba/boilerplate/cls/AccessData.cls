Option Compare Database
Option Explicit



Private m_BudgetPath As BudgetPath
Private m_Error As String
Private m_Notification As String
Private m_DataModels As Collection
Private m_Connection As ADODB.Connection
Private m_ReferenceConnection As ADODB.Connection
Private m_DataConnection As ADODB.Connection
Private m_ViewConnection As ADODB.Connection
Private m_Command As ADODB.Command
Private m_DataSet As ADODB.Recordset
Private m_Record As ADODB.Record




'----------------------------------------------------------------------------------
'   Type        Contructor/Finalizer
'   Name        Class_Initialize()/Class_Terminate
'   Parameters  Void
'   Retval      AccessData
'   Purpose
'---------------------------------------------------------------------------------
Private Sub Class_Initialize()
    Set m_BudgetPath = New BudgetPath
    Set m_DataConnection = New ADODB.Connection
End Sub

Private Sub Class_Terminate()
    KillFiles
    KillDataConnection
    KillReferenceConnection
    KillViewConnection
End Sub
 








'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name        DataConnection
'   Parameters  Void
'   Retval      ADODB.Connection
'   Purpose     Function to create and return the current ADO connection
'---------------------------------------------------------------------------------
Public Function GetDataConnection() As ADODB.Connection
    On Error GoTo ErrorHandler:
    If Not m_DataConnection Is Nothing Then
        m_DataConnection.Open m_BudgetPath.Data
        Set GetDataConnection = m_DataConnection
    Else
        Set m_DataConnection = New ADODB.Connection
        m_DataConnection.Open m_BudgetPath.Data
        Set GetDataConnection = m_DataConnection
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="GetDataConnection()"
    KillConnection
    Exit Function
End Function




'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetReferenceConnection
'   Parameters  Void
'   Retval      ADODB.Connection
'   Purpose     Function to create property getter and return the current ADO connection
'---------------------------------------------------------------------------------
Public Function GetReferenceConnection() As ADODB.Connection
    On Error GoTo ErrorHandler:
    If Not m_ReferenceConnection Is Nothing Then
        m_ReferenceConnection.Open m_BudgetPath.References
        Set GetReferenceConnection = m_ReferenceConnection
    Else
        Set m_ReferenceConnection = New ADODB.Connection
        m_ReferenceConnection.Open m_BudgetPath.References
        Set GetReferenceConnection = m_ReferenceConnection
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="GetReferenceConnection()"
    KillReferenceConnection
    Exit Function
End Function




'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetViewConnection
'   Parameters  Void
'   Retval      ADODB.Connection
'   Purpose     Function to create property getter and return the current ADO connection
'---------------------------------------------------------------------------------
Public Function GetViewConnection() As ADODB.Connection
    On Error GoTo ErrorHandler:
    If Not m_ViewConnection Is Nothing Then
        m_ViewConnection.Open m_BudgetPath.Views
        Set GetViewConnection = m_ViewConnection
    Else
        Set m_ViewConnection = New ADODB.Connection
        m_ViewConnection.Open m_BudgetPath.Views
        Set GetViewConnection = m_ViewConnection
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="GetViewConnection()"
    KillViewConnection
    Exit Function
End Function






'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetDataModel
'   Parameters  Void
'   Retval      ADODB.Recordset
'   Purpose     Function to create and return the pTableName
'---------------------------------------------------------------------------------
Public Function GetDataModel(pTableName As String) As ADODB.Recordset
    On Error GoTo ErrorHandler:
    If Not pTableName & "" = "" Then
        Set m_DataSet = New ADODB.Recordset
        Dim p_Connection As ADODB.Connection
        Set p_Connection = GetDataConnection
        Dim p_SQL As String
        p_SQL = "SELECT * FROM pTableName"
        m_DataSet.Open p_SQL, p_Connection, adOpenStatic, adLockOptimistic
        Set GetDataModel = m_DataSet
        Set p_Connection = Nothing
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="GetDataModel()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetReferenceModel
'   Parameters  Void
'   Retval      ADODB.Recordset
'   Purpose     Function to create and return the pTableName
'---------------------------------------------------------------------------------
Public Function GetReferenceModel(pTableName As String) As ADODB.Recordset
    On Error GoTo ErrorHandler:
    If Not pTableName & "" = "" Then
        Set m_DataSet = New ADODB.Recordset
        Dim p_SQL As String
        p_SQL = "SELECT * FROM pTableName"
        m_DataSet.Open p_SQL, References, adOpenStatic, adLockOptimistic
        Set GetReferenceModel = m_DataSet
        KillDataConnection
        KillConnection
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="GetReferenceModel()"
    Exit Function
End Function







'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetViewModel
'   Parameters  Void
'   Retval      ADODB.Recordset
'   Purpose     Function to create and return the pTableName
'---------------------------------------------------------------------------------
Public Function GetViewModel(pTableName As String) As ADODB.Recordset
    On Error GoTo ErrorHandler:
    If Not pTableName & "" = "" Then
        Set m_DataSet = New ADODB.Recordset
        Dim p_Connection As ADODB.Connection
        Set p_Connection = GetViewConnection
        Dim p_SQL As String
        p_SQL = "SELECT * FROM pTableName"
        m_DataSet.Open p_SQL, p_Connection, adOpenStatic, adLockOptimistic
        Set GetViewModel = m_DataSet
        Set p_Connection = Nothing
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="GetViewModel()"
    Exit Function
End Function




'----------------------------------------------------------------------------------
'   Type        Function
'   Name        CreateSqlCommand
'   Parameters  String - sql
'   Purpose     Function to create and return a command
'               based on a sql string argument
'---------------------------------------------------------------------------------
Public Function CreateCommand(pSQL As String) As ADODB.Command
    On Error GoTo ErrorHandler:
    Set m_DataSet = New ADODB.Recordset
    Dim cmd As ADODB.Command
    Set cmd = New ADODB.Command
    cmd.ActiveConnection = CurrentProject.Connection
    If Not pSQL & "" = "" Then
        cmd.CommandText = pSQL
    End If
    If Not IsNull(cmd) Then
        Set CreateCommand = cmd
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="CreateCommand"
    Exit Function
End Function


'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetModel
'   Parameters  String - Table
'   Purpose     Function to create and return a recordset
'               based on a pTableName name provided as parameter argument
'---------------------------------------------------------------------------------
Public Function GetModel(pTableName As String) As ADODB.Recordset
    On Error GoTo ErrorHandler:
    Set m_DataSet = New ADODB.Recordset
    m_DataSet.Open (pTableName)
    If m_DataSet.RecordCount > 0 Then
        Set GetModel = m_DataSet
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="GetModel"
    Exit Function
End Function


'----------------------------------------------------------------------------------
'   Type        Sub-Procedure
'   Name        ImportExcelData
'   Parameters  String
'   Retval      Void
'   Purpose     Function to Import Excel data into MS Access
'---------------------------------------------------------------------------------
Public Sub ImportExcelData(pFilePath As String)
    On Error GoTo ErrorHandler:
    If Not pFilePath & "" = "" Then
        Dim p_FilePath As String
        Dim p_List() As String
        Dim p_Count As Integer
        Dim p_Worksheet As Excel.Worksheet
        Dim p_Excel As Excel.Application
        p_FilePath = pFilePath
        Set p_Excel = CreateObject("Excel.Application")
        p_Excel.Visible = False
        p_Excel.DisplayAlerts = False
        p_Excel.Workbooks.Open p_FilePath
        If p_Excel.Worksheets.Count > 1 Then
            Dim i As Integer
            For Each p_Worksheet In p_Excel.Worksheets
                ReDim Preserve p_List(p_Count)
                p_List(p_Count) = p_Worksheet.Name
                p_Count = p_Count + 1
            Next
            For i = LBound(p_List()) To UBound(p_List())
                DoCmd.TransferSpreadsheet acImport, acSpreadsheetTypeExcel12, p_List(i), _
                    p_FilePath, True, p_List(i) & "!A1:IU9999"
            Next i
        Else
            DoCmd.TransferSpreadsheet acImport, acSpreadsheetTypeExcel12, p_List(0), _
                p_FilePath, True, p_List(i) & "!A1:IU9999"
        End If
        p_Excel.ActiveWorkbook.Close (True)
        p_Excel.Quit
        Set p_Excel = Nothing
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="ImportExcelData"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Sub-Procedure
'   Name        KillDataConnection
'   Parameters  Void
'   Retval      Void
'   Purpose     Frees resources used by the Database
'---------------------------------------------------------------------------------
Private Sub KillDataConnection()
    On Error GoTo ErrorHandler:
    If Not m_DataConnection Is Nothing Then
        Set m_DataConnection = Nothing
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="KillDataConnection"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Sub-Procedure
'   Name        KillReferenceConnection
'   Parameters  Void
'   Retval      Void
'   Purpose     Frees resources used by the Database
'---------------------------------------------------------------------------------
Private Sub KillReferenceConnection()
    On Error GoTo ErrorHandler:
    If Not m_ReferenceConnection Is Nothing Then
        Set m_ReferenceConnection = Nothing
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="KillReferenceConnection"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Sub-Procedure
'   Name        KillViewConnection
'   Parameters  Void
'   Retval      Void
'   Purpose     Frees resources used by the Database
'---------------------------------------------------------------------------------
Private Sub KillViewConnection()
    On Error GoTo ErrorHandler:
    If Not m_ViewConnection Is Nothing Then
        Set m_ViewConnection = Nothing
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="KillViewConnection"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Sub-Procedure
'   Name        KillDataConnection
'   Parameters  Void
'   Retval      Void
'   Purpose     Frees resources used by the Database
'---------------------------------------------------------------------------------
Private Sub KillConnection()
    On Error GoTo ErrorHandler:
    If Not m_Connection Is Nothing Then
        Set m_Connection = Nothing
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="KillConnection"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Sub-Procedure
'   Name        KillFiles
'   Parameters  Void
'   Retval      Void
'   Purpose     Frees resources used by the BudgetPath object
'---------------------------------------------------------------------------------
Private Sub KillFiles()
    On Error GoTo ErrorHandler:
    If Not m_BudgetPath Is Nothing Then
        Set m_BudgetPath = Nothing
    End If
ErrorHandler:
    ProcessError Name:="AccessData", _
        Member:="KillFiles()"
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




