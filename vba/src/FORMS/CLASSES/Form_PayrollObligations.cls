VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_PayrollObligations"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit


Public Args As PayrollArgs
Public m_Dialog As Form_PayrollTimeSpanDialog
Private FundNameFilter As String
Private PayPeriodFilter As String
Private WorkCodeFilter As String
Private RpioNameFilter As String
Private StartDateFilter As String
Private EndDateFilter As String
Public pAnd As String
Public calendar As Form_BudgetCalendar
Private m_Error As String
Private m_Notification As String




'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        Form_Open
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub Form_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New PayrollArgs
    End If
    pAnd = " AND "
    Set m_Dialog = New Form_PayrollTimeSpanDialog
    DoCmd.OpenForm FormName:="PayrollTimeSpanDialog", _
        WindowMode:=acDialog
    Set m_Dialog = Forms("PayrollTimeSpanDialog")
    Set Args = m_Dialog.Args
    If Not Args.RpioName & "" = "" And _
        Not Args.FundName & "" = "" And _
        Not StartDateFilter & "" = "" And _
        Not EndDateFilter & "" = "" Then
        FundNameFilter = "[FundName] = '" & Args.FundName & "'"
        RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
        StartDateFilter = "[StartDate] = '" & Args.StartDate & "'"
        EndDateFilter = "[EndDate] = '" & Args.EndDate & "'"
        Me.Filter = RpioNameFilter & pAnd & FundNameFilter & _
            pAnd & StartDateFilter & pAnd & EndDateFilter
    End If
    If Not Args.RpioName & "" = "" And _
        Args.FundName & "" = "" And _
        Not StartDateFilter & "" = "" And _
        Not EndDateFilter & "" = "" Then
        RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
        StartDateFilter = "[StartDate] = '" & Args.StartDate & "'"
        EndDateFilter = "[EndDate] = '" & Args.EndDate & "'"
        Me.Filter = RpioNameFilter & pAnd & _
            StartDateFilter & pAnd & EndDateFilter
    End If
    If Not Args.RpioName & "" = "" And _
        Args.FundName & "" = "" And _
        StartDateFilter & "" = "" And _
        Not EndDateFilter & "" = "" Then
        RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
        EndDateFilter = "[EndDate] = '" & Args.EndDate & "'"
        Me.Filter = RpioNameFilter & pAnd & FundNameFilter & _
            pAnd & StartDateFilter & pAnd & EndDateFilter
    End If
    If Not Args.RpioName & "" = "" And _
        Args.FundName & "" = "" And _
        StartDateFilter & "" = "" And _
        EndDateFilter & "" = "" Then
        RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
        Me.Filter = RpioNameFilter
    End If
    If Not Args.RpioName & "" = "" And _
        Not Args.FundName & "" = "" And _
        StartDateFilter & "" = "" And _
        EndDateFilter & "" = "" Then
        FundNameFilter = "[FundName] = '" & Args.FundName & "'"
        RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
        Me.Filter = RpioNameFilter & pAnd & FundNameFilter
    End If
    DoCmd.Close ObjectType:=acForm, ObjectName:=m_Dialog.Name, Save:=acSaveNo
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT PayrollActivity.FundName" _
        & " FROM PayrollActivity;"
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT PayrollActivity.RpioName" _
        & " FROM PayrollActivity;"
    Me.PayPeriodComboBox.RowSource = "SELECT DISTINCT PayrollActivity.PayPeriod" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.WorkCodeComboBox.RowSource = "SELECT DISTINCT PayrollActivity.WorkCode" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.RecordSource = "SELECT * FROM PayrollActivity" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="Form_Open"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
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
    Me.SECTION(acHeader).AutoHeight = False
    Me.SECTION(acHeader).Height = 2
    Me.SECTION(acDetail).AutoHeight = False
    Me.SECTION(acDetail).Height = 4
    Me.SECTION(acFooter).AutoHeight = False
    Me.SECTION(acFooter).Height = 0.5
    InitButtonVisibility
    pAnd = " AND "
    SetComboBoxColors
    ClearComboBoxValues
    ClearFilterValues
    If Not Args.RpioName & "" = "" Then
        Me.Caption = Args.RpioName
        RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
        SetRpioIcon (Args.RpioCode)
    End If
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="Form_Load()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        FundNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FundNameComboBox_Change()
    On Error GoTo ErrorHandler:
    Me.Filter = vbNullString
    FundNameFilter = vbNullString
    FundNameFilter = "[FundName] = '" & Me.FundNameComboBox.Value & "'"
    Me.Filter = GetFundNameFilter
    Me.Caption = Args.RpioName
    Me.RecordSource = "SELECT * FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.Requery
    Me.WorkCodeComboBox.RowSource = "SELECT DISTINCT PayrollActivity.WorkCode" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT PayrollActivity.RpioName" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.PayPeriodComboBox.RowSource = "SELECT DISTINCT PayrollActivity.PayPeriod" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="FundNameComboBox_Change()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetRpioNameFilter
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetRpioNameFilter() As String
    On Error GoTo ErrorHandler:
    If Not RpioNameFilter & "" = "" And _
        PayPeriodFilter & "" = "" And _
        WorkCodeFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" And _
        WorkCodeFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetRpioNameFilter = PayPeriodFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" And _
        Not WorkCodeFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetRpioNameFilter = PayPeriodFilter _
                & pAnd & WorkCodeFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" And _
        Not WorkCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetRpioNameFilter = PayPeriodFilter _
                & pAnd & WorkCodeFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        PayPeriodFilter & "" = "" And _
        Not WorkCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetRpioNameFilter = WorkCodeFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        PayPeriodFilter & "" = "" And _
        WorkCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            Me.Filter = RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        PayPeriodFilter & "" = "" And _
        Not WorkCodeFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetRpioNameFilter = WorkCodeFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" And _
        WorkCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetRpioNameFilter = PayPeriodFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="GetRpioNameFilter()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        PayrollQueryButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub PayrollQueryButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.OpenForm "PayrollAccrualQuery"
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="PayrollQueryButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        RpioNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub RpioNameComboBox_Change()
    On Error GoTo ErrorHandler:
    RpioNameFilter = vbNullString
    Me.Filter = vbNullString
    RpioNameFilter = "[RpioName] = '" & Me.RpioNameComboBox.Value & "'"
    Me.Caption = Me.RpioNameComboBox.Value
    Me.Filter = GetRpioNameFilter
    Me.WorkCodeComboBox.RowSource = "SELECT DISTINCT PayrollActivity.WorkCode" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT PayrollActivity.FundName" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.RecordSource = "SELECT *" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="RpioNameComboBox_Change()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetFundNameFilter
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetFundNameFilter() As String
    On Error GoTo ErrorHandler:
    If Not RpioNameFilter & "" = "" And _
        PayPeriodFilter & "" = "" And _
        WorkCodeFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFundNameFilter = RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" And _
        WorkCodeFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFundNameFilter = PayPeriodFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" And _
        Not WorkCodeFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFundNameFilter = PayPeriodFilter _
                & pAnd & WorkCodeFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" And _
        Not WorkCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFundNameFilter = PayPeriodFilter _
                & pAnd & WorkCodeFilter _
                & pAnd & FundNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        PayPeriodFilter & "" = "" And _
        Not WorkCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFundNameFilter = WorkCodeFilter _
                & pAnd & FundNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        PayPeriodFilter & "" = "" And _
        WorkCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        PayPeriodFilter & "" = "" And _
        Not WorkCodeFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFundNameFilter = WorkCodeFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" And _
        WorkCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFundNameFilter = PayPeriodFilter _
                & pAnd & FundNameFilter _
                & pAnd & RpioNameFilter
    End If
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="GetFundNameFilter()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        PayPeriodComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub PayPeriodComboBox_Change()
    On Error GoTo ErrorHandler:
    PayPeriodFilter = vbNullString
    Me.Filter = vbNullString
    PayPeriodFilter = "[PayPeriod] = '" & Me.PayPeriodComboBox.Value & "'"
    Me.Filter = RpioNameFilter & pAnd & GetPayPeriodFilter
    Me.RecordSource = "SELECT * FROM PayrollActivity WHERE " & Me.Filter
    Me.Requery
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT PayrollActivity.FundName" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT PayrollActivity.RpioName" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.WorkCodeComboBox.RowSource = "SELECT DISTINCT PayrollActivity.WorkCode" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="PayPeriodComboBox_Change()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetFundNameFilter
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetPayPeriodFilter() As String
    On Error GoTo ErrorHandler:
    If Not PayPeriodFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        WorkCodeFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetPayPeriodFilter = PayPeriodFilter
    End If
    If Not PayPeriodFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        WorkCodeFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetPayPeriodFilter = PayPeriodFilter _
                & pAnd & RpioNameFilter
    End If
    If Not PayPeriodFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not WorkCodeFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetPayPeriodFilter = PayPeriodFilter _
                & pAnd & WorkCodeFilter _
                & pAnd & RpioNameFilter
    End If
    If Not PayPeriodFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not WorkCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetPayPeriodFilter = PayPeriodFilter _
                & pAnd & WorkCodeFilter _
                & pAnd & FundNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not PayPeriodFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not WorkCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetPayPeriodFilter = WorkCodeFilter _
                & pAnd & FundNameFilter _
                & pAnd & PayPeriodFilter
    End If
    If Not PayPeriodFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        WorkCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetPayPeriodFilter = FundNameFilter _
                & pAnd & PayPeriodFilter
    End If
    If Not PayPeriodFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not WorkCodeFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetPayPeriodFilter = WorkCodeFilter _
                & pAnd & PayPeriodFilter
    End If
    If Not PayPeriodFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        WorkCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetPayPeriodFilter = PayPeriodFilter _
                & pAnd & FundNameFilter _
                & pAnd & RpioNameFilter
    End If
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="GetPayPeriodFilter()"
    Exit Function
