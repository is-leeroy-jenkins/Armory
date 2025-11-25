
Option Compare Database
Option Explicit


<<<<<<< Updated upstream
=======

<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
Public Args As PayrollArgs
Private pAnd As String
Private m_FundCode As String
Private m_FundName As String
Private FundNameFilter As String
Private m_BFY As String
Private FiscalYearFilter As String
Private m_And As String
Private m_Filter As String
Private m_Error As String
Private m_Notification As String
<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======


>>>>>>> Stashed changes
=======


>>>>>>> Stashed changes




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        FundNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler:
    ClearComboBoxValues
    SetComboBoxColors
    pAnd = " AND "
    Set Args = New PayrollArgs
    Me.FiscalYearOptionGroup.DefaultValue = 2
<<<<<<< Updated upstream
<<<<<<< Updated upstream
    FiscalYearFilter = "[BFY] = '2022'"
    Args.BFY = "2022"
=======
    FiscalYearFilter = "[BFY] = '2021'"
    Args.BFY = "2021"
>>>>>>> Stashed changes
=======
    FiscalYearFilter = "[BFY] = '2021'"
    Args.BFY = "2021"
>>>>>>> Stashed changes
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT UCase(StatusOfFunds.FundName)" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BudgetLevel = '7'" _
        & " AND StatusOfFunds.BocCode = '10';"
ErrorHandler:
<<<<<<< Updated upstream
<<<<<<< Updated upstream
    ProcessError Name:="PayrollStatusDialog", _
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
        Member:="Form_Load()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SetComboBoxColors
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetComboBoxColors()
    On Error GoTo ErrorHandler:
    Me.FundNameComboBox.ForeColor = RGB(255, 255, 255)
    Me.FundNameComboBox.BackColor = RGB(33, 33, 33)
    Me.FundNameComboBox.BorderColor = RGB(68, 114, 196)
ErrorHandler:
<<<<<<< Updated upstream
<<<<<<< Updated upstream
    ProcessError Name:="PayrollStatusDialog", _
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
        Member:="SetComboBoxColors()"
    Exit Sub
End Sub


<<<<<<< Updated upstream

'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        AcceptButton_Click
<<<<<<< Updated upstream
=======
'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        AcceptButton_Click
=======
>>>>>>> Stashed changes
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub AcceptButton_Click()
    On Error GoTo ErrorHandler:
    Me.Visible = Not Me.Visible
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
        Member:="AcceptButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExitButton_Click
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
<<<<<<< Updated upstream
<<<<<<< Updated upstream
Private Sub AcceptButton_Click()
    On Error GoTo ErrorHandler:
    Me.Visible = Not Me.Visible
ErrorHandler:
    ProcessError Name:="PayrollStatusDialog", _
        Member:="AcceptButton_Click()"
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
    ClearFilterValues
    DoCmd.Close acForm, Me.Name
ErrorHandler:
    ProcessError Name:="PayrollStatusDialog", _
        Member:="ExitButton_Click()"
    Exit Sub
End Sub

=======
Private Sub ExitButton_Click()
    On Error GoTo ErrorHandler:
    ClearFilterValues
    DoCmd.Close acForm, Me.Name
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
        Member:="ExitButton_Click()"
    Exit Sub
End Sub

>>>>>>> Stashed changes
=======
Private Sub ExitButton_Click()
    On Error GoTo ErrorHandler:
    ClearFilterValues
    DoCmd.Close acForm, Me.Name
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
        Member:="ExitButton_Click()"
    Exit Sub
End Sub

>>>>>>> Stashed changes
'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        FundNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FundNameComboBox_Change()
    On Error GoTo ErrorHandler:
    m_FundName = vbNullString
    Args.FundName = vbNullString
    Me.Filter = vbNullString
    FundNameFilter = vbNullString
    Args.FundName = Me.FundNameComboBox.Value
    Args.FundCode = DLookup("FundCode", "StatusOfFunds", "StatusOfFunds.FundName = '" _
        & Me.FundNameComboBox.Value & "'")
    FundNameFilter = "[FundName] = '" & Me.FundNameComboBox.Value & "'"
