Option Compare Database
Option Explicit



Public Args As AccountArgs
Private m_Dialog As Form_StatusOfFundsDialog
Private FundNameFilter As String
Private RpioNameFilter As String
Private DocumentNumberFilter As String
Private FiscalYearFilter As String
Private BocNameFilter As String
Private m_FormFilter As String
Private pAnd As String
Private m_Error As String
Private m_Notification As String



'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    pAnd = " AND "
    Set Args = New AccountArgs
    Set m_Dialog = New Form_StatusOfFundsDialog
    DoCmd.OpenForm FormName:="StatusOfFundsDialog", WindowMode:=acDialog
    Set m_Dialog = Forms("StatusOfFundsDialog")
    Set Args = m_Dialog.Args
    SetRpioIcon (Args.RpioCode)
    DoCmd.Close ObjectType:=acForm, ObjectName:=m_Dialog.Name, Save:=acSaveNo
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="Form_Open()"
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
    pAnd = " AND "
    Me.SECTION(acHeader).AutoHeight = False
    Me.SECTION(acHeader).Height = 2
    Me.SECTION(acDetail).AutoHeight = False
    Me.SECTION(acDetail).Height = 4
    Me.SECTION(acFooter).AutoHeight = False
    Me.SECTION(acFooter).Height = 0.5
    Me.FiscalYearOptionGroup.Value = 2
    SetComboBoxColors
    SetButtonVisibility
    ClearComboBoxValues
    If Not Args.RpioName & "" = "" Then
        RpioNameFilter = "[RpioName] = '" & Args.RpioName & "'"
    End If
    If Not Args.FundName & "" = "" Then
        FundNameFilter = "[FundName] = '" & Args.FundName & "'"
    End If
    If Not Args.BFY & "" = "" Then
        Select Case Args.BFY
            Case "2021"
                FiscalYearFilter = "[BFY] = '2021'"
                Me.FiscalYearOptionGroup.Value = 1
            Case "2022"
                FiscalYearFilter = "[BFY] = '2022'"
                Me.FiscalYearOptionGroup.Value = 2
        End Select
        FiscalYearFilter = "[BFY] = '" & Args.BFY & "'"
    End If
    Me.Filter = RpioNameFilter _
        & pAnd & FiscalYearFilter
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT Obligations.FundName" _
        & " FROM Obligations" _
        & " WHERE " & Me.Filter
    Me.DocumentNumberComboBox.RowSource = "SELECT DISTINCT Obligations.DocumentControlNumber" _
        & " FROM Obligations" _
        & " WHERE NOT IsNull(Obligations.DocumentControlNumber)" _
        & pAnd & Me.Filter
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT Obligations.BocName" _
        & " FROM Obligations" _
        & " WHERE NOT IsNull(Obligations.DocumentControlNumber)" _
        & pAnd & Me.Filter
    Me.Requery
    Me.Caption = Args.RpioName
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="Form_Load()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            SetButtonVisibility
'   Parameters:      Void
'   Retval:          Void
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
    ProcessError Name:="DocumentObligationsForm", _
        Member:="SetButtonVisibility()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        Hides buttons
