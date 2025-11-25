Option Compare Database
Option Explicit


Public Args As SiteArgs
Public RpioNameFilter As String
Public SiteNameFilter As String
Public StateFilter As String
Public BocNameFilter As String
Private m_RpioName As String
Private m_BocName As String
Private m_SiteName As String
Private m_State As String
Private pAnd As String
Private m_Error As String






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
    Set Args = New SiteArgs
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT SiteActivity.RpioName FROM SiteActivity"
    Me.SiteNameComboBox.RowSource = "SELECT DISTINCT SiteActivity.SiteProjectName FROM SiteActivity"
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT SiteActivity.BocName FROM SiteActivity"
    Me.StateComboBox.RowSource = "SELECT DISTINCT SiteActivity.State FROM SiteActivity"
ErrorHandler:
    ProcessError Name:="SiteDialog", _
        Member:="Form_Load"
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
    Me.Filter = vbNullString
    RpioNameFilter = vbNullString
    RpioNameFilter = "[RpioName] = '" _
        & Me.RpioNameComboBox.Value & "'"
    Me.Filter = GetRpioNameFilter
    Args.RpioName = Me.RpioNameComboBox.Value
    Me.SiteNameComboBox.RowSource = "SELECT DISTINCT SiteActivity.SiteProjectName" _
        & " FROM SiteActivity WHERE " _
        & Me.Filter
    Me.StateComboBox.RowSource = "SELECT DISTINCT SiteActivity.State" _
        & " FROM SiteActivity WHERE " _
        & Me.Filter
    SetButtonVisibility
ErrorHandler:
    ProcessError Name:="SiteDialog", _
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
        Not SiteNameFilter & "" & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not StateFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & SiteNameFilter _
                & pAnd & BocNameFilter _
                & pAnd & StateFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not SiteNameFilter & "" & "" = "" And _
        BocNameFilter & "" = "" And _
        Not StateFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & SiteNameFilter _
                & pAnd & StateFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        SiteNameFilter & "" & "" = "" And _
        Not BocNameFilter & "" = "" And _
        StateFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & BocNameFilter
    End If
ErrorHandler:
    ProcessError Name:="SiteDialog", _
        Member:="GetRpioNameFilter()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SiteNameComboBox_Change()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SiteNameComboBox_Change()
    On Error GoTo ErrorHandler:
    Me.Filter = vbNullString
    SiteNameFilter = "[SiteProjectName] = '" _
        & Me.SiteNameComboBox.Value & "'"
    m_SiteName = Me.SiteNameComboBox.Value
    Me.Filter = GetSiteNameFilter
    Args.SiteProjectName = m_SiteName
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT SiteActivity.BocName" _
        & " FROM SiteActivity WHERE " _
        & Me.Filter
ErrorHandler:
    ProcessError Name:="SiteDialog", _
        Member:="SiteNameComboBox_Change()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetRpioNameFilter
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetSiteNameFilter() As String
    On Error GoTo ErrorHandler:
    If Not SiteNameFilter & "" = "" And _
        Not StateFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetSiteNameFilter = BocNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not SiteNameFilter & "" = "" And _
        StateFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetSiteNameFilter = RpioNameFilter _
                & pAnd & BocNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not SiteNameFilter & "" = "" And _
        Not StateFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetSiteNameFilter = SiteNameFilter _
                & pAnd & StateFilter
    End If
    If Not SiteNameFilter & "" = "" And _
        Not StateFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetSiteNameFilter = SiteNameFilter _
                & pAnd & StateFilter _
                & pAnd & RpioNameFilter
    End If
    If Not SiteNameFilter & "" = "" And _
        StateFilter & "" = "" And _
        BocNameFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetSiteNameFilter = SiteNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not SiteNameFilter & "" = "" And _
        Not StateFilter & "" = "" And _
        Not BocNameFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetSiteNameFilter = SiteNameFilter _
                & pAnd & StateFilter _
                & pAnd & BocNameFilter
    End If
