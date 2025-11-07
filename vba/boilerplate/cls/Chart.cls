Option Compare Database
Option Explicit


Private Const m_HtmlFileName As String = "BudgetExecutionChart.html"
Private WithEvents m_Control As WebbrowserControl
Private m_ChartType As chChartType
Private m_DataSourceName As String
Private m_SqlStatement As String
Private m_DataSet As DAO.Recordset
Private m_DataSourceLabelFieldName As String
Private m_DataSourceDataFieldName As Variant
Private m_ShowTitle As Boolean
Private m_TitlePostition As chPosition
Private m_TitleText As String
Private m_ShowLegend As Boolean
Private m_LegendPostition As chPosition
Private m_ShowYAxis As Boolean
Private m_ShowXAxis As Boolean
Private m_YAxisLabelText As String
Private m_XAxisLabelText As String
Private m_ChartJsSource As chScriptSource
Private m_ChartJsCDN  As String
Private m_ChartJsPathFilename As String
Private m_StackedChart As Boolean
Private m_ColorSchemaSource As chScriptSource
Private m_ColorSchemaCDN As String
Private m_ColorSchemaPathFilename As String
Private m_ColorSchema As String
Private m_AreaFilled As Boolean
Private m_ChartBackgroundColor As String
Private m_DefaultFontColor As String
Private m_DefaultFontFamily As String
Private m_DefaultFontSize As Integer
Private m_YAxisBeginAtZero As Boolean
Private m_XAxisBeginAtZero As Boolean
Private m_DataLabels As Variant
Private m_DataSetLabel As Variant
Private m_DataSetData As Variant
Private m_IsSingleDataset As Boolean
Private m_IsSingleBarChart As Boolean
Private m_Error As String






'### Enums



'----------------------------------------------------------------------------------
'   Type        Enum
'   Name        chChartType
'   Parameters
'   RetVal
'   Purpose
'---------------------------------------------------------------------------------
Public Enum chChartType
    Line = 1
    Bar = 2
    HorizontalBar = 3
    Radar = 4
    Doughnut = 5
    Pie = 6
    PolarArea = 7
    Bubble = 8
    Scatter = 9
End Enum


'----------------------------------------------------------------------------------
'   Type        Enum
'   Name        chChartType
'   Parameters
'   RetVal
'   Purpose
'---------------------------------------------------------------------------------
Public Enum chPosition
    posTop = 1
    posLeft = 2
    posBottom = 3
    posRight = 4
End Enum


'----------------------------------------------------------------------------------
'   Type        Enum
'   Name        chChartType
'   Parameters
'   RetVal
'   Purpose
'---------------------------------------------------------------------------------
Public Enum chScriptSource
    CDN = 1
    LocalFile = 2
End Enum








'---------------------------------------------------------------------------------
'   Type:            Constructor
'   Name:            Class_Initialize()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Class_Initialize()
    ChartType = chChartType.Bar
    StackedChart = False
    DefaultFontColor = "Black"
    m_ChartBackgroundColor = "#EAEAEA"
    ShowTitle = False
    TitlePostition = posTop
    TitleText = "Budget Execution"
    ShowLegend = False
    LegendPostition = posRight
    ShowYAxis = True
    ShowXAxis = True
    ChartJsSource = chScriptSource.CDN
    ChartJsCDN = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"
    ChartJsPathFilename = CurrentProject.Path & "\Chart.min.js"
    ColorSchemaSource = chScriptSource.CDN
    ColorSchemaCDN = "https://cdn.jsdelivr.net/npm/chartjs-plugin-colorschemes"
    ColorSchemaPathFilename = CurrentProject.Path & "chartjs-plugin-colorschemes.min.js"
    ColorSchema = "tableau.Traffic9"
End Sub




'---------------------------------------------------------------------------------
'   Type:            Sub Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Class_Terminate()
    ' Do Nothing
End Sub

