Option Compare Database
Option Explicit


Public Args As BudgetArgs
Public m_Dialog As Form_TimeDialog
Private m_StartDate As Date
Private m_EndDate As Date
Private m_Error As String







'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Report_Open
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Report_Load()
    On Error GoTo ErrorHandler:
    Set m_Dialog = New Form_TimeDialog
    Set Args = New BudgetArgs
ErrorHandler:
    ProcessError Name:="", _
        Member:=""
    Exit Sub
End Sub

'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Report_Open
'   Parameters:  Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Report_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    DoCmd.OpenForm FormName:="TimeDialog", WindowMode:=acDialog
    Set m_Dialog = Forms("TimeDialog")
    Set Args = m_Dialog.Args
    Dim SQL As String
    If Not Args.FundName & "" = "" And _
        Not Args.BocName & "" = "" Then
            SQL = "SELECT *" _
            & " FROM Reprogrammings" _
            & " WHERE Reprogrammings.FundName = '" & Args.FundName & "'" _
            & " AND Reprogrammings.BocName = '" & Args.BocName & "'" _
            & " AND Reprogrammings.ProcessedDate >= #" & Args.StartDate & "#" _
            & " AND Reprogrammings.ProcessedDate <= #" & Args.EndDate & "#;"
    End If
    If Not Args.FundName & "" = "" And _
        Args.BocName & "" = "" Then
            SQL = "SELECT *" _
            & " FROM Reprogrammings" _
            & " WHERE Reprogrammings.FundName = '" & Args.FundName & "'" _
            & " AND Reprogrammings.ProcessedDate >= #" & Args.StartDate & "#" _
            & " AND Reprogrammings.ProcessedDate <= #" & Args.EndDate & "#;"
    End If
    If Args.FundName & "" = "" And _
        Args.BocName & "" = "" Then
            SQL = "SELECT *" _
            & " FROM Reprogrammings" _
            & " WHERE Reprogrammings.ProcessedDate >= #" & Args.StartDate & "#" _
            & " AND Reprogrammings.ProcessedDate <= #" & Args.EndDate & "#;"
    End If
    Me.RecordSource = SQL
    Me.Requery
    DoCmd.Close ObjectType:=acForm, ObjectName:=Me.Name
ErrorHandler:
    ProcessError Name:="", _
        Member:="Report_Open()"
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

