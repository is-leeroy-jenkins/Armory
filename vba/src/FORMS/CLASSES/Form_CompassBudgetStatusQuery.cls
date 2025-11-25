Option Compare Database
Option Explicit


Private m_Error As String
Private m_Caller As String



'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            Form_Open()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    If Not IsNull(Me.OpenArgs) Then
        m_Caller = CStr(Me.OpenArgs)
    End If
ErrorHandler:
    ProcessError Name:="CompassBudgetStatusQueryForm", _
        Member:="Form_Open"
    Exit Sub
End Sub




'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            ExitButton_Click()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler:
    SetButtonVisibility
    Me.Caption = "CDW Compass Budget Status Query"
ErrorHandler:
    ProcessError Name:="CompassBudgetStatusQueryForm", _
        Member:="Form_Load()"
    Exit Sub
End Sub




'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            ExitButton_Click()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetButtonVisibility()
    On Error GoTo ErrorHandler:
    Me.BudgetDetailedSpendingButton.Visible = Not Me.BudgetDetailedSpendingButton.Visible
    Me.CompassAdvancedQueryButton.Visible = Not Me.CompassAdvancedQueryButton.Visible
    Me.CompassReprogrammingQueryButton.Visible = Not Me.CompassReprogrammingQueryButton.Visible
    Me.CompassTravelQueryButton.Visible = Not Me.CompassTravelQueryButton.Visible
    Me.PayrollAccrualsButton.Visible = Not Me.PayrollAccrualsButton.Visible
    Me.BudgetStatusQueryButton.Visible = Not Me.BudgetStatusQueryButton.Visible
ErrorHandler:
    ProcessError Name:="CompassBudgetStatusQueryForm", _
        Member:="SetButtonVisibility()"
    Exit Sub
End Sub



'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            ExitButton_Click()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ExitButton_Click()
    On Error GoTo ErrorHandler:
    Me.Visible = False
    If Not m_Caller & "" = "" Then
        DoCmd.OpenForm FormName:=m_Caller, WindowMode:=acDialog
    Else
        DoCmd.OpenForm FormName:="Main", WindowMode:=acDialog
    End If
    DoCmd.Close acForm, Me.Name, acSaveNo
ErrorHandler:
    ProcessError Name:="CompassBudgetStatusQueryForm", _
        Member:="ExitButton_Click()"
    Exit Sub
End Sub




'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            ExitButton_Click()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub MenuButton_Click()
    On Error GoTo ErrorHandler:
    SetButtonVisibility
ErrorHandler:
    ProcessError Name:="CompassBudgetStatusQueryForm", _
        Member:="MenuButton_Click()"
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






