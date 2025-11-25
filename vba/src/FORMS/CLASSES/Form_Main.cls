VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_Main"
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
    Me.Caption = "Main Menu"
ErrorHandler:
    ProcessError Name:="MainForm", _
        Member:="Form_Load()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Load()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Close()
    On Error GoTo ErrorHandler:
    DoCmd.Close ObjectType:=acForm, _
        ObjectName:="MainForm", _
        Save:=acSaveNo
ErrorHandler:
    ProcessError Name:="MainForm", _
        Member:="Form_Close()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        GuidanceButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub GuidanceButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close ObjectType:=acForm, ObjectName:="Main"
    DoCmd.OpenForm FormName:="Guidance", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="MainForm", _
        Member:="GuidanceButton_Click()"
    Exit Sub
End Sub








'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        MaintenanceButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub MaintenanceButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close ObjectType:=acForm, ObjectName:="Main"
    DoCmd.OpenForm FormName:="Maintenance", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="MainForm", _
        Member:="MaintenanceButton_Click()"
    Exit Sub
End Sub











'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        MaintenanceButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub TestButton_Click()
    On Error GoTo ErrorHandler
    Dim bf As BudgetFolder
    Dim p_InFile As String
    Set bf = New BudgetFolder
    p_InFile = "C:\Users\teppler\OneDrive - Environmental Protection Agency (EPA)\EPPLER_one_drive\CBOR"
    bf.InFile = p_InFile
    Dim p_Message As String
    p_Message = "The File Extension is: " & bf.Name
    DoCmd.OpenForm FormName:="MessageDialog", OpenArgs:=p_Message
ErrorHandler:
    ProcessError Name:="Main", _
        Member:="TestButton_Click()"
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




