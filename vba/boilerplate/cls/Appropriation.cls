Option Compare Database
Option Explicit





Private m_FundCode As String
Private m_FundName As String
Private m_FundTitle As String
Private m_TreasurySymbol As String
Private m_ID As Integer
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
    If num > 0 Then
        m_ID = num
    End If
ErrorHandler:
    ProcessError Name:="Appropriation", _
        Member:="ID"
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
    If m_ID > 0 Then
        ID = m_ID
    End If
ErrorHandler:
    ProcessError Name:="Appropriation", _
        Member:="ID"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let Code(cd As String)
    On Error GoTo ErrorHandler:
    If Not cd & "" = "" Then
        m_FundCode = cd
    End If
ErrorHandler:
    ProcessError Name:="Appropriation", _
        Member:="Code"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Return          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get Code() As String
    On Error GoTo ErrorHandler:
    If Not m_FundCode & "" = "" Then
        Code = m_FundCode
    End If
ErrorHandler:
    ProcessError Name:="Appropriation", _
        Member:="Code"
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
        m_FundName = nm
    End If
ErrorHandler:
    ProcessError Name:="Appropriation", _
        Member:="Name"
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
    If Not m_FundName & "" = "" Then
        Name = m_FundName
    End If
ErrorHandler:
    ProcessError Name:="Appropriation", _
        Member:="Name"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let Title(tit As String)
    On Error GoTo ErrorHandler:
    If Not tit & "" = "" Then
        m_FundTitle = tit
    End If
ErrorHandler:
    ProcessError Name:="Appropriation", _
        Member:="Title"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Return          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get Title() As String
    On Error GoTo ErrorHandler:
    If Not m_FundTitle & "" = "" Then
        Title = m_FundTitle
    End If
ErrorHandler:
    ProcessError Name:="Appropriation", _
        Member:="Title"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Let
'   Name
'   Parameters      Void
'   Return          Void
'   Purpose
'---------------------------------------------------------------------------------
Public Property Let TreasurySymbol(ts As String)
    On Error GoTo ErrorHandler:
    If Not ts & "" = "" Then
        m_TreasurySymbol = ts
    End If
ErrorHandler:
    ProcessError Name:="Appropriation", _
        Member:="TreasurySymbol"
    Exit Property
End Property


'---------------------------------------------------------------------------------
'   Type            Property-Get
'   Name
'   Parameters      Void
'   Return          String
'   Purpose
'---------------------------------------------------------------------------------
Public Property Get TreasurySymbol() As String
    On Error GoTo ErrorHandler:
    If Not m_TreasurySymbol & "" = "" Then
        TreasurySymbol = m_TreasurySymbol
    End If
ErrorHandler:
    ProcessError Name:="Appropriation", _
        Member:="TreasurySymbol"
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