ErrorHandler:
    ProcessError Name:="SiteDialog", _
        Member:="GetSiteNameFilter()"
    Exit Function
End Function

'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        BocNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub StateComboBox_Change()
    On Error GoTo ErrorHandler:
    Me.Filter = vbNullString
    StateFilter = vbNullString
    m_State = Me.StateComboBox.Value
    Args.State = m_State
ErrorHandler:
    ProcessError Name:="SiteDialog", _
        Member:="StateComboBox_Change()"
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        BocNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub BocNameComboBox_Change()
    On Error GoTo ErrorHandler:
    Me.Filter = vbNullString
    BocNameFilter = vbNullString
    m_BocName = Me.BocNameComboBox.Value
    Args.BocName = m_BocName
ErrorHandler:
    ProcessError Name:="SiteDialog", _
        Member:="BocNameComboBox_Change()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetBocNameFilter
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetBocNameFilter() As String
    On Error GoTo ErrorHandler:
    If Not BocNameFilter & "" = "" And _
        Not SiteNameFilter & "" & "" = "" And _
        Not StateFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & StateFilter _
                & pAnd & RpioNameFilter
    End If
    If BocNameFilter & "" = "" And _
        Not StateFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetBocNameFilter = StateFilter _
                & pAnd & RpioNameFilter
    End If
    If BocNameFilter & "" = "" And _
        StateFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetBocNameFilter = RpioNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        StateFilter & "" = "" And _
        Not RpioNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & RpioNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        Not StateFilter & "" = "" And _
        RpioNameFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & StateFilter
    End If
ErrorHandler:
    ProcessError Name:="SiteDialog", _
        Member:="GetBocNameFilter()"
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
    Me.Visible = Not Me.Visible
ErrorHandler:
    ProcessError Name:="SiteDialog", _
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
ErrorHandler:
    ProcessError Name:="SiteDialog", _
        Member:="RefreshButton_Click()"
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
    Me!BocNameComboBox.ForeColor = RGB(255, 255, 255)
    Me!BocNameComboBox.BackColor = RGB(33, 33, 33)
    Me!BocNameComboBox.BorderColor = RGB(68, 114, 196)
    Me!RpioNameComboBox.ForeColor = RGB(255, 255, 255)
    Me!RpioNameComboBox.BackColor = RGB(33, 33, 33)
    Me!RpioNameComboBox.BorderColor = RGB(68, 114, 196)
    Me!SiteNameComboBox.ForeColor = RGB(255, 255, 255)
    Me!SiteNameComboBox.BackColor = RGB(33, 33, 33)
    Me!SiteNameComboBox.BorderColor = RGB(68, 114, 196)
    Me!StateComboBox.ForeColor = RGB(255, 255, 255)
    Me!StateComboBox.BackColor = RGB(33, 33, 33)
    Me!StateComboBox.BorderColor = RGB(68, 114, 196)
ErrorHandler:
    ProcessError Name:="SiteDialog", _
        Member:="SetComboBoxColors()"
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
    Me.ExitButton.SetFocus
    Me.RefreshButton.Visible = Not Me.RefreshButton.Visible
    Me.AcceptButton.Visible = Not Me.AcceptButton.Visible
ErrorHandler:
    ProcessError Name:="SiteDialog", _
        Member:="SetButtonVisibility()"
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
    Me.SiteNameComboBox.Value = vbNullString
    Me.StateComboBox.Value = vbNullString
    Me.BocNameComboBox.Value = vbNullString
    Me.RpioNameComboBox.Value = vbNullString
ErrorHandler:
    ProcessError Name:="SiteDialog", _
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
    SiteNameFilter = vbNullString
    BocNameFilter = vbNullString
    StateFilter = vbNullString
    Me.Filter = vbNullString
ErrorHandler:
    ProcessError Name:="SiteDialog", _
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
    ClearFilterValues
    DoCmd.Close acForm, Me.Name
ErrorHandler:
    ProcessError Name:="SiteDialog", _
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






