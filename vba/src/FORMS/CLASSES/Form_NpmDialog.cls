
Option Compare Database
Option Explicit





Public Args As AccountArgs
Private m_BFY As String
Private m_RpioName As String
Private m_RpioCode As String
Private m_FundName As String
Private m_FundCode As String
Private m_BocName As String
Private pAnd As String
Private m_Error As String
Private m_Notification As String
Private m_RPIO As String




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
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT HeadquartersAuthority.RpioName" _
        & " FROM HeadquartersAuthority;"
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT HeadquartersAuthority.FundName" _
        & " FROM HeadquartersAuthority;"
    SetFiscalYearFilter (2)
ErrorHandler:
    ProcessError Name:="NpmDialog", _
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
    m_BFY = vbNullString
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    SetFiscalYearFilter (Me.FiscalYearOptionGroup.Value)
ErrorHandler:
    ProcessError Name:="NpmDialog", _
        Member:="FiscalYearOptionGroup_AfterUpdate()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SetFiscalYearFilter()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetFiscalYearFilter(pBFY As Integer)
    On Error GoTo ErrorHandler:
    If IsNumeric(pBFY) And _
        pBFY > 0 And _
        pBFY < 3 Then
        Select Case pBFY
            Case 1
                m_BFY = "[BFY] = '2021'"
                Args.BFY = "2021"
            Case 2
                m_BFY = "[BFY] = '2022'"
                Args.BFY = "2022"
            Case Else
                m_BFY = "[BFY] = '2022'"
                Args.BFY = "2022"
        End Select
    End If
ErrorHandler:
    ProcessError Name:="NpmDialog", _
        Member:="SetFiscalYearFilter()"
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
    If Not m_BFY & "" = "" And _
        Not m_RpioName & "" = "" And _
        Not m_FundName & "" = "" Then
            GetFiscalYearFilter = m_BFY _
                & pAnd & m_RpioName _
                & pAnd & m_FundName
    End If
    If Not m_BFY & "" = "" And _
        m_RpioName & "" = "" And _
        Not m_FundName & "" = "" Then
            GetFiscalYearFilter = m_BFY _
                & pAnd & m_FundName
    End If
    If Not m_BFY & "" = "" And _
        Not m_RpioName & "" = "" And _
        m_FundName & "" = "" Then
            GetFiscalYearFilter = m_BFY _
                & pAnd & m_RpioName
    End If
ErrorHandler:
    ProcessError Name:="NpmDialog", _
        Member:="GetFiscalYearFilter()"
    Exit Function
End Function





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
    Args.RpioCode = DLookup("RpioCode", "HeadquartersAuthority", _
        "HeadquartersAuthority.RpioName = '" & Me.RpioNameComboBox.Value & "'")
    m_RpioName = "[RpioName] = '" & Me.RpioNameComboBox.Value & "'"
ErrorHandler:
    ProcessError Name:="NpmDialog", _
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
    If Not m_RpioName & "" = "" And _
        Not m_FundName & "" = "" And _
        Not m_BFY & "" = "" Then
            GetRpioNameFilter = m_RpioName _
                & pAnd & m_FundName _
                & pAnd & m_BFY
    End If
    If Not m_RpioName & "" = "" And _
        m_FundName & "" = "" And _
        Not m_BFY & "" = "" Then
            GetRpioNameFilter = m_RpioName _
                & pAnd & m_BFY
    End If
    If Not m_RpioName & "" = "" And _
        Not m_FundName & "" = "" And _
        m_BFY & "" = "" Then
            GetRpioNameFilter = m_RpioName _
                & pAnd & m_FundName
    End If
ErrorHandler:
    ProcessError Name:="NpmDialog", _
        Member:="GetRpioNameFilter()"
    Exit Function
End Function





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
    m_FundCode = DLookup("FundCode", "HeadquartersAuthority", _
        "HeadquartersAuthority.FundName = '" & Me.FundNameComboBox.Value & "'")
    m_FundName = "[FundName] = '" & Me.FundNameComboBox.Value & "'"
    Args.FundName = Me.FundNameComboBox.Value
    Args.FundCode = m_FundCode
ErrorHandler:
    ProcessError Name:="NpmDialog", _
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
    If Not m_FundName & "" = "" And _
        Not m_RpioName & "" = "" And _
        Not m_BFY & "" = "" Then
            GetFundNameFilter = m_FundName _
                & pAnd & m_RpioName _
                & pAnd & m_BFY
    End If
    If Not m_FundName & "" = "" And _
        m_RpioName & "" = "" And _
        Not m_BFY & "" = "" Then
            GetFundNameFilter = m_FundName _
                & pAnd & m_BFY
    End If
    If Not m_FundName & "" = "" And _
        Not m_RpioName & "" = "" And _
        m_BFY & "" = "" Then
            GetFundNameFilter = m_FundName _
                & pAnd & m_RpioName
    End If
ErrorHandler:
    ProcessError Name:="NpmDialog", _
        Member:="GetFundNameFilter()"
    Exit Function
End Function





'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExecuteButton_OnClick
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub AcceptButton_Click()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    If Args.BFY & "" = "" And _
     Not Me.FiscalYearOptionGroup.Value & "" = "" Then
        SetFiscalYearFilter (Me.FiscalYearOptionGroup.Value)
    End If
    If Args.RpioName & "" = "" Then
        Args.RpioName = Me.RpioNameComboBox.Value
    End If
    Me.Visible = Not Me.Visible
ErrorHandler:
    ProcessError Name:="NpmDialog", _
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
    ClearOptionGroupValues
ErrorHandler:
    ProcessError Name:="NpmDialog", _
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
    ProcessError Name:="NpmDialog", _
        Member:="SetComboBoxColors()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ClearOptionGroupValues
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearOptionGroupValues()
    On Error GoTo ErrorHandler:
    Me.FiscalYearOptionGroup.Value = 2
ErrorHandler:
    ProcessError Name:="NpmDialog", _
        Member:="ClearOptionGroupValues()"
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
    ProcessError Name:="NpmDialog", _
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
    m_BFY = vbNullString
    m_RpioName = vbNullString
    m_FundName = vbNullString
    m_BocName = vbNullString
    Me.Filter = vbNullString
ErrorHandler:
    ProcessError Name:="NpmDialog", _
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
    ProcessError Name:="NpmDialog", _
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
            MessageFactory.ShowError (m_Error)
            Err.Clear
    End If
    If Err.Number <> 0 And _
        IsMissing(Name) And _
        IsMissing(Member) Then
            m_Error = "Source:      " & Err.Source _
                & vbCrLf & "Number:     " & Err.Number _
                & vbCrLf & "Issue:      " & Err.Description
            MessageFactory.ShowError (m_Error)
            Err.Clear
    End If
End Sub







