
Sub WorksheetIterate()
    Dim p_Worksheet As Excel.Worksheet
    Dim p_Names() As String
    Dim i As Integer
    ReDim p_Names(1 To ActiveWorkbook.Worksheets.count)
    i = 1
    For Each p_Worksheet In ActiveWorkbook.Worksheets
        p_Names(i) = p_Worksheet.Name ' get the name of each worksheet and save it in the array
        i = i + 1
    Next p_Worksheet
End Sub


Sub WorkbookIterate()
    Dim p_Workbook As Excel.Workbook
    Dim p_FileName As String
    Dim p_FilePath As String
    Dim p_Cell As Excel.Range
    Dim p_Range As Excel.Range
    Dim wsO As Excel.Worksheet
    Dim p_Worksheet As Excel.Worksheet
    p_FilePath = "pathtofile(s)" & "\"
    p_FileName = Dir(p_FilePath & "*.xl??")
    Set wsO = ThisWorkbook.Sheets("Sheet1") 
    Do While Len(p_FileName) > 0
        DoEvents
        Set p_Workbook = Workbooks.Open(p_FilePath & p_FileName, True, True)
            For Each p_Worksheet As Excel.Worksheet In ActiveWorkbook.Worksheets 
                Set p_Range = p_Worksheet As Excel.Worksheet.Range("a1:a1000") 'OBV needs to be changed
                For Each p_Cell In p_Range.Cells
                    If p_Cell <> vbNullString _ 
                        And p_Cell.Value <> vbNullString _ 
                        And p_Cell.Value <> 0 Then
                    End If
                Next p_Cell
            Next p_Worksheet As Excel.Worksheet
        p_Workbook.Close False
        p_FileName = Dir
    Loop
 End Sub



Sub LoopAllSheets()
    Dim p_Worksheet As Excel.Worksheet
    Dim p_Names() As String
    Dim i As Integer
    ReDim p_Names(1 To ActiveWorkbook.Worksheets.count)
    i = 1
    For Each p_Worksheet In ActiveWorkbook.Worksheets
        p_Names(i) = p_Worksheet.Name 
        i = i + 1
    Next p_Worksheet
End Sub


Sub OpenMultiFileDialog()
    Dim p_FileDialog As FileDialog
    Dim p_Selected As Integer
    Dim i As Integer
    Dim p_BaseName As String
    Dim p_FileSys As Object
    Set p_FileSys = CreateObject("Scripting.FileSystemObject")
    Set p_FileDialog = Application.FileDialog(msoFileDialogFilePicker)
    p_BaseName = p_FileSys.GetBaseName(ActiveWorkbook.Name)
    p_FileDialog.InitialFileName = ActiveWorkbook.Path
    p_FileDialog.InitialView = msoFileDialogViewList
    p_FileDialog.AllowMultiSelect = True   
    p_Selected = p_FileDialog.Show
    If p_Selected = -1 Then
        For i = 1 To p_FileDialog.SelectedItems.Count
            Dim fileName As String
            fileName = p_FileSys.getFileName(p_FileDialog.SelectedItems(i))
        Next i
    End If
End Sub

Function CreatePivotTable(ByRef pRange As Excel.Range) As Excel.PivotTable
    Dim p_PivotTable As Excel.PivotTable
    Dim p_Datasheet As Excel.Worksheet
    Dim p_Pivotsheet As Excel.Worksheet
    Dim p_PivotCache As Excel.PivotCache
    Set p_PivotCache = ThisWorkbook.PivotCaches.Create(SourceType:=xlDatabase, SourceData:=pRange)
    Set p_Pivotsheet = ThisWorkbook.Sheets.Add
    Set p_PivotTable = p_PivotCache.CreatePivotTable(TableDestination:=p_Pivotsheet.Range("A3"))
    Set CreatePivotTable = p_PivotTable
End Function


Public Sub AddPivotColumn()
    Dim p_PivotTable As PivotTable
    Dim p_Pivotsheet As Worksheet
    Dim p_PivotField As PivotField
    Set p_Pivotsheet = ThisWorkbook.Sheets("SheetNameWithPivotTable")
    Set p_PivotTable = p_Pivotsheet.PivotTables(1)
    With p_PivotTable
        Set p_PivotField = .PivotFields("Gender")
        p_PivotField.Orientation = xlRowField
        p_PivotField.Position = 1
        Set p_PivotField = .PivotFields("LastName")
        p_PivotField.Orientation = xlRowField
        p_PivotField.Position = 2
        Set p_PivotField = .PivotFields("ShirtSize")
        p_PivotField.Orientation = xlColumnField
        p_PivotField.Position = 1
        Set p_PivotField = .AddDataField(.PivotFields("Cost"), "Sum of Cost", xlSum)
        .InGridDropZones = True
        .RowAxisLayout xlTabularRow
    End With