'   Parameters:  Void
'   Purpose:     Toggles the toolbar button on/off
'---------------------------------------------------------------------------------
Private Sub HideButtons()
    On Error GoTo ErrorHandler:
    Me.AddButton.Visible = False
    Me.DataButton.Visible = False
    Me.FirstButton.Visible = False
    Me.PreviousButton.Visible = False
    Me.NextButton.Visible = False
    Me.LastButton.Visible = False
    Me.EditButton.Visible = False
    Me.RefreshButton.Visible = False
    Me.DeleteButton.Visible = False
    Me.CalculatorButton.Visible = False
    Me.ExcelButton.Visible = False
    Me.UndoButton.Visible = False
    Me.SaveButton.Visible = False
    Me.CompassDocumentQueryButton.Visible = False
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="HideButtons()"
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
    Me.DocumentNumberComboBox.ForeColor = RGB(193, 193, 193)
    Me.DocumentNumberComboBox.BackColor = RGB(33, 33, 33)
    Me.DocumentNumberComboBox.BorderColor = RGB(68, 114, 196)
    Me.FundNameComboBox.ForeColor = RGB(193, 193, 193)
    Me.FundNameComboBox.BackColor = RGB(33, 33, 33)
    Me.FundNameComboBox.BorderColor = RGB(68, 114, 196)
    Me.BocNameComboBox.ForeColor = RGB(193, 193, 193)
    Me.BocNameComboBox.BackColor = RGB(33, 33, 33)
    Me.BocNameComboBox.BorderColor = RGB(68, 114, 196)
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="SetComboBoxColors()"
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
    Me.FundNameComboBox.Value = vbNullString
    Me.DocumentNumberComboBox.Value = vbNullString
    Me.BocNameComboBox.Value = vbNullString
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="ClearComboBoxValues()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ResetOptionGroupValues()
    On Error GoTo ErrorHandler:
    FiscalYearOptionGroup.Value = 2
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="ResetOptionGroupValues()"
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
    FundNameFilter = vbNullString
    BocNameFilter = vbNullString
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="ClearFilterValues()"
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
    ResetOptionGroupValues
    FiscalYearFilter = "[BFY] = '2022'"
    Me.Filter = FiscalYearFilter
    Me.Caption = "Budget Execution"
    Me.RecordSource = "SELECT * FROM Obligations" _
        & " WHERE " & Me.Filter
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT Obligations.FundName" _
        & " FROM Obligations" _
        & " WHERE " & Me.Filter
    Me.DocumentNumberComboBox.RowSource = "SELECT DISTINCT Obligations.DocumentControlNumber" _
        & " FROM Obligations" _
        & " WHERE " & Me.Filter
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT Obligations.BocName" _
        & " FROM Obligations" _
        & " WHERE " & Me.Filter
    Me.Requery
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="RefreshButton_Click()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        FiscalYearOptionGroup_AfterUpdate
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetFiscalYearOptionValue(pBFY As String)
    On Error GoTo ErrorHandler:
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    If Not pBFY & "" = "" Then
        Select Case pBFY
            Case "2021"
                Args.BFY = "2021"
                FiscalYearFilter = "[BFY] = '2021'"
                Me.FiscalYearOptionGroup.Value = 1
            Case "2022"
                Args.BFY = "2022"
                FiscalYearFilter = "[BFY] = '2022'"
                Me.FiscalYearOptionGroup.Value = 2
            Case Else
                Args.BFY = "2022"
                FiscalYearFilter = "[BFY] = '2022'"
                Me.FiscalYearOptionGroup.Value = 2
        End Select
    End If
ErrorHandler:
    ProcessError Name:="HeadQuartersAllocationForm", _
        Member:="SetFiscalYearOptionValue()"
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
    Me.Filter = vbNullString
    FiscalYearFilter = vbNullString
    Select Case Me.FiscalYearOptionGroup.Value
        Case 1
            Args.BFY = "2021"
            FiscalYearFilter = "[BFY] = '2021'"
            Me.Filter = RpioNameFilter & pAnd & FiscalYearFilter
            Me.RecordSource = "SELECT * FROM Obligations WHERE " & Me.Filter
            Me.Requery
        Case 2
            Args.BFY = "2022"
            FiscalYearFilter = "[BFY] = '2022'"
            Me.Filter = RpioNameFilter & pAnd & FiscalYearFilter
            Me.RecordSource = "SELECT * FROM Obligations WHERE " & Me.Filter
            Me.Requery
        Case Else
            Args.BFY = "2022"
            FiscalYearFilter = "[BFY] = '2022'"
            Me.Filter = RpioNameFilter & pAnd & FiscalYearFilter
            Me.RecordSource = "SELECT * FROM Obligations WHERE " & Me.Filter
            Me.Requery
    End Select
    Me.FundNameComboBox.RowSource = "SELECT DISTINCT Obligations.FundName" _
        & " FROM Obligations" _
        & " WHERE " & Me.Filter
    Me.DocumentNumberComboBox.RowSource = "SELECT DISTINCT Obligations.DocumentControlNumber" _
        & " FROM Obligations" _
        & " WHERE " & Me.Filter
    Me.BocNameComboBox.RowSource = "SELECT DISTINCT Obligations.BocName FROM Obligations" _
        & " WHERE " & Me.Filter
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
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
Private Function GetFiscalYearFilter() As String
    On Error GoTo ErrorHandler:
    If Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & FundNameFilter _
                & pAnd & DocumentNumberFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        DocumentNumberFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter _
                & pAnd & DocumentNumberFilter
    End If
    If Not FiscalYearFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        DocumentNumberFilter & "" = "" Then
            GetFiscalYearFilter = FiscalYearFilter
    End If
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="GetFiscalYearFilter()"
    Exit Function
