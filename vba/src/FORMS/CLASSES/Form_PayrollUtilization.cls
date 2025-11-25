Option Compare Database
Option Explicit



Public m_Dialog As Form_StatusOfFundsDialog
Public Args As AccountArgs
Private BaseFilter As String
Private RpioNameFilter As String
Private FundNameFilter As String
Private ProgramAreaNameFilter As String
Private ProgramProjectNameFilter As String
Private FiscalYearFilter As String
Private pAnd As String
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
        Set Args = New AccountArgs
    End If
    Set m_Dialog = New Form_StatusOfFundsDialog
    DoCmd.OpenForm FormName:="StatusOfFundsDialog", _
        WindowMode:=acDialog
    Set m_Dialog = Forms("StatusOfFundsDialog")
    pAnd = " AND "
    Set Args = m_Dialog.Args
    BaseFilter = "[BocCode] = '10' AND [BudgetLevel] = '7'"
    If Not Args.RpioName & "" = "" Then
        RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
    End If
    If Not Args Is Nothing Then
        FundNameFilter = "[FundName] = '" & Args.FundName & "'"
        Me.FiscalYearOptionGroup.Value = 2
        FiscalYearFilter = "[BFY] = '" & Args.BFY & "'"
        Me.Filter = BaseFilter _
            & pAnd & RpioNameFilter _
            & pAnd & FiscalYearFilter _
            & pAnd & FundNameFilter
    Else
        Me.FiscalYearOptionGroup.Value = 2
        FiscalYearFilter = "[BFY] = '" & Args.BFY & "'"
        Me.Filter = BaseFilter _
            & pAnd & RpioNameFilter _
            & pAnd & FiscalYearFilter
    End If
    Me.ProgramProjectNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.ProgramProjectName" _
        & " FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    Me.ProgramAreaNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.ProgramAreaName" _
        & " FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.FundName" _
        & " FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    Me.RecordSource = "SELECT * FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    DoCmd.Close ObjectType:=acForm, ObjectName:="StatusOfFundsDialog", Save:=acSaveNo
    Me.ExecutionChart.RowSource = Me.RecordSource
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="Form_Open"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        Form_Close
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub Form_Close()
    On Error GoTo ErrorHandler:
    Me.Filter = vbNullString
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="Form_Close()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        ClearFilterValues
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub Form_Unload(Cancel As Integer)
    On Error GoTo ErrorHandler:
    ClearFilterValues
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="Form_Unload"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        Form_Load
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    ClearComboBoxValues
    SetComboBoxColors
    SetButtonVisibility
    SetHeaderCaption
    Me.Caption = Args.RpioName
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="Form_Load()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type        Sub-Procedure
'   Name        SetButtonVisibility
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub SetButtonVisibility()
    On Error GoTo ErrorHandler:
    Me.FirstButton.Visible = Not Me.FirstButton.Visible
    Me.PreviousButton.Visible = Not Me.PreviousButton.Visible
    Me.NextButton.Visible = Not Me.NextButton.Visible
    Me.LastButton.Visible = Not Me.LastButton.Visible
    Me.RefreshButton.Visible = Not Me.RefreshButton.Visible
    Me.CalculatorButton.Visible = Not Me.CalculatorButton.Visible
    Me.ExcelButton.Visible = Not Me.ExcelButton.Visible
    Me.DataButton.Visible = Not Me.DataButton.Visible
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="SetButtonVisibility()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        FiscalYearOptionGroup_AfterUpdate
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FiscalYearOptionGroup_AfterUpdate()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    FiscalYearFilter = vbNullString
    Me.Filter = vbNullString
    Select Case Me.FiscalYearOptionGroup.Value
        Case 1
            Args.BFY = "2021"
            FiscalYearFilter = "[BFY] = '2021'"
            Me.Filter = GetFiscalYearFilter
            Me.RecordSource = "SELECT * FROM StatusOfFunds WHERE " & Me.Filter
            Me.Requery
        Case 2
            Args.BFY = "2022"
            FiscalYearFilter = "[BFY] = '2022'"
            Me.Filter = GetFiscalYearFilter
            Me.RecordSource = "SELECT * FROM StatusOfFunds WHERE " & Me.Filter
            Me.Requery
    End Select
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="FiscalYearOptionGroup_AfterUpdate()"
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
    ProcessError Name:="PayrollUtilizationForm", _
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
    Me.DataButton.Visible = False
    Me.FirstButton.Visible = False
    Me.PreviousButton.Visible = False
    Me.NextButton.Visible = False
    Me.LastButton.Visible = False
    Me.RefreshButton.Visible = False
    Me.CalculatorButton.Visible = False
    Me.ExcelButton.Visible = False
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="HideButtons()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        SetComboBoxColors
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub SetComboBoxColors()
    On Error GoTo ErrorHandler:
    Me.FundNameComboBox.ForeColor = RGB(255, 255, 255)
    Me.FundNameComboBox.BackColor = RGB(33, 33, 33)
    Me.FundNameComboBox.BorderColor = RGB(68, 114, 196)
    Me.ProgramAreaNameComboBox.ForeColor = RGB(255, 255, 255)
    Me.ProgramAreaNameComboBox.BackColor = RGB(33, 33, 33)
    Me.ProgramAreaNameComboBox.BorderColor = RGB(68, 114, 196)
    Me.ProgramProjectNameComboBox.ForeColor = RGB(255, 255, 255)
    Me.ProgramProjectNameComboBox.BackColor = RGB(33, 33, 33)
    Me.ProgramProjectNameComboBox.BorderColor = RGB(68, 114, 196)
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="SetComboBoxColors()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        ClearComboBoxValues
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub ClearComboBoxValues()
    On Error GoTo ErrorHandler:
    Me.FundNameComboBox.Value = vbNullString
    Me.ProgramAreaNameComboBox.Value = vbNullString
    Me.ProgramProjectNameComboBox.Value = vbNullString
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="ClearComboBoxValues()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        ClearFilterValues
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub ClearFilterValues()
    On Error GoTo ErrorHandler:
    FundNameFilter = vbNullString
    ProgramAreaNameFilter = vbNullString
    FiscalYearFilter = vbNullString
    ProgramProjectNameFilter = vbNullString
    Me.Filter = vbNullString
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="ClearFilterValues()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        ProgramAreaNameComboBox_Change
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub ProgramAreaNameComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    ProgramAreaNameFilter = vbNullString
    Me.Filter = vbNullString
    ProgramAreaNameFilter = "[ProgramAreaName] = '" & Me.ProgramAreaNameComboBox.Value & "'"
    Me.Filter = GetProgramAreaNameFilter
    Me.RecordSource = "SELECT * FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode = '10'" _
        & " AND StatusOfFunds.BudgetLevel = '7'" _
        & pAnd & Me.Filter
    Me.Requery
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="ProgramAreaNameComboBox_Change()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetProgramAreaNameFilter
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Private Function GetProgramAreaNameFilter() As String
    On Error GoTo ErrorHandler:
    If Not RpioNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetProgramAreaNameFilter = RpioNameFilter _
                & pAnd & ProgramAreaNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetProgramAreaNameFilter = RpioNameFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetProgramAreaNameFilter = RpioNameFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & ProgramProjectNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetProgramAreaNameFilter = RpioNameFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetProgramAreaNameFilter = RpioNameFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetProgramAreaNameFilter = RpioNameFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetProgramAreaNameFilter = RpioNameFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & ProgramProjectNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetProgramAreaNameFilter = RpioNameFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="GetProgramAreaNameFilter()"
    Exit Function
