Option Compare Database
Option Explicit



Public DbData As DAO.Database
Public DbSet As DAO.Recordset
Public Args As AccountArgs
Public m_Dialog As Form_StatusOfFundsDialog
Private BocNameFilter As String
Private FiscalYearFilter As String
Private FundNameFilter As String
Private ProgramProjectNameFilter As String
Private RpioNameFilter
Private pAnd As String
Private m_Error As String
Private m_Notification As String




'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    Set m_Dialog = New Form_StatusOfFundsDialog
    Set Args = New AccountArgs
    DoCmd.OpenForm FormName:="StatusOfFundsDialog", WindowMode:=acDialog
    Set m_Dialog = Forms("StatusOfFundsDialog")
    Set Args = m_Dialog.Args
    If Args.BFY = "2021" Then
        Me.FiscalYearOptionGroup.DefaultValue = 1
        FiscalYearFilter = "[BFY] = '2021'"
    Else
        Me.FiscalYearOptionGroup.DefaultValue = 2
        FiscalYearFilter = "[BFY] = '2022'"
    End If
    RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
    Me.Caption = Args.RpioName
    DoCmd.Close ObjectType:=acForm, ObjectName:="StatusOfFundsDialog", Save:=acSaveNo
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="Form_Open"
    Exit Sub
End Sub



'---------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Load
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler:
    ClearComboBoxValues
    pAnd = " AND "
    HideButtons
    If Not Args.RpioCode & "" = "" Then
        SetRpioIcon (Args.RpioCode)
    End If
    If Not Args.FundName & "" = "" Then
        Me.FundNameComboBox.Value = Args.FundName
        FundNameFilter = "[FundName] = '" & Args.FundName & "'"
    End If
    If Not Args.BocName & "" = "" Then
        Me.BocNameComboBox.Value = Args.BocName
        BocNameFilter = "[BocName] = '" & Args.BocName & "'"
    End If
    If Not Args.BFY & "" = "" And _
        Not Args.RpioName & "" = "" And _
        Not Args.FundName & "" = "" Then
            RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
            FundNameFilter = "[FundName] = '" & Args.FundName & "'"
            Me.Filter = FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    Me.RecordSource = "SELECT * FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    Me.ExecutionChart.RowSource = Me.RecordSource
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.FundName" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode IN ('36', '37', '38', '41')" & pAnd & Me.Filter
    Me.ProgramProjectNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.ProgramProjectName" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode IN ('36', '37', '38', '41')" & pAnd & Me.Filter
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.BocName" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode IN ('36', '37', '38', '41')" & pAnd & Me.Filter
    Me.Requery
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="Form_Load()"
    Exit Sub
End Sub



'---------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Close
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Close()
    On Error GoTo ErrorHandler:
    Me.Filter = ""
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="Form_Close()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            SetButtonVisibility
'   Parameters:      Void
'   Purpose:         Toggles button visibility on and off
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
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
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
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
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
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="HideButtons()"
    Exit Sub
End Sub



'---------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        FiscalYearOptionGroup_AfterUpdate
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FiscalYearOptionGroup_AfterUpdate()
    On Error GoTo ErrorHandler:
    FiscalYearFilter = vbNullString
    Me.Filter = vbNullString
    Select Case Me.FiscalYearOptionGroup.Value
        Case 1
            FiscalYearFilter = "[BFY] = '2021'"
            Args.BFY = "2021"
        Case 2
            FiscalYearFilter = "[BFY] = '2022'"
            Args.BFY = "2022"
    End Select
    Me.Filter = RpioNameFilter & pAnd & GetFiscalYearFilter
    Me.RecordSource = "SELECT * FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode IN ('36', '37', '38', '41')" & pAnd & Me.Filter
    Me.Requery
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="FiscalYearOptionGroup_AfterUpdate()"
    Exit Sub
End Sub


'---------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetFiscalYear
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetFiscalYearFilter()
    On Error GoTo ErrorHandler:
    If Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & BocNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & FundNameFilter _
                & pAnd & BocNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & BocNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & BocNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & BocNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter
    End If
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="GetFiscalYearFilter()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Sub Procedure
'   Name:        FundNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FundNameComboBox_Change()
    On Error GoTo ErrorHandler:
    FundNameFilter = vbNullString
    Me.Filter = vbNullString
    FundNameFilter = "[FundName] = '" & Me.FundNameComboBox.Value & "'"
    Me.Filter = RpioNameFilter & pAnd & GetFundNameFilter
    Me.RecordSource = "SELECT * FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode IN ('36', '37', '38', '41')" _
        & pAnd & Me.Filter
    Me.Requery
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.BocName" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode IN ('36', '37', '38', '41')" _
        & pAnd & Me.Filter
    Me.ExecutionChart.RowSource = Me.RecordSource
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
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
        ProgramProjectNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetFundNameFilter = FiscalYearFilter & pAnd & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetFundNameFilter = FiscalYearFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetFundNameFilter = FiscalYearFilter _
                & pAnd & FundNameFilter _
                & pAnd & ProgramProjectNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetFundNameFilter = BocNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & BocNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter _
                & pAnd & BocNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not ProgramProjectNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        ProgramProjectNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetFundNameFilter = FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="GetFundNameFilter()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Sub Procedure