'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Set Control(ByVal pControl As WebbrowserControl)
    On Error GoTo ErrorHandler:
    Set m_Control = pControl
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="Control"
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get Control() As WebbrowserControl
    On Error GoTo ErrorHandler:
    Set Control = m_Control
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="Control"
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ChartType(ByVal pChartType As chChartType)
    On Error GoTo ErrorHandler:
    m_ChartType = pChartType
    Select Case pChartType
        Case chChartType.Bar, chChartType.HorizontalBar, chChartType.Line, chChartType.Bubble, chChartType.Scatter
            ShowYAxis = True
            ShowXAxis = True
        Case chChartType.Doughnut, chChartType.Pie, chChartType.PolarArea, chChartType.Radar
            ShowYAxis = False
            ShowXAxis = False
        Case Else
            'Do Nothing
    End Select
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ChartType"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ChartType() As chChartType
    On Error GoTo ErrorHandler:
    ChartType = m_ChartType
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ChartType"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let DataSourceObjectName(ByVal pDataSourceObjectName As String)
    On Error GoTo ErrorHandler:
    m_DataSourceName = pDataSourceObjectName
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DataSourceObjectName"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get DataSourceObjectName() As String
    On Error GoTo ErrorHandler:
    DataSourceObjectName = m_DataSourceName
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DataSourceObjectName"
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let DataSourceSQLStatement(ByVal pDataSourceSQLStatement As String)
    On Error GoTo ErrorHandler:
    m_SqlStatement = pDataSourceSQLStatement
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DataSourceSQLStatement"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get DataSourceSQLStatement() As String
    On Error GoTo ErrorHandler:
    DataSourceSQLStatement = m_SqlStatement
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DataSourceSQLStatement"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Set DataSourceRecordset(ByVal pDataSourceRecordset As DAO.Recordset)
    On Error GoTo ErrorHandler:
    Set m_DataSet = pDataSourceRecordset
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DataSourceRecordset"
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get DataSourceRecordset() As DAO.Recordset
    On Error GoTo ErrorHandler:
    Set DataSourceRecordset = m_DataSet
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DataSourceRecordset"
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let DataSourceLabelFieldName(ByVal pDataSourceLabelFieldName As String)
    On Error GoTo ErrorHandler:
    m_DataSourceLabelFieldName = pDataSourceLabelFieldName
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DataSourceLabelFieldName"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get DataSourceLabelFieldName() As String
    On Error GoTo ErrorHandler:
    DataSourceLabelFieldName = m_DataSourceLabelFieldName
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DataSourceLabelFieldName"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let DataSourceDataFieldName(ByRef pDataSourceDataFieldName As Variant)
    On Error GoTo ErrorHandler:
    If IsArray(pDataSourceDataFieldName) = True Then
        m_DataSourceDataFieldName = pDataSourceDataFieldName
    Else
        m_DataSourceDataFieldName = Array(pDataSourceDataFieldName)
    End If
    If LBound(m_DataSourceDataFieldName) = UBound(m_DataSourceDataFieldName) Then
        m_IsSingleDataset = True
    Else
        m_IsSingleDataset = False
    End If
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DataSourceDataFieldName"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Variant
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get DataSourceDataFieldName() As Variant
    On Error GoTo ErrorHandler:
    DataSourceDataFieldName = m_DataSourceDataFieldName
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DataSourceDataFieldName"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ShowTitle(ByVal pShowTitle As Boolean)
    On Error GoTo ErrorHandler:
    m_ShowTitle = pShowTitle
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ShowTitle"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ShowTitle() As Boolean
    On Error GoTo ErrorHandler:
    ShowTitle = m_ShowTitle
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ShowTitle"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let TitlePostition(ByVal pTitlePostition As chPosition)
    On Error GoTo ErrorHandler:
    m_TitlePostition = pTitlePostition
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="TitlePostition"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get TitlePostition() As chPosition
    On Error GoTo ErrorHandler:
    TitlePostition = m_TitlePostition
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="TitlePostition"
    Exit Property
End Property





