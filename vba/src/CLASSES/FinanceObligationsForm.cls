Option Compare Database
Option Explicit



Public Args As AccountArgs
Private m_Dialog As Form_StatusOfFundsDialog
Private FundNameFilter As String
Private AccountCodeFilter As String
Private BocNameFilter As String
Private FocNameFilter As String
Private FiscalYearFilter As String
Private RpioNameFilter As String
Private pAnd As String
Private m_Error As String
Private m_Notification As String




'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            Form_Open()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    Set m_Dialog = New Form_StatusOfFundsDialog
    Set Args = New AccountArgs
    DoCmd.OpenForm FormName:="StatusOfFundsDialog", WindowMode:=acDialog
    Set m_Dialog = Forms("StatusOfFundsDialog")
    Set Args = m_Dialog.Args
    RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
    SetRpioIcon (Args.RpioName)
    Me.RecordSource = "SELECT * FROM Obligations" _
        & " WHERE Obligations.BocCode NOT IN ('10', '17')" _
        & " AND Obligations.RpioName = '" & Args.RpioName & "';"
    DoCmd.Close ObjectType:=acForm, ObjectName:=m_Dialog.Name, Save:=acSaveNo
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="Form_Open()"
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
    Me.SECTION(acHeader).AutoHeight = False
    Me.SECTION(acHeader).Height = 2
    Me.SECTION(acDetail).AutoHeight = False
    Me.SECTION(acDetail).Height = 4
    Me.SECTION(acFooter).AutoHeight = False
    Me.SECTION(acFooter).Height = 0.5
    Me.FiscalYearOptionGroup.Value = 2
    FiscalYearFilter = "[BFY] = '2022'"
    ClearComboBoxValues
    SetComboBoxColors
    pAnd = " AND "
    ClearComboBoxValues
    SetComboBoxColors
    SetButtonVisibility
    Me.Filter = RpioNameFilter
    Me.AccountCodeComboBox.RowSource = "SELECT DISTINCT Obligations.AccountCode" _
        & " FROM Obligations" _
        & " WHERE " & Me.Filter
    Me.FocNameComboBox.RowSource = "SELECT DISTINCT Obligations.FocName" _
        & " FROM Obligations" _
        & " WHERE " & Me.Filter
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT Obligations.FundName" _
        & " FROM Obligations" _
        & " WHERE " & Me.Filter
    Me.FilterOn = True
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="Form_Load()"
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
    RpioNameFilter = vbNullString
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="Form_Close()"
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
    Me.CompassSpendingQueryButton.Visible = Not Me.CompassSpendingQueryButton.Visible
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="SetButtonVisibility()"
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
    ProcessError Name:="FinanceClassObligationsForm", _
        Member:="SetRpioIcon()"
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
    ProcessError Name:="FiananceClassObligationForm", _
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
    Me.CompassSpendingQueryButton.Visible = False
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
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
    Me.FocNameComboBox.ForeColor = RGB(255, 255, 255)
    Me.FocNameComboBox.BackColor = RGB(33, 33, 33)
    Me.FocNameComboBox.BorderColor = RGB(68, 114, 196)
    Me.AccountCodeComboBox.ForeColor = RGB(255, 255, 255)
    Me.AccountCodeComboBox.BackColor = RGB(33, 33, 33)
    Me.AccountCodeComboBox.BorderColor = RGB(68, 114, 196)
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
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
    Me.FocNameComboBox.Value = vbNullString
    Me.AccountCodeComboBox.Value = vbNullString
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
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
    FocNameFilter = vbNullString
    AccountCodeFilter = vbNullString
    FiscalYearFilter = vbNullString
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="ClearFilterValues()"
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
     FiscalYearFilter = "[BFY] = '2022'"
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="ResetOptionGroupValues()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        FocNameComboBox_Change
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub FocNameComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    FocNameFilter = vbNullString
    Me.Filter = vbNullString
    Me.AccountCodeComboBox.Value = vbNullString
    FocNameFilter = "[FocName] = '" & Me.FocNameComboBox.Value & "'"
    Me.Filter = RpioNameFilter & pAnd & GetFocNameFilter
    Me.RecordSource = "SELECT * FROM Obligations WHERE " & Me.Filter
    Me.Requery
    Me.AccountCodeComboBox.RowSource = "SELECT DISTINCT Obligations.AccountCode" _
        & " FROM Obligations" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="FocNameComboBox_Change()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetFocNameFilter
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Private Function GetFocNameFilter() As String
    On Error GoTo ErrorHandler:
    If Not FocNameFilter & "" = "" And _
        AccountCodeFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFocNameFilter = FocNameFilter
    End If
    If Not FocNameFilter & "" = "" And _
        Not AccountCodeFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFocNameFilter = FocNameFilter _
            & pAnd & AccountCodeFilter
    End If
    If Not FocNameFilter & "" = "" And _
        Not AccountCodeFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFocNameFilter = FocNameFilter _
                & pAnd & AccountCodeFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not FocNameFilter & "" = "" And _
        Not AccountCodeFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFocNameFilter = FocNameFilter _
                & pAnd & AccountCodeFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
    If Not FocNameFilter & "" = "" And _
        AccountCodeFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFocNameFilter = FocNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
    If Not FocNameFilter & "" = "" And _
        AccountCodeFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFocNameFilter = FocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FocNameFilter & "" = "" And _
        AccountCodeFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFocNameFilter = FocNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not FocNameFilter & "" = "" And _
        Not AccountCodeFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFocNameFilter = FocNameFilter _
                & pAnd & AccountCodeFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:=""
    Exit Function
