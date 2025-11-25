VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_F_Main_MouseMove"
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
Private Sub Detail_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
        frm_CCT.Visible = False
        Me.FirstName.OnMouseMove = "[Event Procedure]"
        Me.JobTitle.OnMouseMove = "[Event Procedure]"
        Me.LastName.OnMouseMove = "[Event Procedure]"
End Sub







'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            Form_Open()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub FirstName_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Call DisplayEnhancedControlTip(Me, Me.FirstName)
    Me.FirstName.OnMouseMove = "" 'Only run our code once, stops continuous calls and flickering
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
Private Sub JobTitle_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Call DisplayEnhancedControlTip(Me, Me.JobTitle)
    Me.JobTitle.OnMouseMove = "" 'Only run our code once, stops continuous calls and flickering
End Sub







'----------------------------------------------------------------------------------
'   Type:            Sub-Procedure
'   Name:            Form_Open()
'   Parameters:      Void
'   Retval:          Void
'   Purpose:
'---------------------------------------------------------------------------------
Private Sub LastName_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Call DisplayEnhancedControlTip(Me, Me.LastName)
    Me.LastName.OnMouseMove = "" 'Only run our code once, stops continuous calls and flickering
End Sub