'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let TitleText(ByVal pTitleText As String)
    On Error GoTo ErrorHandler:
    m_TitleText = pTitleText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="TitleText"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get TitleText() As String
    On Error GoTo ErrorHandler:
    TitleText = m_TitleText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="TitleText"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ShowLegend(ByVal pShowLegend As Boolean)
    On Error GoTo ErrorHandler:
    m_ShowLegend = pShowLegend
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ShowLegend"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ShowLegend() As Boolean
    On Error GoTo ErrorHandler:
    ShowLegend = m_ShowLegend
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ShowLegend"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let LegendPostition(ByVal pLegendPostition As chPosition)
    On Error GoTo ErrorHandler:
    m_LegendPostition = pLegendPostition
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="LegendPostition"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get LegendPostition() As chPosition
    On Error GoTo ErrorHandler:
    LegendPostition = m_LegendPostition
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="LegendPostition"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ShowYAxis(ByVal pShowYAxis As Boolean)
    On Error GoTo ErrorHandler:
    m_ShowYAxis = pShowYAxis
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ShowYAxis"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ShowYAxis() As Boolean
    On Error GoTo ErrorHandler:
    ShowYAxis = m_ShowYAxis
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ShowYAxis"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ShowXAxis(ByVal pShowXAxis As Boolean)
    On Error GoTo ErrorHandler:
    m_ShowXAxis = pShowXAxis
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ShowXAxis"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ShowXAxis() As Boolean
    On Error GoTo ErrorHandler:
    ShowXAxis = m_ShowXAxis
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ShowXAxis"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let YAxisLabelText(ByVal pYAxisLabelText As String)
    On Error GoTo ErrorHandler:
    m_YAxisLabelText = pYAxisLabelText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="YAxisLabelText"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get YAxisLabelText() As String
    On Error GoTo ErrorHandler:
    YAxisLabelText = m_YAxisLabelText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="YAxisLabelText"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let XAxisLabelText(ByVal pXAxisLabelText As String)
    On Error GoTo ErrorHandler:
    m_XAxisLabelText = pXAxisLabelText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="XAxisLabelText"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get XAxisLabelText() As String
    On Error GoTo ErrorHandler:
    XAxisLabelText = m_XAxisLabelText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="XAxisLabelText"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ChartJsSource(ByVal pChartJsSource As chScriptSource)
    On Error GoTo ErrorHandler:
    m_ChartJsSource = pChartJsSource
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ChartJsSource"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ChartJsSource() As chScriptSource
    On Error GoTo ErrorHandler:
    ChartJsSource = m_ChartJsSource
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ChartJsSource"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ChartJsCDN(ByVal pChartJsCDN As String)
    On Error GoTo ErrorHandler:
    m_ChartJsCDN = pChartJsCDN
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ChartJsCDN"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ChartJsCDN() As String
    On Error GoTo ErrorHandler:
    ChartJsCDN = m_ChartJsCDN
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ChartJsCDN"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ChartJsPathFilename(ByVal pChartJsPathFilename As String)
    On Error GoTo ErrorHandler:
    m_ChartJsPathFilename = pChartJsPathFilename
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ChartJsPathFilename"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ChartJsPathFilename() As String
    On Error GoTo ErrorHandler:
    ChartJsPathFilename = m_ChartJsPathFilename
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ChartJsPathFilename"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let StackedChart(ByVal pStackedChart As Boolean)
    On Error GoTo ErrorHandler:
    m_StackedChart = pStackedChart
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="StackedChart"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get StackedChart() As Boolean
    On Error GoTo ErrorHandler:
    StackedChart = m_StackedChart
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="StackedChart"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ColorSchemaSource(ByVal pColorSchemaSource As chScriptSource)
    On Error GoTo ErrorHandler:
    m_ColorSchemaSource = pColorSchemaSource
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ColorSchemaSource"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ColorSchemaSource() As chScriptSource
    On Error GoTo ErrorHandler:
    ColorSchemaSource = m_ColorSchemaSource
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ColorSchemaSource"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ColorSchemaCDN(ByVal pColorSchemaCDN As String)
    On Error GoTo ErrorHandler:
    m_ColorSchemaCDN = pColorSchemaCDN
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ColorSchemaCDN"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ColorSchemaCDN() As String
    On Error GoTo ErrorHandler:
    ColorSchemaCDN = m_ColorSchemaCDN
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ColorSchemaCDN"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ColorSchemaPathFilename(ByVal pColorSchemaPathFilename As String)
    On Error GoTo ErrorHandler:
    m_ColorSchemaPathFilename = pColorSchemaPathFilename
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ColorSchemaPathFilename"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ColorSchemaPathFilename() As String
    On Error GoTo ErrorHandler:
    ColorSchemaPathFilename = m_ColorSchemaPathFilename
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ColorSchemaPathFilename"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ColorSchema(ByVal pColorSchema As String)
    On Error GoTo ErrorHandler:
    m_ColorSchema = pColorSchema
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ColorSchema"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ColorSchema() As String
    On Error GoTo ErrorHandler:
    ColorSchema = m_ColorSchema
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ColorSchema"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let AreaFilled(ByVal pAreaFilled As Boolean)
    On Error GoTo ErrorHandler:
    m_AreaFilled = pAreaFilled
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="AreaFilled"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get AreaFilled() As Boolean
    On Error GoTo ErrorHandler:
    AreaFilled = m_AreaFilled
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="AreaFilled"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let ChartBackgroundColor(ByVal pChartBackgroundColor As String)
    On Error GoTo ErrorHandler:
    m_ChartBackgroundColor = pChartBackgroundColor
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ChartBackgroundColor"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get ChartBackgroundColor() As String
    On Error GoTo ErrorHandler:
    ChartBackgroundColor = m_ChartBackgroundColor
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="ChartBackgroundColor"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let DefaultFontColor(ByVal pDefaultFontColor As String)
    On Error GoTo ErrorHandler:
    m_DefaultFontColor = pDefaultFontColor
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DefaultFontColor"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get DefaultFontColor() As String
    On Error GoTo ErrorHandler:
    DefaultFontColor = m_DefaultFontColor
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DefaultFontColor"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let DefaultFontFamily(ByVal pDefaultFontFamily As String)
    On Error GoTo ErrorHandler:
    m_DefaultFontFamily = pDefaultFontFamily
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DefaultFontFamily"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get DefaultFontFamily() As String
    On Error GoTo ErrorHandler:
    DefaultFontFamily = m_DefaultFontFamily
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DefaultFontFamily"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let DefaultFontSize(ByVal pDefaultFontSize As Integer)
    On Error GoTo ErrorHandler:
    m_DefaultFontSize = pDefaultFontSize
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DefaultFontSize"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get DefaultFontSize() As Integer
    On Error GoTo ErrorHandler:
    DefaultFontSize = m_DefaultFontSize
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DefaultFontSize"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let YAxisBeginAtZero(ByVal pYAxisBeginAtZero As Boolean)
    On Error GoTo ErrorHandler:
    m_YAxisBeginAtZero = pYAxisBeginAtZero
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="YAxisBeginAtZero"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get YAxisBeginAtZero() As Boolean
    On Error GoTo ErrorHandler:
    YAxisBeginAtZero = m_YAxisBeginAtZero
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="YAxisBeginAtZero"
    Exit Property
