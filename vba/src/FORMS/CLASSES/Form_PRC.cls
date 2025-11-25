VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_PRC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

'---------------------------------------------------------------------------------------------------------------------------------------------------
'---------------------------------------------------------------  FIELDS      ----------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------------------------------------------

Private pRC As AccountArgs
Private pBudgetLevelFilter As String
Private pFiscalYearFilter As String
Private pAnd As String
Private m_Error As String

'---------------------------------------------------------------------------------------------------------------------------------------------------
'---------------------------------------------------------------  METHODS     ----------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------------------------------------------

Private Sub SetComboBoxColors()
        Me!BudgetLevelComboBox.ForeColor = RGB(255, 255, 255)
        Me!BudgetLevelComboBox.BackColor = RGB(30, 30, 30)
        Me!BudgetLevelComboBox.BorderColor = RGB(68, 114, 196)
        Me!BfyComboBox.ForeColor = RGB(255, 255, 255)
        Me!BfyComboBox.BackColor = RGB(30, 30, 30)
        Me!BfyComboBox.BorderColor = RGB(68, 114, 196)
        Me!FundCodeComboBox.ForeColor = RGB(255, 255, 255)
        Me!FundCodeComboBox.BackColor = RGB(30, 30, 30)
        Me!FundCodeComboBox.BorderColor = RGB(68, 114, 196)
        Me!AhCodeComboBox.ForeColor = RGB(255, 255, 255)
        Me!AhCodeComboBox.BackColor = RGB(30, 30, 30)
        Me!AhCodeComboBox.BorderColor = RGB(68, 114, 196)
        Me!OrgCodeComboBox.ForeColor = RGB(255, 255, 255)
        Me!OrgCodeComboBox.BackColor = RGB(30, 30, 30)
        Me!OrgCodeComboBox.BorderColor = RGB(68, 114, 196)
        Me!AccountCodeComboBox.ForeColor = RGB(255, 255, 255)
        Me!AccountCodeComboBox.BackColor = RGB(30, 30, 30)
        Me!AccountCodeComboBox.BorderColor = RGB(68, 114, 196)
        Me!RcCodeComboBox.ForeColor = RGB(255, 255, 255)
        Me!RcCodeComboBox.BackColor = RGB(30, 30, 30)
        Me!RcCodeComboBox.BorderColor = RGB(68, 114, 196)
        Me!ActivityCodeComboBox.ForeColor = RGB(255, 255, 255)
        Me!ActivityCodeComboBox.BackColor = RGB(30, 30, 30)
        Me!ActivityCodeComboBox.BorderColor = RGB(68, 114, 196)
        Me!BocCodeComboBox.ForeColor = RGB(255, 255, 255)
        Me!BocCodeComboBox.BackColor = RGB(30, 30, 30)
        Me!BocCodeComboBox.BorderColor = RGB(68, 114, 196)
End Sub

Private Sub SetTextBoxColors()
        Me!BudgetLevelTextBox.ForeColor = RGB(255, 255, 255)
        Me!BudgetLevelTextBox.BackColor = RGB(10, 10, 10)
        Me!BudgetLevelTextBox.BorderColor = RGB(52, 52, 52)
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
End Sub

Private Sub ClearComboBoxValues()
    SetComboBoxColors
    Me!ActivityCodeComboBox.Value = ""
    Me!BudgetLevelComboBox.Value = ""
    Me!BfyComboBox.Value = ""
    Me!AhCodeComboBox.Value = ""
    Me!AccountCodeComboBox.Value = ""
    Me!FundCodeComboBox.Value = ""
    Me!BocCodeComboBox.Value = ""
    Me!OrgCodeComboBox.Value = ""
    Me!RcCodeComboBox.Value = ""
End Sub

Private Sub ClearTextBoxValues()
    SetTextBoxColors
    Me!ActivityCodeTextBox = Null
    Me!BudgetLevelTextBox = Null
    Me!BfyTextBox = Null
    Me!AhCodeTextBox = Null
    Me!AccountCodeTextBox = Null
    Me!FundCodeTextBox = Null
    Me!BocCodeTextBox = Null
    Me!OrgCodeTextBox = Null
    Me!RcCodeTextBox = Null
End Sub