ErrorHandler:
<<<<<<< Updated upstream
<<<<<<< Updated upstream
    ProcessError Name:="PayrollStatusDialog", _
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
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
    If Not FundNameFilter = vbNullString And _
        Not FiscalYearFilter = vbNullString Then
            GetFundNameFilter = FundNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not FundNameFilter = vbNullString And _
        FiscalYearFilter = vbNullString Then
            GetFundNameFilter = FundNameFilter
    End If
ErrorHandler:
<<<<<<< Updated upstream
<<<<<<< Updated upstream
    ProcessError Name:="PayrollStatusDialog", _
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
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
Private Sub FiscalYearOptionGroup_AfterUpdate()
    On Error GoTo ErrorHandler:
    Args.BFY = vbNullString
    FiscalYearFilter = vbNullString
    Me.Filter = vbNullString
    Select Case Me.FiscalYearOptionGroup.Value
        Case 1
<<<<<<< Updated upstream
<<<<<<< Updated upstream
            Args.BFY = "2021"
            FiscalYearFilter = "[BFY] = '2021'"
        Case 2
            Args.BFY = "2022"
            FiscalYearFilter = "[BFY] = '2022'"
    End Select
    Me.Filter = GetFiscalYearFilter
ErrorHandler:
    ProcessError Name:="PayrollStatusDialog", _
=======
            Args.BFY = "2020"
            FiscalYearFilter = "[BFY] = '2020'"
        Case 2
            Args.BFY = "2021"
            FiscalYearFilter = "[BFY] = '2021'"
    End Select
    Me.Filter = GetFiscalYearFilter
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
=======
            Args.BFY = "2020"
            FiscalYearFilter = "[BFY] = '2020'"
        Case 2
            Args.BFY = "2021"
            FiscalYearFilter = "[BFY] = '2021'"
    End Select
    Me.Filter = GetFiscalYearFilter
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
        Member:="FiscalYearOptionGroup_AfterUpdate()"
    Exit Sub
End Sub

<<<<<<< Updated upstream
<<<<<<< Updated upstream


=======
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetFiscalYearFilter
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetFiscalYearFilter()
    On Error GoTo ErrorHandler:
<<<<<<< Updated upstream
<<<<<<< Updated upstream
    If Not FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
=======
=======
>>>>>>> Stashed changes
    If Not FiscalYearFilter = vbNullString And _
        FundNameFilter = vbNullString Then
            GetFiscalYearFilter = FiscalYearFilter
    End If
    If Not FiscalYearFilter = vbNullString And _
        Not FundNameFilter = vbNullString Then
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
<<<<<<< Updated upstream
<<<<<<< Updated upstream
    ProcessError Name:="PayrollStatusDialog", _
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
        Member:="GetFiscalYearFilter()"
    Exit Function
End Function



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
    Me.FiscalYearOptionGroup.Value = 2
ErrorHandler:
<<<<<<< Updated upstream
<<<<<<< Updated upstream
    ProcessError Name:="PayrollStatusDialog", _
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
        Member:="RefreshButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ClearComboBoxValues
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearComboBoxValues()
    On Error GoTo ErrorHandler:
    ClearFilterValues
    Me.FundNameComboBox.Value = vbNullString
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT UCase(StatusOfFunds.FundName)" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BocCode = '10';"
ErrorHandler:
<<<<<<< Updated upstream
<<<<<<< Updated upstream
    ProcessError Name:="PayrollStatusDialog", _
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
=======
    ProcessError Name:="PayPeriodDialog", _
>>>>>>> Stashed changes
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
    FundNameFilter = vbNullString
    m_FundName = vbNullString
<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
    Args.FundName = vbNullString
    Args.FundCode = vbNullString
>>>>>>> Stashed changes
=======
    Args.FundName = vbNullString
    Args.FundCode = vbNullString
>>>>>>> Stashed changes
    Me.Filter = vbNullString
ErrorHandler:
    ProcessError Name:="PayrollStatusDialog", _
        Member:="ClearFilterValues()"
    Exit Sub
End Sub




<<<<<<< Updated upstream
<<<<<<< Updated upstream


=======
>>>>>>> Stashed changes





=======
>>>>>>> Stashed changes




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




<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
=======
>>>>>>> Stashed changes




<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
