Option Compare Database
Option Explicit

Private m_Error As String
Private m_From As String
Private m_To As String
Private m_Subject As String
Private m_Copy() As String
Private m_Body As String





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




'---------------------------------------------------------------------------------
'   Type:        Property
'   Name:
'   Parameters:  String
'   RetVal:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let Sender(pAddress As String)
    On Error GoTo ErrorHandler:
    If Not pAddress & "" = "" Then
        m_From = pAddress
    End If
ErrorHandler:
    ProcessError Name:="EmailBuilder", _ 
        Member:="Sender"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type:        Property
'   Name:
'   Parameters:  Void
'   RetVal:      String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Sender() As String
    On Error GoTo ErrorHandler:
    If Not m_From & "" = "" Then
        Sender = m_From
    End If
ErrorHandler:
    ProcessError Name:="EmailBuilder", _ 
        Member:="Sender"
    Exit Property
End Property







'---------------------------------------------------------------------------------
'   Type:        Property
'   Name:        Reciever
'   Parameters:  String
'   RetVal:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let Reciever(pAddress As String)
    On Error GoTo ErrorHandler:
    If Not pAddress & "" = "" Then
        m_To = pAddress
    End If
ErrorHandler:
    ProcessError Name:="EmailBuilder", _ 
        Member:="Reciever"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type:        Property
'   Name:        Reciever
'   Parameters:  Void
'   RetVal:      String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Reciever() As String
    On Error GoTo ErrorHandler:
    If Not m_To & "" = "" Then
        Reciever = m_To
    End If
ErrorHandler:
    ProcessError Name:="EmailBuilder", _ 
        Member:="Reciever"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type:        Property
'   Name:        Subject
'   Parameters:  String
'   RetVal:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let Subject(pSubject As String)
    On Error GoTo ErrorHandler:
    If Not pSubject & "" = "" Then
        m_Subject = pSubject
    End If
ErrorHandler:
    ProcessError Name:="EmailBuilder", _ 
        Member:="Subject"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type:        Property
'   Name:        Subject
'   Parameters:  Void
'   RetVal:      String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Subject() As String
    On Error GoTo ErrorHandler:
    If Not m_Subject & "" = "" Then
        Subject = m_Subject
    End If
ErrorHandler:
    ProcessError Name:="EmailBuilder", _ 
        Member:="Subject"
    Exit Property
End Property







'---------------------------------------------------------------------------------
'   Type:        Property
'   Name:
'   Parameters:  String
'   RetVal:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let Body(pMessage As String)
    On Error GoTo ErrorHandler:
    If Not pMessage & "" = "" Then
        m_Body = pMessage
    End If
ErrorHandler:
    ProcessError Name:="EmailBuilder", _ 
        Member:="Body"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type:        Property
'   Name:
'   Parameters:  Void
'   RetVal:      String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Body() As String
    On Error GoTo ErrorHandler:
    If Not m_Body & "" = "" Then
        Body = m_Body
    End If
ErrorHandler:
    ProcessError Name:="EmailBuilder", _ 
        Member:="Body"
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


