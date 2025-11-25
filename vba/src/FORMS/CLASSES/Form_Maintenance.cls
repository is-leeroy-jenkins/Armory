VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_Maintenance"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit





Private m_Error As String






'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Load()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler:
    Me.Caption = "Database Menu"
ErrorHandler:
    ProcessError Name:="MaintenanceForm", _
        Member:="Form_Load()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        LinqPadButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub LinqPadButton_Click()
    On Error GoTo ErrorHandler:
    LinqPad.Run
ErrorHandler:
    ProcessError Name:="MaintenanceForm", _
        Member:="LinqPadButton_Click()"
    Exit Sub

End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        PythonButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub PythonButton_Click()
    On Error GoTo ErrorHandler:
    Python.Run
ErrorHandler:
    ProcessError Name:="MaintenanceForm", _
        Member:="PythonButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExcelButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SqliteButton_Click()
    On Error GoTo ErrorHandler:
    SQLite.Run
ErrorHandler:
    ProcessError Name:="MaintenanceForm", _
        Member:="SqliteButton_Click()"
    Exit Sub
End Sub







'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExcelButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SqlServerButton_Click()
    On Error GoTo ErrorHandler:
ErrorHandler:
    ProcessError Name:="MaintenanceForm", _
        Member:="SqlServerButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExcelButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SqlServerCeButton_Click()
    On Error GoTo ErrorHandler:
    SqlServer.RunCompact
ErrorHandler:
    ProcessError Name:="MaintenanceForm", _
        Member:="SqlServerCeButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExcelButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ExitButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close ObjectType:=acForm, ObjectName:="Maintenance", Save:=acSaveNo
    DoCmd.OpenForm FormName:="Main", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="MaintenanceForm", _
        Member:="ExitButton_Click()"
    Exit Sub
End Sub








'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExcelButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ControlPanelButton_Click()
    On Error GoTo ErrorHandler:
ErrorHandler:
    ProcessError Name:="MaintenanceForm", _
        Member:="SqlServerButton_Click()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExcelButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub TaskManagerButton_Click()
    On Error GoTo ErrorHandler:
ErrorHandler:
    ProcessError Name:="MaintenanceForm", _
        Member:="SqlServerButton_Click()"
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