'---------------------------------------------------------------------------------------------------------------------------------------------------
'---------------------------------------------------    COMBOBOX EVENTS    -------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------------------------------------------

Private Sub AccountCodeComboBox_AfterUpdate()
    Me!AccountCodeTextBox.Value = Me.AccountCodeComboBox.SelText
    pRC.AccountCode = Me!AccountCodeTextBox.Value
    Me.AccountCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.AccountCodeTextBox.BackColor = RGB(30, 30, 30)
End Sub

Private Sub ActivityCodeComboBox_AfterUpdate()
    Me!ActivityCodeTextBox.Value = Me.ActivityCodeComboBox.SelText
    pRC.ActivityCode = Me!ActivityCodeTextBox.Value
    Me.ActivityCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.ActivityCodeTextBox.BackColor = RGB(30, 30, 30)
End Sub

Private Sub AhCodeComboBox_AfterUpdate()
    Me!AhCodeTextBox.Value = Me.AhCodeComboBox.SelText
    pRC.AhCode = Me!AhCodeTextBox.Value
    Me.AhCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.AhCodeTextBox.BackColor = RGB(30, 30, 30)
End Sub

Private Sub BfyComboBox_AfterUpdate()
    Me!BfyTextBox.Value = Me.BfyComboBox.SelText
    pRC.BFY = Me!BfyTextBox.Value
    Me.BfyTextBox.BorderColor = RGB(68, 114, 196)
    Me.BfyTextBox.BackColor = RGB(30, 30, 30)
End Sub

Private Sub BocCodeComboBox_AfterUpdate()
    Me!BocCodeTextBox.Value = Me.BocCodeComboBox.SelText
    pRC.BocCode = Me!BocCodeTextBox.Value
    Me.BocCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.BocCodeTextBox.BackColor = RGB(30, 30, 30)
End Sub

Private Sub BudgetLevelComboBox_AfterUpdate()
    Me!BudgetLevelTextBox.Value = Me.BudgetLevelComboBox.SelText
    pRC.BudgetLevel = Me!BudgetLevelTextBox.Value
    Me.BudgetLevelTextBox.BorderColor = RGB(68, 114, 196)
    Me.BudgetLevelTextBox.BackColor = RGB(30, 30, 30)
End Sub

Private Sub FundCodeComboBox_AfterUpdate()
    Me!FundCodeTextBox.Value = Me.FundCodeComboBox.SelText
    pRC.FundCode = Me!FundCodeTextBox.Value
    Me.FundCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.FundCodeTextBox.BackColor = RGB(30, 30, 30)
End Sub

Private Sub OrgCodeComboBox_AfterUpdate()
    Me!OrgCodeTextBox.Value = Me.OrgCodeComboBox.SelText
    pRC.OrgCode = Me!OrgCodeTextBox.Value
    Me.OrgCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.OrgCodeTextBox.BackColor = RGB(30, 30, 30)
End Sub

Private Sub OriginalTextBox_Click()
    Calculator.Calculate
End Sub

Private Sub RcCodeComboBox_AfterUpdate()
    Me!RcCodeTextBox.Value = Me.RcCodeComboBox.SelText
    pRC.RcCode = Me!RcCodeTextBox.Value
    Me.RcCodeTextBox.BorderColor = RGB(68, 114, 196)
    Me.RcCodeTextBox.BackColor = RGB(30, 30, 30)
End Sub

'---------------------------------------------------------------------------------------------------------------------------------------------------
'---------------------------------------------------      BUTTON EVENTS    -------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------------------------------------------

Private Sub CalculatorButton_Click()
    Calculator.Calculate
End Sub


Private Sub RefreshButton_Click()
    ClearComboBoxValues
    ClearTextBoxValues
    ClearOptionGroupValues
End Sub

'---------------------------------------------------------------------------------------------------------------------------------------------------
'------------------------------------------------------    FORM EVENTS   ---------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------------------------------------------

Private Sub Form_Load()
    Set pRC = New AccountArgs
    SetComboBoxColors
    ClearTextBoxValues
    ClearOptionGroupValues
    Me.AccountDataOptionGroup.Value = 1
End Sub

Private Sub Form_Close()
    ClearComboBoxValues
    ClearTextBoxValues
End Sub

