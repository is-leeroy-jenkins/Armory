Option Compare Database
Option Explicit

Public pRC As AccountArgs
Private m_BudgetLevelFilter As String
Private m_FiscalYearFilter As String
Private m_FundNameFilter As String
Private m_ProgramProjectNameFilter As String
Private pAnd As String
Private m_Error As String



'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            SetButtonVisibility
'   Parameters:      Void
'   Retval:          Void
'   Purpose:         Toggles button visibility ON and OFF
'---------------------------------------------------------------------------------
Private Sub SetButtonVisibility()
    On Error GoTo ErrorHandler:
    Me.CopyButton.Visible = Not Me.CopyButton.Visible
    Me.RefreshButton.Visible = Not Me.RefreshButton.Visible
    Me.DataWarehouseButton.Visible = Not Me.DataWarehouseButton.Visible
    Me.CalculatorButton.Visible = Not Me.CalculatorButton.Visible
    Me.UndoButton.Visible = Not Me.UndoButton.Visible
    Me.UpdateButton.Visible = Not Me.UpdateButton.Visible
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="SetButtonVisibility()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name            Update
'   Parameters      Void
'   Purpose         Defines and assigns the insert statement
'                   used to update the fields of a PRC
'---------------------------------------------------------------------------------
Public Sub Update()
    On Error GoTo ErrorHandler:
    Dim SQL As String
    Dim DB As DAO.Database
    Set DB = CurrentDb
    Dim Data As DAO.Recordset
    If Not Me.IdTextBox.Value & "" = "" Then
            pRC.ID = CInt(Me.IdTextBox.Value)
    End If
    If Not IsNull(Me.BudgetLevelTextBox) _
        And Not Me.BudgetLevelTextBox.Value & "" = "" Then
            pRC.BudgetLevel = Me.BudgetLevelTextBox.Value
    End If
    If Not IsNull(Me.BfyTextBox) _
        And Not Me.BfyTextBox.Value & "" = "" Then
            pRC.BFY = Me.BfyTextBox.Value
    End If
    If Not IsNull(Me.AhCodeTextBox) _
        And Not Me.AhCodeTextBox.Value & "" = "" Then
            pRC.AhCode = Me.AhCodeTextBox.Value
    End If
    If Not IsNull(Me.FundCodeTextBox) _
        And Not Me.FundCodeTextBox.Value & "" = "" Then
            pRC.FundCode = Me.FundCodeTextBox.Value
    End If
    If Not IsNull(Me.OrgCodeTextBox) _
        And Not Me.OrgCodeTextBox.Value & "" = "" Then
            pRC.OrgCode = Me.OrgCodeTextBox.Value
    End If
    If Not IsNull(Me.AccountCodeTextBox) _
        And Not Me.AccountCodeTextBox.Value = "" Then
            pRC.AccountCode = Me.AccountCodeTextBox.Value
    End If
    If Not IsNull(Me.BocCodeTextBox) _
        And Not Me.BocCodeTextBox.Value & "" = "" Then
            pRC.BocCode = Me.BocCodeTextBox.Value
    End If
    If Not IsNull(Me.RcCodeTextBox) _
        And Not Me.RcCodeTextBox.Value & "" = "" Then
            pRC.RcCode = Me.RcCodeTextBox.Value
    End If
    SQL = "UPDATE Allocations SET Allocations.AhCode = '" & pRC.AhCode & "'" _
        & pAnd & "Allocations.BudgetLevel = '" & pRC.BudgetLevel & "'" _
        & pAnd & "Allocations.BFY = '" & pRC.BFY & "'" _
        & pAnd & "Allocations.FundCode = '" & pRC.FundCode & "'" _
        & pAnd & "Allocations.OrgCode = '" & pRC.OrgCode & "'" _
        & pAnd & "Allocations.AccountCode = '" & pRC.AccountCode & "'" _
        & pAnd & "Allocations.BocCode = '" & pRC.BocCode & "'" _
        & pAnd & "Allocations.RcCode = '" & pRC.RcCode & "'" _
        & pAnd & "Allocations.Amount = '" & Me.ChangedAmountTextBox.Value & "'" _
        & "WHERE Allocations.PrcId = '" & pRC.ID & "'"
    Set Data = DB.OpenRecordset(SQL)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="Update()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub SetComboBoxColors()
    On Error GoTo ErrorHandler:
    Me!BudgetLevelComboBox.ForeColor = RGB(255, 255, 255)
    Me!BudgetLevelComboBox.BackColor = RGB(33, 33, 33)
    Me!BudgetLevelComboBox.BorderColor = RGB(68, 114, 196)
    Me!RpioCodeComboBox.ForeColor = RGB(255, 255, 255)
    Me!RpioCodeComboBox.BackColor = RGB(33, 33, 33)
    Me!RpioCodeComboBox.BorderColor = RGB(68, 114, 196)
    Me!BfyComboBox.ForeColor = RGB(255, 255, 255)
    Me!BfyComboBox.BackColor = RGB(33, 33, 33)
    Me!BfyComboBox.BorderColor = RGB(68, 114, 196)
    Me!FundCodeComboBox.ForeColor = RGB(255, 255, 255)
    Me!FundCodeComboBox.BackColor = RGB(33, 33, 33)
    Me!FundCodeComboBox.BorderColor = RGB(68, 114, 196)
    Me!AhCodeComboBox.ForeColor = RGB(255, 255, 255)
    Me!AhCodeComboBox.BackColor = RGB(33, 33, 33)
    Me!AhCodeComboBox.BorderColor = RGB(68, 114, 196)
    Me!OrgCodeComboBox.ForeColor = RGB(255, 255, 255)
    Me!OrgCodeComboBox.BackColor = RGB(33, 33, 33)
    Me!OrgCodeComboBox.BorderColor = RGB(68, 114, 196)
    Me!AccountCodeComboBox.ForeColor = RGB(255, 255, 255)
    Me!AccountCodeComboBox.BackColor = RGB(33, 33, 33)
    Me!AccountCodeComboBox.BorderColor = RGB(68, 114, 196)
    Me!RcCodeComboBox.ForeColor = RGB(255, 255, 255)
    Me!RcCodeComboBox.BackColor = RGB(33, 33, 33)
    Me!RcCodeComboBox.BorderColor = RGB(68, 114, 196)
    Me!ActivityCodeComboBox.ForeColor = RGB(255, 255, 255)
    Me!ActivityCodeComboBox.BackColor = RGB(33, 33, 33)
    Me!ActivityCodeComboBox.BorderColor = RGB(68, 114, 196)
    Me!BocCodeComboBox.ForeColor = RGB(255, 255, 255)
    Me!BocCodeComboBox.BackColor = RGB(33, 33, 33)
    Me!BocCodeComboBox.BorderColor = RGB(68, 114, 196)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="SetComboBoxColors()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub SetTextBoxColors()
    On Error GoTo ErrorHandler:
    Me!BudgetLevelTextBox.ForeColor = RGB(255, 255, 255)
    Me!BudgetLevelTextBox.BackColor = RGB(10, 10, 10)
    Me!BudgetLevelTextBox.BorderColor = RGB(52, 52, 52)
    Me!RpioCodeTextBox.ForeColor = RGB(255, 255, 255)
    Me.RpioCodeTextBox.BorderColor = RGB(52, 52, 52)
    Me.RpioCodeTextBox.BackColor = RGB(10, 10, 10)
    Me!BfyTextBox.ForeColor = RGB(255, 255, 255)
    Me!BfyTextBox.BackColor = RGB(10, 10, 10)
    Me!BfyTextBox.BorderColor = RGB(52, 52, 52)
    Me!FundCodeTextBox.ForeColor = RGB(255, 255, 255)
    Me!FundCodeTextBox.BackColor = RGB(10, 10, 10)
    Me!FundCodeTextBox.BorderColor = RGB(52, 52, 52)
    Me!AhCodeTextBox.ForeColor = RGB(255, 255, 255)
    Me!AhCodeTextBox.BackColor = RGB(10, 10, 10)
    Me!AhCodeTextBox.BorderColor = RGB(52, 52, 52)
    Me!OrgCodeTextBox.ForeColor = RGB(255, 255, 255)
    Me!OrgCodeTextBox.BackColor = RGB(10, 10, 10)
    Me!OrgCodeTextBox.BorderColor = RGB(52, 52, 52)
    Me!AccountCodeTextBox.ForeColor = RGB(255, 255, 255)
    Me!AccountCodeTextBox.BackColor = RGB(10, 10, 10)
    Me!AccountCodeTextBox.BorderColor = RGB(52, 52, 52)
    Me!RcCodeTextBox.ForeColor = RGB(255, 255, 255)
    Me!RcCodeTextBox.BackColor = RGB(10, 10, 10)
    Me!RcCodeTextBox.BorderColor = RGB(52, 52, 52)
    Me!ActivityCodeTextBox.ForeColor = RGB(255, 255, 255)
    Me!ActivityCodeTextBox.BackColor = RGB(10, 10, 10)
    Me!ActivityCodeTextBox.BorderColor = RGB(52, 52, 52)
    Me!BocCodeTextBox.ForeColor = RGB(255, 255, 255)
    Me!BocCodeTextBox.BackColor = RGB(10, 10, 10)
    Me!BocCodeTextBox.BorderColor = RGB(52, 52, 52)
    Me!AmountTextBox.ForeColor = RGB(255, 255, 255)
    Me!AmountTextBox.BackColor = RGB(10, 10, 10)
    Me!AmountTextBox.BorderColor = RGB(52, 52, 52)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="SetTextBoxColors()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub ClearFilters()
    On Error GoTo ErrorHandler:
    m_BudgetLevelFilter = ""
    m_FiscalYearFilter = ""
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="ClearFilters()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub ClearTextBoxValues()
    On Error GoTo ErrorHandler:
    SetTextBoxColors
    Me.BfyTextBox = Null
    Me.AccountCodeTextBox = Null
    Me.BudgetLevelTextBox = Null
    Me.RpioCodeTextBox = Null
    Me.BocCodeTextBox = Null
    Me.RcCodeTextBox = Null
    Me.BocCodeTextBox = Null
    Me.AhCodeTextBox = Null
    Me.ActivityCodeTextBox = Null
    Me.FundCodeTextBox = Null
    Me.OrgCodeTextBox = Null
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="ClearTextBoxValues()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub ClearComboBoxValues()
    On Error GoTo ErrorHandler:
    SetComboBoxColors
    Me.BfyComboBox.Value = ""
    Me.AccountCodeComboBox.Value = ""
    Me.BudgetLevelComboBox.Value = ""
    Me.RpioCodeComboBox.Value = ""
    Me.BocCodeComboBox.Value = ""
    Me.RcCodeComboBox.Value = ""
    Me.BocCodeComboBox.Value = ""
    Me.AhCodeComboBox.Value = ""
    Me.ActivityCodeComboBox.Value = ""
    Me.FundCodeComboBox.Value = ""
    Me.OrgCodeComboBox.Value = ""
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="ClearComboBoxValues()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name            ExitButton_Click
'   Parameters      Void
'   Retval
'   Purpose
'---------------------------------------------------------------------------------
Private Sub ExitButton_Click()
    On Error GoTo ErrorHandler:
    Dim m_Owner As String
    m_Owner = Me.Tag
    DoCmd.Close ObjectType:=acForm, _
        ObjectName:="AccountEditor", Save:=acSaveYes
    DoCmd.OpenForm FormName:=m_Owner
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="ExitButton_Click()"
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name            Event to initializes m_embers
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub Form_Load()
    On Error GoTo ErrorHandler:
    Set pRC = New AccountArgs
    pAnd = " AND "
    SetButtonVisibility
    ClearComboBoxValues
    Me.IdTextBox.Value = Me.OpenArgs
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="Form_Load()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub ActivityCodeComboBox_AfterUpdate()
    On Error GoTo ErrorHandler:
    Me!ActivityCodeTextBox.Value = Me.ActivityCodeComboBox.SelText
    Me.ActivityCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.ActivityCodeTextBox.BackColor = RGB(33, 33, 33)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="ActivityCodeComboBox_AfterUpdate()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub AhCodeComboBox_AfterUpdate()
    On Error GoTo ErrorHandler:
    Me!AhCodeTextBox.Value = Me.AhCodeComboBox.SelText
    pRC.AhCode = Me!AhCodeTextBox.Value
    Me.AhCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.AhCodeTextBox.BackColor = RGB(33, 33, 33)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="AhCodeComboBox_AfterUpdate()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub MenuButton_Click()
    On Error GoTo ErrorHandler:
    SetButtonVisibility
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="MenuButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub OrgCodeComboBox_AfterUpdate()
    On Error GoTo ErrorHandler:
    Me!OrgCodeTextBox.Value = Me.OrgCodeComboBox.SelText
    pRC.OrgCode = Me!OrgCodeTextBox.Value
    Me.OrgCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.OrgCodeTextBox.BackColor = RGB(33, 33, 33)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="OrgCodeComboBox_AfterUpdate()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub RcCodeComboBox_AfterUpdate()
    On Error GoTo ErrorHandler:
    Me!RcCodeTextBox.Value = Me.RcCodeComboBox.SelText
    pRC.RcCode = Me!RcCodeTextBox.Value
    Me.RcCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.RcCodeTextBox.BackColor = RGB(33, 33, 33)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="RcCodeComboBox_AfterUpdate()"
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub BfyComboBox_AfterUpdate()
    On Error GoTo ErrorHandler:
    Me!BfyTextBox.Value = Me.BfyComboBox.SelText
    pRC.BFY = Me!BfyTextBox.Value
    Me.BfyTextBox.BorderColor = RGB(68, 114, 196)
    Me.BfyTextBox.BackColor = RGB(33, 33, 33)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="BfyComboBox_AfterUpdate()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub BocCodeComboBox_AfterUpdate()
    On Error GoTo ErrorHandler:
    Me!BocCodeTextBox.Value = Me.BocCodeComboBox.SelText
    pRC.BocCode = Me!BocCodeTextBox.Value
    Me.BocCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.BocCodeTextBox.BackColor = RGB(33, 33, 33)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="BocCodeComboBox_AfterUpdate()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub BudgetLevelComboBox_AfterUpdate()
    On Error GoTo ErrorHandler:
    Me!BudgetLevelTextBox.Value = Me.BudgetLevelComboBox.SelText
    pRC.BudgetLevel = Me!BudgetLevelTextBox.Value
    Me.BudgetLevelTextBox.BorderColor = RGB(68, 114, 196)
    Me.BudgetLevelTextBox.BackColor = RGB(33, 33, 33)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="BudgetLevelComboBox_AfterUpdate()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub RpioCodeComboBox_AfterUpdate()
    On Error GoTo ErrorHandler:
    Me!RpioCodeTextBox.Value = Me.RpioCodeComboBox.SelText
    pRC.RpioCode = Me!RpioCodeTextBox.Value
    Me.RpioCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.RpioCodeTextBox.BackColor = RGB(33, 33, 33)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="RpioCodeComboBox_AfterUpdate()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub FundCodeComboBox_AfterUpdate()
    On Error GoTo ErrorHandler:
    Me!FundCodeTextBox.Value = Me.FundCodeComboBox.SelText
    pRC.FundCode = Me!FundCodeTextBox.Value
    Me.FundCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.FundCodeTextBox.BackColor = RGB(33, 33, 33)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="FundCodeComboBox_AfterUpdate()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub AccountCodeComboBox_AfterUpdate()
    On Error GoTo ErrorHandler:
    Me!AccountCodeTextBox.Value = Me.AccountCodeComboBox.SelText
    pRC.AccountCode = Me!AccountCodeTextBox.Value
    Me.AccountCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.AccountCodeTextBox.BackColor = RGB(33, 33, 33)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="AccountCodeComboBox_AfterUpdate()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------

