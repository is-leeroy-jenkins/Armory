VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_RegionalDocuments"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

Private Args As AccountArgs
Private RpioNameFilter As String
Private DocumentNumberFilter As String
Private FiscalYearFilter As String
Private BocNameFilter As String
Private FundNameFilter As String
Private pFormFilter As String
Private pAnd As String
Private m_Error As String



'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    pAnd = " AND "
    FiscalYearFilter = "[BFY] = '2022'"
    Me.Filter = FiscalYearFilter
    Me.RecordSource = "SELECT * FROM Obligations WHERE NOT" _
        & " IsNull(Obligations.DocumentControlNumber)" _
        & " AND Obligations.BocCode NOT IN ('10', '17')" _
        & pAnd & Me.Filter
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="Form_Open"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:            Event / Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.SECTION(acHeader).AutoHeight = False
    Me.SECTION(acHeader).Height = 2
    Me.SECTION(acDetail).AutoHeight = False
    Me.SECTION(acDetail).Height = 4
    Me.SECTION(acFooter).AutoHeight = False
    Me.SECTION(acFooter).Height = 1
    Me.FiscalYearOptionGroup.Value = 2
    ClearComboBoxValues
    SetComboBoxColors
    SetButtonVisibility
    Me.RpioNameComboBox.RowSource = "SELECT DISTINCT Obligations.RpioName FROM Obligations" _
        & " WHERE NOT IsNull(Obligations.DocumentControlNumber)" _
        & pAnd & "Obligations.BocCode NOT IN ('10', '17');"
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT Obligations.BocName FROM Obligations" _
        & " WHERE NOT IsNull(Obligations.DocumentControlNumber)" _
        & pAnd & "Obligations.BocCode NOT IN ('10', '17');"
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="Form_Load()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            SetButtonVisibility
'   Parameters:      Void
'   Purpose:         Toggles button visibility on and off
'---------------------------------------------------------------------------------
Private Sub SetButtonVisibility()
    On Error GoTo ErrorHandler:
    Me.AddButton.Visible = Not Me.AddButton.Visible
    Me.FirstButton.Visible = Not Me.FirstButton.Visible
    Me.PreviousButton.Visible = Not Me.PreviousButton.Visible
    Me.NextButton.Visible = Not Me.NextButton.Visible
    Me.LastButton.Visible = Not Me.LastButton.Visible
    Me.EditButton.Visible = Not Me.EditButton.Visible
    Me.RefreshButton.Visible = Not Me.RefreshButton.Visible
    Me.DeleteButton.Visible = Not Me.DeleteButton.Visible
    Me.CalculatorButton.Visible = Not Me.CalculatorButton.Visible
    Me.ExcelButton.Visible = Not Me.ExcelButton.Visible
    Me.UndoButton.Visible = Not Me.UndoButton.Visible
    Me.SaveButton.Visible = Not Me.SaveButton.Visible
    Me.DataButton.Visible = Not Me.DataButton.Visible
    Me.CompassDocumentQueryButton.Visible = Not Me.CompassDocumentQueryButton.Visible
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="SetButtonVisibility()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            SetComboBoxColors
'   Parameters:      Void
'   Purpose:         Toggles button visibility ON and OFF
'---------------------------------------------------------------------------------
Private Sub SetComboBoxColors()
    On Error GoTo ErrorHandler:
    Me.DocumentNumberComboBox.ForeColor = RGB(255, 255, 255)
    Me.DocumentNumberComboBox.BackColor = RGB(33, 33, 33)
    Me.DocumentNumberComboBox.BorderColor = RGB(68, 114, 196)
    Me.RpioNameComboBox.ForeColor = RGB(255, 255, 255)
    Me.RpioNameComboBox.BackColor = RGB(33, 33, 33)
    Me.RpioNameComboBox.BorderColor = RGB(68, 114, 196)
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="SetComboBoxColors()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        FiscalYearOptionGroup_AfterUpdate
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FiscalYearOptionGroup_AfterUpdate()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Args.BFY = vbNullString
    FiscalYearFilter = vbNullString
    Me.Filter = vbNullString
    Select Case Me.FiscalYearOptionGroup.Value
        Case 1
            Args.BFY = "2021"
            FiscalYearFilter = "[BFY] IN ('2021', '2022')"
        Case 2
            Args.BFY = "2022"
            FiscalYearFilter = "[BFY] IN ('2022', '2022')"
    End Select
    Me.Filter = GetFiscalYearFilter
    Me.RecordSource = "SELECT * FROM Obligations WHERE" _
        & " NOT IsNull(DocumentControlNumber)" & pAnd & Me.Filter
    Me.Requery
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="FiscalYearOptionGroup_AfterUpdate()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetFiscalYearFilter
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetFiscalYearFilter()
    On Error GoTo ErrorHandler:
    If Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & DocumentNumberFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        DocumentNumberFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & DocumentNumberFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        DocumentNumberFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter
    End If
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="GetFiscalYearFilter()"
    Exit Function