'   Name:        ProgramProjectNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ProgramProjectNameComboBox_Change()
    On Error GoTo ErrorHandler:
    ProgramProjectNameFilter = vbNullString
    Me.Filter = vbNullString
    ProgramProjectNameFilter = "[ProgramProjectName] = '" & Me.ProgramProjectNameComboBox.Value & "'"
    Me.Filter = RpioNameFilter & pAnd & GetProgramProjectNameFilter
    Me.RecordSource = "SELECT * FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    Me.Requery
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.FundName" _
        & " FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.BocName" _
        & " FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    Me.ExecutionChart.RowSource = Me.RecordSource
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="ProgramProjectNameComboBox_Change()"
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
    If Not ProgramProjectNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetProgramProjectNameFilter = ProgramProjectNameFilter
    End If
    If Not ProgramProjectNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetProgramProjectNameFilter = FiscalYearFilter & pAnd & ProgramProjectNameFilter
    End If
    If Not ProgramProjectNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetProgramProjectNameFilter = FiscalYearFilter & pAnd & FundNameFilter _
                & pAnd & ProgramProjectNameFilter
    End If
    If Not ProgramProjectNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetProgramProjectNameFilter = FiscalYearFilter & pAnd & FundNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & BocNameFilter
    End If
    If Not ProgramProjectNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetProgramProjectNameFilter = FundNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & BocNameFilter
    End If
    If Not ProgramProjectNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetProgramProjectNameFilter = ProgramProjectNameFilter _
                & pAnd & BocNameFilter
    End If
    If Not ProgramProjectNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetProgramProjectNameFilter = BocNameFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not ProgramProjectNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetProgramProjectNameFilter = FiscalYearFilter _
                & pAnd & ProgramProjectNameFilter _
                & pAnd & BocNameFilter
    End If
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="GetProgramProjectNameFilter()"
    Exit Function
End Function






'---------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        BocNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub BocNameComboBox_Change()
    On Error GoTo ErrorHandler:
    BocNameFilter = vbNullString
    Me.Filter = vbNullString
    BocNameFilter = "[BocName] = '" & Me.BocNameComboBox.Value & "'"
    Me.Filter = RpioNameFilter & pAnd & GetBocNameFilter
    Me.RecordSource = "SELECT * FROM StatusOfFunds WHERE" & Me.Filter
    Me.Requery
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.FundName" _
        & " FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    Me.ExecutionChart.RowSource = Me.RecordSource
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="BocNameComboBox_Change()"
    Exit Sub
End Sub


'---------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetBocNameFilter
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetBocNameFilter() As String
    On Error GoTo ErrorHandler:
    If Not BocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter & pAnd & FiscalYearFilter
    End If
    If Not BocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter & pAnd & FiscalYearFilter _
                & pAnd & BocNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter & pAnd & FiscalYearFilter _
                & pAnd & BocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & BocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & BocNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="GetBocNameFilter()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ClearFilters
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearFilters()
    On Error GoTo ErrorHandler:
    ProgramProjectNameFilter = vbNullString
    FiscalYearFilter = vbNullString
    BocNameFilter = vbNullString
    FundNameFilter = vbNullString
    Me.Filter = vbNullString
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="ClearFilters()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ClearComboBoxes
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearComboBoxValues()
    On Error GoTo ErrorHandler:
    Me.ProgramProjectNameComboBox.Value = vbNullString
    Me.FundNameComboBox.Value = vbNullString
    Me.BocNameComboBox.Value = vbNullString
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="ClearComboBoxValues()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ResetOptionGroupValues
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ResetOptionGroupValues()
    On Error GoTo ErrorHandler:
    Me.FiscalYearOptionGroup.Value = 2
    FiscalYearFilter = "[BFY] = '2022'"
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="ResetOptionGroupValues()"
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
    ClearFilters
    ResetOptionGroupValues
    Me.Filter = FiscalYearFilter & pAnd & RpioNameFilter
    Me.RecordSource = "SELECT * FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.FundName" _
        & " FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    Me.ProgramProjectNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.ProgramProjectName" _
        & " FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.BocName" _
        & " FROM StatusOfFunds" _
        & " WHERE " & Me.Filter
    Me.Requery
    Me.ExecutionChart.RowSource = Me.RecordSource
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="RefreshButton_Click()"
    Exit Sub
End Sub





'---------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        MenuButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub MenuButton_Click()
    On Error GoTo ErrorHandler:
    SetButtonVisibility
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="MenuButton_Click()"
    Exit Sub
End Sub


'---------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        CalculatorButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub CalculatorButton_Click()
    On Error GoTo ErrorHandler:
    Calculator.Calculate
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="CalculatorButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ExitButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ExitButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close acForm, Me.Name, acSaveNo
    DoCmd.OpenForm FormName:="DataAnalysis", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
        Member:="ExitButton_Click()"
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
                    & "\etc\png\AppIcons\interface\RPIO\OCFO.png"
        End Select
    End If
ErrorHandler:
    ProcessError Name:="RpioUtilizationForm", _ 
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