Private Sub UpdateButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.SetWarnings (False)
    DoCmd.OpenQuery ("UpdateAccountEditorData")
    DoCmd.SetWarnings (True)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="UpdateButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub RefreshButton_Click()
    On Error GoTo ErrorHandler:
    ClearComboBoxValues
    ClearTextBoxValues
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="RefreshButton_Click()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub CalculatorButton_Click()
    On Error GoTo ErrorHandler:
    Calculator.Calculate
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="CalculatorButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Retval          Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub CopyButton_Click()
    On Error GoTo ErrorHandler:
    Dim pSQL As String
    Dim pAhName As String
    Dim pOrgName As String
    Dim pFundName As String
    Dim pBocName As String
    Dim pProgramProjectCode As String
    Dim pProgramAreaCode As String
    Dim pProgramProjectName As String
    Dim pDivisionName As String
    Dim pNpmCode As String
    Dim pNpmName As String
    Dim pGoalCode As String
    Dim pGoalName As String
    Dim pObjectiveCode As String
    Dim pObjectiveName As String
    pProgramProjectCode = Mid(Me.AccountCodeTextBox, 5, 2)
    pGoalCode = Left(Me.AccountCodeTextBox, 1)
    pObjectiveCode = Mid(Me.AccountCodeTextBox, 1, 2)
    pNpmCode = Mid(Me.AccountCodeTextBox, 4, 1)
    pProgramProjectName = DLookup("ProgramProjectName", "Allocations", "[ProgramProjectCode]= '" & pProgramProjectCode & "'")
    pFundName = DLookup("FundName", "Allocations", "[FundCode]= '" & Me.FundCodeTextBox & "'")
    pBocName = DLookup("BocName", "Allocations", "[BocCode]= '" & Me.BocCodeTextBox & "'")
    pNpmName = DLookup("BocName", "Allocations", "[NpmCode]= '" & pNpmCode & "'")
    pDivisionName = DLookup("DivisionName", "Allocations", "[RcCode]= '" & Me.RcCodeTextBox & "'")
    pGoalName = DLookup("GoalName", "Allocations", "[GoalCode]= '" & pGoalCode & "'")
    pObjectiveName = DLookup("ObjectiveName", "Allocations", "[ObjectiveCode]= '" & pObjectiveCode & "'")
    pAhName = DLookup("AhName", "Allocations", "[AhCode]= '" & Me.AhCodeTextBox & "'")
    pOrgName = DLookup("ORgName", "Allocations", "[OrgCode]= '" & Me.OrgCodeTextBox & "'")
    pSQL = "INSERT INTO Allocations (BudgetLevel, BFY, RPIO, AhCode, FundCode, OrgCode," _
        & " AccountCode, BocCode, RcCode, ActivityCode)" _
        & " VALUES (Me.BudgetLevelTextBox.Text, Me.BfyTextBox.Text, Me.RpioTextBox.Text," _
        & " Me.AhCodeTextBox.Text, Me.FundCodeTextBox.Text, Me.OrgTextBox.Text," _
        & " Me.AccountCodeTextBox.Text, Me.BocCodeTextBox.Text, Me.RcCodeTextBox.Text, Me.ActivityCodeTextBox.Text)"
    DoCmd.RunSQL (pSQL)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="CopyButton_Click()"
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub InsertButton_Click()
    On Error GoTo ErrorHandler:
    Dim pSQL As String
    Dim pAhName As String
    Dim pOrgName As String
    Dim pFundName As String
    Dim pBocName As String
    Dim pProgramProjectCode As String
    Dim pProgramAreaCode As String
    Dim pProgramProjectName As String
    Dim pDivisionName As String
    Dim pNpmCode As String
    Dim pNpmName As String
    Dim pGoalCode As String
    Dim pGoalName As String
    Dim pObjectiveCode As String
    Dim pObjectiveName As String
    pProgramProjectCode = Mid(Me.AccountCodeTextBox, 5, 2)
    pGoalCode = Left(Me.AccountCodeTextBox, 1)
    pObjectiveCode = Mid(Me.AccountCodeTextBox, 1, 2)
    pNpmCode = Mid(Me.AccountCodeTextBox, 4, 1)
    pProgramProjectName = DLookup("ProgramProjectName", "Allocations", "[ProgramProjectCode]= '" & pProgramProjectCode & "'")
    pFundName = DLookup("FundName", "Allocations", "[FundCode]= '" & Me.FundCodeTextBox & "'")
    pBocName = DLookup("BocName", "Allocations", "[BocCode]= '" & Me.BocCodeTextBox & "'")
    pNpmName = DLookup("BocName", "Allocations", "[NpmCode]= '" & pNpmCode & "'")
    pDivisionName = DLookup("DivisionName", "Allocations", "[RcCode]= '" & Me.RcCodeTextBox & "'")
    pGoalName = DLookup("GoalName", "Allocations", "[GoalCode]= '" & pGoalCode & "'")
    pObjectiveName = DLookup("ObjectiveName", "Allocations", "[ObjectiveCode]= '" & pObjectiveCode & "'")
    pAhName = DLookup("AhName", "Allocations", "[AhCode]= '" & Me.AhCodeTextBox & "'")
    pOrgName = DLookup("ORgName", "Allocations", "[OrgCode]= '" & Me.OrgCodeTextBox & "'")
    pSQL = "INSERT INTO Allocations (BudgetLevel, BFY, RPIO, AhCode, FundCode, OrgCode, AccountCode, BocCode, RcCode, ActivityCode) " _
        & "VALUES (Me.BudgetLevelTextBox.Text, Me.BfyTextBox.Text, Me.RpioTextBox.Text, Me.AhCodeTextBox.Text, Me.FundCodeTextBox.Text, Me.OrgTextBox.Text, " _
        & "Me.AccountCodeTextBox.Text, Me.BocCodeTextBox.Text, Me.RcCodeTextBox.Text, Me.ActivityCodeTextBox.Text)"
    DoCmd.RunSQL (pSQL)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="InsertButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub UpdateBudgetLevel()
    On Error GoTo ErrorHandler:
    Me.IdTextBox.SetFocus
    pRC.ID = CInt(Me!IdTextBox.text)
    Me.BudgetLevelTextBox.SetFocus
    pRC.BudgetLevel = Me.BudgetLevelTextBox.text
    Dim SQL As String
    SQL = "UPDATE Allocations SET Allocations.BudgetLevel = '" _
        & pRC.BudgetLevel & "'" & _
        " WHERE Allocations.PrcId = " & pRC.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="UpdateBudgetLevel()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub UpdateBfy()
    On Error GoTo ErrorHandler:
    Me.IdTextBox.SetFocus
    pRC.ID = CInt(Me!IdTextBox.text)
    Me.BfyTextBox.SetFocus
    pRC.BFY = Me.BfyTextBox.text
    Dim SQL As String
    SQL = "UPDATE Allocations SET Allocations.BFY = '" _
        & pRC.BFY & "'" & _
        " WHERE Allocations.PrcId = " & pRC.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="UpdateBfy()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub UpdateRpioCode()
    On Error GoTo ErrorHandler:
    Me.IdTextBox.SetFocus
    pRC.ID = CInt(Me!IdTextBox.text)
    Me.RpioCodeTextBox.SetFocus
    pRC.RpioCode = Me.RpioCodeTextBox.text
    Dim SQL As String
    SQL = "UPDATE Allocations SET Allocations.RPIO = '" _
        & pRC.RpioCode & "'" & _
        " WHERE Allocations.PrcId = " & pRC.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="UpdateRpioCode()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub UpdateAhCode()
    On Error GoTo ErrorHandler:
    Me.IdTextBox.SetFocus
    pRC.ID = CInt(Me!IdTextBox.text)
    Me.AhCodeTextBox.SetFocus
    pRC.AhCode = Me.AhCodeTextBox.text
    Dim SQL As String
    SQL = "UPDATE Allocations SET Allocations.AhCode = '" _
        & pRC.AhCode & "'" & _
        " WHERE Allocations.PrcId = " & pRC.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="UpdateAhCode()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub UpdateOrgCode()
    On Error GoTo ErrorHandler:
    Me.IdTextBox.SetFocus
    pRC.ID = CInt(Me!IdTextBox.text)
    Me.OrgCodeTextBox.SetFocus
    pRC.OrgCode = Me.OrgCodeTextBox.text
    Dim SQL As String
    SQL = "UPDATE Allocations SET Allocations.OrgCode = '" _
        & pRC.OrgCode & "'" & _
        " WHERE Allocations.PrcId = " & pRC.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="UpdateOrgCode()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub UpdateAccountCode()
    On Error GoTo ErrorHandler:
    Me.IdTextBox.SetFocus
    pRC.ID = CInt(Me!IdTextBox.text)
    Me.AccountCodeTextBox.SetFocus
    pRC.AccountCode = Me.AccountCodeTextBox.text
    Dim SQL As String
    SQL = "UPDATE Allocations SET Allocations.AccountCode = '" _
        & pRC.AccountCode & "'" & _
        " WHERE Allocations.PrcId = " & pRC.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="UpdateAccountCode()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub UpdateBocCode()
    On Error GoTo ErrorHandler:
    Me.IdTextBox.SetFocus
    pRC.ID = CInt(Me!IdTextBox.text)
    Me.BocCodeTextBox.SetFocus
    pRC.BocCode = Me.BocCodeTextBox.text
    Dim SQL As String
    SQL = "UPDATE Allocations SET Allocations.BocCode = '" _
        & pRC.BocCode & "'" & _
        " WHERE Allocations.PrcId = " & pRC.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="UpdateBocCode()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub UpdateRcCode()
    On Error GoTo ErrorHandler:
    Me.IdTextBox.SetFocus
    pRC.ID = CInt(Me!IdTextBox.text)
    Me.RcCodeTextBox.SetFocus
    pRC.RcCode = Me.RcCodeTextBox.text
    Dim SQL As String
    SQL = "UPDATE Allocations SET Allocations.RcCode = '" _
        & pRC.RcCode & "'" & _
        " WHERE Allocations.PrcId = " & pRC.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="UpdateRcCode()"
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type            Sub-Procedure
'   Name
'   Parameters      Void
'   Purpose
'---------------------------------------------------------------------------------
Private Sub UpdateAmount()
    On Error GoTo ErrorHandler:
    Me.IdTextBox.SetFocus
    pRC.ID = CInt(Me!IdTextBox.text)
    Me.ChangedAmountTextBox.SetFocus
    Dim Change As Double
    Change = CDbl(Me.ChangedAmountTextBox.text)
    Dim SQL As String
    SQL = "UPDATE Allocations SET Allocations.Amount = " _
        & Change & _
        " WHERE Allocations.PrcId = " & pRC.ID
    Dim DB As DAO.Database
    Set DB = CurrentDb
    DB.Execute (SQL)
ErrorHandler:
    ProcessError Name:="AccountEditor", _ 
        Member:="UpdateAmount()"
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
    ProcessError Name:="AccountEditor", _ 
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
    ProcessError Name:="AccountEditor", _ 
        Member:="SaveButton_Click()"
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



