VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_F_Main_Shortcut"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database





'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            Form_Open()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FirstName_GotFocus()
    If frm_CCT.Visible = True Then frm_CCT.Visible = False
End Sub







'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            Form_Open()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Close()
    DoCmd.Close acForm, "F_Enhanced_ControlTip"
End Sub







'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            Form_Open()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    Call HandleKeys(KeyCode, Shift)
End Sub







'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            Form_Open()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Form_Open(Cancel As Integer)
    Dim sName                 As String
    On Error Resume Next
    sName = frm_CCT.Name
    If Err.Number <> 0 Then
        If CurrentProject.AllForms("F_Enhanced_ControlTip").IsLoaded = False Then
            DoCmd.OpenForm "F_Enhanced_ControlTip", acNormal, , , , acHidden
        End If
        Set frm_CCT = Forms![F_Enhanced_ControlTip].Form
        Err.Clear
    End If
End Sub






'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            Form_Open()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub JobTitle_GotFocus()
    If frm_CCT.Visible = True Then frm_CCT.Visible = False
End Sub






'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            Form_Open()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub LastName_GotFocus()
    If frm_CCT.Visible = True Then frm_CCT.Visible = False
End Sub





'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            Form_Open()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Sub HandleKeys(KeyCode As Integer, Shift As Integer)
    Dim ShiftDown             As Integer
    Const KEY_h = 72
    Const Key_Tab = 9
    Const CTRL_MASK = 2
    
    ShiftDown = ((Shift And CTRL_MASK) > 0)
    Debug.Print KeyCode, ShiftDown
    Select Case KeyCode
        Case KEY_h
            If ShiftDown = -1 Then
                'do what ever here
                Call DisplayEnhancedControlTip(Me, Screen.ActiveControl)
                KeyCode = 0
            Else
            End If
        Case Key_Tab
            frm_CCT.Visible = False
    End Select
    
End Sub
