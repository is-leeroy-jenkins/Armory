Option Compare Database
Option Explicit

Private m_Error As String




'---------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler
    'Me.lblVersion.Caption = "Version: " & DMax("V_Number", "tbl_VersionHistory")
    If IsFormOpen("ChartConfig") = True Then
        Forms!ChartConfig.Visible = False
    End If
ErrorHandler:
    ProcessError Name:="BudgetChartForm", _
        Member:="Form_Load()"
    Exit Sub
End Sub





'---------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Sub CreateChart_Click()
    On Error GoTo ErrorHandler
    'Declarations
    Dim p_Chart As Chart
    Dim p_Data As DAO.Recordset
    
    'Make sure ChartConfig is open
    If IsFormOpen("ChartConfig") = False Then
        DoCmd.OpenForm "ChartConfig", acNormal
        If Forms!ChartConfig.Visible = False Then
            Forms!ChartConfig.Visible = True
        End If
        Forms!ChartConfig.SetFocus
    End If
    If IsFormOpen("ChartConfig") = True And Forms!ChartConfig.Visible = False Then
        Forms!ChartConfig.Visible = True
    End If
    
    'Create a new instance
    Set p_Chart = New Chart
    
    'Connect the web browser control to the class module
    Set p_Chart.control = Me.ctlWebbrowser
    
    'Define type of chart
    p_Chart.ChartType = Forms!ChartConfig.fraChartType
    p_Chart.StackedChart = Forms!ChartConfig.chkStackedChart
    p_Chart.AreaFilled = Forms!ChartConfig.chkAreaFilled
    
    'Define datasource
    Select Case Forms!ChartConfig.fraDataSource
        Case 1  'Table
            p_Chart.DataSourceObjectName = "tbl_DemoData"
        Case 2  'Query
            p_Chart.DataSourceObjectName = "qry_DemoData"
        Case 3  'SQL-Statement
            p_Chart.DataSourceSQLStatement = "Select * from tbl_DemoData order by pkid desc"
        Case 4  'Recordset
            Set p_Data = CurrentDb.OpenRecordset("Select * from tbl_DemoData order by pkid desc")
            Set p_Chart.DataSourceRecordset = p_Data
        Case 5  'None
            'Do Nothing
    End Select
    p_Chart.DataSourceLabelFieldName = "DataLabel"
    p_Chart.DataSourceDataFieldName = Array("Dataset1", "Dataset2", "Dataset3")
    
    'Define title
    p_Chart.ShowTitle = Forms!ChartConfig.chkShowTitle
    p_Chart.TitlePostition = Forms!ChartConfig.fraTitlePosition
    p_Chart.TitleText = Forms!ChartConfig.txtTitleText
    
    'Define legend
    p_Chart.ShowLegend = Forms!ChartConfig.chkShowLegend
    p_Chart.LegendPostition = Forms!ChartConfig.fraLegendPosition
    
    'Define axis
    p_Chart.ShowYAxis = Forms!ChartConfig.chkShowYAxis
    p_Chart.ShowXAxis = Forms!ChartConfig.chkShowXAxis
    p_Chart.YAxisLabelText = Nz(Forms!ChartConfig.txtLabelYAxis, vbNullString)
    p_Chart.XAxisLabelText = Nz(Forms!ChartConfig.txtLabelXAxis, vbNullString)
    p_Chart.YAxisBeginAtZero = Nz(Forms!ChartConfig.chkYAxisBeginAtZero, False)
    p_Chart.XAxisBeginAtZero = Nz(Forms!ChartConfig.chkXAxisBeginAtZero, False)
    
    'Define chart.js
    p_Chart.ChartJsSource = Forms!ChartConfig.cboChartJsSource
    p_Chart.ChartJsCDN = Forms!ChartConfig.txtChartJsCDN
    p_Chart.ChartJsPathFilename = Forms!ChartConfig.txtChartJsPathFilename
    
    'define color scheme plug-in
    p_Chart.ColorSchemaSource = Forms!ChartConfig.cboColorSchemaSource
    p_Chart.ColorSchemaCDN = Forms!ChartConfig.txtColorSchemaCDN
    p_Chart.ColorSchemaPathFilename = Forms!ChartConfig.txtColorSchemaPathFilename
    
    'Color schema
    p_Chart.ColorSchema = Forms!ChartConfig.cboChartColorSchema
    p_Chart.ChartBackgroundColor = Nz(Forms!ChartConfig.txtChartBackgroundColor, "#EAEAEA")
    
    'Default font
    p_Chart.DefaultFontColor = Nz(Forms!ChartConfig.txtDefaultFontColor, "Black")
    p_Chart.DefaultFontFamily = Nz(Forms!ChartConfig.txtDefaultFontFamily, vbNullString)
    p_Chart.DefaultFontSize = Nz(Forms!ChartConfig.txtDefaultFontSize, 0)
    
    'Draw chart
    p_Chart.DrawChart
ErrorHandler:
    ProcessError Name:="BudgetChartForm", _
        Member:="CreatChart_Click()"
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




