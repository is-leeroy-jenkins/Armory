Option Compare Database
Option Explicit




Public Args As ExpenseArgs
Private m_StartDate As String
Private m_EndDate As String
Private m_RpioName As String
Private m_FundName As String
Private pAnd As String
Private m_Error As String






'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Load
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    Set Args = New PayrollArgs
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="Form_Open"
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
    If Args Is Nothing Then
        Set Args = New PayrollArgs
    End If
    ClearComboBoxValues
    SetComboBoxColors
    pAnd = " AND "
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT Obligations.RpioName" _
        & " FROM Obligations;"
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT Obligations.FundName" _
        & " FROM Obligations;"
    Me.StartDateTextBox.Value = #10/1/2021#
    Me.EndDateTextBox.Value = Date
    Args.StartDate = m_StartDate
    Args.EndDate = m_EndDate
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="Form_Load()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        RpioNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub RpioNameComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New PayrollArgs
    End If
    m_RpioName = vbNullString
    Args.RpioName = Me.RpioNameComboBox.Value
    Args.RcCode = DLookup("RcCode", "Obligations", _
        "Obligations.RpioName = '" & Me.RpioNameComboBox.Value & "'")
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT Obligations.FundName" _
        & " FROM Obligations WHERE" _
        & " Obligations.RpioName = '" & Me.RpioNameComboBox.Value & "'"
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="RpioNameComboBox_Change()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ProgramProjectNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FundNameComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New PayrollArgs
    End If
    m_FundName = vbNullString
    m_FundName = Me.FundNameComboBox.Value
    Args.FundName = m_FundName
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="FundNameComboBox_Change()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        FiscalYearOptionGroup_AfterUpdate
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub StartDateTextBox_AfterUpdate()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New PayrollArgs
    End If
    m_StartDate = vbNullString
    m_StartDate = Me.StartDateTextBox.text
    Args.StartDate = m_StartDate
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="StartDateTextBox_AfterUpdate()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        FiscalYearOptionGroup_AfterUpdate
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub EndDateTextBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New PayrollArgs
    End If
    m_EndDate = vbNullString
    m_EndDate = Me.EndDateTextBox.text
    Args.EndDate = m_EndDate
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="EndDateTextBox_Change()"
    Exit Sub
End Sub



'---------------------------------------------------------------------------------
'   Type:           Event Sub-Procedure
'   Name:           AcceptButton_Click()
'   Parameters:     Void
'   Retval:         Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub AcceptButton_Click()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New PayrollArgs
    End If
    If Not Me.RpioNameComboBox.Value & "" = "" Then
        Args.RpioName = Me.RpioNameComboBox.Value
    End If
    If Not Me.FundNameComboBox.Value & "" = "" Then
        Args.FundName = Me.FundNameComboBox.Value
    End If
    If Not m_StartDate & "" = "" Then
        Args.StartDate = m_StartDate
    Else
        Args.StartDate = #10/1/2021#
    End If
    If Not m_EndDate & "" = "" Then
        Args.EndDate = m_EndDate
    Else
        Args.EndDate = Date
    End If
    Me.Visible = Not Me.Visible
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="AcceptButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        RefreshButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub RefreshButton_Click()
    On Error GoTo ErrorHandler:
    ClearComboBoxValues
    ClearFilterValues
    ClearTextBoxValues
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="RefreshButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SetComboBoxColors
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetComboBoxColors()
    On Error GoTo ErrorHandler:
    Me!RpioNameComboBox.ForeColor = RGB(255, 255, 255)
    Me!RpioNameComboBox.BackColor = RGB(33, 33, 33)
    Me!RpioNameComboBox.BorderColor = RGB(68, 114, 196)
    Me!FundNameComboBox.ForeColor = RGB(255, 255, 255)
    Me!FundNameComboBox.BackColor = RGB(33, 33, 33)
    Me!FundNameComboBox.BorderColor = RGB(68, 114, 196)
    Me!StartDateTextBox.ForeColor = RGB(255, 255, 255)
    Me!StartDateTextBox.BackColor = RGB(33, 33, 33)
    Me!StartDateTextBox.BorderColor = RGB(68, 114, 196)
    Me!EndDateTextBox.ForeColor = RGB(255, 255, 255)
    Me!EndDateTextBox.BackColor = RGB(33, 33, 33)
    Me!EndDateTextBox.BorderColor = RGB(68, 114, 196)
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="SetComboBoxColors()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ClearComboBoxValues
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearComboBoxValues()
    On Error GoTo ErrorHandler:
    Me.RpioNameComboBox.Value = vbNullString
    Me.FundNameComboBox.Value = vbNullString
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="ClearComboBoxValues()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        RefreshButton_Click
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearTextBoxValues()
    On Error GoTo ErrorHandler:
    Me.StartDateTextBox.Value = #10/1/2021#
    Me.EndDateTextBox.Value = Date
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="ClearTextBoxValues()"
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
    m_EndDate = vbNullString
    m_StartDate = vbNullString
    m_RpioName = vbNullString
    m_FundName = vbNullString
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="ClearFilterValues()"
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
    If Not Args Is Nothing Then
        Set Args = Nothing
    End If
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name, Save:=acSaveNo
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="ExitButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExitButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub StartDateTextBox_Enter()
    On Error GoTo ErrorHandler:
    m_StartDate = vbNullString
    Dim calendar As New Form_BudgetCalendar
    DoCmd.OpenForm FormName:="BudgetCalendar", WindowMode:=acDialog, OpenArgs:=Me.StartDateTextBox
    Set calendar = Forms("BudgetCalendar")
    Me.StartDateTextBox.Value = calendar.txtCalendarDate
    m_StartDate = Me.StartDateTextBox.Value
    Args.StartDate = m_StartDate
    DoCmd.Close ObjectType:=acForm, ObjectName:="BudgetCalendar", Save:=acSaveNo
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="StartDateTextBox_Enter()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExitButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub EndDateTextBox_Enter()
    On Error GoTo ErrorHandler:
    Dim calendar As New Form_BudgetCalendar
    DoCmd.OpenForm FormName:="BudgetCalendar", WindowMode:=acDialog, OpenArgs:=Me.EndDateTextBox
    Set calendar = Forms("BudgetCalendar")
    Me.EndDateTextBox.Value = calendar.txtCalendarDate
    m_EndDate = Me.EndDateTextBox.Value
    Args.EndDate = m_EndDate
    DoCmd.Close ObjectType:=acForm, ObjectName:="BudgetCalendar", Save:=acSaveNo
ErrorHandler:
    ProcessError Name:="ObligationTimeSpanDialog", _
        Member:="EndDateTextBox_Enter()"
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