End Property




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Let XAxisBeginAtZero(ByVal pXAxisBeginAtZero As Boolean)
    On Error GoTo ErrorHandler:
    m_XAxisBeginAtZero = pXAxisBeginAtZero
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="XAxisBeginAtZero"
    Exit Property
End Property



'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Property Get XAxisBeginAtZero() As Boolean
    On Error GoTo ErrorHandler:
    XAxisBeginAtZero = m_XAxisBeginAtZero
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="XAxisBeginAtZero"
    Exit Property
End Property






'---------------------------------------------------------------------------------
'   Type:            Sub Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Sub DrawChart()
    On Error GoTo ErrorHandler:
    Dim filename As String
    CreateChartFile
    filename = CurrentProject.Path & "\" & m_HtmlFileName
    Control.Object.Navigate filename
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DrawChart()"
    Exit Sub
End Sub






'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub CreateChartFile()
    On Error GoTo ErrorHandler:
    Dim f As Integer
    Dim strPath As String
    Dim strFilename As String
    Dim strContent As String
    strPath = CurrentProject.Path
    strFilename = "\" & m_HtmlFileName
    strContent = strContent & GetHeader
    strContent = strContent & GetChartType
    strContent = strContent & GetChartData
    strContent = strContent & GetChartOptions
    strContent = strContent & GetFooter
    f = FreeFile()
    Open strPath & strFilename For Output As f
    Print #f, strContent;
    Close f
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="CreateChartFile()"
    Exit Sub
End Sub




