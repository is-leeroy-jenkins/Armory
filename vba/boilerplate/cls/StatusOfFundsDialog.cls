Option Compare Database
Option Explicit





Public Args As AccountArgs
Private FiscalYearFilter As String
Private RpioNameFilter As String
Private FundNameFilter As String
Private m_FundCode As String
Private pAnd As String
Private m_Error As String
Private m_Notification As String
Private m_RpioCode As String




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Load
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler:
    ClearComboBoxValues
    SetComboBoxColors
    pAnd = " AND "
    Set Args = New AccountArgs
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.RpioName" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.RpioCode" _
        & " IN ('01', '02', '03', '04', '05', '06', '07', '08', '09', '10');"
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.FundName As FundName" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.RpioCode" _
        & " IN ('01', '02', '03', '04', '05', '06', '07', '08', '09', '10');"
    Me.FiscalYearOptionGroup.DefaultValue = 2
    Me.FiscalYearOptionGroup.Value = 2
    Me.RpioOptionGroup.DefaultValue = 2
    Me.RpioOptionGroup.Value = 2
    Args.BFY = "2022"
ErrorHandler:
    ProcessError Name:="StatusOfFundsDialog", _
        Member:="Form_Load()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
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
    Select Case Me.FiscalYearOptionGroup.Value
        Case 1
            FiscalYearFilter = "[BFY] = '2021'"
            Args.BFY = "2021"
        Case 2
            FiscalYearFilter = "[BFY] = '2022'"
            Args.BFY = "2022"
    End Select
ErrorHandler:
    ProcessError Name:="StatusOfFundsDialog", _
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
Private Function GetFiscalYearFilter() As String
    On Error GoTo ErrorHandler:
    If Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter
    End If
ErrorHandler:
    ProcessError Name:="StatusOfFundsDialog", _
        Member:="GetFiscalYearFilter()"
    Exit Function
End Function




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        FiscalYearOptionGroup_AfterUpdate
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub RpioOptionGroup_AfterUpdate()
    On Error GoTo ErrorHandler:
    Select Case Me.RpioOptionGroup.Value
        Case 1
            Me.RpioNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.RpioName" _
                & " FROM StatusOfFunds" _
                & " WHERE StatusOfFunds.RpioCode" _
                & " NOT IN ('01', '02', '03', '04', '05', '06', '07', '08', '09', '10');"
            Me.FundNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.FundName" _
                & " FROM StatusOfFunds" _
                & " WHERE StatusOfFunds.RpioCode" _
                & " NOT IN ('01', '02', '03', '04', '05', '06', '07', '08', '09', '10');"
        Case 2
            Me.RpioNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.RpioName" _
                & " FROM StatusOfFunds" _
                & " WHERE StatusOfFunds.RpioCode" _
                & " IN ('01', '02', '03', '04', '05', '06', '07', '08', '09', '10');"
            Me.FundNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.FundName" _
                & " FROM StatusOfFunds" _
                & " WHERE StatusOfFunds.RpioCode" _
                & " NOT IN ('01', '02', '03', '04', '05', '06', '07', '08', '09', '10');"
    End Select
ErrorHandler:
    ProcessError Name:="StatusOfFundsDialog", _
        Member:="RpioOptionGroup_AfterUpdate()"
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
        Set Args = New AccountArgs
    End If
    Args.RpioName = Me.RpioNameComboBox.Value
    Args.RpioCode = DLookup("RpioCode", "StatusOfFunds", _
        "[RpioName] = '" & Args.RpioName & "'")
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT StatusOfFunds.FundName" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.RpioName = '" & Args.RpioName & "'" _
        & " AND StatusOfFunds.BFY = '" & Args.BFY & "'"
ErrorHandler:
    ProcessError Name:="StatusOfFundsDialog", _
        Member:="RpioNameComboBox_Change()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        FundNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FundNameComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Args.FundName = Me.FundNameComboBox.Value
ErrorHandler:
    ProcessError Name:="StatusOfFundsDialog", _
        Member:="FundNameComboBox_Change()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExecuteButton_OnClick
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub AcceptButton_Click()
    On Error GoTo ErrorHandler:
    Me.Visible = Not Me.Visible
ErrorHandler:
    ProcessError Name:="StatusOfFundsDialog", _
        Member:="AcceptButton_Click()"
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
    ClearComboBoxValues
    ClearFilterValues
    ResetOptionGroupValues
ErrorHandler:
    ProcessError Name:="StatusOfFundsDialog", _
        Member:="RefreshButton_Click()"
    Exit Sub
End Sub


'---------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SetComboBoxColors
'   Parameters:  Void
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
ErrorHandler:
    ProcessError Name:="StatusOfFundsDialog", _
        Member:="SetComboBoxColors()"
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
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.FiscalYearOptionGroup.Value = 2
    Me.RpioOptionGroup.Value = 2
    Args.BFY = "2022"
ErrorHandler:
    ProcessError Name:="StatusOfFundsDialog", _
        Member:="ResetOptionGroupValues()"
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
    ProcessError Name:="StatusOfFundsDialog", _
        Member:="ClearComboBoxValues()"
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
    FiscalYearFilter = vbNullString
    RpioNameFilter = vbNullString
    FundNameFilter = vbNullString
    Me.Filter = vbNullString
ErrorHandler:
    ProcessError Name:="StatusOfFundsDialog", _
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
    DoCmd.Close acForm, Me.Name
ErrorHandler:
    ProcessError Name:="StatusOfFundsDialog", _
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