End Function


'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            RpioNameComboBox_Change()
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub RpioNameComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.Filter = vbNullString
    Args.RpioName = Me.RpioNameComboBox.Value
    RpioNameFilter = "[RpioName] = '" & Me.RpioNameComboBox.Value & "'"
    Me.Filter = GetRpioNameFilter
    Me.DocumentNumberComboBox.RowSource = "SELECT DISTINCT Obligations.DocumentControlNumber" _
        & " FROM Obligations WHERE" _
        & " NOT IsNull(DocumentControlNumber)" _
        & pAnd & "[BocCode] NOT IN ('10', '17')" _
        & pAnd & Me.Filter
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT Obligations.BocName" _
        & " FROM Obligations WHERE" _
        & " NOT IsNull(DocumentControlNumber)" _
        & pAnd & "[BocCode] NOT IN ('10', '17')" _
        & pAnd & Me.Filter
    Me.RecordSource = "SELECT * FROM Obligations" _
        & " WHERE NOT IsNull(DocumentControlNumber)" _
        & pAnd & "[BocCode] NOT IN ('10', '17')" _
        & pAnd & Me.Filter
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="RpioNameComboBox_Change()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetRpioNameFilter
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetRpioNameFilter() As String
    On Error GoTo ErrorHandler:
    If Not RpioNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetRpioNameFilter = DocumentNumberFilter & pAnd _
                & RpioNameFilter & pAnd _
                & FiscalYearFilter & pAnd & BocNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetRpioNameFilter = DocumentNumberFilter & pAnd _
                & RpioNameFilter & pAnd _
                & FiscalYearFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetRpioNameFilter = DocumentNumberFilter & pAnd _
                & RpioNameFilter & pAnd & BocNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetRpioNameFilter = DocumentNumberFilter & pAnd _
                & RpioNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        DocumentNumberFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & BocNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        DocumentNumberFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetRpioNameFilter = FiscalYearFilter _
                & pAnd & RpioNameFilter _
                & pAnd & BocNameFilter
    End If
    If Not RpioNameFilter & "" = "" And _
        DocumentNumberFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetRpioNameFilter = RpioNameFilter _
                & pAnd & FiscalYearFilter
    End If
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="GetRpioNameFilter()"
    Exit Function
End Function

