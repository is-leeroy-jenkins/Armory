Option Compare Database
Option Explicit

Private m_Error As String





'---------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        SynchronizeStatusOfFunds()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Sub SynchronizeStatusOfFunds()
    On Error GoTo ErrorHandler
    DoCmd.OpenQuery "DeleteStatusOfFunds"
    DoCmd.OpenQuery "InsertStatusOfFundsUpdates"
    DoCmd.OpenForm FormName:="MessageDialog", _
        OpenArgs:="The Status Of Funds Data Table has been synchronized!"
ErrorHandler:
    ProcessError Name:="Command", _
        Member:="SynchronizeStatusOfFunds()"
End Sub





'---------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        SynchronizeDefactos()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Sub SynchronizeDefactos()
    On Error GoTo ErrorHandler
    DoCmd.OpenQuery "DeleteDefactos"
    DoCmd.OpenQuery "InsertDefactoUpdates"
    DoCmd.OpenForm FormName:="MessageDialog", _
        OpenArgs:="The Defactos Data Table has been synchronized!"
ErrorHandler:
    ProcessError Name:="Command", _
        Member:="SynchronizeDefactos()"
End Sub



'---------------------------------------------------------------------------------
'   Type:        Sub-Procedure
'   Name:        USynchronizeTransfers()
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Sub SynchronizeTransfers()
    On Error GoTo ErrorHandler
    DoCmd.RunMacro "UpdateTransfers"
ErrorHandler:
    ProcessError Name:="Command", _
        Member:="SSynchronizeTransfers()"
End Sub











'---------------------------------------------------------------------------------
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