End Function




'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        AccountCodeComboBox_Change
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub AccountCodeComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.Filter = vbNullString
    AccountCodeFilter = vbNullString
    Args.AccountCode = Me.AccountCodeComboBox.Value
    AccountCodeFilter = "[AccountCode] = '" & Me.AccountCodeComboBox.Value & "'"
    Me.Filter = RpioNameFilter & pAnd & GetAccountCodeFilter
    Me.RecordSource = "SELECT * FROM Obligations WHERE " & Me.Filter
    Me.Requery
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="AccountCodeComboBox_Change()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetAccountCodeFilter
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Private Function GetAccountCodeFilter() As String
    On Error GoTo ErrorHandler:
    If Not AccountCodeFilter & "" = "" And _
        FocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetAccountCodeFilter = AccountCodeFilter
    End If
    If Not AccountCodeFilter & "" = "" And _
        Not FocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetAccountCodeFilter = AccountCodeFilter _
            & pAnd & FocNameFilter
    End If
    If Not AccountCodeFilter & "" = "" And _
        Not FocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetAccountCodeFilter = AccountCodeFilter _
                & pAnd & FocNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not AccountCodeFilter & "" = "" And _
        Not FocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetAccountCodeFilter = AccountCodeFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not AccountCodeFilter & "" = "" And _
        FocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetAccountCodeFilter = AccountCodeFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
    If Not AccountCodeFilter & "" = "" And _
        FocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetAccountCodeFilter = AccountCodeFilter _
                & pAnd & FundNameFilter
    End If
    If Not AccountCodeFilter & "" = "" And _
        FocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetAccountCodeFilter = AccountCodeFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not AccountCodeFilter & "" = "" And _
        Not FocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetAccountCodeFilter = AccountCodeFilter _
                & pAnd & FocNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not AccountCodeFilter & "" = "" And _
        FocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetAccountCodeFilter = AccountCodeFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="GetAccountCodeFilter()"
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
    Me.FocNameComboBox.Value = vbNullString
    Me.AccountCodeComboBox.Value = vbNullString
    Args.FundName = Me.FundNameComboBox.Value
    FundNameFilter = "[FundName] = '" & Me.FundNameComboBox.Value & "'"
    Me.Filter = RpioNameFilter & pAnd & GetFundNameFilter
    Me.RecordSource = "SELECT * FROM Obligations WHERE" & Me.Filter
    Me.Requery
    Me.FocNameComboBox.RowSource = "SELECT DISTINCT Obligations.FocName" _
        & " FROM Obligations" _
        & " WHERE " & Me.Filter
    Me.AccountCodeComboBox.RowSource = "SELECT DISTINCT Obligations.AccountCode" _
        & " FROM Obligations" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
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
        FocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        AccountCodeFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        AccountCodeFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter _
            & pAnd & FocNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        AccountCodeFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter _
                & pAnd & FocNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not AccountCodeFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter _
                & pAnd & FocNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & AccountCodeFilter
    End If
    If Not FundNameFilter & "" = "" And _
        FocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not AccountCodeFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & AccountCodeFilter
    End If
    If Not FundNameFilter & "" = "" And _
        FocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not AccountCodeFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter _
                & pAnd & AccountCodeFilter
    End If
    If Not FundNameFilter & "" = "" And _
        FocNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        AccountCodeFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FocNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not AccountCodeFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter _
                & pAnd & FocNameFilter _
                & pAnd & AccountCodeFilter
    End If
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="GetFundNameFilter()"
    Exit Function
