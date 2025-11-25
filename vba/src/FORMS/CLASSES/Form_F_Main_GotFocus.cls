VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_F_Main_GotFocus"
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
    Call DisplayEnhancedControlTip(Me, Me.FirstName)
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
Private Sub Form_Open(Cancel As Integer)
    DoCmd.OpenForm "F_Enhanced_ControlTip", acNormal, , , , acHidden
    If frm_CCT Is Nothing Then Set frm_CCT = Forms![F_Enhanced_ControlTip].Form
End Sub






'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub JobTitle_GotFocus()
    Call DisplayEnhancedControlTip(Me, Me.JobTitle)
End Sub






'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub LastName_GotFocus()
    Call DisplayEnhancedControlTip(Me, Me.LastName)
End Sub
