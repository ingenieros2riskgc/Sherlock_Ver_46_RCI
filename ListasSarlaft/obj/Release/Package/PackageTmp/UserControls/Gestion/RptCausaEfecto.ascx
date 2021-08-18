﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RptCausaEfecto.ascx.cs" Inherits="ListasSarlaft.UserControls.Gestion.RptCausaEfecto" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>--%>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>--%>

<link href="../../Styles/MastersPages.css" rel="stylesheet" type="text/css" />
<style type="text/css">
    #TableVision
    {
        width: 1305px;
        height: 811px;
    }
    #Background
    {
        position: fixed;
        top: 0px;
        bottom: 0px;
        left: 0px;
        right: 0px;
        overflow: hidden;
        padding: 0;
        margin: 0;
        background: #EEEEEE;
        filter: alpha(opacity=80);
        opacity: 0.8;
        z-index: 100000;
    }
    
    #Progress
    {
        position: fixed;
        top: 40%;
        left: 40%;
        height: 10%;
        width: 20%;
        z-index: 100001;
        background-color: #FFFFFF;
        border: 1px solid Gray;
        background-image: url('./Imagenes/Icons/loading.gif');
        background-repeat: no-repeat;
        background-position: center;
    }
</style>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table align="center" bgcolor="#EEEEEE">
            <tr>
	<td align="center">
    		<asp:UpdateProgress ID="UpdateProgress4" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
    		<ProgressTemplate>
                                <div id="Background">
                                </div>
                                <div id="Progress">
                                    <asp:Label ID="Lbl11" runat="server" Text="Procesando, por favor espere..." Font-Names="Calibri"
                                        Font-Size="Small"></asp:Label>
                                    <br />
                                    <asp:Image ID="Img11" runat="server" ImageUrl="~/Imagenes/Icons/loading.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
            </tr>
            <tr align="center" bgcolor="#333399">
                <td>
                    <asp:Label ID="Label7" runat="server" ForeColor="White" Text="Reporte Causa & Efecto" Font-Bold="False"
                        Font-Names="Calibri" Font-Size="Large"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                                <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
                                <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Button" />
                                <br />
                                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
                                    Font-Size="8pt" InteractiveDeviceInfos="(Colección)" 
                                    WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="1200px" 
                                    Height="600px">
                                    <LocalReport ReportPath="Reportes\CausaEfecto.rdlc">
                                        <DataSources>
                                            <rsweb:ReportDataSource DataSourceId="SqlDataSourceCausaEfecto" 
                                                Name="DataSet1" />
                                        </DataSources>
                                    </LocalReport>
                                </rsweb:ReportViewer>
                                <asp:SqlDataSource ID="SqlDataSourceCausaEfecto" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>" 
                                    SelectCommand="sp_CausaEfecto" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="TextBox8" DefaultValue="PE1" Name="CodigoPlan" 
                                            PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <br />
                </td>
            </tr>
        </table>
        <asp:ModalPopupExtender ID="mpeMsgBox" runat="server" TargetControlID="btndummy"
            PopupControlID="pnlMsgBox" OkControlID="btnAceptar" BackgroundCssClass="FondoAplicacion"
            Enabled="True" DropShadow="true">
        </asp:ModalPopupExtender>
        <asp:Button ID="btndummy" runat="server" Text="Button" Style="display: none" />
        <asp:Panel ID="pnlMsgBox" runat="server" Width="400px" Style="display: none;" BorderColor="#575757" BorderWidth="1px" 
            BackColor="White" BorderStyle="Solid">
            <table width="100%">
                <tr class="topHandle" style="background-color: #333399">
                    <td colspan="2" align="center" runat="server" id="tdCaption">
                        &nbsp;
                        <asp:Label ID="lblCaption" runat="server" Text="Atención" ForeColor="White" Font-Names="Calibri" Font-Size="Small"></asp:Label><br />
                    </td>
                </tr>
                <tr>
                    <td style="width: 60px" valign="middle" align="center">
                        <asp:Image ID="imgInfo" runat="server" ImageUrl="~/Imagenes/Icons/icontexto-webdev-ok.png" />
                    </td>
                    <td valign="middle" align="left">
                        <asp:Label ID="lblMsgBox" runat="server" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2">
                        <asp:Button ID="btnAceptar" runat="server" Text="Ok" Font-Names="Calibri" Font-Size="Small" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>