End Function


'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FundNameComboBox_Change()
    On Error GoTo ErrorHandler
    If Args Is Nothing Then
        Set Args = New AccountArgs
    End If
    Me.Filter = vbNullString
    FundNameFilter = vbNullString
    BocNameFilter = vbNullString
    DocumentNumberFilter = vbNullString
    Args.FundCode = Me.FundNameComboBox.Value
    FundNameFilter = "[FundName] = '" & Me.FundNameComboBox.Value & "'"
    Me.Filter = RpioNameFilter & pAnd & GetFundNameFilter
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
    ProcessError Name:="DocumentObligationsForm", _
        Member:="FundNameComboBox_Change()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetFundNameFilter
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetFundNameFilter() As String
    On Error GoTo ErrorHandler:
    If Not FundNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetFundNameFilter = DocumentNumberFilter & pAnd _
                & FundNameFilter & pAnd _
                & FiscalYearFilter
    End If
    If Not FundNameFilter & "" = "" And _
        Not DocumentNumberFilter & "" = "" And _
        FiscalYearFilter & "" = "" Then
            GetFundNameFilter = DocumentNumberFilter & pAnd _
                & FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        DocumentNumberFilter & "" = "" And _
        FiscalYearFilter & "" = "" Then
            GetFundNameFilter = FundNameFilter
    End If
    If Not FundNameFilter & "" = "" And _
        DocumentNumberFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetFundNameFilter = FiscalYearFilter _
                & pAnd & FundNameFilter
    End If
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="GetFundNameFilter()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
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
    DocumentNumberFilter = "[DocumentControlNumber] = '" & Me.DocumentNumberComboBox.Value & "'"
    Me.Filter = RpioNameFilter & pAnd & GetDocumentNumberFilter
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
    ProcessError Name:="DocumentObligationsForm", _
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
        Not FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetDocumentNumberFilter = DocumentNumberFilter _
                & pAnd & FundNameFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not DocumentNumberFilter & "" = "" And _
        Not FundNameFilter & "" = "" And _
        FiscalYearFilter & "" = "" Then
            GetDocumentNumberFilter = DocumentNumberFilter _
                & pAnd & FundNameFilter
    End If
    If Not DocumentNumberFilter & "" = "" And _
        FundNameFilter & "" = "" And _
        Not FiscalYearFilter & "" = "" Then
            GetDocumentNumberFilter = DocumentNumberFilter _
                & pAnd & FiscalYearFilter
    End If
    If Not DocumentNumberFilter & "" = "" And _
        FundNameFilter & "" = "" And _
         FiscalYearFilter & "" = "" Then
            GetDocumentNumberFilter = DocumentNumberFilter
    End If
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="GetDocumentNumberFilter()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:            Event / Sub-Procedure
'   Name:
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
    Args.BocName = Me.BocNameComboBox.Value
    BocNameFilter = "[BocName] = '" & Me.BocNameComboBox.Value & "'"
    Me.Filter = RpioNameFilter & pAnd & GetBocNameFilter
    Me.RecordSource = "SELECT * FROM Obligations" _
        & " WHERE NOT IsNull(DocumentControlNumber)" _
        & pAnd & "[BocCode] NOT IN ('10', '17')" _
        & pAnd & Me.Filter
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
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
    ProcessError Name:="DocumentObligationsForm", _
        Member:="GetBocNameFilter()"
    Exit Function
End Function


