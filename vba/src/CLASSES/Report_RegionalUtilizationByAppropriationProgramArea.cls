
Option Compare Database
Option Explicit

Public Args As AccountArgs
Public m_Dialog As Form_RegionDialog
Public FundCodeArgs As String
Public RcCodeArgs As String
Public FiscalYearArgs As String
Public DivisionTitleArgs As String
Public AhCodeArgs As String
Public RpioCodeArgs As String
Public PublicLawArgs As String
Public FundTitleArgs As String
Public TreasurySymbolArgs As String
Private m_Error As String
Private m_Notification As String


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Report_Open
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Report_Load()
    On Error GoTo ErrorHandler:
ErrorHandler:
    ProcessError
    Exit Sub
End Sub


'----------------------------------------------------------------------------------
'   Type:        Event Sub-Procedure
'   Name:        Report_Open
'   Parameters:  Void
'   Retval:      Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Report_Open(Cancel As Integer)
    On Error GoTo ErrorHandler:
    DoCmd.OpenForm FormName:="RegionDialog", WindowMode:=acDialog
    Set m_Dialog = New Form_RegionDialog
    Set m_Dialog = Forms("RegionDialog")
    Set Args = New AccountArgs
    Set Args = m_Dialog.Args
    Dim SQL As String
    If Args.FundName <> "" And _
        Args.BFY <> "" And _
        Args.RpioName <> "" Then
        SQL = "SELECT *" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.FundCode = '" & Args.FundName & "'" _
        & " AND StatusOfFunds.BFY = '" & Args.BFY & "'" _
        & " AND StatusOfFunds.RpioName = '" & Args.RpioName & "';"
    End If
    If Args.FundName & "" = "" And _
        Not Args.RpioName & "" = "" And _
        Not Args.BFY = "" Then
        SQL = "SELECT *" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BFY = '" & Args.BFY & "'" _
        & " AND StatusOfFunds.RpioName = '" & Args.RpioName & "';"
    End If
    If Not Args.FundName & "" = "" And _
        Args.RpioName & "" = "" And _
        Not Args.BFY & "" = "" Then
        SQL = "SELECT *" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BFY = '" & Args.BFY & "'" _
        & " AND StatusOfFunds.FundName = '" & Args.FundName & "';"
    End If
    If Args.FundName & "" = "" And _
        Args.RpioName & "" = "" And _
        Not Args.BFY & "" = "" Then
        SQL = "SELECT *" _
        & " FROM StatusOfFunds" _
        & " WHERE StatusOfFunds.BFY = '" & Args.BFY & "';"
    End If
    Me.RecordSource = SQL
    Me.Requery
    DoCmd.Close ObjectType:=acForm, ObjectName:=m_Dialog.Name, Save:=acSaveNo
ErrorHandler:
    ProcessError
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



