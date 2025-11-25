VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_RegionalOffice"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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
    Me.Tag = "Division"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '16'"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '06J'"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '06D'"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '06L'"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '06G'"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '06K'"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '06F'"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '06N'"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '06M'"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '06X'"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '06R'"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '06B'"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '06H'"
ErrorHandler:
    ProcessError
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
        OpenArgs:="[RpioCode] = '06C'"
ErrorHandler:
    ProcessError
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
    ProcessError
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





