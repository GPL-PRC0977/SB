Imports System.Data
Imports System.Data.SqlClient

Public Class DTRLogs
    Inherits System.Web.UI.Page
    Dim ds As DataSet
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        'txtDateFrom.Attributes.Add("readonly", "true")
        'txtDateTo.Attributes.Add("readonly", "true")


        If Not IsPostBack Then
            'If Now.Day <= 15 Then
            '    ' txtFrom.Text = 
            '    txtDateFrom_CalendarExtender.SelectedDate = Now.Year.ToString & "-" & Right("0" & Now.Month.ToString, 2) & "-01"
            'Else
            '    txtDateFrom_CalendarExtender.SelectedDate = Now.Year.ToString & "-" & Right("0" & Now.Month.ToString, 2) & "-16"
            'End If

            'If Now.Day <= 15 Then
            '    txtDateTo_CalendarExtender.SelectedDate = Now.Year.ToString & "-" & Right("0" & Now.Month.ToString, 2) & "-15"
            'Else
            '    txtDateTo_CalendarExtender.SelectedDate = Now.Date.AddDays(1)
            'End If
            Call LoadShifts(ddlShift)

            txtDateFrom_CalendarExtender.StartDate = Now.Date.AddDays(-181)
            txtDateFrom_CalendarExtender.EndDate = Now.Date.AddDays(181)

            txtDateTo_CalendarExtender.StartDate = Now.Date.AddDays(-181)
            txtDateTo_CalendarExtender.EndDate = Now.Date.AddDays(181)
        Else
            'txtDateFrom.Text = Session("DateFrom")
            'txtDateTo.Text = Session("DateTo")
            'txtDateFrom.Attributes.Add("readonly", "true")
            'txtDateTo.Attributes.Add("readonly", "true")
        End If


    End Sub
    Private Sub LoadSites(ddl As DropDownList)
        Dim strSQL As String
        Dim ds As New DataSet
        strSQL = "SELECT * FROM vw_SitesNearby WHERE EmployeeID = '" & txtEmpID.Text & "' order by SiteName"

        ds = ExecuteQuery(strSQL)

        ddl.DataTextField = "SiteName"
        ddl.DataValueField = "SiteCode"
        ddl.DataSource = ds.Tables(0)
        ddl.DataBind()
    End Sub
    Private Sub LoadShifts(ddl As DropDownList)
        Dim tStart As DateTime
        Dim tEnd As DateTime
        Dim i As Integer
        Dim itm As ListItem
        tStart = "6:00:00.000"
        tEnd = tStart.AddHours(9)
        For i = 0 To 38
            itm = New ListItem
            itm.Text = tStart.TimeOfDay.ToString & " - " & tEnd.TimeOfDay.ToString
            itm.Value = tStart.TimeOfDay.ToString
            ddl.Items.Add(itm)

            tStart = tStart.AddMinutes(15)
            tEnd = tStart.AddHours(9)
        Next

        itm = New ListItem
        itm.Text = "REST DAY"
        itm.Value = "00:00:10"
        ddl.Items.Add(itm)

        itm = New ListItem
        itm.Text = "ABSENT"
        itm.Value = "00:00:00"
        ddl.Items.Add(itm)

        itm = New ListItem
        itm.Text = "OFFICIAL BUSINESS"
        itm.Value = "00:00:01"
        ddl.Items.Add(itm)
    End Sub
    Private Function GetEmployeeInfoByID(ByVal EmployeeID As String) As DataSet
        Dim strSQL As String
        Dim ds As New DataSet
        strSQL = "SELECT * FROM T_Employee WHERE EmployeeID = '" & EmployeeID & "'"

        ds = ExecuteQuery(strSQL)

        Return ds
    End Function
    Private Function GetLogs(tStart As DateTime) As DataSet
        Dim strSQL As String
        Dim ds As New DataSet

        'strSQL = "exec sp_ProcessLogs"
        'ExecuteNonQuery(strSQL)

        'strSQL = "delete from [dbo].[T_Shift] where EmployeeID = '" & txtEmpID.Text & "' and [Date] between '" & txtDateFrom.Text & "' and '" & txtDateTo.Text & "' "
        'ExecuteNonQuery(strSQL)

        strSQL = "insert into [dbo].[T_Shift] (EmployeeID, [Date], StartShift, [SiteCode], [Location]) Select EmployeeID, LogDate, Cast(LogDate as DateTime) + ' " & tStart.TimeOfDay.ToString & "','" & ddlSite.SelectedItem.Value & "', [Location]  from [dbo].[T_DTRLogs] where EmployeeID = '" & txtEmpID.Text & "' and LogDate between '" & txtDateFrom.Text & "' and '" & txtDateTo.Text & "'"
        ExecuteNonQuery(strSQL)


        strSQL = "Select Distinct * From vw_DTRLogs Where EmployeeID = '" & txtEmpID.Text & "' and LogDate between '" & txtDateFrom.Text & "' and '" & txtDateTo.Text & "' ORDER BY LogDate, [IN] "
        ds = ExecuteQuery(strSQL)

        If ds.Tables(0).Rows.Count > 0 Then
            Session("DTRLogs") = ds.Tables(0)
            gvLogs.DataSource = Session("DTRLogs")
            gvLogs.DataBind()
            ds = Nothing
        Else
            ds = Nothing
            gvLogs.DataSource = Nothing
            gvLogs.DataBind()
        End If







        strSQL = "Select ISNULL(sum(DaysWork),0) as CT, ISNULL(CAST(CAST(SUM(DATEDIFF(mi,'0:00:00.000',CAST(Total_OT_Hrs as Time))) as numeric(18,2))/60 as numeric(18,2)),0) as OT_Hrs From vw_DTRLogs Where EmployeeID = '" & txtEmpID.Text & "' and LogDate between '" & txtDateFrom.Text & "' and '" & txtDateTo.Text & "' "
        ds = ExecuteQuery(strSQL)
        With ds.Tables(0)
            'lblDaysWork.Text = .Rows(0)("CT")
            lblOTHours.Text = .Rows(0)("OT_Hrs")
        End With


        strSQL = "select SUM(DaysWork) as CT from (Select logdate, ISNULL(max(DaysWork),0) as DaysWork From [dbo].[vw_DTRLogs] where EmployeeID = '" & txtEmpID.Text & "' and LogDate between '" & txtDateFrom.Text & "' and '" & txtDateTo.Text & "' group by LogDate) as x"
        ds = New DataSet
        ds = ExecuteQuery(strSQL)
        With ds.Tables(0)
            lblDaysWork.Text = .Rows(0)("CT")
            'lblOTHours.Text = .Rows(0)("OT_Hrs")
        End With

    End Function
    Private Function ExecuteQuery(ByVal strSQL As String) As DataSet
        Dim ds As New DataSet
        Dim cn As New SqlConnection(ConfigurationManager.ConnectionStrings("SQLConnection").ToString)
        Dim da As New SqlDataAdapter
        Dim cmd As SqlCommand

        Try
            cmd = New SqlCommand(strSQL, cn)
            cmd.CommandTimeout = 0
            da.SelectCommand = cmd
            da.Fill(ds, "Result")
            Return ds
            cn.Close()
            cn = Nothing
        Catch ex As Exception
            Return Nothing

        End Try

    End Function

    Private Function ExecuteNonQuery(ByVal strSQL As String) As Long
        'Dim strSQL As String
        Dim iRet As Integer

        Dim cn As New SqlConnection(ConfigurationManager.ConnectionStrings("SQLConnection").ToString)
        Dim da As New SqlDataAdapter
        Dim cmd As New SqlCommand

        Try
            cn.Open()
            cmd.CommandText = strSQL
            cmd.Connection = cn
            iRet = cmd.ExecuteNonQuery
            cn.Close()
            cn = Nothing

            Return iRet
        Catch ex As Exception
            Return -1

        End Try
    End Function
    Protected Sub btnGenerate_Click(sender As Object, e As EventArgs) Handles btnGenerate.Click
        GetLogs(ddlShift.SelectedValue)
    End Sub

    Protected Sub txtEmpID_TextChanged(sender As Object, e As EventArgs) Handles txtEmpID.TextChanged
        ds = New DataSet
        ds = GetEmployeeInfoByID(txtEmpID.Text)
        If ds.Tables(0).Rows.Count = 1 Then
            txtDateFrom.Attributes.Add("readonly", "false")
            txtDateTo.Attributes.Add("readonly", "false")
            Session("DateFrom") = txtDateFrom.Text
            Session("DateTo") = txtDateTo.Text
            Session("EmployeeInfo") = ds.Tables(0)
            With Session("EmployeeInfo")
                lblName.Text = .Rows(0)("FirstName") & " " & .Rows(0)("LastName")
                lblName0.Text = .Rows(0)("FirstName") & " " & .Rows(0)("LastName")
            End With
            Call LoadSites(ddlSite)

        End If



    End Sub

    Private Sub gvLogs_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvLogs.RowDataBound
        Try
            If (e.Row.RowType = DataControlRowType.DataRow) Then

                Dim ddl As DropDownList = CType(e.Row.FindControl("ddlRowShift"), DropDownList)
                LoadShifts(ddl)

                Dim ddl2 As DropDownList = CType(e.Row.FindControl("ddlRowSite"), DropDownList)
                LoadSites(ddl2)

                Dim shift As String = CType(e.Row.FindControl("lblShift"), Label).Text
                ddl.Items.FindByValue(shift).Selected = True

                Dim site As String = CType(e.Row.FindControl("lblSite"), Label).Text
                ddl2.Items.FindByValue(site).Selected = True

            End If
        Catch ex As Exception

        End Try


    End Sub

    Protected Sub ddlRowShift_SelectedIndexChanged(sender As Object, e As EventArgs)
        'Dim shift As String = CType(e.Row.FindControl("lblShift"), Label).Text
        'ddl.Items.FindByValue(shift).Selected = True
        Dim ddl As DropDownList = DirectCast(sender, DropDownList)
        'Dim iRow As String = e.CommandArgument
        Dim str As String
        Dim id As Integer
        'id = gvLogs.rowi
        Dim gvr As GridViewRow = CType(ddl.NamingContainer, GridViewRow)
        Dim sEmployee As String = CType(gvr.FindControl("lblEmployeeID"), Label).Text

        Dim sLocation As String = CType(gvr.FindControl("lblLocation"), Label).Text
        Dim sLogDate As DateTime = CType(gvr.FindControl("lblLogDate"), Label).Text
        str = ddl.SelectedValue

        Dim strsql As String
        If ddl.SelectedItem.Text = "REST DAY" Then
            strsql = "Update T_Shift Set StartShift = CAST('" & Format(sLogDate, "yyyy-MM-dd") & " 00:00:10.000' as datetime) Where EmployeeID = '" & sEmployee & "' and Date = CAST('" & sLogDate & "' as Date) "

        ElseIf ddl.SelectedItem.Text = "ABSENT" Then
            strsql = "Update T_Shift Set StartShift = CAST('" & Format(sLogDate, "yyyy-MM-dd") & " 00:00:00.000' as datetime) Where EmployeeID = '" & sEmployee & "' and Date = CAST('" & sLogDate & "' as Date) "

        ElseIf ddl.SelectedItem.Text = "OFFICIAL BUSINESS" Then
            strsql = "Update T_Shift Set StartShift = CAST('" & Format(sLogDate, "yyyy-MM-dd") & " 00:00:01.000' as datetime) Where EmployeeID = '" & sEmployee & "' and Date = CAST('" & sLogDate & "' as Date) "

        Else

            strsql = "Update T_Shift Set StartShift = CAST('" & Format(sLogDate, "yyyy-MM-dd") & " " & ddl.SelectedValue & "' as datetime) Where EmployeeID = '" & sEmployee & "' and Date = CAST('" & sLogDate & "' as Date) AND [Location] = 'Mike-ICT'"
        End If

        ExecuteNonQuery(strsql)



        strsql = "Select Distinct * From vw_DTRLogs Where EmployeeID = '" & txtEmpID.Text & "' and LogDate between '" & txtDateFrom.Text & "' and '" & txtDateTo.Text & "' ORDER BY LogDate, [IN] "
        ds = ExecuteQuery(strsql)
        Session("DTRLogs") = ds.Tables(0)
        gvLogs.DataSource = Session("DTRLogs")
        gvLogs.DataBind()
        ds = Nothing



        strsql = "Select ISNULL(sum(DaysWork),0) as CT, ISNULL(CAST(CAST(SUM(DATEDIFF(mi,'0:00:00.000',CAST(Total_OT_Hrs as Time))) as numeric(18,2))/60 as numeric(18,2)),0) as OT_Hrs From vw_DTRLogs Where EmployeeID = '" & txtEmpID.Text & "' and LogDate between '" & txtDateFrom.Text & "' and '" & txtDateTo.Text & "' "
        ds = ExecuteQuery(strsql)
        With ds.Tables(0)
            'lblDaysWork.Text = .Rows(0)("CT")
            lblOTHours.Text = .Rows(0)("OT_Hrs")
        End With


        strsql = "select SUM(DaysWork) as CT from (Select logdate, ISNULL(max(DaysWork),0) as DaysWork From [dbo].[vw_DTRLogs] where EmployeeID = '" & txtEmpID.Text & "' and LogDate between '" & txtDateFrom.Text & "' and '" & txtDateTo.Text & "' group by LogDate) as x"
        ds = New DataSet
        ds = ExecuteQuery(strsql)
        With ds.Tables(0)
            lblDaysWork.Text = .Rows(0)("CT")
            'lblOTHours.Text = .Rows(0)("OT_Hrs")
        End With
    End Sub

    Protected Sub gvLogs_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvLogs.SelectedIndexChanged

    End Sub

    Protected Sub ddlRowSite_SelectedIndexChanged(sender As Object, e As EventArgs)
        'Dim shift As String = CType(e.Row.FindControl("lblShift"), Label).Text
        'ddl.Items.FindByValue(shift).Selected = True
        Dim ddl As DropDownList = DirectCast(sender, DropDownList)
        'Dim iRow As String = e.CommandArgument
        Dim str As String
        Dim id As Integer
        'id = gvLogs.rowi
        Dim gvr As GridViewRow = CType(ddl.NamingContainer, GridViewRow)
        Dim sEmployee As String = CType(gvr.FindControl("lblEmployeeID"), Label).Text
        Dim sLocation As String = CType(gvr.FindControl("lblLocation"), Label).Text
        Dim sLogDate As DateTime = CType(gvr.FindControl("lblLogDate"), Label).Text
        str = ddl.SelectedValue

        Dim strsql As String
        If sLocation.Trim = "" Then
            strsql = "Update T_Shift Set SiteCode = '" & str & "' Where EmployeeID = '" & sEmployee & "' and Date = CAST('" & sLogDate & "' as Date) AND [Location] is null"
        Else
            strsql = "Update T_Shift Set SiteCode = '" & str & "' Where EmployeeID = '" & sEmployee & "' and Date = CAST('" & sLogDate & "' as Date) AND [Location] = 'Mike-ICT'--'" & sLocation & "'"
        End If


        ExecuteNonQuery(strsql)



        strsql = "Select Distinct * From vw_DTRLogs Where EmployeeID = '" & txtEmpID.Text & "' and LogDate between '" & txtDateFrom.Text & "' and '" & txtDateTo.Text & "' "
        ds = ExecuteQuery(strsql)
        Session("DTRLogs") = ds.Tables(0)
        gvLogs.DataSource = Session("DTRLogs")
        gvLogs.DataBind()
        ds = Nothing

    End Sub
End Class