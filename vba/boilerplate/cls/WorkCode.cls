Option Compare Database
Option Explicit




Private m_Code As String
Private m_Name As String
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
    ProcessError Name:="WorkCode", _
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
    ProcessError Name:="WorkCode", _
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
    ProcessError Name:="WorkCode", _
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
    ProcessError Name:="WorkCode", _
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
    ProcessError Name:="WorkCode", _
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
    ProcessError Name:="WorkCode", _
        Member:="Name"
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


