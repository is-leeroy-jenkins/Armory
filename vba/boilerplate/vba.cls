Sub SaveWorkshetAsPDF()
	Dimws As Worksheet
	For Each ws In Worksheets
		ws.ExportAsFixedFormat _
		xlTypePDF, _
		"ENTER-FOLDER-NAME-HERE" & _
		ws.Name & ".pdf"
	Next ws
End Sub


Sub FileBackUp()
	ThisWorkbook.SaveCopyAs Filename:=ThisWorkbook.Path & _
		"" & Format(Date, "mm-dd-yy") & " " & _
	ThisWorkbook.name
End Sub


Sub CopyWorksheetToNewWorkbook()
	ThisWorkbook.ActiveSheet.Copy Before:=Workbooks.Add.Worksheets(1)
End Sub


Sub SendEmail()
	Dim p_Outlook As Object
	Dim p_EmailItem As Object
	Set p_Outlook = CreateObject("Outlook.Application")
	Set p_EmailItem = p_Outlook.CreateItem(0)
	With p_EmailItem
		.to = "Sales@FrontLinePaper.com"
		.Subject = "Growth Report"
		.Body = "Hello Team, Please find attached Growth Report."
		.Attachments.Add ActiveWorkbook.FullName
		.display
	End With
	Set p_EmailItem = Nothing
	Set p_Outlook = Nothing
End Sub




Sub OpenWorkbookAsAttachment()
	Application.Dialogs(xlDialogSendMail).Show
End Sub


Sub HideSubtotals()
    Dim pt As PivotTable
    Dim pf As PivotField
    On Error Resume Next
    Set pt = ActiveSheet.PivotTables(ActiveCell.PivotTable.Name)
    If pt Is Nothing Then
        MsgBox "You must place your cursor inside of a PivotTable."
        Exit Sub
    End If
    For Each pf In pt.PivotFields
        pf.Subtotals(1) = True
        pf.Subtotals(1) = False
    Next pf
End Sub



Sub RefreshPivotTables()
    Dim pt As PivotTable
    For Each pt In ActiveWorkbook.PivotTables
        pt.RefreshTable
    Next pt
End Sub


Sub CreatePivotTable()
	'PURPOSE: Creates a brand new Pivot table on a new worksheet from data in the ActiveSheet
	'Source: www.TheSpreadsheetGuru.com

	Dim sht As Worksheet
	Dim pvtCache As PivotCache
	Dim pvt As PivotTable
	Dim StartPvt As String
	Dim SrcData As String

	'Determine the data range you want to pivot
	SrcData = ActiveSheet.Name & "!" & Range("A1:R100").Address(ReferenceStyle:=xlR1C1)

	'Create a new worksheet
	Set sht = Sheets.Add

	'Where do you want Pivot Table to start?
	StartPvt = sht.Name & "!" & sht.Range("A3").Address(ReferenceStyle:=xlR1C1)

	'Create Pivot Cache from Source Data
	Set pvtCache = ActiveWorkbook.PivotCaches.Create( _
		SourceType:=xlDatabase, _
		SourceData:=SrcData)

	'Create Pivot table from Pivot Cache
	Set pvt = pvtCache.CreatePivotTable( _
		TableDestination:=StartPvt, _
		TableName:="PivotTable1")

End Sub




Sub Adding_PivotFields()
	'PURPOSE: Show how to add various Pivot Fields to Pivot Table
	'SOURCE: www.TheSpreadsheetGuru.com
	Dim pvt As PivotTable
	Set pvt = ActiveSheet.PivotTables("PivotTable1")    
  'Add item to the Report Filter
    pvt.PivotFields("Year").Orientation = xlPageField  
  'Add item to the Column Labels
    pvt.PivotFields("Month").Orientation = xlColumnField    
  'Add item to the Row Labels
    pvt.PivotFields("Account").Orientation = xlRowField   
  'Position Item in list
    pvt.PivotFields("Year").Position = 1   
  'Format Pivot Field
    pvt.PivotFields("Year").NumberFormat = "#,##0"    
  'Turn on Automatic updates/calculations --like screenupdating to speed up code
    pvt.ManualUpdate = False
End Sub





