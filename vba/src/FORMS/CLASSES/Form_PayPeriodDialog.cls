VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_PayPeriodDialog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit


Public Args As PayrollArgs
Private FiscalYearFilter As String
Private FundNameFilter As String
Private RpioNameFilter As String
Private PayPeriodFilter As String
Private pAnd As String
Private m_Error As String
Private m_Notification As String







'---------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        FundNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    pAnd = " AND "
    If Args Is Nothing Then
        Set Args = New PayrollArgs
    End If
    FiscalYearFilter = "[BFY] = '2022'"
    Me.Filter = FiscalYearFilter
    Args.BFY = "2022"
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT UCase(PayrollObligations.RpioName)" _
        & " FROM PayrollObligations" _
        & " WHERE " & Me.Filter
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT UCase(PayrollObligations.FundName)" _
        & " FROM PayrollObligations" _
        & " WHERE " & Me.Filter
    Me.PayPeriodComboBox.RowSource = "SELECT DISTINCT PayrollObligations.PayPeriod" _
        & " FROM PayrollObligations" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
        Member:="Form_Open"
    Exit Sub
End Sub


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
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
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
    Me.RpioNameComboBox.ForeColor = RGB(255, 255, 255)
    Me.RpioNameComboBox.BackColor = RGB(33, 33, 33)
    Me.RpioNameComboBox.BorderColor = RGB(68, 114, 196)
    Me.PayPeriodComboBox.ForeColor = RGB(255, 255, 255)
    Me.PayPeriodComboBox.BackColor = RGB(33, 33, 33)
    Me.PayPeriodComboBox.BorderColor = RGB(68, 114, 196)
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
        Member:="SetComboBoxColors()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        AcceptButton_Click
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
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ExitButton_Click()
    On Error GoTo ErrorHandler:
    ClearFilterValues
    DoCmd.Close acForm, Me.Name
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
        Member:="ExitButton_Click()"
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        FundNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub RpioNameComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New PayrollArgs
    End If
    RpioNameFilter = vbNullString
    Args.RpioName = Me.RpioNameComboBox.Value
    Args.RcCode = DLookup("RcCode", "PayrollObligations", "PayrollObligations.RpioName = '" _
        & Me.RpioNameComboBox.Value & "'")
    RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
    Me.Filter = GetRpioNameFilter
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT UCase(PayrollObligations.FundName)" _
        & " FROM PayrollObligations" _
        & " WHERE " & Me.Filter
    Me.PayPeriodComboBox.RowSource = "SELECT DISTINCT PayrollObligations.PayPeriod" _
        & " FROM PayrollObligations" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
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
Private Function GetRpioNameFilter() As String
    On Error GoTo ErrorHandler:
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter _
                & pAnd & PayPeriodFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & PayPeriodFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        PayPeriodFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        PayPeriodFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter
    End If
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
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
        Set Args = New PayrollArgs
    End If
    FundNameFilter = vbNullString
    Args.FundName = Me.FundNameComboBox.Value
    FundNameFilter = "[FundName] = '" & Me.FundNameComboBox.Value & "'"
    Me.Filter = GetFundNameFilter
    Me.PayPeriodComboBox.RowSource = "SELECT DISTINCT PayrollObligations.PayPeriod" _
        & " FROM PayrollObligations" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
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
        Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" Then
            GetFundNameFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & PayPeriodFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        PayPeriodFilter & "" = "" Then
            GetFundNameFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        PayPeriodFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not PayPeriodFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter _
                & pAnd & PayPeriodFilter
    End If
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
        Member:="GetFundNameFilter()"
    Exit Function
End Function


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        FundNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub PayPeriodComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New PayrollArgs
    End If
    PayPeriodFilter = vbNullString
    Args.PayPeriod = Me.PayPeriodComboBox.Value
    PayPeriodFilter = "[PayPeriod] = '" & Args.PayPeriod & "'"
    Me.Filter = GetPayPeriodFilter
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT UCase(PayrollObligations.RpioName)" _
        & " FROM PayrollObligations" _
        & " WHERE " & Me.Filter
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT UCase(PayrollObligations.FundName)" _
        & " FROM PayrollObligations" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
        Member:="PayPeriodComboBox_Change()"
    Exit Sub
End Sub




'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetPayPeriodFilter
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetPayPeriodFilter() As String
    On Error GoTo ErrorHandler:
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetPayPeriodFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetPayPeriodFilter = RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetPayPeriodFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetPayPeriodFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetPayPeriodFilter = RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetPayPeriodFilter = RpioNameFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" Then
            GetPayPeriodFilter = RpioNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" Then
            GetPayPeriodFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
        Member:="GetPayPeriodFilter()"
    Exit Function
End Function




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
        Set Args = New PayrollArgs
    End If
    Me.FiscalYearOptionGroup.Value = 2
    FiscalYearFilter = "[BFY] = '2022'"
    Args.BFY = "2022"
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
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
Private Sub FiscalYearOptionGroup_AfterUpdate()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New PayrollArgs
    End If
    FiscalYearFilter = vbNullString
    Args.BFY = vbNullString
    Select Case Me.FiscalYearOptionGroup.Value
        Case 1
            Args.BFY = "2021"
            FiscalYearFilter = "[BFY] = '2021'"
        Case 2
            Args.BFY = "2022"
            FiscalYearFilter = "[BFY] = '2022'"
    End Select
    Me.Filter = GetFiscalYearFilter
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT UCase(PayrollObligations.RpioName)" _
        & " FROM PayrollObligations" _
        & " WHERE " & Me.Filter
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT UCase(PayrollObligations.FundName)" _
        & " FROM PayrollObligations" _
        & " WHERE " & Me.Filter
    Me.PayPeriodComboBox.RowSource = "SELECT DISTINCT PayrollObligations.PayPeriod" _
        & " FROM PayrollObligations" _
        & " WHERE " & Me.Filter
    Me.RecordSource = "SELECT * FROM PayrollObligations" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
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
        RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & FundNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter
    End If
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
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
    ResetOptionGroupValues
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT UCase(PayrollObligations.RpioName)" _
        & " FROM PayrollObligations;"
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT UCase(PayrollObligations.FundName)" _
        & " FROM PayrollObligations;"
    Me.PayPeriodComboBox.RowSource = "SELECT DISTINCT PayrollObligations.PayPeriod" _
        & " FROM PayrollObligations;"
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
        Member:="RefreshButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ClearComboBoxValues
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearComboBoxValues()
    On Error GoTo ErrorHandler:
    Me.FundNameComboBox.Value = vbNullString
    Me.RpioNameComboBox.Value = vbNullString
    Me.PayPeriodComboBox.Value = vbNullString
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
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
    RpioNameFilter = vbNullString
    FundNameFilter = vbNullString
    PayPeriodFilter = vbNullString
ErrorHandler:
    ProcessError Name:="PayPeriodDialog", _
        Member:="ClearFilterValues()"
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




