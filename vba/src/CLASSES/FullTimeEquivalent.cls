
Option Compare Database
Option Explicit



Private m_RpioCode As String
Private m_BFY As String
Private m_BudgetLevel As String
Private m_FundCode As String
Private m_AhCode As String
Private m_OrgCode As String
Private m_AccountCode As String
Private m_ActivityCode As String
Private m_BocCode As String
Private m_RcCode As String
Private m_Amount As Double
Private m_Error As String






'----------------------------------------------------------------------------------
'   Type        Contructor/Finalizer
'   Name        Class_Initialize()/Class_Terminate
'   Parameters  Void
'   Retval      AccessData
'   Purpose
'---------------------------------------------------------------------------------
Public Sub Class_Initialize()
End Sub

Public Sub Class_Terminate()
End Sub






'----------------------------------------------------------------------------------
'   Type:        Property Procedure Get
'   Name:
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get BFY() As String
    On Error GoTo ErrorHandler:
    If Not m_BFY & "" = "" Then
        BFY = m_BFY
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="BFY"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Let
'   Name:
'   Parameters:  String
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let BFY(year As String)
    On Error GoTo ErrorHandler:
    If Not year & "" = "" Then
        m_BFY = year
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="BFY"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Get
'   Name:
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get RPIO() As String
    On Error GoTo ErrorHandler:
    If Not m_RpioCode & "" = "" Then
        RPIO = m_RpioCode
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="RPIO"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Let
'   Name:
'   Parameters:  String
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let RPIO(rp As String)
    On Error GoTo ErrorHandler:
    If Not rp & "" = "" Then
        m_RpioCode = rp
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="RPIO"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Let
'   Name:
'   Parameters:  String
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let BudgetLevel(bl As String)
    On Error GoTo ErrorHandler:
    If Not bl & "" = "" Then
        m_BudgetLevel = bl
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="BudgetLevel"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Get
'   Name:
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get BudgetLevel() As String
    On Error GoTo ErrorHandler:
    If Not m_BudgetLevel & "" = "" Then
        BudgetLevel = m_BudgetLevel
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="BudgetLevel"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Let
'   Name:
'   Parameters:  String
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let FundCode(fc As String)
    On Error GoTo ErrorHandler:
    If Not fc & "" = "" Then
        m_FundCode = fc
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="FundCode"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Get
'   Name:
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get FundCode() As String
    On Error GoTo ErrorHandler:
    If Not m_FundCode & "" = "" Then
        FundCode = m_FundCode
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="FundCode"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Let
'   Name:
'   Parameters:  String
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let AhCode(AH As String)
    On Error GoTo ErrorHandler:
    If Not AH & "" = "" Then
        m_AhCode = AH
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="AhCode"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Get
'   Name:
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get AhCode() As String
    On Error GoTo ErrorHandler:
    If Not m_AhCode & "" = "" Then
        AhCode = m_AhCode
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="AhCode"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Let
'   Name:
'   Parameters:  String
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let OrgCode(ORG As String)
    On Error GoTo ErrorHandler:
    If Not ORG & "" = "" Then
        m_OrgCode = ORG
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="OrgCode"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Get
'   Name:
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get OrgCode() As String
    On Error GoTo ErrorHandler:
    If Not m_OrgCode & "" = "" Then
        OrgCode = m_OrgCode
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="OrgCode"
    Exit Property
End Property


'----------------------------------------------------------------------------------
'   Type:        Property Procedure Let
'   Name:
'   Parameters:  String
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let AccountCode(ac As String)
    On Error GoTo ErrorHandler:
    If Not ac & "" = "" Then
        m_AccountCode = ac
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="AccountCode"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Get
'   Name:
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get AccountCode() As String
    On Error GoTo ErrorHandler:
    If Not m_AccountCode & "" = "" Then
        AccountCode = m_AccountCode
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="AccountCode"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Let
'   Name:
'   Parameters:  String
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let RcCode(RC As String)
    On Error GoTo ErrorHandler:
    If Not RC & "" = "" Then
        m_RcCode = RC
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="RcCode"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Get
'   Name:
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get RcCode() As String
    On Error GoTo ErrorHandler:
    If Not m_RcCode & "" = "" Then
        RcCode = m_RcCode
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="RcCode"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Let
'   Name:
'   Parameters:  String
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let Amount(funds As Double)
    On Error GoTo ErrorHandler:
    If Not IsNull(funds) Or Not funds < 0 Then
        m_Amount = funds
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="Amount"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Procedure Get
'   Name:
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Amount() As Double
    On Error GoTo ErrorHandler:
    If Not IsNull(m_Amount) Or Not m_Amount < 0 Then
        Amount = m_Amount
    End If
ErrorHandler:
    ProcessError Name:="FullTimeEquivalent", _
        Member:="Amount"
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


