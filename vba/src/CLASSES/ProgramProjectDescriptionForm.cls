VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_ProgramProjectDescription"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit



Public Args As AccountArgs
Public DataModelFilter As String
Private m_BFY As String
Private m_ProgramProjectName As String
Private m_ProgramProjectCode As String
Private pAnd As String
Private m_Error As String








'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Open
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    Set Args = New AccountArgs
    If IsNull(Me.OpenArgs) Then
        Me.RecordSource = "SELECT * FROM ProgramDescriptions;"
    End If
    Me.ProgramProjectCodeComboBox.RowSource = "SELECT DISTINCT ProgramProjectCode" _
        & " FROM ProgramDescriptions;"
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Load
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler:
    Me.Caption = "Program Project Description"
    SetButtonVisibility
    Me.MenuButton.SetFocus
    pAnd = " AND "
    DataModelFilter = "[ProgramProjectCode] = '" & m_ProgramProjectCode & "'"
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        TableNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub TableNameComboBox_Change()
    On Error GoTo ErrorHandler:
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ClearFilterValues
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearFilterValues()
    On Error GoTo ErrorHandler:
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub






'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ClearFilterValues
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ProgramProjectCodeComboBox_Change()
    On Error GoTo ErrorHandler:
    m_ProgramProjectCode = Me.ProgramProjectCodeComboBox.Value
    Me.RecordSource = "SELECT * FROM ProgramDescriptions" _
        & " WHERE ProgramDescriptions.ProgramProjectCode = '" & m_ProgramProjectCode & "';"
    Me.Requery
    Me.ProgramProjectCodeComboBox.SetFocus
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        RefreshButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub RefreshButton_Click()
    On Error GoTo ErrorHandler:
    Me.RecordSource = "SELECT * FROM ProgramDescriptions;"
    Me.ProgramProjectCodeComboBox.RowSource = "SELECT DISTINCT ProgramProjectCode FROM ProgramDescriptions;"
    Me.ProgramProjectCodeComboBox.Value = vbNullString
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExitButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ExitButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close acForm, Me.Name
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub NextButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.RunCommand acCmdRecordsGoToNext
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub PreviousButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.RunCommand acCmdRecordsGoToPrevious
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FirstButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.RunCommand acCmdRecordsGoToFirst
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub LastButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.RunCommand acCmdRecordsGoToLast
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub MenuButton_Click()
    On Error GoTo ErrorHandler:
    SetButtonVisibility
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        SetButtonVisibility
'   Retval:      Void
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetButtonVisibility()
    On Error GoTo ErrorHandler:
    Me.FirstButton.Visible = Not Me.FirstButton.Visible
    Me.PreviousButton.Visible = Not Me.PreviousButton.Visible
    Me.NextButton.Visible = Not Me.NextButton.Visible
    Me.LastButton.Visible = Not Me.LastButton.Visible
    Me.CalculatorButton.Visible = Not Me.CalculatorButton.Visible
    Me.GoogleSearchButton.Visible = Not Me.GoogleSearchButton.Visible
    Me.CdwQueryButton.Visible = Not Me.CdwQueryButton.Visible
    Me.ProgramProjectCodeComboBox.Visible = Not Me.ProgramProjectCodeComboBox.Visible
    Me.RefreshButton.Visible = Not Me.RefreshButton.Visible
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub CdwQueryButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name, Save:=acSaveNo
    DoCmd.OpenForm FormName:="CompassBudgetStatusQuery", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub GoogleSearchButton_Click()
    On Error GoTo ErrorHandler:
    Dim p_Law As String
    Dim p_Search As Object
    p_Law = Me.StatuteTextBox.Value
    Set p_Search = CreateObject("Shell.Application")
    p_Search.ShellExecute "microsoft-edge:https://www.Google.com/search?q=" & p_Law
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name, Save:=acSaveNo
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        CalculatorButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub CalculatorButton_Click()
    On Error GoTo ErrorHandler:
    Calculator.Calculate
ErrorHandler:
    ProcessError Name:="ProgramProjectDescriptionForm", _ 
        Member:=""
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