
Option Compare Database
Option Explicit




Private m_SSID As Integer
Private m_City As String
Private m_RpioCode As String
Private m_RpioName As String
Private m_State As String
Private m_SiteProjectCode As String
Private m_FundCode As String
Private m_FundName As String
Private m_OrgCode As String
Private m_AccountCode As String
Private m_BocCode As String
Private m_BocName As String
Private m_RcCode As String
Private m_OperableUnit As String
Private m_ActionCode As String
Private m_ProgramProjectName As String
Private m_SiteProjectName As String
Private m_StartDate As String
Private m_LastActivityDate As String
Private m_Error As String




Public Sub Class_Initialize()
End Sub

Public Sub Class_Terminate()
End Sub




'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            SSID
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let SSID(pid As Integer)
    On Error GoTo ErrorHandler:
    If Not pid < 0 Then
        m_SSID = pid
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="SSID"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name            SSID
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get SSID() As Integer
    On Error GoTo ErrorHandler:
    If Not m_SSID < 0 Then
        SSID = m_SSID
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="SSID"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            City
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let City(yr As String)
    On Error GoTo ErrorHandler:
    If Not yr & "" = "" Then
        m_City = yr
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="City"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name            City
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get City() As String
    On Error GoTo ErrorHandler:
    If Not m_City & "" = "" Then
        City = m_City
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="City"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            State
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let State(bl As String)
    On Error GoTo ErrorHandler:
    If Not bl & "" = "" Then
        m_State = bl
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="State"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name            State
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get State() As String
    On Error GoTo ErrorHandler:
    If Not m_State & "" = "" Then
        State = m_State
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="State"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            RpioCode
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let RpioName(rn As String)
    On Error GoTo ErrorHandler:
    If Not rn & "" = "" Then
        m_RpioName = rn
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="RpioName"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name            SiteProjectName
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get SiteProjectName() As String
    On Error GoTo ErrorHandler:
    If Not m_SiteProjectName & "" = "" Then
        SiteProjectName = m_SiteProjectName
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="SiteProjectName"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            RpioCode
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let SiteProjectName(rn As String)
    On Error GoTo ErrorHandler:
    If Not rn & "" = "" Then
        m_SiteProjectName = rn
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="SiteProjectName"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name            RpioCode
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get RpioName() As String
    On Error GoTo ErrorHandler:
    If Not m_RpioName & "" = "" Then
        RpioName = m_RpioName
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="RpioName"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            RpioCode
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let RpioCode(rp As String)
    On Error GoTo ErrorHandler:
    If Not rp & "" = "" Then
        m_RpioCode = rp
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="RpioCode"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name            RpioCode
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get RpioCode() As String
    On Error GoTo ErrorHandler:
    If Not m_RpioCode & "" = "" Then
        RpioCode = m_RpioCode
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="RpioCode"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            SiteProjectCode
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let SiteProjectCode(ac As String)
    On Error GoTo ErrorHandler:
    If Not ac & "" = "" Then
        m_SiteProjectCode = ac
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="SiteProjectCode"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name            SiteProjectCode
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get SiteProjectCode() As String
    On Error GoTo ErrorHandler:
    If Not m_SiteProjectCode & "" = "" Then
        SiteProjectCode = m_SiteProjectCode
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="SiteProjectCode"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            OrgCode
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let OrgCode(oc As String)
    On Error GoTo ErrorHandler:
    If Not oc & "" = "" Then
        m_OrgCode = oc
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="OrgCode"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name            OrgCode
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get OrgCode() As String
    On Error GoTo ErrorHandler:
    If Not m_OrgCode & "" = "" Then
        OrgCode = m_OrgCode
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="OrgCode"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let FundCode(fc As String)
    On Error GoTo ErrorHandler:
    If Not fc & "" = "" Then
        m_FundCode = fc
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="FundCode"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get FundCode() As String
    On Error GoTo ErrorHandler:
    If Not m_FundCode & "" = "" Then
        FundCode = m_FundCode
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="FundCode"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let FundName(fn As String)
    On Error GoTo ErrorHandler:
    If Not fn & "" = "" Then
        m_FundName = fn
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="FundName"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get FundName() As String
    On Error GoTo ErrorHandler:
    If Not m_FundName & "" = "" Then
        FundName = m_FundName
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="FundName"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let AccountCode(ac As String)
    On Error GoTo ErrorHandler:
    If Not ac & "" = "" Then
        m_AccountCode = ac
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="AccountCode"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get AccountCode() As String
    On Error GoTo ErrorHandler:
    If Not m_AccountCode & "" = "" Then
        AccountCode = m_AccountCode
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="AccountCode"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let ActionCode(act As String)
    On Error GoTo ErrorHandler:
    If act & "" = "" Then
        m_ActionCode = act
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="ActionCode"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get ActionCode() As String
    On Error GoTo ErrorHandler:
    If Not m_ActionCode & "" = "" Then
        ActionCode = m_ActionCode
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="ActionCode"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let BocCode(bc As String)
    On Error GoTo ErrorHandler:
    If Not bc & "" = "" Then
        m_BocCode = bc
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="BocCode"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get BocCode() As String
    On Error GoTo ErrorHandler:
    If Not m_BocCode & "" = "" Then
        BocCode = m_BocCode
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="BocCode"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let BocName(bn As String)
    On Error GoTo ErrorHandler:
    If Not bn & "" = "" Then
        m_BocName = bn
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="BocName"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get BocName() As String
    On Error GoTo ErrorHandler:
    If Not m_BocName & "" = "" Then
        BocName = m_BocName
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="BocName"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let OperableUnit(dn As String)
    On Error GoTo ErrorHandler:
    If Not dn & "" = "" Then
        m_OperableUnit = dn
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="OperableUnit"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get OperableUnit() As String
    On Error GoTo ErrorHandler:
    If Not m_OperableUnit & "" = "" Then
        OperableUnit = m_OperableUnit
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="OperableUnit"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let ProgramProjectName(pn As String)
    On Error GoTo ErrorHandler:
    If Not pn & "" = "" Then
        m_ProgramProjectName = pn
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="ProgramProjectName"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get ProgramProjectName() As String
    On Error GoTo ErrorHandler:
    If Not m_ProgramProjectName & "" = "" Then
        ProgramProjectName = m_ProgramProjectName
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="ProgramProjectName"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let StartDate(pStart As String)
    On Error GoTo ErrorHandler:
    If Not pStart & "" = "" Then
        m_StartDate = pStart
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="StartDate"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get StartDate() As String
    On Error GoTo ErrorHandler:
    If Not m_StartDate & "" = "" Then
        StartDate = m_StartDate
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="StartDate"
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let LastActivityDate(pEnd As String)
    On Error GoTo ErrorHandler:
    If Not pEnd & "" = "" Then
        m_LastActivityDate = pEnd
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="LastActivityDate"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get LastActivityDate() As String
    On Error GoTo ErrorHandler:
    If Not m_LastActivityDate & "" = "" Then
        LastActivityDate = m_LastActivityDate
    End If
ErrorHandler:
    ProcessError Name:="SiteArgs", _
        Member:="LastActivityDate"
    Exit Property
End Property





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