End Function




'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        ProgramProjectNameComboBox_Change
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub ProgramProjectNameComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.Filter = vbNullString
    ProgramProjectNameFilter = vbNullString
    ProgramProjectNameFilter = "[ProgramProjectName] = '" & Me.ProgramProjectNameComboBox.Value & "'"
    If Not IsNull(Me.OpenArgs) Then
        Me.Filter = Me.OpenArgs & pAnd & GetProgramProjectNameFilter
    Else
        Me.Filter = BaseFilter & pAnd & GetProgramProjectNameFilter
    End If
    Me.RecordSource = "SELECT * FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    Me.Requery
    SetHeaderCaption
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="ProgramProjectNameComboBox_Change()"
    Exit Sub
End Sub




'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetProgramProjectNameFilter
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetProgramProjectNameFilter() As String
    On Error GoTo ErrorHandler:
    If Not RpioNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetProgramProjectNameFilter = RpioNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        ProgramAreaNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" Then
            GetProgramProjectNameFilter = RpioNameFilter _
                & pAnd & ProgramProjectNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        ProgramAreaNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" Then
            GetProgramProjectNameFilter = RpioNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" Then
            GetProgramProjectNameFilter = RpioNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & ProgramAreaNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        ProgramAreaNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetProgramProjectNameFilter = RpioNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetProgramProjectNameFilter = RpioNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" Then
            GetProgramProjectNameFilter = RpioNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & ProgramAreaNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        Not FundNameFilter = "" And _
        ProgramAreaNameFilter = "" And _
        Not FiscalYearFilter = "" Then
            GetProgramProjectNameFilter = RpioNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & FiscalYearFilter
    End If
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="GetProgramProjectNameFilter()"
    Exit Function
End Function


