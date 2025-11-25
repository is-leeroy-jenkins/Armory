VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_RegionalAllocations"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit



Private Args As AccountArgs
Private m_Dialog As Form_RegionDialog
Private FiscalYearFilter As String
Private BocNameFilter As String
Private RpioNameFilter As String
Private BudgetLevelFilter As String
Private FundNameFilter As String
Private pAnd As String
Private m_DataSet As DAO.Recordset
Private m_OriginalAmount As Double
Private m_Error As String




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        Form_Open
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    pAnd = " AND "
    DoCmd.OpenForm FormName:="RegionDialog", WindowMode:=acDialog
    Set m_Dialog = Forms("RegionDialog")
    Set Args = m_Dialog.Args
    If Not Args.RpioName & "" = "" Then
        RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
    End If
    FiscalYearFilter = "[BFY] = '2022'"
    Me.Filter = GetFiscalYearFilter
    Me.RecordSource = "SELECT *" _
        & " FROM RegionalAuthority" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="Form_Open"
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        Form_Load
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.SECTION(acHeader).AutoHeight = False
    Me.SECTION(acHeader).Height = 2
    Me.SECTION(acDetail).AutoHeight = False
    Me.SECTION(acDetail).Height = 4
    Me.SECTION(acFooter).AutoHeight = False
    Me.SECTION(acFooter).Height = 0.5
    SetComboBoxColors
    ClearComboBoxes
    Set m_DataSet = Me.Recordset
    HideButtons
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT RegionalAuthority.RpioName" _
        & " FROM RegionalAuthority;"
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT RegionalAuthority.FundName" _
        & " FROM RegionalAuthority;"
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT RegionalAuthority.BocName" _
        & " FROM RegionalAuthority;"
    If Not Args.RpioName & "" = "" And _
        Not Args.BFY & "" = "" Then
        SetRpioIcon (Args.RpioName)
        SetFiscalYearOptionGroupValue (Args.BFY)
    End If
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="Form_Load()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        SetComboBoxColors
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetComboBoxColors()
    On Error GoTo ErrorHandler:
    Me.RpioNameComboBox.ForeColor = RGB(255, 255, 255)
    Me.RpioNameComboBox.BackColor = RGB(33, 33, 33)
    Me.RpioNameComboBox.BorderColor = RGB(68, 114, 196)
    Me.FundNameComboBox.ForeColor = RGB(255, 255, 255)
    Me.FundNameComboBox.BackColor = RGB(33, 33, 33)
    Me.FundNameComboBox.BorderColor = RGB(68, 114, 196)
    Me.BocNameComboBox.ForeColor = RGB(255, 255, 255)
    Me.BocNameComboBox.BackColor = RGB(33, 33, 33)
    Me.BocNameComboBox.BorderColor = RGB(68, 114, 196)
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="SetComboBoxColors()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        SetButtonVisibility
'   Parameters:  Void
'   Purpose:     Toggles the toolbar button on/off
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
    Me.FilterButton.Visible = Not Me.FilterButton.Visible
    Me.CompassStatusOfFundsButton.Visible = Not Me.CompassStatusOfFundsButton.Visible
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
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
    On Error GoTo ErrorHandler::
    HideButtons
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
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
    Me.FilterButton.Visible = False
    Me.CompassStatusOfFundsButton.Visible = False
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="HideButtons()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ClearFilters
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearFilters()
    On Error GoTo ErrorHandler:
    BocNameFilter = vbNullString
    FiscalYearFilter = vbNullString
    RpioNameFilter = vbNullString
    FundNameFilter = vbNullString
    Me.Filter = vbNullString
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="ClearFilters()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ClearComboBoxes
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearComboBoxes()
    On Error GoTo ErrorHandler:
    Me.RpioNameComboBox.Value = vbNullString
    Me.FundNameComboBox.Value = vbNullString
    Me.BocNameComboBox.Value = vbNullString
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="ClearComboBoxes()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ResetOptionGroupValues
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ResetOptionGroupValues()
    On Error GoTo ErrorHandler:
    Me.FiscalYearOptionGroup.Value = 2
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="ResetOptionGroupValues()"
    Exit Sub
End Sub






