Option Compare Database
Option Explicit




Private m_Error As String
Private m_Notification As String




'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub BudgetDetailedSpendingButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close ObjectType:=acForm, ObjectName:="DataWarehouse", Save:=acSaveNo
    DoCmd.OpenForm FormName:="BudgetDetailedSpendingQuery", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="DataWarehouseForm", _
        Member:="BudgetDetailedSpendingButton_Click()"
    Exit Sub
End Sub




'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            BudgetStatusQueryButton_Click()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub BudgetStatusQueryButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close ObjectType:=acForm, ObjectName:="DataWarehouse", Save:=acSaveNo
    DoCmd.OpenForm FormName:="CompassBudgetStatusQuery", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="DataWarehouseForm", _
        Member:="BudgetStatusQueryButton_Click()"
    Exit Sub
End Sub



'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            CompassAdvancedButton_Click()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub CompassAdvancedButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close ObjectType:=acForm, ObjectName:="DataWarehouse", Save:=acSaveNo
    DoCmd.OpenForm FormName:="CompassAdvancedQuery", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="DataWarehouseForm", _
        Member:="CompassAdvancedButton_Click()"
    Exit Sub
End Sub



'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            PayrollAcrrualButton_Click()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub PayrollAcrrualButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close ObjectType:=acForm, ObjectName:="DataWarehouse", Save:=acSaveNo
    DoCmd.OpenForm FormName:="PayrollAccrualQuery", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="DataWarehouseForm", _
        Member:="PayrollAcrrualButton_Click()"
    Exit Sub
End Sub



'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            ReprogrammingButton_Click()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub ReprogrammingButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close ObjectType:=acForm, ObjectName:="DataWarehouse", Save:=acSaveNo
    DoCmd.OpenForm FormName:="CompassReprogrammingQuery", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="DataWarehouseForm", _
        Member:="ReprogrammingButton_Click()"
    Exit Sub
End Sub




'---------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub TravelButton_Click()
    On Error GoTo ErrorHandler:
    DoCmd.Close ObjectType:=acForm, ObjectName:="DataWarehouse", Save:=acSaveNo
    DoCmd.OpenForm FormName:="CompassTravelQuery", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="DataWarehouseForm", _
        Member:="TravelButton_Click()"
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