'---------------------------------------------------------------------------------------------------------------------------------------------------
'---------------------------------------------------  RADIO BUTTON EVENTS  -------------------------------------------------------------------------
'---------------------------------------------------------------------------------------------------------------------------------------------------


Private Sub AccountDataOptionGroup_AfterUpdate()
    Select Case AccountDataOptionGroup.Value
        Case 1
            ClearComboBoxValues
            ClearTextBoxValues
            Me.ActivityCodeComboBox.RowSource = "SELECT DISTINCT Left(Allocations.ActivityCode, 2) FROM ALlocations"
            Me.ActivityCodeComboBox.Requery
            Me.BudgetLevelComboBox.RowSource = "SELECT DISTINCT Allocations.BudgetLevel FROM Allocations"
            Me.BudgetLevelComboBox.Requery
            Me.BfyComboBox.RowSource = "SELECT DISTINCT Allocations.BFY FROM Allocations"
            Me.BfyComboBox.Requery
            Me.AhCodeComboBox.RowSource = "SELECT DISTINCT Allocations.AhCode FROM Allocations"
            Me.AhCodeComboBox.Requery
            Me.FundCodeComboBox.RowSource = "SELECT DISTINCT Allocations.FundCode FROM Allocations"
            Me.FundCodeComboBox.Requery
            Me.OrgCodeComboBox.RowSource = "SELECT DISTINCT Allocations.OrgCode FROM Allocations"
            Me.OrgCodeComboBox.Requery
            Me.RcCodeComboBox.RowSource = "SELECT DISTINCT Allocations.RcCode FROM Allocations"
            Me.RcCodeComboBox.Requery
            Me.AccountCodeComboBox.RowSource = "SELECT DISTINCT Allocations.AccountCode FROM Allocations"
            Me.AccountCodeComboBox.Requery
            Me.BocCodeComboBox.RowSource = "SELECT DISTINCT Allocations.BocCode FROM Allocations"
            Me.BocCodeComboBox.Requery
        Case 2
            ClearComboBoxValues
            ClearTextBoxValues
            Me.ActivityCodeComboBox.RowSource = "SELECT DISTINCT Activity.Code FROM Activity"
            Me.ActivityCodeComboBox.Requery
            Me.BudgetLevelComboBox.RowSource = "SELECT '7'"
            Me.BudgetLevelComboBox.Requery
            Me.BfyComboBox.RowSource = "SELECT DISTINCT Allocations.BFY FROM Allocations"
            Me.BfyComboBox.Requery
            Me.AhCodeComboBox.RowSource = "SELECT DISTINCT AllowanceHolders.Code FROM AllowanceHolders"
            Me.AhCodeComboBox.Requery
            Me.FundCodeComboBox.RowSource = "SELECT DISTINCT Funds.Code FROM Funds"
            Me.FundCodeComboBox.Requery
            Me.OrgCodeComboBox.RowSource = "SELECT DISTINCT Organizations.Code FROM Organizations"
            Me.OrgCodeComboBox.Requery
            Me.RcCodeComboBox.RowSource = "SELECT DISTINCT ResponsibilityCenters.Code FROM ResponsibilityCenters"
            Me.RcCodeComboBox.Requery
            Me.AccountCodeComboBox.RowSource = "SELECT DISTINCT Accounts.Code FROM Accounts"
            Me.AccountCodeComboBox.Requery
            Me.BocCodeComboBox.RowSource = "SELECT DISTINCT BudgetObjectClass.Code FROM BudgetObjectClass"
            Me.BocCodeComboBox.Requery
            Me.ActivityCodeComboBox.RowSource = "SELECT DISTINCT Activity.Code FROM Activity"
            Me.ActivityCodeComboBox.Requery
    End Select
End Sub

Private Sub ClearOptionGroupValues()
    If Not IsNull(Me.AccountDataOptionGroup) And _
        Not Me.AccountDataOptionGroup.Value & "" = "" Then
        Me.AccountDataOptionGroup.Value = ""
    End If
End Sub







'---------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        ProcessError
'   Parameters:  Void
'   RetVal:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ProcessError()
    If Err.Number <> 0 Then
        m_Error = "Source:      " & Err.Source _
            & vbCrLf & "Number:     " & Err.Number _
            & vbCrLf & "Issue:      " & Err.Description
        Err.Clear
    End If
    MessageFactory.ShowError (m_Error)
End Sub