'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        FiscalYearOptionGroup_AfterUpdate
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetFiscalYearOptionGroupValue(pBFY As String)
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    If Not pBFY & "" = "" Then
        Select Case pBFY
            Case "2021"
                Args.BFY = "2021"
                FiscalYearFilter = "[BFY] = '2021'"
                Me.FiscalYearOptionGroup.Value = 1
            Case "2022"
                Args.BFY = "2022"
                FiscalYearFilter = "[BFY] = '2022'"
                Me.FiscalYearOptionGroup.Value = 2
        End Select
    End If
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="SetFiscalYearOptionGroupValue()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        FiscalYearOptionGroup_AfterUpdate
'   Parameters:  Void
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
            Me.RecordSource = "SELECT * FROM RegionalAuthority WHERE " & Me.Filter
            Me.Requery
        Case 2
            Args.BFY = "2022"
            FiscalYearFilter = "[BFY] = '2022'"
            Me.Filter = GetFiscalYearFilter
            Me.RecordSource = "SELECT * FROM RegionalAuthority WHERE " & Me.Filter
            Me.Requery
    End Select
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="FiscalYearOptionGroup_AfterUpdate()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetFiscalYearFilter
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetFiscalYearFilter()
    On Error GoTo ErrorHandler:
    If Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & BocNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="GetFiscalYearFilter()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        RpioNameComboBox_Change
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub RpioNameComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.Filter = vbNullString
    RpioNameFilter = "[RpioName] = '" & Me.RpioNameComboBox.Value & "'"
    Args.RpioName = Me.RpioNameComboBox.Value
    SetRpioIcon (Me.RpioNameComboBox.Value)
    Me.Filter = GetRpioNameFilter
    Me.RecordSource = "SELECT * FROM RegionalAuthority WHERE " & Me.Filter
    Me.Requery
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT FundName" _
        & " FROM RegionalAuthority WHERE " & Me.Filter
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT BocName" _
        & " FROM RegionalAuthority WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="RpioNameComboBox_Change()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetRpioNameFilter
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetRpioNameFilter()
    On Error GoTo ErrorHandler:
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & BocNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="GetRpioNameFilter()"
    Exit Function
End Function


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        FundNameComboBox_Change
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FundNameComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Args.FundName = vbNullString
    FundNameFilter = vbNullString
    Me.Filter = vbNullString
    Args.FundName = Me.FundNameComboBox.Value
    FundNameFilter = "[FundName] = '" & Me.FundNameComboBox.Value & "'"
    Me.Filter = GetProgramProjectNameFilter
    Me.RecordSource = "SELECT * FROM RegionalAuthority WHERE " & Me.Filter
    Me.Requery
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT BocName" _
        & " FROM RegionalAuthority" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="FundNameComboBox_Change()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetProgramProjectNameFilter
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetProgramProjectNameFilter()
    On Error GoTo ErrorHandler:
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetProgramProjectNameFilter = FundNameFilter _
            & pAnd & FiscalYearFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetProgramProjectNameFilter = FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetProgramProjectNameFilter = FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetProgramProjectNameFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="GetProgramProjectNameFilter()"
    Exit Function
End Function


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        BocNameComboBox_Change
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub BocNameComboBox_Change()
    On Error GoTo ErrorHandler:
    Args.BocName = vbNullString
    BocNameFilter = vbNullString
    Me.Filter = vbNullString
    Args.BocName = Me.BocNameComboBox.Value
    BocNameFilter = "[BocName] = '" & Me.BocNameComboBox.Value & "'"
    Me.Filter = GetBocNameFilter
    Me.RecordSource = "SELECT * FROM RegionalAuthority WHERE " & Me.Filter
    Me.Requery
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="BocNameComboBox_Change()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetProgramProjectNameFilter
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetBocNameFilter() As String
    On Error GoTo ErrorHandler:
    If Not BocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not BocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetBocNameFilter = FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FiscalYearFilter
    End If
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="GetBocNameFilter()"
    Exit Function
