Option Compare Database
Option Explicit




Private m_Code As String
Private m_Name As String
Private m_Identifier As String
Private m_Address As String
Private m_State As String
Private m_City As String
Private m_ID As Integer
Private m_Error As String




Public Sub Class_Initialize()
End Sub

Public Sub Class_Terminate()
End Sub





'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let ID(intId As Integer)
    On Error GoTo ErrorHandler:
    If intId > -1 Then
        m_ID = intId
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="ID"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get ID() As Integer
    On Error GoTo ErrorHandler:
    If Not m_ID > -1 Then
        ID = m_ID
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="ID"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let Code(cd As String)
    On Error GoTo ErrorHandler:
    If Not cd & "" = "" Then
        m_Code = cd
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="Code"
    Exit Property
End Property




'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get Code() As String
    On Error GoTo ErrorHandler:
    If Not m_Code & "" = "" Then
        Code = m_Code
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="Code"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let Name(OrgName As String)
    On Error GoTo ErrorHandler:
    If Not OrgName & "" = "" Then
        m_Name = OrgName
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="Name"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get Name() As String
    On Error GoTo ErrorHandler:
    If Not m_Name & "" = "" Then
        Name = m_Name
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="Name"
    Exit Property
End Property






'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let Identifier(pIdent As String)
    On Error GoTo ErrorHandler:
    If Not pIdent & "" = "" Then
        m_Identifier = pIdent
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="Identifier"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name        Identifier
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get Identifier() As String
    On Error GoTo ErrorHandler:
    If Not m_Identifier & "" = "" Then
        Identifier = m_Identifier
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="Identifier"
    Exit Property
End Property






'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let State(pState As String)
    On Error GoTo ErrorHandler:
    If Not pState & "" = "" Then
        m_State = pState
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="State"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name        State
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get State() As String
    On Error GoTo ErrorHandler:
    If Not m_State & "" = "" Then
        State = m_State
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="State"
    Exit Property
End Property







'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let City(pCity As String)
    On Error GoTo ErrorHandler:
    If Not pCity & "" = "" Then
        m_City = pCity
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="City"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name        State
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get City() As String
    On Error GoTo ErrorHandler:
    If Not m_City & "" = "" Then
        City = m_City
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="City"
    Exit Property
End Property




'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let Address(pAddress As String)
    On Error GoTo ErrorHandler:
    If Not pAddress & "" = "" Then
        m_Address = pAddress
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="Address"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name        State
'   Parameters  Void
'   Retval      String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get Address() As String
    On Error GoTo ErrorHandler:
    If Not m_Address & "" = "" Then
        Address = m_Address
    End If
ErrorHandler:
    ProcessError Name:="Site", _
        Member:="Address"
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



