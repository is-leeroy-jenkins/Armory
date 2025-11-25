Option Compare Database
Option Explicit



Public Args As AccountArgs
Private m_DataColumns As Scripting.Dictionary
Private m_Name As String
Private m_DataType As String
Private m_Database As String
Private pAnd As String
Private m_Error As String





'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Open
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    Me.DatabaseComboBox.RowSource = "SELECT DISTINCT SchemaTypes.Database FROM SchemaTypes;"
    Me.DataTypeComboBox.RowSource = vbNullString
ErrorHandler:
    ProcessError Name:="ColumnDefinitionDialog", _
        Member:="Form_Open()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Form_Load
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler:
    Me.Caption = "Data Schema"
    SetComboBoxColors
    pAnd = " AND "
    ClearComboBoxValues
    Set m_DataColumns = CreateObject("Scripting.Dictionary")
ErrorHandler:
    ProcessError Name:="ColumnDefinitionDialog", _
        Member:="Form_Load()"
    Exit Sub
End Sub






'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        DataTypeComboBox_Change
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub DatabaseComboBox_Change()
    On Error GoTo ErrorHandler:
    m_Database = vbNullString
    m_Database = Me.DatabaseComboBox.Value
    Me.DataTypeComboBox.RowSource = "SELECT DISTINCT SchemaTypes.TypeName" _
        & " FROM SchemaTypes" _
        & " WHERE [Database] = '" & m_Database & "'"
ErrorHandler:
    ProcessError Name:="ColumnDefinitionDialog", _
        Member:="DatabaseComboBox_Change()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        DataTypeComboBox_Change()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub DataTypeComboBox_Change()
    On Error GoTo ErrorHandler:
    m_DataType = vbNullString
    m_DataType = Me.DataTypeComboBox.Value
ErrorHandler:
    ProcessError Name:="ColumnDefinitionDialog", _
        Member:="DataTypeComboBox_Change()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        GetSchemaData()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetSchemaData() As Scripting.Dictionary
    On Error GoTo ErrorHandler:
    If Not Me.ColumnNameTextBox.Value & "" = "" And _
        Not m_DataType & "" = "" Then
            m_Name = vbNullString
            m_Name = Me.ColumnNameTextBox.Text
            m_DataColumns.add Key:="Name", Item:=m_Name
            m_DataColumns.add Key:="Type", Item:=m_DataType
    End If
ErrorHandler:
    ProcessError Name:="ColumnDefinitionDialog", _
        Member:="GetSchemaData()"
    Exit Function
End Function






'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExecuteButton_OnClick
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub AddButton_Click()
    On Error GoTo ErrorHandler:
    If Not Me.ColumnNameTextBox.Value & "" = "" And _
        Not m_DataType & "" = "" Then
            Dim p_DataColumn As Scripting.Dictionary
            Set p_DataColumn = CreateObject("Scripting.Dictionary")
            Set p_DataColumn = GetSchemaData
    End If
ErrorHandler:
    ProcessError Name:="ColumnDefinitionDialog", _
        Member:="AddButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        RefreshButton_Click
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub RefreshButton_Click()
    On Error GoTo ErrorHandler:
    Me.ColumnNameTextBox.Value = "Enter Column Name"
    Me.DataTypeComboBox.Value = vbNullString
    Me.DatabaseComboBox.Value = vbNullString
    Me.DataTypeComboBox.RowSource = vbNullString
    Me.DatabaseComboBox.RowSource = "SELECT DISTINCT SchemaTypes.Database FROM SchemaTypes;"
ErrorHandler:
    ProcessError Name:="ColumnDefinitionDialog", _
        Member:="RefreshButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SetComboBoxColors
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetComboBoxColors()
    On Error GoTo ErrorHandler:
    Me!ColumnNameTextBox.ForeColor = RGB(255, 255, 255)
    Me!ColumnNameTextBox.BackColor = RGB(33, 33, 33)
    Me!ColumnNameTextBox.BorderColor = RGB(68, 114, 196)
ErrorHandler:
    ProcessError Name:="ColumnDefinitionDialog", _
        Member:="SetComboBoxColors()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ClearComboBoxValues
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearComboBoxValues()
    On Error GoTo ErrorHandler:
    Me.ColumnNameTextBox.Value = "Enter Column Name"
    Me.DataTypeComboBox.Value = vbNullString
    Me.DatabaseComboBox.Value = vbNullString
    Me.DataTypeComboBox.RowSource = vbNullString
    Me.DatabaseComboBox.RowSource = vbNullString
    Me.DatabaseComboBox.RowSource = "SELECT DISTINCT SchemaTypes.Database FROM SchemaTypes;"
ErrorHandler:
    ProcessError Name:="ColumnDefinitionDialog", _
        Member:="ClearComboBoxValues()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ClearComboBoxValues
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ColumnNameTextBox_Enter()
    On Error GoTo ErrorHandler:
    Me.ColumnNameTextBox.Value = vbNullString
ErrorHandler:
    ProcessError Name:="ColumnDefinitionDialog", _
        Member:="ColumnNameTextBox_Enter()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExitButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ExitButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close acForm, Me.Name
ErrorHandler:
    ProcessError Name:="ColumnDefinitionDialog", _
        Member:="ExitButton_Click()"
    Exit Sub
End Sub
















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