End Function


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        WorkCodeComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub WorkCodeComboBox_Change()
    On Error GoTo ErrorHandler:
    WorkCodeFilter = vbNullString
    Me.Filter = vbNullString
    WorkCodeFilter = "[WorkCode] = '" & Me.WorkCodeComboBox.Value & "'"
    Me.Filter = RpioNameFilter & pAnd & GetWorkCodeFilter
    Me.RecordSource = "SELECT * FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.Requery
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT PayrollActivity.FundName" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT PayrollActivity..RpioName" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.PayPeriodComboBox.RowSource = "SELECT DISTINCT PayrollActivity.PayPeriod" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="WorkCodeComboBox_Change()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetWorkCodeFilter
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetWorkCodeFilter() As String
    On Error GoTo ErrorHandler:
    If Not WorkCodeFilter & "" = "" And _
        PayPeriodFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetWorkCodeFilter = WorkCodeFilter
    End If
    If Not WorkCodeFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetWorkCodeFilter = PayPeriodFilter _
                & pAnd & WorkCodeFilter
    End If
    If Not WorkCodeFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetWorkCodeFilter = PayPeriodFilter _
                & pAnd & WorkCodeFilter _
                & pAnd & RpioNameFilter
    End If
    If Not WorkCodeFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetWorkCodeFilter = PayPeriodFilter _
                & pAnd & WorkCodeFilter _
                & pAnd & FundNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not WorkCodeFilter & "" = "" And _
        PayPeriodFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetWorkCodeFilter = WorkCodeFilter _
                & pAnd & FundNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not WorkCodeFilter & "" = "" And _
        PayPeriodFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetWorkCodeFilter = FundNameFilter _
                & pAnd & WorkCodeFilter
    End If
    If Not WorkCodeFilter & "" = "" And _
        PayPeriodFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetWorkCodeFilter = WorkCodeFilter _
                & pAnd & RpioNameFilter
    End If
    If Not WorkCodeFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetWorkCodeFilter = PayPeriodFilter _
                & pAnd & FundNameFilter _
                & pAnd & WorkCodeFilter
    End If
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="GetWorkCodeFilter()"
    Exit Function