Sub Adding_PivotFields()
	'PURPOSE: Show how to add various Pivot Fields to Pivot Table
	'SOURCE: www.TheSpreadsheetGuru.com
	Dim pvt As PivotTable
	Set pvt = ActiveSheet.PivotTables("PivotTable1")		
	'Add item to the Report Filter
		pvt.PivotFields("Year").Orientation = xlPageField	
	'Add item to the Column Labels
		pvt.PivotFields("Month").Orientation = xlColumnField		
	'Add item to the Row Labels
		pvt.PivotFields("Account").Orientation = xlRowField		
	'Position Item in list
		pvt.PivotFields("Year").Position = 1		
	'Format Pivot Field
		pvt.PivotFields("Year").NumberFormat = "#,##0"		
	'Turn on Automatic updates/calculations --like screenupdating to speed up code
		pvt.ManualUpdate = False		
End Sub




Sub ReportFiltering_Single()
'PURPOSE: Filter on a single item with the Report Filter field
'SOURCE: www.TheSpreadsheetGuru.com

Dim pf As PivotField

Set pf = ActiveSheet.PivotTables("PivotTable2").PivotFields("Fiscal_Year")

'Clear Out Any Previous Filtering
  pf.ClearAllFilters

'Filter on 2014 items
  pf.CurrentPage = "2014"

End Sub



Sub ReportFiltering_Multiple()
'PURPOSE: Filter on multiple items with the Report Filter field
'SOURCE: www.TheSpreadsheetGuru.com

Dim pf As PivotField

Set pf = ActiveSheet.PivotTables("PivotTable2").PivotFields("Variance_Level_1")

'Clear Out Any Previous Filtering
  pf.ClearAllFilters

'Enable filtering on multiple items
    pf.EnableMultiplePageItems = True
    
'Must turn off items you do not want showing
    pf.PivotItems("Jan").Visible = False
    pf.PivotItems("Feb").Visible = False
    pf.PivotItems("Mar").Visible = False

End Sub



Sub ClearReportFiltering()
	'PURPOSE: How to clear the Report Filter field
	'SOURCE: www.TheSpreadsheetGuru.com

	Dim pf As PivotField

	Set pf = ActiveSheet.PivotTables("PivotTable2").PivotFields("Fiscal_Year")

	'Option 1: Clear Out Any Previous Filtering
	pf.ClearAllFilters
	
	'Option 2: Show All (remove filtering)
	pf.CurrentPage = "(All)"

End Sub




Sub RefreshingPivotTables()
	'PURPOSE: Shows various ways to refresh Pivot Table Data
	'SOURCE: www.TheSpreadsheetGuru.com

	'Refresh A Single Pivot Table
	ActiveSheet.PivotTables("PivotTable1").PivotCache.Refresh
	
	'Refresh All Pivot Tables
	ActiveWorkbook.RefreshAll
		
End Sub



Sub ChangePivotDataSourceRange()
	'PURPOSE: Change the range a Pivot Table pulls from
	'SOURCE: www.TheSpreadsheetGuru.com

	Dim sht As Worksheet
	Dim SrcData As String
	Dim pvtCache As PivotCache

	'Determine the data range you want to pivot
	Set sht = ThisWorkbook.Worksheets("Sheet1")
	SrcData = sht.Name & "!" & Range("A1:R100").Address(ReferenceStyle:=xlR1C1)
	
	'Create New Pivot Cache from Source Data
	Set pvtCache = ActiveWorkbook.PivotCaches.Create( _
		SourceType:=xlDatabase, _
		SourceData:=SrcData)

	'Change which Pivot Cache the Pivot Table is referring to
	ActiveSheet.PivotTables("PivotTable1").ChangePivotCache (pvtCache)

End Sub




Sub PivotGrandTotals()
	'PURPOSE: Show setup for various Pivot Table Grand Total options
	'SOURCE: www.TheSpreadsheetGuru.com

	Dim pvt As PivotTable

	Set pvt = ActiveSheet.PivotTables("PivotTable1")

	'Off for Rows and Columns
	pvt.ColumnGrand = False
	pvt.RowGrand = False

	'On for Rows and Columns
	pvt.ColumnGrand = True
	pvt.RowGrand = True

	'On for Rows only
	pvt.ColumnGrand = False
	pvt.RowGrand = True
	
	'On for Columns Only
	pvt.ColumnGrand = True
	pvt.RowGrand = False