End Function





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
'   Type        Event Sub-Procedure
'   Name        FiscalYearOptionGroup_AfterUpdate
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub FiscalYearOptionGroup_AfterUpdate()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.Filter = vbNullString
    FiscalYearFilter = vbNullString
    Select Case FiscalYearOptionGroup.Value
        Case 1
            FiscalYearFilter = "[BFY] = '2021'"
            Args.BFY = "2021"
            Me.Filter = RpioNameFilter & pAnd & GetFiscalYearFilter
            Me.RecordSource = "SELECT * FROM Obligations WHERE " & Me.Filter
            Me.Requery
        Case 2
            FiscalYearFilter = "[BFY] = '2022'"
            Args.BFY = "2022"
            Me.Filter = RpioNameFilter & pAnd & GetFiscalYearFilter
            Me.RecordSource = "SELECT * FROM Obligations WHERE " & Me.Filter
            Me.Requery
        Case Else
            FiscalYearFilter = "[BFY] = '2022'"
            Args.BFY = "2022"
            Me.Filter = RpioNameFilter & pAnd & GetFiscalYearFilter
            Me.RecordSource = "SELECT * FROM Obligations WHERE " & Me.Filter
            Me.Requery
    End Select
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="FiscalYearOptionGroup_AfterUpdate()"
    Exit Sub
End Sub



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
        AccountCodeFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        FocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not AccountCodeFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        FocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & AccountCodeFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not AccountCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        FocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & AccountCodeFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        AccountCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        FocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
            & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        AccountCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not FocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & FundNameFilter _
                & pAnd & FocNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not AccountCodeFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not FocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & AccountCodeFilter _
                & pAnd & FundNameFilter _
                & pAnd & FocNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        AccountCodeFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not FocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & FocNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not AccountCodeFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not FocNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & AccountCodeFilter _
                & pAnd & FocNameFilter
    End If
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="GetFiscalYearFilter()"
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
    ProcessError Name:="FiananceClassObligationForm", _
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
    ProcessError Name:="FiananceClassObligationForm", _
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
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="MenuButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type        Event Sub-Procedure
'   Name        OriginalActionDateTextBox_Click
'   Parameters  Void
'   Retval      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub OriginalActionDateTextBox_Click()
    On Error GoTo ErrorHandler:
    DoCmd.OpenForm "BudgetCalendar", , , , , , Me.OriginalActionDateTextBox
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="OriginalActionDateTextBox_Click()"
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
    ResetOptionGroupValues
    Me.Filter = GetFiscalYearFilter
    Me.AccountCodeComboBox.RowSource = "SELECT DISTINCT Obligations.AccountCode FROM Obligations"
    Me.FocNameComboBox.RowSource = "SELECT DISTINCT Obligations.FocName FROM Obligations"
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT Obligations.FundName FROM Obligations"
    Me.RecordSource = "SELECT * FROM Obligations" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="FiananceClassObligationForm", _
        Member:="RefreshButton_Click()"
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
    ProcessError Name:="FiananceClassObligationForm", _
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
    ProcessError Name:="FiananceClassObligationForm", _
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
    p_Worksheet.Name = "Obligations By FOC"
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
    ProcessError Name:="FiananceClassObligationForm", _
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
    ProcessError Name:="FiananceClassObligationForm", _
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
    ProcessError Name:="FiananceClassObligationForm", _
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
    ProcessError Name:="FiananceClassObligationForm", _
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




