VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_Systems"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit



Private m_Error As String



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Load()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler:
    Me.Caption = "System Menu"
ErrorHandler:
    ProcessError Name:="Systems", _
        Member:="Form_Load()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        BfsButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub BfsButton_Click()
    On Error GoTo ErrorHandler:
    Application.FollowHyperlink "https://bfs.epa.gov/Account/Login?ReturnUrl=/"
ErrorHandler:
    ProcessError Name:="Systems", _
        Member:="BfsButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        BusinessObjectsButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub BusinessObjectsButton_Click()
    On Error GoTo ErrorHandler:
    Application.FollowHyperlink "https://ocfoboprodw.epa.gov/BOE/BI"
ErrorHandler:
    ProcessError Name:="Systems", _
        Member:="BusinessObjectsButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        CompassButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub CompassButton_Click()
    On Error GoTo ErrorHandler:
    Application.FollowHyperlink "https://compassmomentum.epa.gov/authservice/login.jsp;"
ErrorHandler:
    ProcessError Name:="Systems", _
        Member:="CompassButton_Click()"
    Exit Sub
End Sub



'---------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ConcurButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ConcurButton_Click()
    On Error GoTo ErrorHandler:
    Application.FollowHyperlink "https://idp.epa.gov/SecureAuth97/"
ErrorHandler:
    ProcessError Name:="Systems", _
        Member:="ConcurButton_Click()"
    Exit Sub
End Sub




'---------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ConcurButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub EBusinessButton_Click()
    On Error GoTo ErrorHandler:
    Application.FollowHyperlink "https://ebusiness.epa.gov/ebusiness/index.cfm?event=home"
ErrorHandler:
    ProcessError Name:="Systems", _
        Member:="EBusinessButton_Click()"
    Exit Sub
End Sub



'---------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ConcurButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub EpaAcquisitionSystemButton_Click()
    On Error GoTo ErrorHandler:
    Application.FollowHyperlink "https://eas.epa.gov/prism.net/Security/logon.aspx"
ErrorHandler:
    ProcessError Name:="Systems", _
        Member:="EpaAcquisitionSysteButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        PeoplePlusButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub PeoplePlusButton_Click()
    On Error GoTo ErrorHandler:
    Application.FollowHyperlink "https://peopleplus.epa.gov/psp/ots92prd/"
ErrorHandler:
    ProcessError Name:="Systems", _
        Member:="PeopPlussButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ProcurementDataSystemButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ProcurementDataSystemButton_Click()
    On Error GoTo ErrorHandler:
    Application.FollowHyperlink "https://www.fpds.gov/fpdsng_cms/index.php/en/"
ErrorHandler:
    ProcessError Name:="Systems", _
        Member:="ProcurementDataSystemButton_Click()"
    Exit Sub
End Sub



'---------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ScorpiosButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ScorpiosButton_Click()
    On Error GoTo ErrorHandler:
    Application.FollowHyperlink "https://usepa.sharepoint.com/sites/OCFO/ots/Pages/SCORPIOS%20e-Recovery.aspx"
ErrorHandler:
    ProcessError Name:="Systems", _
        Member:="ScopriosButton_Click()"
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






