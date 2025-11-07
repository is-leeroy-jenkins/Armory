Option Compare Database
Option Explicit


Private m_DataAccess As DataAccess
Private m_Base As DAO.field
Private m_DataRow As DataRow
Private m_Value  As Variant
Private m_Name As String
Private m_Caption As String
Private m_Type As String
Private m_Ordinal As Integer
Private m_Error As String
Private m_Notification As String





Private Sub Class_Initialize()
    Set m_DataAccess = New DataAccess
    Set m_Base = New DAO.field
End Sub

Private Sub Class_Terminate()
    If Not m_DataAccess Is Nothing Then
        Set m_DataAccess = Nothing
    End If
    If Not m_Base Is Nothing Then
        Set m_Base = Nothing
    End If
End Sub



'----------------------------------------------------------------------------------
'   Type:        Property Let
'   Name:        Base
'   Parameters:  Void
'   RetVal:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let Base(pBase As DAO.field)
    On Error GoTo ErrorHandler:
    If Not pBase Is Nothing Then
        Set m_Base = pBase
    End If
ErrorHandler:
    ProcessError Name:="DataColumn", _ 
        Member:="Base"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Get
'   Name:        Base
'   Parameters:  Void
'   RetVal:
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Base() As DAO.field
    On Error GoTo ErrorHandler:
    If Not m_Base Is Nothing Then
        Set Base = m_Base
    End If
ErrorHandler:
    ProcessError Name:="DataColumn", _ 
        Member:="Base"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Get
'   Name:        DAO.Field
'   Parameters:  Void
'   RetVal:
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Name() As String
    On Error GoTo ErrorHandler:
    If Not m_Base Is Nothing Then
    End If
ErrorHandler:
    ProcessError Name:="DataColumn", _ 
        Member:="Name"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Get
'   Name:        Ordinal
'   Parameters:  Void
'   RetVal:      Integer
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Ordinal() As Integer
    On Error GoTo ErrorHandler:
    If Not m_Base Is Nothing Then
        Ordinal = m_Base.OrdinalPosition
    End If
ErrorHandler:
    ProcessError Name:="DataColumn", _ 
        Member:="Ordinal"
    Exit Property
End Property





'----------------------------------------------------------------------------------
'   Type:        Property Get
'   Name:        Ordinal
'   Parameters:  Void
'   RetVal:      Integer
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get IsNumeric() As Boolean
    On Error GoTo ErrorHandler:
    If Not m_Base Is Nothing Then
        Select Case m_Base.Type
            Case adVarChar:
                IsNumeric = False
            Case adNumeric:
                IsNumeric = True
            Case adCurrency:
                IsNumeric = True
            Case adDecimal:
                IsNumeric = True
            Case adDouble:
                IsNumeric = True
            Case adDate:
                IsNumeric = False
            Case adInteger:
                IsNumeric = True
            Case Else:
                IsNumeric = False
        End Select
    End If
ErrorHandler:
    ProcessError Name:="DataColumn", _ 
        Member:="IsNumeric"
    Exit Property
End Property





'----------------------------------------------------------------------------------
'   Type:        Property Get
'   Name:        Ordinal
'   Parameters:  Void
'   RetVal:      Integer
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get IsText() As Boolean
    On Error GoTo ErrorHandler:
    If Not m_Base Is Nothing Then
        Select Case m_Base.Type
            Case adVarChar:
                IsText = True
            Case adVarWChar:
                IsText = True
            Case adWChar:
                IsText = True
            Case Else
                IsText = False
        End Select
    End If
ErrorHandler:
    ProcessError Name:="DataColumn", _ 
        Member:="IsText"
    Exit Property
End Property




'----------------------------------------------------------------------------------
'   Type:        Property Get
'   Name:        Ordinal
'   Parameters:  Void
'   RetVal:      Integer
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Value() As Variant
    On Error GoTo ErrorHandler:
    If Not m_Base.Value Is Nothing Then
        Value = m_Base.Value
    End If
ErrorHandler:
    ProcessError Name:="DataColumn", _ 
        Member:="Value"
    Exit Property
End Property



'----------------------------------------------------------------------------------
'   Type:        Property Get
'   Name:        DataType
'   Parameters:  Void
'   RetVal:      Integer
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get DataType() As String
    On Error GoTo ErrorHandler:
    If Not m_Base.Type & "" = "" Then
        DataType = m_Base.Type
    End If
ErrorHandler:
    ProcessError Name:="DataColumn", _ 
        Member:="DataType"
    Exit Property
End Property




'----------------------------------------------------------------------------------
'   Type:        Property Get
'   Name:        Ordinal
'   Parameters:  Void
'   RetVal:      Integer
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let Caption(pCaption As String)
    On Error GoTo ErrorHandler:
    If Not pCaption & "" = "" Then
        m_Caption = pCaption
    End If
ErrorHandler:
    ProcessError Name:="DataColumn", _ 
        Member:="Caption"
    Exit Property
End Property







'----------------------------------------------------------------------------------
'   Type:        Property Get
'   Name:        Ordinal
'   Parameters:  Void
'   RetVal:      Integer
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Caption() As String
    On Error GoTo ErrorHandler:
    If Not m_Caption & "" = "" Then
        Caption = m_Caption
    End If
ErrorHandler:
    ProcessError Name:="DataColumn", _ 
        Member:="Caption"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type:        Property Get
'   Name:        IsConnected
'   Parameters:  Void
'   RetVal:      Boolean
'   Purpose:     Function returns boolean value indicating if Workspace is open
'---------------------------------------------------------------------------------
Public Property Get IsConnected() As Boolean
    On Error GoTo ErrorHandler:
    If Not m_Base Is Nothing Then
        IsConnected = True
    End If
    If m_Base Is Nothing Then
        IsConnected = False
    End If
ErrorHandler:
    ProcessError Name:="DataColumn", _ 
        Member:="IsConnected"
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

