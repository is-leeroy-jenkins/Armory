Option Compare Database
Option Explicit



Private m_Code As String
Private m_Name As String
Private m_Value As Double
Private m_ID As Integer
Private m_Error As String


'---------------------------------------------------------------------------------
'   Type:            Property Let
'   Name:
'   Parameters:      String
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ID(bocid As Integer)
    On Error GoTo ErrorHandler:
    If bocid > 0 Then
        m_ID = bocid
    End If
ErrorHandler:
    ProcessError Name:="BudgetObjectClass", _ 
        Member:="ID"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type:            Property Let
'   Name:
'   Parameters:      String
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ID() As Integer
    On Error GoTo ErrorHandler:
    If m_ID > 0 Then
    End If
ErrorHandler:
    ProcessError Name:="BudgetObjectClass", _ 
        Member:="ID"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type:            Property Let
'   Name:
'   Parameters:      String
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let Code(cd As String)
    On Error GoTo ErrorHandler:
    If Not cd & "" = "" Then
        m_Code = cd
    End If
ErrorHandler:
    ProcessError Name:="BudgetObjectClass", _ 
        Member:="Code"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type:            Property Let
'   Name:
'   Parameters:      String
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Code() As String
    On Error GoTo ErrorHandler:
    If Not m_Code & "" = "" Then
        Code = m_Code
    End If
ErrorHandler:
    ProcessError Name:="BudgetObjectClass", _ 
        Member:="Code"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type:            Property Let
'   Name:
'   Parameters:      String
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let Name(nm As String)
    On Error GoTo ErrorHandler:
    If Not nm & "" = "" Then
        m_Name = nm
    End If
ErrorHandler:
    ProcessError Name:="BudgetObjectClass", _ 
        Member:="Name"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type:            Property Let
'   Name:
'   Parameters:      String
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Name() As String
    On Error GoTo ErrorHandler:
    If Not m_Name & "" = "" Then
        Name = m_Name
    End If
ErrorHandler:
    ProcessError Name:="BudgetObjectClass", _ 
        Member:="Name"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type:            Property Let
'   Name:
'   Parameters:      String
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let Value(vl As Double)
    On Error GoTo ErrorHandler:
    If Not vl & "" = "" Then
        m_Value = vl
    End If
ErrorHandler:
    ProcessError Name:="BudgetObjectClass", _ 
        Member:="Value"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type:            Property Let
'   Name:
'   Parameters:      String
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Value() As Double
    On Error GoTo ErrorHandler:
    If Not m_Value & "" = "" Then
        Value = m_Value
    End If
ErrorHandler:
    ProcessError Name:="BudgetObjectClass", _ 
        Member:="Value"
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