End Function


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        Form_Close
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Close()
    On Error GoTo ErrorHandler:
    ClearFilters
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="Form_Close()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        EditButton_Click
'   Parameters:  Void
'   Purpose:     Opens editor form based on current record data
'---------------------------------------------------------------------------------
Private Sub EditButton_Click()
    On Error GoTo ErrorHandler:
    Dim m_DataSet As DAO.Database
    Set m_DataSet = CurrentDb
    Dim Account As DAO.Recordset
    Dim ID As Integer
    Me.CurrentIdTextBox.SetFocus
    ID = CInt(Me!CurrentIdTextBox.Value)
    Dim frm As Form_AccountEditor
    Set frm = New Form_AccountEditor
    DoCmd.OpenForm FormName:="AccountEditor", OpenArgs:=str(ID)
    Set frm = Forms("AccountEditor")
    Forms("AccountEditor").Tag = Me.Name
    Forms("AccountEditor").RecordSource = Me.RecordSource
    Forms("AccountEditor").BudgetLevelTextBox.SetFocus
    Forms("AccountEditor").BudgetLevelTextBox.Value = Me.BudgetLevelTextBox.Value
    Forms("AccountEditor").RpioCodeTextBox.SetFocus
    Forms("AccountEditor").RpioCodeTextBox.Value = Me.RpioCodeTextBox.Value
    Forms("AccountEditor").BfyTextBox.SetFocus
    Forms("AccountEditor").BfyTextBox.Value = Me.BfyTextBox.Value
    Forms("AccountEditor").AhCodeTextBox.SetFocus
    Forms("AccountEditor").AhCodeTextBox.Value = Me.AhCodeTextBox.Value
    Forms("AccountEditor").FundCodeTextBox.SetFocus
    Forms("AccountEditor").FundCodeTextBox.Value = Me.FundCodeTextBox.Value
    Forms("AccountEditor").OrgCodeTextBox.SetFocus
    Forms("AccountEditor").OrgCodeTextBox.Value = Me.OrgCodeTextBox.Value
    Forms("AccountEditor").AccountCodeTextBox.SetFocus
    Forms("AccountEditor").AccountCodeTextBox.Value = Me.AccountCodeTextBox.Value
    Forms("AccountEditor").BocCodeTextBox.SetFocus
    Forms("AccountEditor").BocCodeTextBox.Value = Me.BocCodeTextBox.Value
    Forms("AccountEditor").RcCodeTextBox.SetFocus
    Forms("AccountEditor").RcCodeTextBox.Value = Me.RcCodeTextBox.Value
    Forms("AccountEditor").OriginalAmountTextBox.SetFocus
    Forms("AccountEditor").OriginalAmountTextBox.Value = Me.AmountTextBox.Value
    DoCmd.Close ObjectType:=acForm, _
        ObjectName:=Me.Name, Save:=acSaveYes
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="EditButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        CalculatorButton_Click
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub CalculatorButton_Click()
    On Error GoTo ErrorHandler:
    Calculator.Calculate
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="CalculatorButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        Form_Load
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'----------------------------------------------------------------------------------
Private Sub CompassStatusOfFundsButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.OpenForm "CompassBudgetStatusQuery"
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="CompassStatusOfFundsButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        MenuButton_Click
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub MenuButton_Click()
    On Error GoTo ErrorHandler:
    SetButtonVisibility
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="MenuButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        RefreshButton_Click
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub RefreshButton_Click()
    On Error GoTo ErrorHandler:
    Me.Filter = vbNullString
    ClearComboBoxes
    ResetOptionGroupValues
    ClearFilters
    Me.Filter = GetFiscalYearFilter
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT RegionalAuthority.RpioName" _
        & " FROM RegionalAuthority" _
        & " WHERE " & Me.Filter
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT RegionalAuthority.FundName" _
        & " FROM RegionalAuthority" _
        & " WHERE " & Me.Filter
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT RegionalAuthority.BocName" _
        & " FROM RegionalAuthority" _
        & " WHERE " & Me.Filter
    Me.RecordSource = "SELECT * FROM RegionalAuthority" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="RefreshButton_Click()"
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
    ProcessError Name:="RegionalAllocationsForm", _
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
    ProcessError Name:="RegionalAllocationsForm", _
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
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="DeleteButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        UpdateBudgetLevel
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub UpdateBudgetLevel()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.Text)
    Me.BudgetLevelTextBox.SetFocus
    Args.BudgetLevel = Me.BudgetLevelTextBox.Text
    Dim SQL As String
    SQL = "UPDATE RegionalAuthority SET RegionalAuthority.BudgetLevel = '" _
        & Args.BudgetLevel & "'" & _
        " WHERE RegionalAuthority.PrcId = " & Args.ID
    Dim db As DAO.Database
    Set db = CurrentDb
    db.Execute (SQL)
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="UpdateBudgetLevel()"
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        UpdateBfy
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub UpdateBfy()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.Text)
    Me.BfyTextBox.SetFocus
    Args.BFY = Me.BfyTextBox.Text
    Dim SQL As String
    SQL = "UPDATE RegionalAuthority SET RegionalAuthority.BFY = '" _
        & Args.BFY & "'" & _
        " WHERE RegionalAuthority.PrcId = " & Args.ID
    Dim db As DAO.Database
    Set db = CurrentDb
    db.Execute (SQL)
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="UpdateBfy()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        UpdateRpioCode
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub UpdateRpioCode()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.Text)
    Me.RpioCodeTextBox.SetFocus
    Args.RpioCode = Me.RpioCodeTextBox.Text
    Dim SQL As String
    SQL = "UPDATE RegionalAuthority SET RegionalAuthority.RPIO = '" _
        & Args.RpioCode & "'" & _
        " WHERE RegionalAuthority.PrcId = " & Args.ID
    Dim db As DAO.Database
    Set db = CurrentDb
    db.Execute (SQL)
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="UpdateRpioCode()"
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        UpdateAhCode
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub UpdateAhCode()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.Text)
    Me.AhCodeTextBox.SetFocus
    Args.AhCode = Me.AhCodeTextBox.Text
    Dim SQL As String
    SQL = "UPDATE RegionalAuthority SET RegionalAuthority.AhCode = '" _
        & Args.AhCode & "'" & _
        " WHERE RegionalAuthority.PrcId = " & Args.ID
    Dim db As DAO.Database
    Set db = CurrentDb
    db.Execute (SQL)
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="UpdateAhCode()"
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        UpdateOrgCode
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub UpdateOrgCode()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.Text)
    Me.OrgCodeTextBox.SetFocus
    Args.OrgCode = Me.OrgCodeTextBox.Text
    Dim SQL As String
    SQL = "UPDATE RegionalAuthority SET RegionalAuthority.OrgCode = '" _
        & Args.OrgCode & "'" & _
        " WHERE RegionalAuthority.PrcId = " & Args.ID
    Dim db As DAO.Database
    Set db = CurrentDb
    db.Execute (SQL)
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="UpdateOrgCode()"
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        UpdateAccountCode
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub UpdateAccountCode()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.Text)
    Me.AccountCodeTextBox.SetFocus
    Args.AccountCode = Me.AccountCodeTextBox.Text
    Dim SQL As String
    SQL = "UPDATE RegionalAuthority SET RegionalAuthority.AccountCode = '" _
        & Args.AccountCode & "'" & _
        " WHERE RegionalAuthority.PrcId = " & Args.ID
    Dim db As DAO.Database
    Set db = CurrentDb
    db.Execute (SQL)
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="UpdateAccountCode()"
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        UpdateBocCode
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub UpdateBocCode()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.Text)
    Me.BocCodeTextBox.SetFocus
    Args.BocCode = Me.BocCodeTextBox.Text
    Dim SQL As String
    SQL = "UPDATE RegionalAuthority SET RegionalAuthority.BocCode = '" _
        & Args.BocCode & "'" & _
        " WHERE RegionalAuthority.PrcId = " & Args.ID
    Dim db As DAO.Database
    Set db = CurrentDb
    db.Execute (SQL)
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="UpdateBocCode()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        UpdateRcCode
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub UpdateRcCode()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.Text)
    Me.RcCodeTextBox.SetFocus
    Args.RcCode = Me.RcCodeTextBox.Text
    Dim SQL As String
    SQL = "UPDATE RegionalAuthority SET RegionalAuthority.RcCode = '" _
        & Args.RcCode & "'" & _
        " WHERE RegionalAuthority.PrcId = " & Args.ID
    Dim db As DAO.Database
    Set db = CurrentDb
    db.Execute (SQL)
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="UpdateRcCode()"
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        UpdateAmount
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub UpdateAmount()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.Text)
    Me.AmountTextBox.SetFocus
    Dim Change As Double
    Change = CDbl(Me.AmountTextBox.Text)
    Dim SQL As String
    SQL = "UPDATE RegionalAuthority SET RegionalAuthority.Amount = " _
        & Change & _
        " WHERE RegionalAuthority.PrcId = " & Args.ID
    Dim db As DAO.Database
    Set db = CurrentDb
    db.Execute (SQL)
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="UpdateAmount()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetColumnNames
'   Parameters:  Void
'   Retval:      Collection
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetReportData() As DAO.Recordset
    On Error GoTo ErrorHandler:
    Dim m_SQL As String
    Dim m_Data As DAO.Recordset
    m_SQL = "SELECT RegionalAuthority.BudgetLevel AS [Level], RegionalAuthority.RPIO, RegionalAuthority.BFY," _
        & " RegionalAuthority.AhCode AS AH, RegionalAuthority.FundCode AS Fund, RegionalAuthority.OrgCode AS ORG," _
        & " RegionalAuthority.AccountCode AS Account, RegionalAuthority.BocCode AS BOC," _
        & " RegionalAuthority.Amount AS Amount" _
        & " FROM RegionalAuthority" _
        & " WHERE RegionalAuthority.Amount <> 0" & pAnd & Me.Filter
    Set m_Data = CurrentDb.OpenRecordset(m_SQL)
    Set GetReportData = m_Data
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="GetReportData()"
    Exit Function
