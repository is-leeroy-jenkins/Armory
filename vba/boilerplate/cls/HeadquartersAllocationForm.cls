Option Compare Database
Option Explicit



Public Args As AccountArgs
Public m_Dialog As Form_NpmDialog
Private FiscalYearFilter As String
Private BocNameFilter As String
Private RpioNameFilter As String
Private FundNameFilter As String
Private pAnd As String
Private m_DataSet As DAO.Recordset
Private m_OriginalAmount As Double
Private m_Error As String





'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        Form_Open
'   Parameters:  Integer
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    pAnd = " AND "
    Me.Filter = vbNullString
    Set m_Dialog = New Form_NpmDialog
    Set Args = New AccountArgs
    DoCmd.OpenForm FormName:="NpmDialog", WindowMode:=acDialog
    Set m_Dialog = Forms("NpmDialog")
    Set Args = m_Dialog.Args
    SetFiscalYearOptionValue (Args.BFY)
    SetFilters
    Me.Filter = GetFilters
    Me.RecordSource = "SELECT * FROM HeadquartersAuthority WHERE " & Me.Filter
    SetRpioIcon (Args.RpioName)
    PopulateComboBoxes
    DoCmd.Close ObjectType:=acForm, ObjectName:="NpmDialog", Save:=acSaveNo
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="Form_Open()"
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
    Me.SECTION(acHeader).AutoHeight = False
    Me.SECTION(acHeader).Height = 2
    Me.SECTION(acDetail).AutoHeight = False
    Me.SECTION(acDetail).Height = 4
    Me.SECTION(acFooter).AutoHeight = False
    Me.SECTION(acFooter).Height = 0.5
    SetComboBoxColors
    ClearComboBoxValues
    HideButtons
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="SetButtonVisibility()"
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
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="HideButtons()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        SetFilters
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetFilters()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    If Not Args.RpioName & "" = "" Then
        RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
    End If
    If Not Args.BFY & "" = "" Then
        FiscalYearFilter = "[BFY] = '" & Args.BFY & "'"
    End If
    If Not Args.FundName & "" = "" Then
        FundNameFilter = "[FundName] = '" & Args.FundName & "'"
    End If
    If Not Args.BocName & "" = "" Then
        BocNameFilter = "[BocName] = '" & Args.BocName & "'"
    End If
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="SetFilters()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetFilters
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetFilters() As String
    On Error GoTo ErrorHandler:
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetFilters = RpioNameFilter _
                & pAnd & FiscalYearFilter
            Exit Function
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetFilters = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter
            Exit Function
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetFilters = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter _
                & pAnd & BocNameFilter
            Exit Function
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetFilters = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & BocNameFilter
            Exit Function
    End If
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="GetFilters()"
    Exit Function
