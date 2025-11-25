VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_F_Enhanced_ControlTip"
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
Private Sub cmd_FrmHide_Click()
    Me.Visible = False
End Sub








'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            Form_Open()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Public Sub Form_Click()
    DoCmd.Close
End Sub







'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            Form_Open()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub Text0_Click()
    Call Me.Form_Click
End Sub