'---------------------------------------------------------------------------------
'   Type:            Property Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetHeader() As String
    On Error GoTo ErrorHandler:
    Dim strText As String
    strText = strText & "<!DOCTYPE html>" & vbCrLf
    strText = strText & "<!-- saved from url=(0014)about:internet -->" & vbCrLf
    strText = strText & "<!-- saved from url=(0016)http://localhost -->" & vbCrLf
    strText = strText & "<html>" & vbCrLf
    strText = strText & "<head>" & vbCrLf
    strText = strText & "    <meta charset=""utf-8"">" & vbCrLf
    strText = strText & "    <meta http-equiv=""X-UA-Compatible"" content=""IE=Edge""/>" & vbCrLf
    strText = strText & "    <title>Chart</title>" & vbCrLf
    strText = strText & "    <style>body{margin:0;padding:0;}</style>" & vbCrLf
    strText = strText & "    <script src=" & GetChartJsLocation & "></script>" & vbCrLf
    strText = strText & "    <script src=" & GetColorSchemaLocation & "></script>" & vbCrLf
    strText = strText & "</head>" & vbCrLf
    strText = strText & "<body>" & vbCrLf
    strText = strText & "<div id=""container"" style=""width: 100%;"">" & vbCrLf
    If Len(m_ChartBackgroundColor) > 0 Then
        strText = strText & "    <canvas id=""myChart"" style=""background-color: " & m_ChartBackgroundColor & """ ></canvas>" & vbCrLf
    Else
        strText = strText & "    <canvas id=""myChart""></canvas>" & vbCrLf
    End If
    strText = strText & "</div>" & vbCrLf
    strText = strText & "<script>" & vbCrLf
    If Len(DefaultFontColor) > 0 Then
        strText = strText & "    Chart.defaults.global.defaultFontColor = '" & DefaultFontColor & "';" & vbCrLf
    End If
    If Len(DefaultFontFamily) > 0 Then
        strText = strText & "    Chart.defaults.global.defaultFontFamily = '" & DefaultFontFamily & "';" & vbCrLf
    End If
    If DefaultFontSize > 0 Then
        strText = strText & "    Chart.defaults.global.defaultFontSize = " & DefaultFontSize & ";" & vbCrLf
    End If
    strText = strText & "    var ctx = document.getElementById('myChart').getContext('2d');" & vbCrLf
    strText = strText & "    var myChart = new Chart(ctx, {" & vbCrLf
    GetHeader = strText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="GetHeader()"
    Exit Function
End Function




'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetChartType
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetChartType() As String
    On Error GoTo ErrorHandler:
    Dim strText As String
    Dim strType As String
    Select Case ChartType
        Case chChartType.Line
            strType = "line"
        Case chChartType.Bar
            strType = "bar"
        Case chChartType.HorizontalBar
            strType = "horizontalBar"
        Case chChartType.Radar
            strType = "radar"
        Case chChartType.Doughnut
            strType = "doughnut"
        Case chChartType.Pie
            strType = "pie"
        Case chChartType.PolarArea
            strType = "polarArea"
        Case chChartType.Bubble
            strType = "bubble"
        Case chChartType.Scatter
            strType = "scatter"
        Case Else
    End Select
    strText = strText & "        type: '" & strType & "'," & vbCrLf
    GetChartType = strText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="GetChartType()"
    Exit Function
End Function


'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetChartType
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetChartData() As String
    On Error GoTo ErrorHandler:
    Dim strText As String
    Dim i As Integer
    Call GetData
    strText = strText & "        data: {" & vbCrLf
    If ChartType <> chChartType.Bubble Then
        If ChartType <> chChartType.Scatter Then
            strText = strText & "            labels: [" & m_DataLabels & "]," & vbCrLf
        End If
    End If
    strText = strText & "            datasets: [" & vbCrLf
    For i = LBound(m_DataSetData) To UBound(m_DataSetData)
        Select Case ChartType
            Case chChartType.Bubble, chChartType.Scatter
                strText = strText & "               {label: '" & m_DataLabels(i) & "' ," & vbCrLf
            Case Else
                strText = strText & "               {label: '" & m_DataSetLabel(i) & "' ," & vbCrLf
        End Select
        Select Case ChartType
            Case chChartType.Line, chChartType.Radar
                If m_AreaFilled = False Then
                    strText = strText & "                fill: false ," & vbCrLf
                End If
            Case Else
        End Select
        strText = strText & "                data: [" & m_DataSetData(i) & "]," & vbCrLf
        If m_IsSingleBarChart = True Then
            strText = strText & "                backgroundColor: Chart['colorschemes']." & ColorSchema & "," & vbCrLf
        End If
        strText = strText & "                borderWidth: 1}," & vbCrLf
    Next i
    strText = CutTrailingComma(strText)
    strText = strText & "             ]" & vbCrLf
    strText = strText & "        }," & vbCrLf
    GetChartData = strText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="GetChartData()"
    Exit Function
End Function


'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetChartType
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetChartOptions() As String
    On Error GoTo ErrorHandler:
    Dim strText As String
    strText = strText & "        options: {" & vbCrLf
    strText = strText & GetTitle
    strText = strText & GetLegend
    strText = strText & GetScales
    strText = strText & GetColorSchema
    strText = CutTrailingComma(strText)
    strText = strText & "        }" & vbCrLf
    GetChartOptions = strText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="GetChartOptions()"
    Exit Function
End Function


'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetChartType
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetFooter() As String
    On Error GoTo ErrorHandler:
    Dim strText As String
    strText = strText & "    });" & vbCrLf
    strText = strText & "</script>" & vbCrLf
    strText = strText & "</body>" & vbCrLf
    strText = strText & "</html>"
    GetFooter = strText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="GetFooter()"
    Exit Function
End Function



'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetChartType
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetChartJsLocation() As String
    On Error GoTo ErrorHandler:
    Dim strText As String
    Select Case ChartJsSource
        Case chScriptSource.CDN
            strText = """" & ChartJsCDN & """"
        Case chScriptSource.LocalFile
            strText = """" & ChartJsPathFilename & """"
        Case Else
    End Select
    GetChartJsLocation = strText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="GetChartJsLocation()"
    Exit Function
End Function



'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetChartType
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetColorSchemaLocation() As String
    On Error GoTo ErrorHandler:
    Dim strText As String
    Select Case ColorSchemaSource
        Case chScriptSource.CDN
            strText = """" & ColorSchemaCDN & """"
        Case chScriptSource.LocalFile
            strText = """" & ColorSchemaPathFilename & """"
        Case Else
    End Select
    GetColorSchemaLocation = strText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="GetColorSchemaLocation()"
    Exit Function
End Function



'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            GetChartType
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub GetData()
    On Error GoTo ErrorHandler:
    Dim DB As DAO.Database
    Dim rst As DAO.Recordset
    Dim strLabels() As String
    Dim strData() As String
    Dim field As Variant
    Dim i As Integer
    Set DB = CurrentDb()
    If Len(DataSourceObjectName) > 0 Then
        Set rst = DB.OpenRecordset(DataSourceObjectName)
    ElseIf Len(DataSourceSQLStatement) > 0 Then
        Set rst = DB.OpenRecordset(DataSourceSQLStatement)
    ElseIf Not DataSourceRecordset Is Nothing Then
        Set rst = DataSourceRecordset
    Else
        DataSourceDataFieldName = "Demo"
    End If
    Select Case ChartType
        Case chChartType.Bubble
            If Not rst Is Nothing Then
                ReDim strLabels(rst.RecordCount - 1)
                ReDim strData(rst.RecordCount - 1)
                Do While Not rst.EOF
                    strLabels(i) = rst(DataSourceLabelFieldName)
                    strData(i) = "{x:" & str$(rst(DataSourceDataFieldName(0))) & _
                                 ", y:" & str$(rst(DataSourceDataFieldName(1))) & _
                                 ", r:" & str$(rst(DataSourceDataFieldName(2))) & "}"
                    i = i + 1
                    rst.MoveNext
                Loop
            Else
                ReDim strLabels(0)
                ReDim strData(0)
                strLabels(0) = "Demo"
                strData(0) = "{x:2,y:3,r:17}"
            End If
                m_DataLabels = strLabels()
                m_DataSetData = strData()
        Case chChartType.Scatter
            If Not rst Is Nothing Then
                ReDim strLabels(rst.RecordCount - 1)
                ReDim strData(rst.RecordCount - 1)
                Do While Not rst.EOF
                    strLabels(i) = rst(DataSourceLabelFieldName)
                    strData(i) = "{x:" & str$(rst(DataSourceDataFieldName(0))) & _
                                 ", y:" & str$(rst(DataSourceDataFieldName(1))) & "}"
                    i = i + 1
                    rst.MoveNext
                Loop
            Else
                ReDim strLabels(0)
                ReDim strData(0)
                strLabels(0) = "Demo"
                strData(0) = "{x:2,y:3,r:17}"
            End If
                m_DataLabels = strLabels()
                m_DataSetData = strData()
        Case Else
            ReDim strLabels(1)
            ReDim strData(UBound(DataSourceDataFieldName))
            If Not rst Is Nothing Then
                Do While Not rst.EOF
                    strLabels(0) = strLabels(0) & "'" & rst(DataSourceLabelFieldName) & "',"
                    i = 0
                    For Each field In DataSourceDataFieldName
                        strData(i) = strData(i) & str$(rst(DataSourceDataFieldName(i))) & ","
                        i = i + 1
                    Next field
                    rst.MoveNext
                Loop
            Else
                strLabels(0) = "'Berlin', 'London', 'Paris', 'Rome', 'Lisbon', 'Madrid',"
                strData(0) = "2, 13, 7, 9, 12, 5,"
            End If
            DetermineSingleBarChart
            ReDim mDataSet1Colors(UBound(DataSourceDataFieldName))
            m_DataLabels = CutTrailingComma(strLabels(0))
            m_DataSetLabel = DataSourceDataFieldName()
            i = 0
            For Each field In DataSourceDataFieldName()
                strData(i) = CutTrailingComma(strData(i))
                i = i + 1
            Next field
            m_DataSetData = strData()
    End Select
ErrorHandler:
    rst.Close
    Set rst = Nothing
    Set DB = Nothing
    ProcessError Name:="Chart", _
        Member:="DetermineSingleBarChart()"
    Exit Sub
End Sub



'---------------------------------------------------------------------------------
'   Type:            Sub Procedure
'   Name:            DeterminSingleBarChart()
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub DetermineSingleBarChart()
    On Error GoTo ErrorHandler:
    Select Case m_ChartType
        Case chChartType.Bar, chChartType.HorizontalBar
            If m_IsSingleDataset = True Then
                m_IsSingleBarChart = True
            Else
                m_IsSingleBarChart = False
            End If
        Case Else
            m_IsSingleBarChart = False
    End Select
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:="DetermineSingleBarChart()"
    Exit Sub
End Sub




'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetTitle
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetTitle() As String
    On Error GoTo ErrorHandler:
    Dim strText As String
    If ShowTitle = False Then
        strText = strText & "            title: {" & vbCrLf
        strText = strText & "                display: false," & vbCrLf
        strText = strText & "            }," & vbCrLf
        GetTitle = strText
        Exit Function
    End If
    strText = strText & "            title: {" & vbCrLf
    strText = strText & "                display: true," & vbCrLf
    strText = strText & "                position: " & getPositionString(TitlePostition) & "," & vbCrLf
    strText = strText & "                text: '" & TitleText & "'" & vbCrLf
    strText = strText & "            }," & vbCrLf
    GetTitle = strText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:=""
    Exit Function
End Function



'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetChartType
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetLegend() As String
    On Error GoTo ErrorHandler:
    Dim strText As String
    If ShowLegend = False Then
        strText = strText & "            legend: {" & vbCrLf
        strText = strText & "                display: false" & vbCrLf
        strText = strText & "            }," & vbCrLf
        GetLegend = strText
        Exit Function
    End If
    strText = strText & "            legend: {" & vbCrLf
    strText = strText & "                display: true," & vbCrLf
    strText = strText & "                position: " & getPositionString(LegendPostition) & vbCrLf
    strText = strText & "            }," & vbCrLf
    GetLegend = strText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:=""
    Exit Function
End Function



'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetChartType
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetScales() As String
    On Error GoTo ErrorHandler:
    Dim strText As String
    strText = strText & "            scales: {" & vbCrLf
    strText = strText & "                yAxes: [{" & vbCrLf
    strText = strText & "                    id: 'first-y-Axis'," & vbCrLf
    If StackedChart = True Then
        Select Case ChartType
            Case chChartType.Line, chChartType.Bar, chChartType.HorizontalBar
                strText = strText & "                    stacked: true," & vbCrLf
            Case Else
        End Select
    End If
    If ShowYAxis = False Then
        strText = strText & "                    display: false" & vbCrLf
    Else
        strText = strText & "                    display: true," & vbCrLf
        If Len(YAxisLabelText) > 0 Then
            strText = strText & "                    scaleLabel: {" & vbCrLf
            strText = strText & "                       display: true," & vbCrLf
            strText = strText & "                       labelString: '" & YAxisLabelText & "'" & vbCrLf
            strText = strText & "                    }," & vbCrLf
        End If
        If YAxisBeginAtZero = True Then
            strText = strText & "                    ticks: {" & vbCrLf
            strText = strText & "                       beginAtZero: true" & vbCrLf
            strText = strText & "                    }," & vbCrLf
        End If
    End If
    strText = CutTrailingComma(strText)
    strText = strText & "                    }]," & vbCrLf
    strText = strText & "                xAxes: [{" & vbCrLf
    strText = strText & "                    id: 'first-x-Axis'," & vbCrLf
    If StackedChart = True Then
        Select Case ChartType
            Case chChartType.Line, chChartType.Bar, chChartType.HorizontalBar
                strText = strText & "                    stacked: true," & vbCrLf
            Case Else
        End Select
    End If
    If ShowXAxis = False Then
        strText = strText & "                    display: false" & vbCrLf
    Else
        strText = strText & "                    display: true," & vbCrLf
        If Len(XAxisLabelText) > 0 Then
            strText = strText & "                    scaleLabel: {" & vbCrLf
            strText = strText & "                    display: true," & vbCrLf
            strText = strText & "                    labelString: '" & XAxisLabelText & "'" & vbCrLf
            strText = strText & "                    }," & vbCrLf
        End If
        If XAxisBeginAtZero = True Then
            strText = strText & "                    ticks: {" & vbCrLf
            strText = strText & "                       beginAtZero: true" & vbCrLf
            strText = strText & "                    }," & vbCrLf
        End If
    End If
    strText = CutTrailingComma(strText)
    strText = strText & "                    }]," & vbCrLf
    strText = strText & "            }," & vbCrLf
    GetScales = strText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:=""
    Exit Function
End Function



'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetChartType
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function GetColorSchema() As String
    On Error GoTo ErrorHandler:
    Dim strText As String
    strText = strText & "            plugins: {" & vbCrLf
    strText = strText & "                colorschemes: {" & vbCrLf
    strText = strText & "                    scheme: '" & ColorSchema & "'" & vbCrLf
    strText = strText & "                    }" & vbCrLf
    strText = strText & "                }," & vbCrLf
    GetColorSchema = strText
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:=""
    Exit Function
End Function



'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetChartType
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function getPositionString(ByVal ThisPosition As chPosition) As String
    On Error GoTo ErrorHandler:
    Select Case ThisPosition
        Case chPosition.posTop
            getPositionString = "'top'"
        Case chPosition.posLeft
            getPositionString = "'left'"
        Case chPosition.posBottom
            getPositionString = "'bottom'"
        Case chPosition.posRight
            getPositionString = "'right'"
        Case Else
            getPositionString = "'top'"
    End Select
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:=""
    Exit Function
End Function




'---------------------------------------------------------------------------------
'   Type:            Function
'   Name:            GetChartType
'   Parameters:      Void
'   Retval:          String
'   Purpose:
'---------------------------------------------------------------------------------
Private Function CutTrailingComma(ByVal strText As String) As String
    On Error GoTo ErrorHandler:
    If Right$(strText, 1) = "," Then
        CutTrailingComma = Left$(strText, Len(strText) - 1)
    ElseIf Right$(strText, 3) = "," & vbCrLf Then
        CutTrailingComma = Left$(strText, Len(strText) - 3) & vbCrLf
    Else
        CutTrailingComma = strText
    End If
ErrorHandler:
    ProcessError Name:="Chart", _
        Member:=""
    Exit Function
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





