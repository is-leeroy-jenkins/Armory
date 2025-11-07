VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Authority"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Compare Database
Option Explicit



Private m_ID As Integer
Private m_DCN As String
Private m_Name As String
Private m_Account As Account
Private m_BFY As BudgetFiscalYear
Private m_Fund As Fund
Private m_RPIO As ResourcePlanningOffice
Private m_RC As ResponsibilityCenter
Private m_AH As AllowanceHolder
Private m_ORG As Organization
Private m_Amount As Double
Private m_Error As String




'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let ID(num As Integer)
    On Error GoTo ErrorHandler:
    If Not num < 0 Then
        m_ID = num
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Return          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get ID() As Integer
    On Error GoTo ErrorHandler:
    If Not m_ID < 0 Then
        ID = m_ID
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            Fund
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let BFY(pYear As BudgetFiscalYear)
    On Error GoTo ErrorHandler:
    If Not pYear Is Nothing Then
        m_BFY = pYear
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get BFY() As BudgetFiscalYear
    On Error GoTo ErrorHandler:
    If Not m_BFY Is Nothing Then
        BFY = m_BFY
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let Account(cd As Account)
    On Error GoTo ErrorHandler:
    If Not cd Is Nothing Then
        m_Account = cd
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Return          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get Account() As Account
    On Error GoTo ErrorHandler:
    If Not m_Account Is Nothing Then
        Account = m_Account
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let Name(nm As String)
    On Error GoTo ErrorHandler:
    If Not nm & "" = "" Then
        m_Name = nm
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Return          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get Name() As String
    On Error GoTo ErrorHandler:
    If Not m_Name & "" = "" Then
        Name = m_Name
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            Fund
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let Fund(pFund As Fund)
    On Error GoTo ErrorHandler:
    If Not pFund Is Nothing Then
        m_Fund = pFund
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get Fund() As Fund
    On Error GoTo ErrorHandler:
    If Not m_Fund Is Nothing Then
        Fund = m_Fund
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property










'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            Fund
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let RPIO(pRPIO As ResourcePlanningOffice)
    On Error GoTo ErrorHandler:
    If Not pRPIO Is Nothing Then
        m_RPIO = pRPIO
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get RPIO() As ResourcePlanningOffice
    On Error GoTo ErrorHandler:
    If Not m_RPIO Is Nothing Then
        RPIO = m_RPIO
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property











'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            Fund
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let RC(pRC As ResponsibilityCenter)
    On Error GoTo ErrorHandler:
    If Not pRC Is Nothing Then
        m_RC = pRC
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get RC() As ResponsibilityCenter
    On Error GoTo ErrorHandler:
    If Not m_RC Is Nothing Then
        RC = m_RC
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property










'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            Fund
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let ORG(pOrg As Organization)
    On Error GoTo ErrorHandler:
    If Not pOrg Is Nothing Then
        m_ORG = pOrg
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get ORG() As Organization
    On Error GoTo ErrorHandler:
    If Not m_ORG Is Nothing Then
        ORG = m_ORG
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property








'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            Fund
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let AH(pAH As AllowanceHolder)
    On Error GoTo ErrorHandler:
    If Not pAH Is Nothing Then
        m_AH = pAH
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get AH() As AllowanceHolder
    On Error GoTo ErrorHandler:
    If Not m_AH Is Nothing Then
        AH = m_AH
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property











'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name            Fund
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let Amount(pAmount As Double)
    On Error GoTo ErrorHandler:
    If Not IsNull(pAmount) Then
        m_Amount = pAmount
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get Amount() As Double
    On Error GoTo ErrorHandler:
    If Not IsNull(m_Amount) Then
        Amount = m_Amount
    End If
ErrorHandler:
    ProcessError
    Exit Property
End Property











'---------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ProcessError
'   Parameters:  Void
'   RetVal:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ProcessError()
    If Err.Number <> 0 Then
        m_Error = "Source:      " & Err.Source _
            & vbCrLf & "Number:     " & Err.Number _
            & vbCrLf & "Issue:      " & Err.Description
        Err.Clear
    End If
    MessageFactory.ShowError (m_Error)
End Sub