'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Close()
    On Error GoTo ErrorHandler:
    RpioNameFilter = vbNullString
    Me.Filter = vbNullString
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="Form_Close()"
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
    ProcessError Name:="DocumentObligationsForm", _
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
    ProcessError Name:="DocumentObligationsForm", _
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
    ProcessError Name:="DocumentObligationsForm", _
        Member:="OriginalActionDateTextBox_Enter()"
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub LastActvityDateTextBox_Enter()
    On Error GoTo ErrorHandler:
    DoCmd.OpenForm "BudgetCalendar", , , , , , Me.OriginalActionDateTextBox
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="LastActvityDateTextBox_Enter()"
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
    ProcessError Name:="DocumentObligationsForm", _
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
Private Function GetColumnNames() As String()
    On Error GoTo ErrorHandler:
    Dim mFields As Collection
    Dim field As DAO.field
    Dim mData As DAO.Recordset
    Set mData = Me.Recordset
    Dim i As Integer
    Dim j As Integer
    Dim mArray() As String
    j = mData.Fields.Count - 1
    ReDim mArray(j)
    For i = LBound(mArray()) To UBound(mArray())
        If Not mData.Fields(i).Name & "" = "" Then
            mArray(i) = mData.Fields(i).Name
        End If
    Next i
    GetColumnNames = mArray()
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="GetColumnNames()"
    Exit Function
End Function



'----------------------------------------------------------------------------------
'   Type:        Function
'   Name:        GetReportData
'   Parameters:  Void
'   Retval:      DAO Recordset
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetReportData() As DAO.Recordset
    On Error GoTo ErrorHandler:
    Dim mData As DAO.Recordset
    Set mData = Me.Recordset
    mData.Filter = Me.Filter
    Set GetReportData = mData
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
        Member:="GetReportData()"
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
    Dim mFields() As String
    mFields() = GetColumnNames
    Dim mBudgetPath As BudgetPath
    Dim mExcel As Excel.Application
    Dim mAllocations As Excel.Workbook
    Dim mWorksheet As Excel.Worksheet
    Dim mList As Excel.ListObject
    Dim mRange As Excel.Range
    Dim mCell As Object
    Dim mHeader As Excel.Range
    Dim mStart As Excel.Range
    Dim mEnd As Excel.Range
    Dim field As DAO.field
    Dim mData As DAO.Recordset
    Dim i As Integer
    Dim j As Integer
    Set mBudgetPath = New BudgetPath
    Set mExcel = CreateObject("Excel.Application")
    Set mAllocations = mExcel.Workbooks.Open(mBudgetPath.ReportTemplate)
    mAllocations.Worksheets(2).Visible = False
    Set mWorksheet = mAllocations.Worksheets(1)
    mWorksheet.Name = "Obligations By DCN"
    mWorksheet.Cells.HorizontalAlignment = xlHAlignLeft
    mWorksheet.Cells.Font.Name = "Source Code Pro"
    mWorksheet.Cells.Font.Size = 8
    Set mStart = mWorksheet.Cells(1, 1)
    Set mEnd = mWorksheet.Cells(1, UBound(mFields) - 1)
    Set mHeader = mWorksheet.Range(mStart, mEnd)
    mHeader.HorizontalAlignment = xlHAlignLeft
    mHeader.Borders(xlEdgeBottom).Color = RGB(0, 0, 0)
    mHeader.Font.Name = "Source Code Pro"
    mHeader.Font.Color = vbBlack
    mHeader.Font.Bold = True
    mHeader.Font.Size = 8
    For i = LBound(mFields) To UBound(mFields)
        mHeader.Cells(i + 1).Value = mFields(i)
    Next i
    Set mData = Me.Recordset
    mData.Filter = Me.Filter
    mWorksheet.Cells(2, 1).CopyFromRecordset mData
    mHeader.Font.Color = vbBlack
    mExcel.WindowState = xlMaximized
    mExcel.Visible = True
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
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
    ProcessError Name:="DocumentObligationsForm", _
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
    ProcessError Name:="DocumentObligationsForm", _
        Member:="SaveButton_Click()"
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
    ProcessError Name:="DocumentObligationsForm", _
        Member:="DeleteButton_Click()"
    Exit Sub
End Sub








'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        SetNpmIcon
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub SetRpioIcon(pRpioCode As String)
    On Error GoTo ErrorHandler:
    If Not pRpioCode & "" = "" Then
        Select Case CStr(pRpioCode)
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
                    & "\etc\png\AppIcons\interface\RPIO\OCFO.png"
        End Select
    End If
ErrorHandler:
    ProcessError Name:="DocumentObligationsForm", _
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



v