'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            DocumentNumberComboBox_Change()
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub DocumentNumberComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.Filter = vbNullString
    DocumentNumberFilter = vbNullString
    BocNameFilter = vbNullString
    DocumentNumberFilter = "[DocumentControlNumber] = '" _
        & Me.DocumentNumberComboBox.Value & "'"
    Me.Filter = GetDocumentNumberFilter
    Me.RecordSource = "SELECT * FROM Obligations" _
        & " WHERE NOT IsNull(DocumentControlNumber)" _
        & pAnd & "[BocCode] NOT IN ('10', '17')" _
        & pAnd & Me.Filter
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT Obligations.BocName" _
        & " FROM Obligations WHERE" _
        & " NOT IsNull(DocumentControlNumber)" _
        & pAnd & "[BocCode] NOT IN ('10', '17')" _
        & pAnd & Me.Filter
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="DocumentNumberComboBox_Change()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetDocumentNumberFilter
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetDocumentNumberFilter() As String
    On Error GoTo ErrorHandler:
    If Not DocumentNumberFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetDocumentNumberFilter = DocumentNumberFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & BocNameFilter
    End If
    If Not DocumentNumberFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        BocNameFilter & "" = "" Then
            GetDocumentNumberFilter = DocumentNumberFilter _
                & pAnd & RpioNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not DocumentNumberFilter & "" = "" And _
        Not RpioNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetDocumentNumberFilter = DocumentNumberFilter _
                & pAnd & RpioNameFilter _
                & pAnd & BocNameFilter
    End If
    If Not DocumentNumberFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetDocumentNumberFilter = DocumentNumberFilter _
                & pAnd & FiscalYearFilter _
                & pAnd & BocNameFilter
    End If
    If Not DocumentNumberFilter & "" = "" And _
        RpioNameFilter & "" = "" And _
         FiscalYearFilter & "" = "" And _
        Not BocNameFilter & "" = "" Then
            GetDocumentNumberFilter = DocumentNumberFilter _
                & pAnd & BocNameFilter
    End If
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="GetDocumentNumberFilter()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:            Event / Sub-Procedure
'   Name:            BocNameComboBox_Change()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub BocNameComboBox_Change()
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.Filter = vbNullString
    BocNameFilter = vbNullString
    BocNameFilter = "[BocName] = '" & Me.BocNameComboBox.Value & "'"
    Me.Filter = GetBocNameFilter
    Me.RecordSource = "SELECT * FROM Obligations" _
        & " WHERE NOT IsNull(DocumentControlNumber)" _
        & pAnd & Me.Filter
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="BocNameComboBox_Change()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:            Function
'   Name:
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetBocNameFilter() As String
    On Error GoTo ErrorHandler:
    If Not BocNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & DocumentNumberFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not BocNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & DocumentNumberFilter _
                & pAnd & FundNameFilter
    End If
    If Not BocNameFilter & "" = "" And _
        DocumentNumberFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & FundNameFilter
    End If
    If BocNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetBocNameFilter = DocumentNumberFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not BocNameFilter & "" = "" And _
        DocumentNumberFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & FundNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not BocNameFilter & "" = "" And _
        DocumentNumberFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not BocNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter _
                & pAnd & DocumentNumberFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not BocNameFilter & "" = "" And _
        DocumentNumberFilter & "" = "" And _
        FundNameFilter & "" = "" And _
         FiscalYearFilter & "" = "" Then
            GetBocNameFilter = BocNameFilter
    End If
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="GetBocNameFilter("
    Exit Function
End Function


