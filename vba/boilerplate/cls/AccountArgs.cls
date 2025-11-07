
Option Compare Database
Option Explicit




Private m_PrcId As Integer
Private m_BFY As String
Private m_RpioCode As String
Private m_RpioName As String
Private m_BudgetLevel As String
Private m_AhCode As String
Private m_AhName As String
Private m_FundCode As String
Private m_FundName As String
Private m_OrgCode As String
Private pAccountCode As String
Private m_BocCode As String
Private m_BocName As String
Private m_RcCode As String
Private m_DivisionName As String
Private m_ActivityCode As String
Private m_ProgramProjectName As String
Private m_StartDate As String
Private m_EndDate As String
Private m_Error As String




Public Sub Class_Initialize()
End Sub

Public Sub Class_Terminate()
End Sub




'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            ID
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let ID(pid As Integer)
    On Error GoTo ErrorHandler:
    If Not pid < 0 Then
        m_PrcId = pid
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="ID"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name            ID
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get ID() As Integer
    On Error GoTo ErrorHandler:
    If Not m_PrcId < 0 Then
        ID = m_PrcId
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="ID"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            BFY
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let BFY(yr As String)
    On Error GoTo ErrorHandler:
    If Not yr & "" = "" Then
        m_BFY = yr
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="BFY"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name            BFY
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get BFY() As String
    On Error GoTo ErrorHandler:
    If Not m_BFY & "" = "" Then
        BFY = m_BFY
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="BFY"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            BudgetLevel
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let BudgetLevel(bl As String)
    On Error GoTo ErrorHandler:
    If Not bl & "" = "" Then
        m_BudgetLevel = bl
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="BudgetLevel"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name            BudgetLevel
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get BudgetLevel() As String
    On Error GoTo ErrorHandler:
    If Not m_BudgetLevel & "" = "" Then
        BudgetLevel = m_BudgetLevel
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="BudgetLevel"
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
    ProcessError Name:="AccountArgs", _
        Member:="RpioName"
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
    ProcessError Name:="AccountArgs", _
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
    ProcessError Name:="AccountArgs", _
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
    ProcessError Name:="AccountArgs", _
        Member:="RpioCode"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            AhCode
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let AhCode(ac As String)
    On Error GoTo ErrorHandler:
    If Not ac & "" = "" Then
        m_AhCode = ac
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="AhCode"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name            AhCode
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get AhCode() As String
    On Error GoTo ErrorHandler:
    If Not m_AhCode & "" = "" Then
        AhCode = m_AhCode
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="AhCode"
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
    ProcessError Name:="AccountArgs", _
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
    ProcessError Name:="AccountArgs", _
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
    ProcessError Name:="AccountArgs", _
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
    ProcessError Name:="AccountArgs", _
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
    ProcessError Name:="AccountArgs", _
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
    ProcessError Name:="AccountArgs", _
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
        pAccountCode = ac
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
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
    If Not pAccountCode & "" = "" Then
        AccountCode = pAccountCode
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
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
Public Property Let ActivityCode(act As String)
    On Error GoTo ErrorHandler:
    If act & "" = "" Then
        m_ActivityCode = act
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="ActivityCode"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get ActivityCode() As String
    On Error GoTo ErrorHandler:
    If Not m_ActivityCode & "" = "" Then
        ActivityCode = m_ActivityCode
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="ActivityCode"
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
    ProcessError Name:="AccountArgs", _
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
    ProcessError Name:="AccountArgs", _
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
    ProcessError Name:="AccountArgs", _
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
    ProcessError Name:="AccountArgs", _
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
Public Property Let RcCode(RC As String)
    On Error GoTo ErrorHandler:
    If Not RC & "" = "" Then
        m_RcCode = RC
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="RcCode"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get RcCode() As String
    On Error GoTo ErrorHandler:
    If Not m_RcCode & "" = "" Then
        RcCode = m_RcCode
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="RcCode"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let DivisionName(dn As String)
    On Error GoTo ErrorHandler:
    If Not dn & "" = "" Then
        m_DivisionName = dn
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="DivisionName"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get DivisionName() As String
    On Error GoTo ErrorHandler:
    If Not m_DivisionName & "" = "" Then
        DivisionName = m_DivisionName
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="DivisionName"
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
    ProcessError Name:="AccountArgs", _
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
    ProcessError Name:="AccountArgs", _
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
    ProcessError Name:="AccountArgs", _
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
    ProcessError Name:="AccountArgs", _
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
Public Property Let EndDate(pEnd As String)
    On Error GoTo ErrorHandler:
    If Not pEnd & "" = "" Then
        m_EndDate = pEnd
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="EndDate"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Retval          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get EndDate() As String
    On Error GoTo ErrorHandler:
    If Not m_EndDate & "" = "" Then
        EndDate = m_EndDate
    End If
ErrorHandler:
    ProcessError Name:="AccountArgs", _
        Member:="EndDate"
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




