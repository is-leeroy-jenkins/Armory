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
    Me.Caption = "Analytics Menu"
ErrorHandler:
    ProcessError Name:="DataAnalysisForm", _
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
Private Sub CloseButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close acForm, "DataAnalysis", acSaveNo
    DoCmd.OpenForm FormName:="Main", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="DataAnalysisForm", _
        Member:="CloseButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Load()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub AuthorityAnalysisButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close acForm, "DataAnalysis", acSaveNo
    DoCmd.OpenForm FormName:="Budget", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="DataAnalysisForm", _
        Member:="AuthorityAnalysisButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Load()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub DivisionButton__AuthorityReportButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close acForm, "DataAnalysis", acSaveNo
    DoCmd.OpenForm FormName:="RpioUtilization", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="DataAnalysisForm", _
        Member:="DivisionButton__AuthorityReportButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Load()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub TravelButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close acForm, "DataAnalysis", acSaveNo
    DoCmd.OpenForm FormName:="Travel", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="DataAnalysisForm", _
        Member:="TravelButton_Click()"
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