'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetFiscalYearFilter
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Private Function GetFiscalYearFilter() As String
    On Error GoTo ErrorHandler:
    If Not FiscalYearFilter & "" = "" And _
        ProgramAreaNameFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFiscalYearFilter = RpioNameFilter _
            & pAnd & FiscalYearFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFiscalYearFilter = RpioNameFilter _
            & pAnd & FiscalYearFilter _
            & pAnd & ProgramAreaNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFiscalYearFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & ProgramProjectNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFiscalYearFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        ProgramAreaNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFiscalYearFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        ProgramAreaNameFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFiscalYearFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        ProgramAreaNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFiscalYearFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & ProgramProjectNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFiscalYearFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        ProgramAreaNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFiscalYearFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="GetFiscalYearFilter()"
    Exit Function
End Function




'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        FundNameComboBox_Change
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub FundNameComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.Filter = vbNullString
    FundNameFilter = vbNullString
    FundNameFilter = "[FundName] = '" & Me.FundNameComboBox.Value & "'"
    Me.Filter = GetFundNameFilter
    Me.RecordSource = "SELECT * FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode = '10'" _
        & " AND StatusOfFunds.BudgetLevel = '7'" _
        & pAnd & Me.Filter
    Me.Requery
    Me.ProgramProjectNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.ProgramProjectName" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode = '10'" _
        & " AND StatusOfFunds.BudgetLevel = '7'" _
        & pAnd & Me.Filter
    Me.ProgramAreaNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.ProgramAreaName" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode = '10'" _
        & " AND StatusOfFunds.BudgetLevel = '7'" _
        & pAnd & Me.Filter
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="FundNameComboBox_Change()"
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
    If Not FundNameFilter & "" = "" And _
        ProgramAreaNameFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" Then
            GetFundNameFilter = RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" Then
            GetFundNameFilter = RpioNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & ProgramAreaNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" Then
            GetFundNameFilter = RpioNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & ProgramProjectNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetFundNameFilter = RpioNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not FundNameFilter & "" = "" And _
        ProgramAreaNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetFundNameFilter = RpioNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not FundNameFilter & "" = "" And _
        ProgramAreaNameFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetFundNameFilter = RpioNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not FundNameFilter & "" = "" And _
        ProgramAreaNameFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" Then
            GetFundNameFilter = RpioNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & ProgramProjectNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not ProgramAreaNameFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetFundNameFilter = RpioNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & ProgramAreaNameFilter _
                & pAnd & FiscalYearFilter
    End If
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="GetFundNameFilter()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        CalculatorButton_Click
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub CalculatorButton_Click()
    On Error GoTo ErrorHandler:
    Calculator.Calculate
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="CalculatorButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub CompassSpendingQueryButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.OpenForm "BudgetDetailedSpendingQuery"
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="CompassSpendingQueryButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        MenuButton_Click
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub MenuButton_Click()
    On Error GoTo ErrorHandler:
    SetButtonVisibility
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="MenuButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        RefreshButton_Click
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub RefreshButton_Click()
    On Error GoTo ErrorHandler:
    ClearComboBoxValues
    ClearFilterValues
    Me.FiscalYearOptionGroup.Value = 2
    Me.ProgramProjectNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.ProgramProjectName" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode = '10'" _
        & " AND StatusOfFunds.BudgetLevel = '7';"
    Me.ProgramAreaNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.ProgramAreaName" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode = '10'" _
        & " AND StatusOfFunds.BudgetLevel = '7';"
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.FundName" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode = '10'" _
        & " AND StatusOfFunds.BudgetLevel = '7';"
    Me.RecordSource = "SELECT * FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode = '10'" _
        & " AND StatusOfFunds.BudgetLevel = '7';"
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="RefreshButton_Click()"
    Exit Sub
End Sub





Private Sub SetHeaderCaption()
    On Error GoTo ErrorHandler:
    If Not Me.ProgramProjectNameComboBox.Value & "" = "" Then
            Me.ProgramAreaHeader.Caption = DLookup("ProgramAreaName", "StatusOfFunds", _
                "[StatusOfFunds].[ProgramProjectName] = '" & Me.ProgramProjectNameComboBox.Value & "'")
    Else
        Me.ProgramAreaHeader.Caption = "Payroll Utilization"
    End If
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="SetHeaderCaption()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SetNpmIcon
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetRpioIcon(pRpioCode As String)
    On Error GoTo ErrorHandler:
    If Not pRpioCode & "" = "" Then
        Select Case CStr(pRpioCode)
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
                    & "\etc\png\AppIcons\interface\ui\EpaHorizontal.png"
        End Select
    End If
ErrorHandler:
    ProcessError Name:="PayrollUtilizationForm", _
        Member:="SetRpioIcon"
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




