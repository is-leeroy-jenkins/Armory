VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_PdfBrowser"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

Private m_Document As String
Private m_Error As String


Private Sub Form_Load()
    If Not Me.OpenArgs & "" = "" Then
        m_Document = CStr(Me.OpenArgs)
        Me.Document.ControlSource = Application.CurrentProject.Path _
            & "\etc\docs\rmds" & m_Document & ".pdf"
    Else
        m_Document = "ObjecClassManual"
    End If
End Sub


Private Sub Form_Current()
    Dim sHTMLFile             As String    'Path to the HTML File to be rendered in the Webbrowser Control
    Dim sPDFFile              As String    'Path to each PDF
    Dim sHTML                 As String    'HTML for the HTML File to be rendered in the Webbrowser Control

    sHTMLFile = Application.CurrentProject.Path & "\PDF.html"
    sPDFFile = Application.CurrentProject.Path & "\etc\docs\rmds" & m_Document & ".pdf"
    sHTML = "<!DOCTYPE html>" & vbCrLf
    sHTML = sHTML & "<!-- saved from url=(0016)http://localhost -->" & vbCrLf
    sHTML = sHTML & "<html>" & vbCrLf
    sHTML = sHTML & "   <head>" & vbCrLf
    sHTML = sHTML & "       <meta charset=""UTF-8"">" & vbCrLf
    sHTML = sHTML & "       <meta http-equiv=""X-UA-Compatible"" content=""IE=edge"" />" & vbCrLf
    sHTML = sHTML & "       <title>Inline Documents</title>" & vbCrLf
    sHTML = sHTML & "       <style>html, body, object { height: 100%; width: 100%; }</style>" & vbCrLf
    sHTML = sHTML & "   </head>" & vbCrLf
    sHTML = sHTML & "   <body>" & vbCrLf
    sHTML = sHTML & "       <object data=""" & sPDFFile & "#view=fitH,100&scrollbar=1&toolbar=0&statusbar=0&navpanes=0"" type=""application/pdf"">" & vbCrLf
    sHTML = sHTML & "           <p>It appears you don't have Adobe Reader or PDF support in this web browser. <a href=""" & sPDFFile & """>Click here to download the PDF</a>.</p>" & vbCrLf
    sHTML = sHTML & "           <embed src=""" & sPDFFile & "#view=fitH,100&scrollbar=1&toolbar=0&statusbar=0&navpanes=0"" type=""application/pdf""/>" & vbCrLf
    sHTML = sHTML & "       </object>" & vbCrLf
    sHTML = sHTML & "   </body>" & vbCrLf
    sHTML = sHTML & "</html>"
    
    
'    'Dynamic HTML, no I/O!  ***********DOES NOT WORK****************
'    With Me.WB_Document.Object.Document
'        .Open
'        .Write sHTML
'        .Close
'    End With

    Call OverwriteTxt(sHTMLFile, sHTML)

    Me.Document.ControlSource = "=""" & sHTMLFile & """"
    On Error Resume Next
    Me.Document.Object.Refresh
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