End Function




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
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="ClearFilters()"
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
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="Form_Timer()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ResetComboBoxes
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub PopulateComboBoxes()
    On Error GoTo ErrorHandler:
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT HeadquartersAuthority.RpioName" _
        & " FROM HeadquartersAuthority;"
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT HeadquartersAuthority.FundName" _
        & " FROM HeadquartersAuthority;"
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT HeadquartersAuthority.BocName" _
        & " FROM HeadquartersAuthority;"
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="PopulateComboBoxes()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ClearComboBoxValues
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearComboBoxValues()
    On Error GoTo ErrorHandler:
    Me.RpioNameComboBox.Value = vbNullString
    Me.FundNameComboBox.Value = vbNullString
    Me.BocNameComboBox.Value = vbNullString
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="ClearComboBoxValues()"
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
    ProcessError Name:="HeadQuartersAllocationForm", _
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
Private Sub SetFiscalYearOptionValue(pBFY As String)
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
            Case Else
                Args.BFY = "2022"
                FiscalYearFilter = "[BFY] = '2022'"
                Me.FiscalYearOptionGroup.Value = 2
        End Select
    End If
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="SetFiscalYearOptionValue()"
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
    FiscalYearFilter = vbNullString
    If Not Me.FiscalYearOptionGroup.Value & "" = "" Then
        Select Case Me.FiscalYearOptionGroup.Value
            Case 1
                Args.BFY = "2021"
                FiscalYearFilter = "[BFY] = '2021'"
                Me.FiscalYearOptionGroup.Value = 1
            Case 2
                Args.BFY = "2022"
                FiscalYearFilter = "[BFY] = '2022'"
                Me.FiscalYearOptionGroup.Value = 2
            Case Else
                Args.BFY = "2022"
                FiscalYearFilter = "[BFY] = '2022'"
                Me.FiscalYearOptionGroup.Value = 2
        End Select
    End If
    Me.Filter = GetFiscalYearFilter
    Me.RecordSource = "SELECT * FROM HeadquartersAuthority" _
        & " WHERE " & Me.Filter
    Me.Requery
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    Args.RpioName = Me.RpioNameComboBox.Value
    Dim p_RpioCode As String
    SetRpioIcon (Me.RpioNameComboBox.Value)
    RpioNameFilter = "[RpioName] = '" & Me.RpioNameComboBox.Value & "'"
    Me.Filter = GetRpioNameFilter
    Me.RecordSource = "SELECT *" _
        & " FROM HeadquartersAuthority" _
        & " WHERE HeadquartersAuthority.BudgetLevel = '7'" _
        & pAnd & "HeadquartersAuthority.RpioCode NOT IN ('01', '02', '03', '04', '05', '06', '07', '08', '09', '10')" _
        & pAnd & Me.Filter
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT HeadquartersAuthority.FundName" _
        & " FROM HeadquartersAuthority" _
        & " WHERE HeadquartersAuthority.BudgetLevel = '7'" _
        & pAnd & "HeadquartersAuthority.RpioCode NOT IN ('01', '02', '03', '04', '05', '06', '07', '08', '09', '10')" _
        & pAnd & Me.Filter
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT HeadquartersAuthority.BocName" _
        & " FROM HeadquartersAuthority" _
        & " WHERE HeadquartersAuthority.BudgetLevel = '7'" _
        & pAnd & "HeadquartersAuthority.RpioCode NOT IN ('01', '02', '03', '04', '05', '06', '07', '08', '09', '10')" _
        & pAnd & Me.Filter
    Me.Requery
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
        FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetRpioNameFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetRpioNameFilter = FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & vbNullString & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetRpioNameFilter = FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetRpioNameFilter = BocNameFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            Me.Filter = RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetRpioNameFilter = BocNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetRpioNameFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    Args.FundName = vbNullString
    FundNameFilter = vbNullString
    Args.FundName = Me.FundNameComboBox.Value
    FundNameFilter = "[FundName] = '" & Me.FundNameComboBox.Value & "'"
    If Not Args.RpioName & "" = "" Then
        Me.Filter = RpioNameFilter & pAnd & GetFundNameFilter
        Me.RecordSource = "SELECT * FROM HeadquartersAuthority" _
            & " WHERE " & Me.Filter
        Me.BocNameComboBox.RowSource = "SELECT DISTINCT BocName" _
            & " FROM HeadquartersAuthority" _
            & " WHERE " & Me.Filter
        Me.Requery
    Else
        Me.Filter = GetFundNameFilter
        Me.RecordSource = "SELECT * FROM HeadquartersAuthority" _
            & " WHERE " & Me.Filter
        Me.BocNameComboBox.RowSource = "SELECT DISTINCT BocName" _
            & " FROM HeadquartersAuthority" _
            & " WHERE " & Me.Filter
        Me.Requery
    End If
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
Private Function GetFundNameFilter()
    On Error GoTo ErrorHandler:
    If Not FundNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetFundNameFilter = FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetFundNameFilter = FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetFundNameFilter = FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetFundNameFilter = BocNameFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetFundNameFilter = RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetFundNameFilter = BocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetFundNameFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="GetFundNameFilter()"
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
    Args.BocName = Me.BocNameComboBox.Value
    BocNameFilter = "[BocName] = '" & Me.BocNameComboBox.Value & "'"
    If Not Args.RpioName & "" = "" Then
        Me.Filter = GetBocNameFilter
        Me.RecordSource = "SELECT *" _
            & " FROM HeadquartersAuthority" _
            & " WHERE " & Me.Filter
        Me.Requery
    Else
        Me.Filter = GetBocNameFilter
        Me.RecordSource = "SELECT *" _
            & " FROM HeadquartersAuthority" _
            & " WHERE " & Me.Filter
        Me.Requery
    End If
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="BocNameComboBox_Change()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetFundNameFilter
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
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="GetBocNameFilter()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        RefreshButton_Click
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub RefreshButton_Click()
    On Error GoTo ErrorHandler:
    ClearFilters
    ClearComboBoxValues
    PopulateComboBoxes
    ResetOptionGroupValues
    If Not Args.RpioName & "" = "" Then
        Me.Filter = GetRpioNameFilter
        Me.RecordSource = "SELECT *" _
            & " FROM HeadquartersAuthority" _
            & " WHERE " & Me.Filter
        Set m_DataSet = Me.Recordset
        Me.Requery
    Else
        Me.Filter = GetFiscalYearFilter
        Me.RecordSource = "SELECT *" _
            & " FROM HeadquartersAuthority" _
            & " WHERE " & Me.Filter
        Set m_DataSet = Me.Recordset
        Me.Requery
    End If
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="RefreshButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        Form_Close
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Close()
    On Error GoTo ErrorHandler:
    ClearFilters
    Me.Filter = vbNullString
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="Form_Close()"
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
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="CompassStatusOfFundsButton_Click()"
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
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="EditButton_Click()"
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
        p_RpioCode = DLookup("RpioCode", "HeadquartersAuthority", _
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
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="SetRpioIcon()"
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
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="CalculatorButton_Click()"
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
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="MenuButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExitButton_Click
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ExitButton_Click()
    On Error GoTo ErrorHandler:
    If Not Me.OpenArgs & "" = "" Then
        DoCmd.Close ObjectType:=acForm, _
            ObjectName:=Me.Name, Save:=acSaveNo
        DoCmd.OpenForm FormName:="Budget", _
            WindowMode:=acDialog
    Else
        DoCmd.Close ObjectType:=acForm, _
            ObjectName:=Me.Name, Save:=acSaveNo
        DoCmd.OpenForm FormName:="Main", _
            WindowMode:=acDialog
    End If
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="ExitButton_Click()"
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
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.text)
    Me.BudgetLevelTextBox.SetFocus
    Args.BudgetLevel = Me.BudgetLevelTextBox.text
    Dim SQL As String
    SQL = "UPDATE HeadquartersAuthority SET HeadquartersAuthority.BudgetLevel = '" _
        & Args.BudgetLevel & "'" & _
        " WHERE HeadquartersAuthority.PrcId = " & Args.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.text)
    Me.BfyTextBox.SetFocus
    Args.BFY = Me.BfyTextBox.text
    Dim SQL As String
    SQL = "UPDATE HeadquartersAuthority SET HeadquartersAuthority.BFY = '" _
        & Args.BFY & "'" & _
        " WHERE HeadquartersAuthority.PrcId = " & Args.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.text)
    Me.RpioCodeTextBox.SetFocus
    Args.RpioCode = Me.RpioCodeTextBox.text
    Dim SQL As String
    SQL = "UPDATE HeadquartersAuthority SET HeadquartersAuthority.RPIO = '" _
        & Args.RpioCode & "'" & _
        " WHERE HeadquartersAuthority.PrcId = " & Args.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.text)
    Me.AhCodeTextBox.SetFocus
    Args.AhCode = Me.AhCodeTextBox.text
    Dim SQL As String
    SQL = "UPDATE HeadquartersAuthority SET HeadquartersAuthority.AhCode = '" _
        & Args.AhCode & "'" & _
        " WHERE HeadquartersAuthority.PrcId = " & Args.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.text)
    Me.OrgCodeTextBox.SetFocus
    Args.OrgCode = Me.OrgCodeTextBox.text
    Dim SQL As String
    SQL = "UPDATE HeadquartersAuthority SET HeadquartersAuthority.OrgCode = '" _
        & Args.OrgCode & "'" & _
        " WHERE HeadquartersAuthority.PrcId = " & Args.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.text)
    Me.AccountCodeTextBox.SetFocus
    Args.AccountCode = Me.AccountCodeTextBox.text
    Dim SQL As String
    SQL = "UPDATE HeadquartersAuthority SET HeadquartersAuthority.AccountCode = '" _
        & Args.AccountCode & "'" & _
        " WHERE HeadquartersAuthority.PrcId = " & Args.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.text)
    Me.BocCodeTextBox.SetFocus
    Args.BocCode = Me.BocCodeTextBox.text
    Dim SQL As String
    SQL = "UPDATE HeadquartersAuthority SET HeadquartersAuthority.BocCode = '" _
        & Args.BocCode & "'" & _
        " WHERE HeadquartersAuthority.PrcId = " & Args.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.text)
    Me.RcCodeTextBox.SetFocus
    Args.RpioCode = Me.RcCodeTextBox.text
    Dim SQL As String
    SQL = "UPDATE HeadquartersAuthority SET HeadquartersAuthority.RcCode = '" _
        & Args.RpioCode & "'" & _
        " WHERE HeadquartersAuthority.PrcId = " & Args.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    Me.PrcIdTextBox.SetFocus
    Args.ID = CInt(Me!PrcIdTextBox.text)
    Me.AmountTextBox.SetFocus
    Dim Change As Double
    Change = CDbl(Me.AmountTextBox.text)
    Dim SQL As String
    SQL = "UPDATE HeadquartersAuthority SET HeadquartersAuthority.Amount = " _
        & Change & _
        " WHERE HeadquartersAuthority.PrcId = " & Args.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    m_SQL = "SELECT HeadquartersAuthority.BudgetLevel AS [Level], HeadquartersAuthority.RPIO, HeadquartersAuthority.BFY," _
        & " HeadquartersAuthority.AhCode AS AH, HeadquartersAuthority.FundCode AS Fund," _
        & " HeadquartersAuthority.OrgCode AS ORG, HeadquartersAuthority.AccountCode AS Account, HeadquartersAuthority.BocCode AS BOC," _
        & " HeadquartersAuthority.Amount AS Amount" _
        & " FROM HeadquartersAuthority" _
        & " WHERE HeadquartersAuthority.Amount <> 0" & pAnd & Me.Filter
    Set m_Data = CurrentDb.OpenRecordset(m_SQL)
    Set GetReportData = m_Data
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    Dim p_BudgetPath As BudgetPath
    Dim p_Excel As Excel.Application
    Dim p_HeadquartersAuthority As Excel.Workbook
    Dim p_Worksheet As Excel.Worksheet
    Dim p_List As Excel.ListObject
    Dim p_Range As Excel.Range
    Dim p_Cell As Variant
    Dim p_Header As Excel.Range
    Dim p_Start As Excel.Range
    Dim p_End As Excel.Range
    Dim field As DAO.field
    Dim p_Data As DAO.Recordset
    Dim p_Fields() As String
    Set p_Data = GetReportData
    p_Fields() = GetColumnNames
    Dim i As Integer
    Dim j As Integer
    Set p_BudgetPath = New BudgetPath
    Set p_Excel = CreateObject("Excel.Application")
    Set p_HeadquartersAuthority = p_Excel.Workbooks.Open(p_BudgetPath.ReportTemplate)
    p_HeadquartersAuthority.Worksheets(2).Visible = False
    Set p_Worksheet = p_HeadquartersAuthority.Worksheets(1)
    p_Worksheet.Name = "HeadquartersAuthority"
    p_Worksheet.Cells.HorizontalAlignment = xlHAlignLeft
    p_Worksheet.Cells.Font.Name = "Source Code Pro"
    p_Worksheet.Cells.Font.Size = 8
    Set p_Start = p_Worksheet.Cells(1, 1)
    Set p_End = p_Worksheet.Cells(1, UBound(p_Fields) + 1)
    Set p_Header = p_Worksheet.Range(p_Start, p_End)
    p_Header.Interior.Color = RGB(217, 217, 217)
    p_Header.HorizontalAlignment = xlHAlignLeft
    p_Header.Borders(xlEdgeBottom).Color = RGB(0, 0, 0)
    p_Header.Borders(xlEdgeLeft).Color = RGB(133, 133, 133)
    p_Header.Borders(xlEdgeRight).Color = RGB(133, 133, 133)
    p_Header.Borders(xlEdgeTop).Color = RGB(133, 133, 133)
    p_Header.Font.Name = "Source Code Pro"
    p_Header.Font.Color = vbBlack
    p_Header.Font.Bold = True
    p_Header.Font.Size = 8
    For i = LBound(p_Fields) To UBound(p_Fields)
        j = i
        p_Header.Cells(1, i + 1).Value = p_Fields(j)
    Next i
    p_Worksheet.Cells(2, 1).CopyFromRecordset p_Data
    p_Header.Font.Color = vbBlack
    p_Excel.WindowState = xlMaximized
    p_Excel.Visible = True
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    ProcessError Name:="HeadQuartersAllocationForm", _
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
    Err.Clear
    MessageFactory.ShowError (m_Error)
End Sub