End Function





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
    Dim i As Integer
    Dim j As Integer
    Dim m_Array() As String
    Set m_Data = GetReportData
    j = m_Data.Fields.Count - 1
    ReDim m_Array(j)
    For i = LBound(m_Array()) To UBound(m_Array())
        If Not m_Data.Fields(i).Name & "" = "" Then
            m_Array(i) = m_Data.Fields(i).Name
        End If
    Next i
    GetColumnNames = m_Array()
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="GetColumnNames()"
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
    Dim m_BudgetPath As BudgetPath
    Dim m_Excel As Excel.Application
    Dim m_RegionalAuthority As Excel.Workbook
    Dim m_Worksheet As Excel.Worksheet
    Dim m_List As Excel.ListObject
    Dim m_Range As Excel.Range
    Dim m_Cell As Variant
    Dim m_Header As Excel.Range
    Dim m_Start As Excel.Range
    Dim m_End As Excel.Range
    Dim field As DAO.field
    Dim m_Data As DAO.Recordset
    Dim m_Fields() As String
    Set m_Data = GetReportData
    m_Fields() = GetColumnNames
    Dim i As Integer
    Dim j As Integer
    Set m_BudgetPath = New BudgetPath
    Set m_Excel = CreateObject("Excel.Application")
    Set m_RegionalAuthority = m_Excel.Workbooks.Open(m_BudgetPath.ReportTemplate)
    m_RegionalAuthority.Worksheets(2).Visible = False
    Set m_Worksheet = m_RegionalAuthority.Worksheets(1)
    m_Worksheet.Name = "RegionalAuthority"
    m_Worksheet.Cells.HorizontalAlignment = xlHAlignLeft
    m_Worksheet.Cells.Font.Name = "Source Code Pro"
    m_Worksheet.Cells.Font.Size = 8
    Set m_Start = m_Worksheet.Cells(1, 1)
    Set m_End = m_Worksheet.Cells(1, UBound(m_Fields) + 1)
    Set m_Header = m_Worksheet.Range(m_Start, m_End)
    m_Header.Interior.Color = RGB(217, 217, 217)
    m_Header.HorizontalAlignment = xlHAlignLeft
    m_Header.Borders(xlEdgeBottom).Color = RGB(0, 0, 0)
    m_Header.Borders(xlEdgeLeft).Color = RGB(133, 133, 133)
    m_Header.Borders(xlEdgeRight).Color = RGB(133, 133, 133)
    m_Header.Borders(xlEdgeTop).Color = RGB(133, 133, 133)
    m_Header.Font.Name = "Source Code Pro"
    m_Header.Font.Color = vbBlack
    m_Header.Font.Bold = True
    m_Header.Font.Size = 8
    For i = LBound(m_Fields) To UBound(m_Fields)
        j = i
        m_Header.Cells(1, i + 1).Value = m_Fields(j)
    Next i
    m_Worksheet.Cells(2, 1).CopyFromRecordset m_Data
    m_Header.Font.Color = vbBlack
    m_Excel.WindowState = xlMaximized
    m_Excel.Visible = True
ErrorHandler:
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="ExcelButton_Click()"
    Exit Sub
End Sub








'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SetRpioIcon
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetRpioIcon(pRpioName As String)
    On Error GoTo ErrorHandler:
    Dim p_RpioCode As String
    If Not pRpioName & "" = "" Then
        p_RpioCode = DLookup("RpioCode", "RegionalAuthority", _
            "[RpioName] = '" & pRpioName & "'")
        Me.Caption = pRpioName
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
                    & "etc\png\AppIcons\interface\RPIO\OMS.png"
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
    ProcessError Name:="RegionalAllocationsForm", _
        Member:="SetRpioIcon()"
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