'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Close()
    Me.Filter = vbNullString
    If Not Args Is Nothing Then
        Set Args = Nothing
    End If
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="Form_Close()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub RefreshButton_Click()
    On Error GoTo ErrorHandler:
    ClearComboBoxValues
    ClearFilterValues
    ResetOptionGroup
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="RefreshButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearComboBoxValues()
    On Error GoTo ErrorHandler:
    Me.RpioNameComboBox.Value = vbNullString
    Me.DocumentNumberComboBox.Value = vbNullString
    Me.BocNameComboBox.Value = vbNullString
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="ClearComboBoxValues()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ResetOptionGroup()
    On Error GoTo ErrorHandler:
    FiscalYearOptionGroup.Value = 2
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="ResetOptionGroup()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ClearFilterValues()
    On Error GoTo ErrorHandler:
    DocumentNumberFilter = vbNullString
    FiscalYearFilter = vbNullString
    RpioNameFilter = vbNullString
    BocNameFilter = vbNullString
    Me.Requery
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="ClearFilterValues()"
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub CompassDocumentQueryButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.OpenForm "BudgetDetailedSpendingQuery", , , , , acDialog
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="CompassDocumentQueryButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub CalculatorButton_Click()
    On Error GoTo ErrorHandler:
    Calculator.Calculate
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="CalculatorButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub OriginalActionDateTextBox_Enter()
    On Error GoTo ErrorHandler:
    DoCmd.OpenForm "BudgetCalendar", , , , , , Me.OriginalActionDateTextBox
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="OriginalActionDateTextBox_Enter()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub MenuButton_Click()
    On Error GoTo ErrorHandler:
    SetButtonVisibility
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="MenuButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetColumnNames
'   Parameters:  Void
'   Retval:      Collection
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetColumnNames(pData As DAO.Recordset) As String()
    On Error GoTo ErrorHandler:
    Dim m_Fields As Collection
    Dim field As DAO.field
    Dim i As Integer
    Dim j As Integer
    Dim p_Array() As String
    Dim p_Data As DAO.Recordset
    Set p_Data = pData
    j = p_Data.Fields.Count - 1
    ReDim p_Array(j)
    For i = LBound(p_Array()) To UBound(p_Array())
        If Not p_Data.Fields(i).Name & "" = "" Then
            p_Array(i) = p_Data.Fields(i).Name
        End If
    Next i
    GetColumnNames = p_Array()
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="GetColumnNames"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetSqlStatement()
'   Parameters:  Void
'   Retval:      String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetSqlStatement() As String
    On Error GoTo ErrorHandler:
    Dim p_SQL As String
    p_SQL = "SELECT DISTINCT Obligations.BFY AS BFY, Obligations.RpioName AS Fund," _
        & " Obligations.AccountCode AS Account, Obligations.RcCode AS RC, Obligations.OrgCode AS ORG," _
        & " Obligations.DocumentControlNumber AS DCN, Obligations.BocCode AS BOC, Obligations.ProcessedDate AS [Date]," _
        & " SUM(Obligations.OpenCommitments) AS Commitments, SUM(Obligations.Obligations) AS Obligations" _
        & " FROM Obligations" _
        & " WHERE " & Me.Filter _
        & " AND NOT IsNull(Obligations.DocumentControlNumber)" _
        & " GROUP BY Obligations.BFY, Obligations.RpioName, Obligations.AccountCode, Obligations.RcCode," _
        & " Obligations.OrgCode, Obligations.DocumentControlNumber, Obligations.BocCode, Obligations.ProcessedDate;"
    GetSqlStatement = p_SQL
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="GetSqlStatement()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetReportData()
'   Parameters:  Void
'   Retval:      Collection
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetDataSet(pQuery As String) As DAO.Recordset
    On Error GoTo ErrorHandler:
    Dim p_Query As String
    p_Query = pQuery
    Dim p_Records As DAO.Recordset
    Set p_Records = CurrentDb.OpenRecordset(p_Query)
    Set GetDataSet = p_Records
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="GetDataSet"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        ExcelButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ExcelButton_Click()
    On Error GoTo ErrorHandler:
    Dim m_Data As DAO.Recordset
    Dim m_SqlQuery As String
    Dim m_Fields() As String
    Dim m_BudgetPath As BudgetPath
    Dim m_Excel As Excel.Application
    Dim m_Allocations As Excel.Workbook
    Dim m_Worksheet As Excel.Worksheet
    Dim m_List As Excel.ListObject
    Dim m_Range As Excel.Range
    Dim m_Cell As Object
    Dim m_Header As Excel.Range
    Dim m_Start As Excel.Range
    Dim m_End As Excel.Range
    Dim field As DAO.field
    Dim i As Integer
    Dim j As Integer
    m_SqlQuery = GetSqlStatement
    Set m_Data = CurrentDb.OpenRecordset(m_SqlQuery)
    m_Fields() = GetColumnNames(m_Data)
    Set m_BudgetPath = New BudgetPath
    Set m_Excel = CreateObject("Excel.Application")
    Set m_Allocations = m_Excel.Workbooks.Open(m_BudgetPath.ReportTemplate)
    m_Allocations.Worksheets(2).Visible = False
    Set m_Worksheet = m_Allocations.Worksheets(1)
    m_Worksheet.Name = "Regional Documents"
    m_Worksheet.Cells.HorizontalAlignment = xlHAlignLeft
    m_Worksheet.Cells.Font.Name = "Source Code Pro"
    m_Worksheet.Cells.Font.Size = 8
    Set m_Start = m_Worksheet.Cells(1, 1)
    Set m_End = m_Worksheet.Cells(1, UBound(m_Fields) + 1)
    Set m_Header = m_Worksheet.Range(m_Start, m_End)
    m_Header.Interior.Color = RGB(217, 217, 217)
    m_Header.HorizontalAlignment = xlHAlignLeft
    m_Header.Borders(xlEdgeBottom).Color = RGB(0, 0, 0)
    m_Header.Borders(xlEdgeLeft).Color = RGB(133, 133, 133)
    m_Header.Borders(xlEdgeRight).Color = RGB(133, 133, 133)
    m_Header.Borders(xlEdgeTop).Color = RGB(133, 133, 133)
    m_Header.Font.Name = "Source Code Pro"
    m_Header.Font.Color = vbBlack
    m_Header.Font.Bold = True
    m_Header.Font.Size = 8
    For i = LBound(m_Fields) To UBound(m_Fields)
        j = i
        m_Header.Cells(1, i + 1).Value = m_Fields(j)
    Next i
    m_Worksheet.Cells(2, 1).CopyFromRecordset m_Data
    m_Header.Font.Color = vbBlack
    m_Excel.WindowState = xlMaximized
    m_Excel.Visible = True
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="ExcelButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SaveButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub UndoButton_Click()
    On Error GoTo ErrorHandler:
    If Me.Dirty Then
        DoCmd.RunCommand acCmdUndo
    End If
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="UndoButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SaveButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SaveButton_Click()
    On Error GoTo ErrorHandler:
    If Me.Dirty Then
        DoCmd.RunCommand acCmdSave
    End If
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:=""
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        DeleteButton_Click
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub DeleteButton_Click()
    On Error GoTo ErrorHandler:
    If Me.Dirty Then
        DoCmd.RunCommand acCmdDelete
    End If
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="SaveButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SetRpioIcon
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetRpioIcon(pRpioCode As String)
    On Error GoTo ErrorHandler:
    Dim p_RpioCode As String
    If Not pRpioCode & "" = "" Then
        p_RpioCode = DLookup("RpioCode", "StatusOfFunds", _
            "[RpioName] = '" & pRpioCode & "'")
        Me.Caption = pRpioCode
        Select Case CStr(p_RpioCode)
            Case "01"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R1.png"
            Case "02"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R2.png"
            Case "03"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R3.png"
            Case "04"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R4.png"
            Case "05"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R5.png"
            Case "06"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R6.png"
            Case "07"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R7.png"
            Case "08"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R8.png"
            Case "09"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R9.png"
            Case "10"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\R10.png"
            Case "11"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OA.png"
            Case "13"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OITA.png"
            Case "16"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OMS.png"
            Case "17"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OCFO.png"
            Case "20"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OCSPP.png"
            Case "26"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\ORD.png"
            Case "27"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OAR.png"
            Case "30"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OW.png"
            Case "35"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OIG.png"
            Case "39"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OGC.png"
            Case "75"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OLEM.png"
            Case "77"
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\RPIO\OECA.png"
            Case Else
                Me.RpioIcon.Picture = CurrentProject.Path _
                    & "\etc\png\AppIcons\interface\ui\capital.png"
        End Select
    End If
ErrorHandler:
    ProcessError Name:="RegionalDocumentsForm", _
        Member:="SetRpioIcon()"
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




