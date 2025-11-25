Option Compare Database
Option Explicit



Public Args As AccountArgs
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



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        FundNameComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler:
    pAnd = " AND "
    Set Args = New AccountArgs
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="Form_Load()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        OraButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub OraButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06A'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="OraButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ArdButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ArdButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06J'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="ArdButton_Click()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        OrcButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub OrcButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06D'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="OrcButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        SemdButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SemdButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06L'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="SemdButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        WcfButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub WcfButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06G'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="WcfButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        WdButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub WdButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06K'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="WdButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        OejtaButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub OejtaButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06F'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="OejtaButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        WsaButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub WsaButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06N'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="WsaButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        EcadButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub EcadButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06M'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="EcadButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        XaButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub XaButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06X'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="XaButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        MdrButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub MdrButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06R'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="MdrButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        LcardButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub LcardButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06B'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="LcardButton_Click()"
    Exit Sub
End Sub






'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        LsasdButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub LsasdButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06H'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="LsasdButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        MsdButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub MsdButton_Click()
    On Error GoTo ErrorHandler:
    Dim Form As New Form_HeadquartersAllocations
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="HeadquartersAllocations", _
        WindowMode:=acDialog, _
        OpenArgs:="[RcCode] = '06C'"
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="MsdButton_Click()"
    Exit Sub
End Sub






'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        MsdButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub MainButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
    DoCmd.OpenForm FormName:="Main", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="HeadquartersMenu", 
        Member:="MainButton_Click()"
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