End Sub



Sub PivotReportLayout()
	'PURPOSE: Show setup for various Pivot Table Report Layout options
	'SOURCE: www.TheSpreadsheetGuru.com

	Dim pvt As PivotTable

	Set pvt = ActiveSheet.PivotTables("PivotTable1")

	'Show in Compact Form
	pvt.RowAxisLayout xlCompactRow

	'Show in Outline Form
	pvt.RowAxisLayout xlOutlineRow
	
	'Show in Tabular Form
	pvt.RowAxisLayout xlTabularRow
    
End Sub




Sub PivotTable_DataFormatting()
	'PURPOSE: Various ways to format a Pivot Table's data
	'SOURCE: www.TheSpreadsheetGuru.com

	Dim pvt As PivotTable

	Set pvt = ActiveSheet.PivotTables("PivotTable1")

	'Change Data's Number Format
	pvt.DataBodyRange.NumberFormat = "#,##0;(#,##0)"

	'Change Data's Fill Color
	pvt.DataBodyRange.Interior.Color = RGB(0, 0, 0)

	'Change Data's Font Type
	pvt.DataBodyRange.Font.FontStyle = "Arial"

End Sub




Sub PivotField_DataFormatting()
	'PURPOSE: Various ways to format a Pivot Field's data
	'SOURCE: www.TheSpreadsheetGuru.com

	Dim pf As PivotField

	Set pf = ActiveSheet.PivotTables("PivotTable1").PivotFields("Months")

	'Change Data's Number Format
	pf.DataRange.NumberFormat = "#,##0;(#,##0)"
	
	'Change Data's Fill Color
	pf.DataRange.Interior.Color = RGB(219, 229, 241)

	'Change Data's Font Type
	pf.DataRange.Font.FontStyle = "Arial"

End Sub



Sub PivotField_ExpandCollapse()
	'PURPOSE: Shows how to Expand or Collapse the detail of a Pivot Field
	'SOURCE: www.TheSpreadsheetGuru.com

	Dim pf As PivotField

	Set pf = ActiveSheet.PivotTables("PivotTable1").PivotFields("Month")

	'Collapse Pivot Field
	pf.ShowDetail = False
	
	'Expand Pivot Field
	pf.ShowDetail = True

End Sub


Sub AdjustPivotDataRange()
	'PURPOSE: Automatically readjust a Pivot Table's data source range
	'SOURCE: www.TheSpreadsheetGuru.com/The-Code-Vault

	Dim Data_sht As Worksheet
	Dim Pivot_sht As Worksheet
	Dim StartPoint As Range
	Dim DataRange As Range
	Dim PivotName As String
	Dim NewRange As String

	'Set Variables Equal to Data Sheet and Pivot Sheet
	Set Data_sht = ThisWorkbook.Worksheets("Sheet1")
	Set Pivot_sht = ThisWorkbook.Worksheets("Sheet2")

	'Enter in Pivot Table Name
	PivotName = "PivotTable1"

	'Dynamically Retrieve Range Address of Data
	Set StartPoint = Data_sht.Range("A1")
	Set DataRange = Data_sht.Range(StartPoint, StartPoint.SpecialCells(xlLastCell))
	
	NewRange = Data_sht.Name & "!" & _
		DataRange.Address(ReferenceStyle:=xlR1C1)

	'Make sure every column in data set has a heading and is not blank (error prevention)
	If WorksheetFunction.CountBlank(DataRange.Rows(1)) > 0 Then
		MsgBox "One of your data columns has a blank heading." & vbNewLine _
		& "Please fix and re-run!.", vbCritical, "Column Heading Missing!"
		Exit Sub
	End If

	'Change Pivot Table Data Source Range Address
	Pivot_sht.PivotTables(PivotName).ChangePivotCache _
		ThisWorkbook.PivotCaches.Create( _
		SourceType:=xlDatabase, _
		SourceData:=NewRange)
		
	'Ensure Pivot Table is Refreshed
	Pivot_sht.PivotTables(PivotName).RefreshTable

	'Complete Message
	MsgBox PivotName & "'s data source range has been successfully updated!"

End Sub