End Function


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        SetComboBoxColors
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetComboBoxColors()
    On Error GoTo ErrorHandler:
    Me.WorkCodeComboBox.ForeColor = RGB(255, 255, 255)
    Me.WorkCodeComboBox.BackColor = RGB(33, 33, 33)
    Me.WorkCodeComboBox.BorderColor = RGB(68, 114, 196)
    Me.RpioNameComboBox.ForeColor = RGB(255, 255, 255)
    Me.RpioNameComboBox.BackColor = RGB(33, 33, 33)
    Me.RpioNameComboBox.BorderColor = RGB(68, 114, 196)
    Me.FundNameComboBox.ForeColor = RGB(255, 255, 255)
    Me.FundNameComboBox.BackColor = RGB(33, 33, 33)
    Me.FundNameComboBox.BorderColor = RGB(68, 114, 196)
    Me.PayPeriodComboBox.ForeColor = RGB(255, 255, 255)
    Me.PayPeriodComboBox.BackColor = RGB(33, 33, 33)
    Me.PayPeriodComboBox.BorderColor = RGB(68, 114, 196)
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
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
    Me.FundNameComboBox.Value = vbNullString
    Me.WorkCodeComboBox.Value = vbNullString
    Me.RpioNameComboBox.Value = vbNullString
    Me.PayPeriodComboBox.Value = vbNullString
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="ClearComboBoxValues()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        SetButtonVisibility
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetButtonVisibility()
    On Error GoTo ErrorHandler:
    Me.AddButton.Visible = Not Me.AddButton.Visible
    Me.FirstButton.Visible = Not Me.FirstButton.Visible
    Me.PreviousButton.Visible = Not Me.PreviousButton.Visible
    Me.NextButton.Visible = Not Me.NextButton.Visible
    Me.LastButton.Visible = Not Me.LastButton.Visible
    Me.EditButton.Visible = Not Me.EditButton.Visible
    Me.RefreshButton.Visible = Not Me.RefreshButton.Visible
    Me.DeleteButton.Visible = Not Me.DeleteButton.Visible
    Me.CalculatorButton.Visible = Not Me.CalculatorButton.Visible
    Me.ExcelButton.Visible = Not Me.ExcelButton.Visible
    Me.UndoButton.Visible = Not Me.UndoButton.Visible
    Me.SaveButton.Visible = Not Me.SaveButton.Visible
    Me.DataButton.Visible = Not Me.DataButton.Visible
    Me.PayrollQueryButton.Visible = Not Me.PayrollQueryButton.Visible
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="SetButtonVisibility()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        Form_Timer()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Timer()
    On Error GoTo ErrorHandler:
    HideButtons
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="Form_Timer()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        Hides buttons
'   Parameters:  Void
'   Purpose:     Toggles the toolbar button on/off
'---------------------------------------------------------------------------------
Private Sub HideButtons()
    On Error GoTo ErrorHandler:
    Me.AddButton.Visible = False
    Me.DataButton.Visible = False
    Me.FirstButton.Visible = False
    Me.PreviousButton.Visible = False
    Me.NextButton.Visible = False
    Me.LastButton.Visible = False
    Me.EditButton.Visible = False
    Me.RefreshButton.Visible = False
    Me.DeleteButton.Visible = False
    Me.CalculatorButton.Visible = False
    Me.ExcelButton.Visible = False
    Me.UndoButton.Visible = False
    Me.SaveButton.Visible = False
    Me.PayrollQueryButton.Visible = False
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="HideButtons()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        InitButtonVisibility
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub InitButtonVisibility()
    On Error GoTo ErrorHandler:
    Me.AddButton.Visible = False
    Me.FirstButton.Visible = False
    Me.PreviousButton.Visible = False
    Me.NextButton.Visible = False
    Me.LastButton.Visible = False
    Me.EditButton.Visible = False
    Me.RefreshButton.Visible = False
    Me.DeleteButton.Visible = False
    Me.CalculatorButton.Visible = False
    Me.ExcelButton.Visible = False
    Me.UndoButton.Visible = False
    Me.SaveButton.Visible = False
    Me.DataButton.Visible = False
    Me.PayrollQueryButton.Visible = False
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="InitButtonVisibility()"
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
    WorkCodeFilter = vbNullString
    FundNameFilter = vbNullString
    PayPeriodFilter = vbNullString
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="ClearFilterValues()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        RefreshButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub RefreshButton_Click()
    On Error GoTo ErrorHandler:
    ClearFilterValues
    ClearComboBoxValues
    Me.Filter = RpioNameFilter
    Me.WorkCodeComboBox.RowSource = "SELECT DISTINCT PayrollActivity.WorkCode" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT PayrollActivity.RpioName" _
        & " FROM PayrollActivity;"
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT PayrollActivity.FundName" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.PayPeriodComboBox.RowSource = "SELECT DISTINCT PayrollActivity.PayPeriod" _
        & " FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.RecordSource = "SELECT * FROM PayrollActivity" _
        & " WHERE " & Me.Filter
    Me.Requery
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="RefreshButton_Click()"
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
    ProcessError Name:="PayrollObligationsForm", _
        Member:="CalculatorButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        MenuButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub MenuButton_Click()
    On Error GoTo ErrorHandler:
    SetButtonVisibility
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="MenuButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SetRpioIcon
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetRpioIcon(pRpioCode As String)
    On Error GoTo ErrorHandler:
    Dim p_RpioCode As String
    If Not pRpioCode & "" = "" Then
        p_RpioCode = DLookup("RpioCode", "StatusOfFunds", _
            "[RpioName] = '" & pRpioCode & "'")
        Me.Caption = pRpioCode
        Select Case CStr(p_RpioCode)
            Case "01"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R1.png"
            Case "02"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R2.png"
            Case "03"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R3.png"
            Case "04"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R4.png"
            Case "05"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R5.png"
            Case "06"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R6.png"
            Case "07"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R7.png"
            Case "08"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R8.png"
            Case "09"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R9.png"
            Case "10"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R10.png"
            Case "11"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OA.png"
            Case "13"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OITA.png"
            Case "16"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OMS.png"
            Case "17"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OCFO.png"
            Case "20"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OCSPP.png"
            Case "26"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\ORD.png"
            Case "27"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OAR.png"
            Case "30"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OW.png"
            Case "35"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OIG.png"
            Case "39"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OGC.png"
            Case "75"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OLEM.png"
            Case "77"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OECA.png"
            Case Else
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\ui\capital.png"
        End Select
    End If
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="SetRpioIcon()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetColumnNames
'   Parameters:  Void
'   Retval:      Collection
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetColumnNames() As String()
    On Error GoTo ErrorHandler:
    Dim m_Fields As Collection
    Dim field As DAO.field
    Dim m_Data As DAO.Recordset
    Set m_Data = Me.Recordset
    Dim i As Integer
    Dim j As Integer
    Dim m_Array() As String
    j = m_Data.Fields.Count - 1
    ReDim m_Array(j)
    For i = LBound(m_Array()) To UBound(m_Array())
        If Not m_Data.Fields(i).Name & "" = "" Then
            m_Array(i) = m_Data.Fields(i).Name
        End If
    Next i
    GetColumnNames = m_Array()
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="GetColumnNames()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetReportData
'   Parameters:  Void
'   Retval:      DAO Recordset
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetReportData() As DAO.Recordset
    On Error GoTo ErrorHandler:
    Dim m_Data As DAO.Recordset
    Set m_Data = Me.Recordset
    m_Data.Filter = Me.Filter
    Set GetReportData = m_Data
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="GetReportData()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExcelButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ExcelButton_Click()
    On Error GoTo ErrorHandler:
    Dim p_Fields() As String
    p_Fields() = GetColumnNames
    Dim p_BudgetPath As BudgetPath
    Dim p_Excel As Excel.Application
    Dim p_Allocations As Excel.Workbook
    Dim p_Worksheet As Excel.Worksheet
    Dim p_List As Excel.ListObject
    Dim p_Range As Excel.Range
    Dim p_Cell As Object
    Dim p_Header As Excel.Range
    Dim p_Start As Excel.Range
    Dim p_End As Excel.Range
    Dim field As DAO.field
    Dim p_Data As DAO.Recordset
    Dim i As Integer
    Dim j As Integer
    Set p_BudgetPath = New BudgetPath
    Set p_Excel = CreateObject("Excel.Application")
    Set p_Allocations = p_Excel.Workbooks.Open(p_BudgetPath.ReportTemplate)
    p_Allocations.Worksheets(2).Visible = False
    Set p_Worksheet = p_Allocations.Worksheets(1)
    p_Worksheet.Name = "Payroll Obligations"
    p_Worksheet.Cells.HorizontalAlignment = xlHAlignLeft
    p_Worksheet.Cells.Font.Name = "Source Code Pro"
    p_Worksheet.Cells.Font.Size = 8
    Set p_Start = p_Worksheet.Cells(1, 1)
    Set p_End = p_Worksheet.Cells(1, UBound(p_Fields) - 1)
    Set p_Header = p_Worksheet.Range(p_Start, p_End)
    p_Header.HorizontalAlignment = xlHAlignLeft
    p_Header.Borders(xlEdgeBottom).Color = RGB(0, 0, 0)
    p_Header.Font.Name = "Source Code Pro"
    p_Header.Font.Color = vbBlack
    p_Header.Font.Bold = True
    p_Header.Font.Size = 8
    For i = LBound(p_Fields) To UBound(p_Fields)
        p_Header.Cells(i + 1).Value = p_Fields(i)
    Next i
    Set p_Data = Me.Recordset
    p_Data.Filter = Me.Filter
    p_Worksheet.Cells(2, 1).CopyFromRecordset p_Data
    p_Header.Font.Color = vbBlack
    p_Excel.WindowState = xlMaximized
    p_Excel.Visible = True
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="ExcelButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SaveButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub UndoButton_Click()
    On Error GoTo ErrorHandler:
    If Me.Dirty Then
        DoCmd.RunCommand acCmdUndo
    End If
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="UndoButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SaveButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SaveButton_Click()
    On Error GoTo ErrorHandler:
    If Me.Dirty Then
        DoCmd.RunCommand acCmdSave
    End If
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="SaveButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        DeleteButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub DeleteButton_Click()
    On Error GoTo ErrorHandler:
    If Me.Dirty Then
        DoCmd.RunCommand acCmdDelete
    End If
ErrorHandler:
    ProcessError Name:="PayrollObligationsForm", _
        Member:="DeleteButton_Click()"
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




