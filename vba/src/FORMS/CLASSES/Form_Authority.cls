Option Compare Database
Option Explicit

Private m_Error As String






Private Sub ObligationButton_Click()
    On Error GoTo ErrorHandler
    DoCmd.Close acForm, "Authority", acSaveNo
    DoCmd.OpenForm FormName:="ProgrammaticObligations", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="Authority", _
        Member:="StatusOfFundsButton_Click()"
    Exit Sub
End Sub




'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        MaintenanceButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub StatusOfFundsButton_Click()
    On Error GoTo ErrorHandler
    DoCmd.Close acForm, "Authority", acSaveNo
    DoCmd.OpenForm FormName:="StatusOfFunds", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="Authority", _
        Member:="StatusOfFundsButton_Click()"
    Exit Sub
End Sub





'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        MaintenanceButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub TravelButton_Click()
    On Error GoTo ErrorHandler
    DoCmd.Close acForm, "Authority", acSaveNo
    DoCmd.OpenForm FormName:="TravelAllocations", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="Authority", _
        Member:="TravelButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        MaintenanceButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub PayrollButton_Click()
    On Error GoTo ErrorHandler
    DoCmd.Close acForm, "Authority", acSaveNo
    DoCmd.OpenForm FormName:="PayrollAuthority", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="Authority", _
        Member:="PayrollButton_Click()"
    Exit Sub
End Sub



'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        MaintenanceButton_Click()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub TransferButton_Click()
    On Error GoTo ErrorHandler
    DoCmd.Close acForm, "Authority", acSaveNo
    DoCmd.OpenForm FormName:="Transfer", WindowMode:=acDialog
ErrorHandler:
    ProcessError Name:="Authority", _
        Member:="TransferButton_Click()"
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



