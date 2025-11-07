Option Compare Database
Option Explicit

Public RcCodeArgs As String
Public FundCodeArgs As String
Public FiscalYearArgs As String
Private SQL As String
Public m_Dialog As Form_StatusOfFundsDialog
Public pAnd As String
Public Args As AccountArgs
Private m_Error As String



'---------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Report_Open
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Report_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    Set Args = New AccountArgs
    pAnd = " AND "
    DoCmd.OpenForm FormName:="StatusOfFundsDialog", WindowMode:=acDialog
    Set m_Dialog = Forms("StatusOfFundsDialog")
    Set Args = m_Dialog.Args
    If Not Args.RpioName & "" = "" And _
        Not Args.FundName & "" = "" And _
        Not Args.BFY & "" = "" Then
            SQL = "SELECT *" _
            & " FROM Obligations" _
            & " WHERE Obligations.BFY = '" & Args.BFY & "'" _
            & " AND Obligations.RpioName = '" & Args.RpioName & "'" _
            & " AND Obligations.FundName = '" & Args.FundName & "'" _
            & " AND NOT IsNull(Obligations.DocumentNumber)"
    End If
    If Not Args.RpioName & "" = "" And _
        Args.FundName & "" = "" And _
        Not Args.BFY & "" = "" Then
            SQL = "SELECT *" _
            & " FROM Obligations" _
            & " WHERE Obligations.BFY = '" & Args.BFY & "'" _
            & " AND Obligations.RpioName = '" & Args.RpioName & "'" _
            & " AND NOT IsNull(Obligations.DocumentNumber);"
    End If
    If Args.RpioName & "" = "" And _
        Args.FundName & "" = "" And _
        Not Args.BFY & "" = "" Then
            SQL = "SELECT *" _
            & " FROM Obligations" _
            & " AND NOT IsNull(Obligations.DocumentNumber)"
    End If
    If Args.RpioName & "" = "" And _
        Not Args.FundName & "" = "" And _
        Not Args.BFY & "" = "" Then
            SQL = "SELECT *" _
            & " FROM Obligations" _
            & " WHERE Obligations.BFY = '" & Args.BFY & "'" _
            & " AND Obligations.FundName = '" & Args.FundName & "'" _
            & " AND NOT IsNull(Obligations.DocumentNumber)"
    End If
    Me.RecordSource = SQL
    Me.Requery
    DoCmd.Close ObjectType:=acForm, _
        ObjectName:="StatusOfFundsDialog", Save:=acSaveNo
ErrorHandler:
    ProcessError Name:="Report", _
        Member:="ObligationsByFundingDocument"
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



