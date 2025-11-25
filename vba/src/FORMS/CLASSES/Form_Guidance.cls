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
    Me.Caption = "Guidance Menu"
ErrorHandler:
    ProcessError Name:="GuidanceMenu", _ 
        Member:="Form_Load()"
    Exit Sub
End Sub





'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            AdviceOfAllowanceButton_Click()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub AdviceOfAllowanceButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close acForm, Me.Name
    Application.FollowHyperlink CurrentProject.Path & "\etc\docs\rmds\AdviceOfAllowance21.pdf"
    DoCmd.OpenForm FormName:="Main", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="GuidanceMenu", _ 
        Member:="AdviceOfAllowanceButton_Click()"
    Exit Sub
End Sub




'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            FundsControlManualButton_Click()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FundsControlManualButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close acForm, Me.Name
    Application.FollowHyperlink CurrentProject.Path & "\etc\docs\rmds\FundsControlManual.pdf"
    DoCmd.OpenForm FormName:="Main", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="GuidanceMenu", _ 
        Member:="FundsControlManualButton_Click()"
    Exit Sub
End Sub




'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            MoneyAndFinanceButton_Click()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub MoneyAndFinanceButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close acForm, Me.Name
    Application.FollowHyperlink CurrentProject.Path & "\etc\docs\rmds\CFR31.pdf"
    DoCmd.OpenForm FormName:="Main", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="GuidanceMenu", _ 
        Member:="MoneyAndFinanceButton_Click()"
    Exit Sub
End Sub



'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            ObjectClassManualButton_Click()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ObjectClassManualButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close acForm, Me.Name
    Application.FollowHyperlink CurrentProject.Path & "\etc\docs\rmds\ObjectClassManual.pdf"
    DoCmd.OpenForm FormName:="Main", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="GuidanceMenu", _ 
        Member:="ObjectClassManualButton_Click()"
    Exit Sub
End Sub







'---------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ExitButtonClick
'   Parameters:  Void
'   RetVal:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ExitButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close acForm, Me.Name
    DoCmd.OpenForm FormName:="Main", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="GuidanceMenu", _ 
        Member:="ExitButton_Click()"
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