End Sub



Function ImportExcelFile()		
    Dim sFileName As String
    Dim rs2 As New ADODB.Recordset
    Dim cnn2 As New ADODB.Connection
    Dim cmd2 As New ADODB.Command        
    sFileName = dhFileDialog(strFilter:="Microsoft Excel (*.xlsx)" & vbNullChar & "*.xlsx" & vbNullChar & vbNullChar, _
        strDialogTitle:="Open", lngFlags:=dhOFN_OPENEXISTING, fOpenFile:=False)
        With cnn2
            .Provider = "Microsoft.Jet.OLEDB.4.0"
            .ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" _
                & sFileName _
                & ";ExtendedProperties=""" _ 
                & "Excel 12.0 Xml;HDR=YES;IMEX=1;" & """"
            .Open
        End With   
    Set cmd2.ActiveConnection = cnn2
    cmd2.CommandType = adCmdText
    cmd2.CommandText = "SELECT * FROM [Sheet1$]"
    rs2.CursorLocation = adUseClient
    rs2.CursorType = adOpenStatic
    rs2.LockType = adLockReadOnly
    rs2.Open cmd2  
    DoCmd.SetWarnings False
    Dim sql As String
    Dim sWeight As Double
    Dim sWeightTotal As Double
    While Not rs2.EOF
        If Trim(rs2(13)) = "" Or Not IsNumeric(Trim(rs2(13))) Then
            sWeight = 0
        Else
            sWeight = rs2(13)
        End If
        If Trim(rs2(14)) = "" Or Not IsNumeric(Trim(rs2(14))) Then
            sWeightTotal = 0
        Else
            sWeightTotal = rs2(14)
        End If
        sql = "'" & rs2(0) & "'," & rs2(1) & ",'" & rs2(2) & "','" & rs2(3) & "','" & rs2(4) & "','" & rs2(5) & "'," & sWeight & "," & sWeightTotal
        DoCmd.RunSQL "INSERT INTO tblYourTable ( Field1, Field2, Field3, Field4, Field5, Field6, Field7, Field8 ) Values (" & sql & " )"
        rs2.MoveNext
    Wend
    DoCmd.SetWarnings True
    rs2.Close
    cnn2.Close
Exit Sub


Sub CustomHeader()
    Dim p_HeaderText As String
    p_HeaderText = InputBox("Enter your text here", "Enter Text")
    With ActiveSheet.PageSetup
    .LeftHeader = ""
    .CenterHeader = p_HeaderText
    .RightHeader = ""
    .LeftFooter = ""
    .CenterFooter = ""
    .RightFooter = ""
    End With
End Sub



Sub ProtectAllWorskeets()
    Dim p_Worksheet As Worksheet
    Dim ps As String
    ps = InputBox("Enter a Password.", vbOKCancel)
    For Each p_Worksheet In ActiveWorkbook.Worksheets
    p_Worksheet.Protect Password:=ps
    Next p_Worksheet
End Sub


Sub HideWorksheet()
    Dim p_Worksheet As Worksheet
    For Each p_Worksheet In ThisWorkbook.Worksheets
    If p_Worksheet.Name <> ThisWorkbook.ActiveSheet.Name Then
    p_Worksheet.Visible = xlSheetHidden
    End If
    Next p_Worksheet
End Sub


Sub UnhideAllWorksheet()
    Dim p_Worksheet As Worksheet
    For Each p_Worksheet In ActiveWorkbook.Worksheets
    p_Worksheet.Visible = xlSheetVisible
    Next p_Worksheet
End Sub


Sub DeleteWorksheets()
    Dim p_Worksheet As Worksheet
    For Each p_Worksheet In ThisWorkbook.Worksheets
    If p_Worksheet.name <> ThisWorkbook.ActiveSheet.name Then
    Application.DisplayAlerts = False
    p_Worksheet.Delete
    Application.DisplayAlerts = True
    End If
    Next p_Worksheet
End Sub


Sub SaveWorkshetAsPDF()
    Dim p_Worksheet As Excel.Worksheet
    For Each p_Worksheet In Worksheets
    p_Worksheet.ExportAsFixedFormat _
    xlTypePDF, _
    "ENTER-FOLDER-NAME-HERE" & _
    p_Worksheet.Name & ".pdf"
    Next p_Worksheet
End Sub

Sub SendEmail( pReceiver As String, pSubject As String, pBody As String)
    Dim p_Outlook As Object
    Dim p_MailItem As Object
    Set p_Outlook = CreateObject("Outlook.Application")
    Set p_MailItem = p_Outlook.CreateItem(0)
    With p_MailItem
        .to = pReceiver
        .Subject = pSubject
        .Body = pBody
        .Attachments.Add ActiveWorkbook.FullName
        .display
    End With
    Set p_MailItem = Nothing
    Set p_Outlook = Nothing
End Sub


Sub UpdatePivotTableRange()
    Dim Data_Sheet As Worksheet
    Dim Pivot_Sheet As Worksheet
    Dim StartPoint As Range
    Dim DataRange As Range
    Dim PivotName As String
    Dim NewRange As String
    Dim LastCol As Long
    Dim lastRow As Long
    'Set Pivot Table & Source Worksheet
    Set Data_Sheet = ThisWorkbook.Worksheets("PivotTableData3")
    Set Pivot_Sheet = ThisWorkbook.Worksheets("Pivot3")
    'Enter in Pivot Table Name
    PivotName = "PivotTable2"
    'Defining Staring Point & Dynamic Range
    Data_Sheet.Activate
    Set StartPoint = Data_Sheet.Range("A1")
    LastCol = StartPoint.End(xlToRight).Column
    DownCell = StartPoint.End(xlDown).Row
    Set DataRange = Data_Sheet.Range(StartPoint, Cells(DownCell, LastCol))
    NewRange = Data_Sheet.Name & "!" & DataRange.Address(ReferenceStyle:=xlR1C1)
    'Change Pivot Table Data Source Range Address
    Pivot_Sheet.PivotTables(PivotName). _
    ChangePivotCache ActiveWorkbook. _
    PivotCaches.Create(SourceType:=xlDatabase, SourceData:=NewRange)
    'Ensure Pivot Table is Refreshed
    Pivot_Sheet.PivotTables(PivotName).RefreshTable
    'Complete Message
    Pivot_Sheet.Activate
    MsgBox "Your Pivot Table is now updated."
End Sub


Sub activateGetPivotData()
    Application.GenerateGetPivotData = True
End Sub


Sub deactivateGetPivotData()
    Application.GenerateGetPivotData = False
End Sub

Sub TableofContent()
    Dim i As Long
    On Error Resume Next
    Application.DisplayAlerts = False
    Worksheets("Table of Content").Delete
    Application.DisplayAlerts = True
    On Error GoTo 0
    ThisWorkbook.Sheets.Add Before:=ThisWorkbook.Worksheets(1)
    ActiveSheet.Name = "Table of Content"
    For i = 1 To Sheets.Count
    With ActiveSheet
    .Hyperlinks.Add _
    Anchor:=ActiveSheet.Cells(i, 1), _
    Address:="", _
    SubAddress:="'" & Sheets(i).Name & "'!A1", _
    ScreenTip:=Sheets(i).Name, _
    TextToDisplay:=Sheets(i).Name
    End With
    Next i
End Sub

Sub SearchWindow32()
    Dim chromePath As String
    Dim search_string As String
    Dim query As String
    query = InputBox("Enter here your search here", "Google Search")
    search_string = query
    search_string = Replace(search_string, " ", "+")
    'Uncomment the following line for Windows 64 versions and comment out Windows 32 versions'
    'chromePath = "C:Program FilesGoogleChromeApplicationchrome.exe"
    'Uncomment the following line for Windows 32 versions and comment out Windows 64 versions
    'chromePath = "C:Program Files (x86)GoogleChromeApplicationchrome.exe"
    Shell (chromePath & " -url http://google.com/#q=" & search_string)
End Sub



Sub removeChar()
    Dim Rng As Range
    Dim rc As String
    rc = InputBox("Character(s) to Replace", "Enter Value")
    For Each Rng In Selection
    Selection.Replace What:=rc, Replacement:=""
    Next
End Sub