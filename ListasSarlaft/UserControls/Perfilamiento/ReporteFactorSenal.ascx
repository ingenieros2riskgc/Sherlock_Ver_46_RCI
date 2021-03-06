<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReporteFactorSenal.ascx.cs"
    Inherits="ListasSarlaft.UserControls.Perfilamiento.ReporteFactorSenal" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>--%>
<%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>--%>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<style type="text/css">
    .gridViewHeader a:link
    {
        text-decoration: none;
    }

    .FondoAplicacion
    {
        background-color: Gray;
        filter: alpha(opacity=80);
        opacity: 0.8;
    }

    .scrollingControlContainer
    {
        overflow-x: hidden;
        overflow-y: scroll;
    }

    .scrollingCheckBoxList
    {
        border: 1px #808080 solid;
        margin: 10px 10px 10px 10px;
        height: 200px;
    }

    .popup
    {
        border: Silver 1px solid;
        color: #060F40;
        background: #ffffff;
    }

    .style1
    {
        width: 815px;
    }

    .auto-style1
    {
        width: 810px;
    }
</style>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table align="center" bgcolor="#EEEEEE">
            <tr align="center" bgcolor="#333399">
                <td class="style1">
                    <asp:Label ID="Label61" runat="server" ForeColor="White" Text="Reporte relación Factores de riesgo - Señales de alerta"
                        Font-Bold="False" Font-Names="Calibri" Font-Size="Large"></asp:Label>
                </td>
            </tr>
            <tr align="center">
                <td class="style1">
                    <table>
                        <tr align="left">
                            <td bgcolor="#BBBBBB">
                                <asp:Label ID="Label4" runat="server" Text="Factor de Riesgo:" Font-Names="Calibri"
                                    Font-Size="Small"></asp:Label>
                            </td>
                            <td bgcolor="#EEEEEE">
                                <asp:DropDownList ID="ddlFactorRiesgo" runat="server" Width="200px" Font-Names="Calibri"
                                    Font-Size="Small" AutoPostBack="False">
                                </asp:DropDownList>
                                <asp:TextBox ID="TextBox8" runat="server" Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr align="center">
                <td class="style1">
                    <table>
                        <tr>
                            <td>
                                <asp:ImageButton ID="btnConsultar" runat="server" ImageUrl="~/Imagenes/Icons/lupa.png"
                                    ToolTip="Consultar" OnClick="btnConsultar_Click" />
                            </td>
                            <td>
                                <asp:ImageButton ID="btnCancelar" runat="server" ImageUrl="~/Imagenes/Icons/cancel.png"
                                    ToolTip="Cancelar" OnClick="btnCancelar_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr align="center" id="trRptFactorSenal" runat="server">
                <td class="style1">
                    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt"
                        InteractiveDeviceInfos="(Colección)" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt"
                        Height="700px" Width="750px" ShowParameterPrompts="False" ShowPrintButton="False"
                        ShowRefreshButton="False" ShowZoomControl="False">
                        <LocalReport ReportPath="Reportes\ReporteRelFactorSenal.rdlc" ReportEmbeddedResource="ListasSarlaft.Reportes.ReporteRelFactorSenal.rdlc">
                            <DataSources>
                                <rsweb:ReportDataSource DataSourceId="SqlDataSourceRelFactorSenal" Name="DSRelFactorSenal" />
                            </DataSources>
                        </LocalReport>
                    </rsweb:ReportViewer>
                    <asp:SqlDataSource ID="SqlDataSourceRelFactorSenal" runat="server" ConnectionString="<%$ ConnectionStrings:Sherlock_TestConnectionString %>"
                        SelectCommand="SP_RptFactorSenal" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="TextBox8" DefaultValue="0" Name="FactorRiesgo" PropertyName="Text"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </td>
            </tr>
        </table>
        <asp:ModalPopupExtender ID="mpeMsgBox" runat="server" TargetControlID="btndummy"
            PopupControlID="pnlMsgBox" OkControlID="btnAceptar" BackgroundCssClass="FondoAplicacion"
            Enabled="True" DropShadow="true">
        </asp:ModalPopupExtender>
        <asp:Button ID="btndummy" runat="server" Text="Button" Style="display: none" />
        <asp:Panel ID="pnlMsgBox" runat="server" Width="400px" Style="display: none;" BorderColor="#575757"
            BackColor="#FFFFFF" BorderStyle="Solid">
            <table width="100%">
                <tr class="topHandle" style="background-color: #5D7B9D">
                    <td colspan="2" align="center" runat="server" id="tdCaption">&nbsp;
                        <asp:Label ID="lblCaption" runat="server" Text="Atención" Font-Names="Calibri" Font-Size="Small"></asp:Label><br />
                    </td>
                </tr>
                <tr>
                    <td style="width: 60px" valign="middle" align="center">
                        <asp:Image ID="imgInfo" runat="server" ImageUrl="~/Imagenes/Icons/icontexto-webdev-about.png" />
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
