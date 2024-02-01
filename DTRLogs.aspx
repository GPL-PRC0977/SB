<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DTRLogs.aspx.vb" Inherits="SB.DTRLogs" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
       <style type="text/css">
        
body
{
    margin: 0;
    padding: 0;
    font-family: Arial;
}
/*-------------------------------------------*/
div.ajax__calendar_days table tr td {
    padding-right: 0px;
}




.Calendar .ajax__calendar_container {
    border: 1px solid #E0E0E0;
    background-color: #FAFAFA;
    width: 175px;
}
.Calendar .ajax__calendar_header {
    font-family: verdana, sans-serif;
    font-size: 12px;
    text-align: center;
    color: #9F9F9F;
    font-weight: normal;
    text-shadow: 0px 0px 2px #D3D3D3;
    height: 20px;
} 
.Calendar .ajax__calendar_title,
.Calendar .ajax__calendar_next,
.Calendar .ajax__calendar_prev {color: #004080;}
.Calendar .ajax__calendar_body {
    width: 175px;
    height: 150px;
    position: relative;
}
.Calendar .ajax__calendar_dayname {
    font-family: verdana, sans-serif;
    font-size: 10px;
    text-align: center;
    color: #FA9900;
    
    text-shadow: 0px 0px 2px #D3D3D3;
    text-align: center !important;
    background-color: #EDEDED;
    border: solid 1px #D3D3D3;
    text-transform: uppercase;
    margin: 1px;
} 
.Calendar .ajax__calendar_day {
    font-family: verdana, sans-serif;
    font-size: 10px;
    text-align: center;
    
    text-shadow: 0px 0px 2px #D3D3D3;
    text-align: center !important;
    border: solid 1px #E0E0E0;
    text-transform: uppercase;
    margin: 1px;
    width: 17px !important;
    
}

.Calendar .ajax__calendar_year {
    border: solid 1px #E0E0E0;
    font-family: verdana, sans-serif;
    font-size: 10px;
    text-align: center;
    
    text-shadow: 0px 0px 2px #D3D3D3;
    text-align: center !important;
    vertical-align: middle;
    margin: 1px;
}

.Calendar .ajax__calendar_month {
    border: solid 1px #E0E0E0;
    font-family: verdana, sans-serif;
    font-size: 10px;
    text-align: center;
    
    text-shadow: 0px 0px 2px #D3D3D3;
    text-align: center !important;
    vertical-align: middle;
    margin: 1px;
}

.Calendar .ajax__calendar_today {
    font-family: verdana, sans-serif;
    font-size: 10px;
    text-align: center;
    font-weight: bold;
    text-shadow: 0px 0px 2px #D3D3D3;
    text-align: center !important;
    text-transform: uppercase;
    margin: 1px;
    color: #6B6B6B;
}
.Calendar .ajax__calendar_other {
    background-color: #E0E0E0;
    margin: 1px;
    width: 17px;
}
.Calendar .ajax__calendar_hover .ajax__calendar_today,
.Calendar .ajax__calendar_hover .ajax__calendar_title {

}
.Calendar .ajax__calendar_footer {
    width: 175px;
    border: none;
    height: 20px;
    vertical-align: middle;
    color: #6B6B6B;
}

.Calendar .ajax__calendar_invalid 
{ 
	background-color:gray; 
	color:lightgray; 
    text-decoration:none;
	cursor:default;
} 
img.PopupImg {
    vertical-align: middle;
    padding: 0px;
    margin: 0px;
    border: none;
}
/*-------------------------------------------*/
.modal
{
    position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    top: 0;
    background-color: Black;
    filter: alpha(opacity=60);
    opacity: 0.6;
    -moz-opacity: 0.8;
}
.center
{
    z-index: 1000;
    margin: 300px auto;
    padding: 10px;
    width: 130px;
    background-color: White;
    border-radius: 10px;
    filter: alpha(opacity=100);
    opacity: 1;
    -moz-opacity: 1;
}
.center img
{
    height: 128px;
    width: 128px;
}



        .modalBackground
    {
        background-color: Black;
        filter: alpha(opacity=90);
        opacity: 0.8;
    }
    .modalPopup
    {
        background-color: #FFFFFF;
        border-width: 3px;
        border-style: solid;
        border-color: black;
        padding-top: 10px;
        padding-left: 10px;
        width: 300px;
        height: 140px;
    }

        .auto-style3 {
            width: 80px;
        }

        .auto-style6 {
            width: 200px;
        }
        .auto-style7 {
            width: 800px;
        }
        .auto-style8 {
            width: 260px;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
      <div>
    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>


    </div>
<br />

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">

        <ContentTemplate>

       
        <table style="padding: 10px; width:100%;">
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label1" runat="server" Text="ID"></asp:Label>
                </td>
                <td>
        <asp:TextBox ID="txtEmpID" runat="server" AutoPostBack="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label2" runat="server" Text="Name"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblName" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label3" runat="server" Text="Dates"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtDateFrom" runat="server" Width="80px"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="txtDateFrom_CalendarExtender" runat="server" BehaviorID="txtDateFrom_CalendarExtender" TargetControlID="txtDateFrom">
                    </ajaxToolkit:CalendarExtender>
                    <asp:Label ID="Label5" runat="server" Text=" to "></asp:Label>
                    <asp:TextBox ID="txtDateTo" runat="server" Width="80px"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="txtDateTo_CalendarExtender" runat="server" BehaviorID="TextBox2_CalendarExtender" TargetControlID="txtDateTo" >
                    </ajaxToolkit:CalendarExtender>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label20" runat="server" Text="Site"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlSite" runat="server" Width="160px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label6" runat="server" Text="Shift"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlShift" runat="server" Width="160px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td>
                    <asp:Button ID="btnGenerate" runat="server" Text="Generate" />
                </td>
            </tr>
            <tr>
                <td class="auto-style3">
                    
                </td>
                <td>

                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="gvLogs" runat="server" AutoGenerateColumns="False" CellPadding="4" Font-Size="10pt" ForeColor="#333333" Width="2100px" EmptyDataText="No Details Available">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="LogDate" DataFormatString="{0:yyyy-MM-dd}" HeaderText="Date" ItemStyle-Width="180px" >
                            <ItemStyle Width="80px" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Site">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblSite" runat="server" Text='<%# Eval("SiteCode") %>' Visible="false"></asp:Label>
                                    <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>' Visible="false"></asp:Label>

                                    <asp:DropDownList ID="ddlRowSite" runat="server" Width="200px" OnSelectedIndexChanged="ddlRowSite_SelectedIndexChanged" AutoPostBack="true" CommandArgument='<%# Container.DataItemIndex %>' >
                                    </asp:DropDownList>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Shift">
                                <ItemTemplate>

                                    <asp:Label ID="lblShift" runat="server"  Text='<%# Eval("StartShift") %>' Visible = "false" />
                                    <asp:Label ID="lblEmployeeID" runat="server" Text='<%# Eval("EmployeeID") %>' Visible = "false" />
                                    <asp:Label ID="lblLogDate" runat="server"  DataFormatString="{0:yyyy-MM-dd}" Text='<%# Eval("LogDate") %>' Visible = "false" />

                                    <asp:DropDownList ID="ddlRowShift" runat="server" Width="160px" DataValueField="ShiftStart" OnSelectedIndexChanged="ddlRowShift_SelectedIndexChanged" AutoPostBack="true" CommandArgument='<%# Container.DataItemIndex %>' >
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Location" HeaderText="Location" ItemStyle-Width="150px" >
                            <ItemStyle Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="In" DataFormatString="{0:hh:mm tt}" HeaderText="In" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80px" >
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LB-OUT" DataFormatString="{0:hh:mm tt}" HeaderText="LB-Out" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80px" >
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LB-IN" DataFormatString="{0:hh:mm tt}" HeaderText="LB-In" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80px" >
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CB-OUT" DataFormatString="{0:hh:mm tt}" HeaderText="CB-Out" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80px" >
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CB-IN" DataFormatString="{0:hh:mm tt}" HeaderText="CB-In" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80px" >
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="OUT" DataFormatString="{0:hh:mm tt}" HeaderText="Out" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80px" >
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Regular_Hrs" DataFormatString="{0:HH:mm}" HeaderText="Reg Hrs" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80px">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Total_OT_Hrs" DataFormatString="{0:HH:mm}" HeaderText="OT Hrs" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80px">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Total_Hrs" DataFormatString="{0:HH:mm}" HeaderText="Total Hrs" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80px">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                            </asp:BoundField>


                            <asp:BoundField DataField="Late_In" DataFormatString="{0:HH:mm}" HeaderText="Tardy (In)" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80px" >
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                            </asp:BoundField>

                                                        <asp:BoundField DataField="Late_LB" DataFormatString="{0:HH:mm}" HeaderText="Tardy (LB)" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80px" >
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                            </asp:BoundField>
                                                        <asp:BoundField DataField="Late_CB" DataFormatString="{0:HH:mm}" HeaderText="Tardy (CB)" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80px" >
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Total_Tardy" DataFormatString="{0:HH:mm}" HeaderText="Total Tardy"  ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80px">
                            <ItemStyle HorizontalAlign="Right" Width="80px" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    
                                    <asp:Label ID="lblRemarks" runat="server" Text='' Width="200px" />

                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="False" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F5F7FB" />
                        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                        <SortedDescendingCellStyle BackColor="#E9EBEF" />
                        <SortedDescendingHeaderStyle BackColor="#4870BE" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <br />



            <table class="auto-style7" style="padding: 0px; margin: 0px; border: 1px solid #000000; border-spacing: 0px; empty-cells: hide;">
                <tr>
                    <td class="auto-style8" style="border: 1px solid #000000; padding: 4px; margin: 0px;">

                        <asp:Label ID="Label7" runat="server" Font-Bold="False" Font-Size="8pt" Text="TOTAL NUMBER OF DAYS WORK"></asp:Label>

                    </td>
                    <td class="auto-style6" style="border: 1px solid #000000; padding: 4px; margin: 0px; text-align: center;">
                        <asp:Label ID="lblDaysWork" runat="server" Font-Bold="True" Font-Size="10pt" Text="00"></asp:Label>
                    </td>
                    <td class="auto-style8" style="border: 1px solid #000000; padding: 4px; margin: 0px;">


                        <asp:Label ID="Label9" runat="server" Font-Bold="False" Font-Size="8pt" Text="TOTAL NUMBER OF LATES"></asp:Label>


                    </td>
                    <td class="auto-style6" style="border: 1px solid #000000; padding: 4px; margin: 0px;">&nbsp;</td>
                </tr>

                <tr>
                    <td class="auto-style8" style="border: 1px solid #000000; padding: 4px; margin: 0px;">
                        <asp:Label ID="Label8" runat="server" Font-Bold="False" Font-Size="8pt" Text="TOTAL NUMBER OF EXTENDED HOURS"></asp:Label>
                    </td>
                    <td class="auto-style6" style="border: 1px solid #000000; padding: 4px; margin: 0px; text-align: center;">
                        <asp:Label ID="lblOTHours" runat="server" Font-Bold="True" Font-Size="10pt" Text="00"></asp:Label>
                    </td>
                    <td class="auto-style8" style="border: 1px solid #000000; padding: 4px; margin: 0px;">
                        <asp:Label ID="Label10" runat="server" Font-Bold="False" Font-Size="8pt" Text="WORKING DAY OFF"></asp:Label>
                    </td>
                    <td class="auto-style6" style="border: 1px solid #000000; padding: 4px; margin: 0px;">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8" style="border: 1px solid #000000; padding: 4px; margin: 0px;">&nbsp;</td>
                    <td class="auto-style6" style="border: 1px solid #000000; padding: 4px; margin: 0px;">&nbsp;</td>
                    <td class="auto-style8" style="border: 1px solid #000000; padding: 4px; margin: 0px;">
                        <asp:Label ID="Label11" runat="server" Font-Bold="False" Font-Size="8pt" Text="LEGAL HOLIDAY"></asp:Label>
                    </td>
                    <td class="auto-style6" style="border: 1px solid #000000; padding: 4px; margin: 0px;">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8" style="border: 1px solid #000000; padding: 4px; margin: 0px;">&nbsp;</td>
                    <td class="auto-style6" style="border: 1px solid #000000; padding: 4px; margin: 0px;">&nbsp;</td>
                    <td class="auto-style8" style="border: 1px solid #000000; padding: 4px; margin: 0px;">
                        <asp:Label ID="Label12" runat="server" Font-Bold="False" Font-Size="8pt" Text="SPECIAL HOLIDAY"></asp:Label>
                    </td>
                    <td class="auto-style6" style="border: 1px solid #000000; padding: 4px; margin: 0px;">&nbsp;</td>
                </tr>

            </table>
            <br />
            <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Size="9pt" Text="I HEREBY CERTIFY THA ABOVE ENTRIES ARE TRUE AND CORRECT."></asp:Label>
            <table style="width:100%;">
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label14" runat="server" Font-Bold="True" Font-Size="9pt" Text="Prepared By:"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Label ID="Label15" runat="server" Font-Bold="True" Font-Size="9pt" Text="Noted By:"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Label ID="Label16" runat="server" Font-Bold="True" Font-Size="9pt" Text="Noted By:"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td style="border-width: 1px; border-bottom-style: solid; border-color: #000000">
                        <asp:Label ID="lblName0" runat="server"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                    <td style="border-width: 1px; border-bottom-style: solid; border-color: #000000">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td style="border-width: 1px; border-bottom-style: solid; border-color: #000000">&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label17" runat="server" Font-Bold="True" Font-Size="9pt" Text="Member"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Label ID="Label18" runat="server" Font-Bold="True" Font-Size="9pt" Text="Leader"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Label ID="Label19" runat="server" Font-Bold="True" Font-Size="9pt" Text="Head"></asp:Label>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>
