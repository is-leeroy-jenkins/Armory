Option Compare Database
Option Explicit



Private m_CreateDatabase As String
Private m_CreateTable As String
Private m_CreateView As String
Private m_Select As String
Private m_Insert As String
Private m_Update As String
Private m_Delete As String
Private m_Drop As String
Private m_AlterTable As String
Private m_AlterColumn As String
Private m_Source As String
Private m_Tables() As String
Private m_Criteria As New Scripting.Dictionary
Private m_Command As String
Private m_Commands() As String
Private pAnd As String
Private pLike As String
Private pWhere As String
Private m_Error As String
Private m_Notification As String





'----------------------------------------------------------------------------------
'   Type:        Constructor/Finalizer
'   Name:
'   Parameters:  Void
'   RetVal:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Class_Initialize()
    pAnd = " AND "
    m_Commands(0) = "CREATE"
    m_Commands(1) = "SELECT"
    m_Commands(2) = "UPDATE"
    m_Commands(3) = "INSERT"
    m_Commands(4) = "DELETE"
    m_Commands(7) = "DROP"
    m_Commands(8) = "ALTER"
    Set m_Criteria = CreateObject("Scripting.Dicitionary")
End Sub

Private Sub Class_Terminate()
    If Not m_Criteria Is Nothing Then
        Set m_Criteria = Nothing
    End If
End Sub






'----------------------------------------------------------------------------------
'   Type        Property Let
'   Name        Replace
'   Parameters  Replace
'   Retval      Void
'   Purpose     Replace
'---------------------------------------------------------------------------------
Public Property Let Source(Value As String)
    On Error GoTo ErrorHandler
    If Not Value & "" = "" Then
        m_Source = Value
    End If
ErrorHandler:
    ProcessError Name:="SqlBuilder", _
        Member:="Source"
    Exit Property
End Property





'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name        Replace
'   Parameters  Void
'   Retval      Replace
'   Purpose     Replace
'---------------------------------------------------------------------------------
Public Property Get Source() As String
    On Error GoTo ErrorHandler
    If Not m_Source & "" = "" Then
        Source = m_Source
    End If
ErrorHandler:
    ProcessError Name:="SqlBuilder", _
        Member:="Source"
    Exit Property
End Property




'----------------------------------------------------------------------------------
'   Type        Property Let
'   Name        Command
'   Parameters  String
'   Retval      Void
'   Purpose     Replace
'---------------------------------------------------------------------------------
Public Property Let Command(Value As String)
    On Error GoTo ErrorHandler
    If Not Value & "" = "" Then
        Dim i As Integer
        For i = LBound(m_Commands) To i = UBound(m_Commands)
            If m_Commands(i) = Value Then
                m_Command = Value
                Exit Property
            End If
        Next i
    End If
ErrorHandler:
    ProcessError Name:="SqlBuilder", _
        Member:="Command"
    Exit Property
End Property





'----------------------------------------------------------------------------------
'   Type        Property Let
'   Name        Command
'   Parameters  String
'   Retval      Void
'   Purpose     Replace
'---------------------------------------------------------------------------------
Private Function GetNames(Data As Scripting.Dictionary) As String()
    On Error GoTo ErrorHandler
    If Not Data Is Nothing Then
        Dim i As Integer
        Dim p_Names() As String
        For i = 0 To i = Data.Count
            p_Names(i) = Data.Keys(i)
        Next i
        GetNames = p_Names
    End If
ErrorHandler:
    ProcessError Name:="SqlBuilder", _
        Member:="GetNames()"
    Exit Function
End Function





'----------------------------------------------------------------------------------
'   Type        Function
'   Name        GetValues
'   Parameters  String
'   Retval      Void
'   Purpose     Replace
'---------------------------------------------------------------------------------
Private Function GetValues(Data As Scripting.Dictionary) As Variant()
    On Error GoTo ErrorHandler
ErrorHandler:
    ProcessError Name:="SqlBuilder", _
        Member:="GetValues()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type        Property Get
'   Name        Command
'   Parameters  Void
'   Retval      String
'   Purpose     Replace
'---------------------------------------------------------------------------------
Public Property Get Command() As String
    On Error GoTo ErrorHandler
    If Not m_Command & "" = "" Then
        Command = m_Command
    End If
ErrorHandler:
    ProcessError Name:="SqlBuilder", _
        Member:="GetValues()"
    Exit Property
End Property





'----------------------------------------------------------------------------------
'   Type        Property Let
'   Name        CreateSelectCommand
'   Parameters  Scripting.Dictionary
'   Retval      String
'   Purpose     Replace
'---------------------------------------------------------------------------------
Public Function CreateSelectCommand(KeyValuePairs As Scripting.Dictionary) As String
    On Error GoTo ErrorHandler
    If Not KeyValuePairs Is Nothing And _
        KeyValuePairs.Count > 0 Then
            Dim p_Names() As String
            Dim p_Values() As Variant
            Dim p_NameValuePairs As String
            Dim p_SQL As String
            Dim p_Predicate As String
            Dim i As Integer
            p_SQL = "SELECT * FROM m_Source" & pWhere
            For i = 0 To i = KeyValuePairs.Count
                p_Names(i) = KeyValuePairs.Keys(i)
                p_Values(i) = KeyValuePairs.Items(i)
            Next i
            For i = 0 To i = KeyValuePairs.Count
                Dim p_Pair As String
                p_Pair = p_Names(i) & " = '" & p_Values(i) & "'"
                p_NameValuePairs = p_NameValuePairs & p_Pair & pAnd
            Next i
            p_Predicate = Replace(Expression:=p_NameValuePairs, Find:=pAnd, _
                Replace:=";", Start:=-1)
            CreateSelectCommand = p_SQL & p_Predicate
    End If
ErrorHandler:
    ProcessError Name:="SqlBuilder", _
        Member:="CreateSelectCommand"
End Function









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



