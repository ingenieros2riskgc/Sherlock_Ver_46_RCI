﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReporteEventos.ascx.cs"
    Inherits="ListasSarlaft.UserControls.Eventos.ReporteEventos" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
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
</style>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table align="center" bgcolor="#EEEEEE">
            <tr align="center" bgcolor="#333399">
                <td>
                    <asp:Label ID="Label140" runat="server" Font-Bold="False" Font-Names="Calibri" Font-Size="Large"
                        ForeColor="White" Text="Reportes Eventos"></asp:Label>
                </td>
            </tr>
            <tr align="center">
                <td>
                    <table>
                        <tr align="left">
                            <td bgcolor="#BBBBBB">
                                <asp:Label ID="Label1" runat="server" Text="Tipo de reporte" Font-Names="Calibri"
                                    Font-Size="Small"></asp:Label>
                            </td>
                            <td bgcolor="#EEEEEE">
                                <asp:DropDownList ID="DropDownList1" runat="server" Width="200px" Font-Names="Calibri"
                                    Font-Size="Small">
                                    <asp:ListItem Value="---">---</asp:ListItem>
                                    <asp:ListItem Value="1">No hubo eventos</asp:ListItem>
                                    <asp:ListItem Value="2">Eventos</asp:ListItem>
                                    <asp:ListItem Value="3">Eventos vrs Planes de Acción</asp:ListItem>
                                    <asp:ListItem Value="4">Sin Reporte</asp:ListItem>
                                    <asp:ListItem Value="5">Consolidado</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DropDownList1"
                                    InitialValue="---" ForeColor="Red" ValidationGroup="consultar">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr align="left">
                            <td bgcolor="#BBBBBB">
                                <asp:Label ID="Label153" runat="server" Text="Cadena de valor" Font-Names="Calibri"
                                    Font-Size="Small"></asp:Label>
                            </td>
                            <td bgcolor="#EEEEEE">
                                <asp:DropDownList ID="DropDownList52" runat="server" Width="200px" Font-Names="Calibri"
                                    Font-Size="Small" AutoPostBack="True" OnSelectedIndexChanged="DropDownList52_SelectedIndexChanged">
                                    <asp:ListItem Value="---">---</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td bgcolor="#BBBBBB">
                                <asp:Label ID="Label154" runat="server" Text="Macroproceso" Font-Names="Calibri"
                                    Font-Size="Small"></asp:Label>
                            </td>
                            <td bgcolor="#EEEEEE">
                                <asp:DropDownList ID="DropDownList53" runat="server" Width="200px" Font-Names="Calibri"
                                    Font-Size="Small" AutoPostBack="True" OnSelectedIndexChanged="DropDownList53_SelectedIndexChanged">
                                    <asp:ListItem Value="---">---</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td bgcolor="#BBBBBB">
                                <asp:Label ID="Label155" runat="server" Text="Proceso" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td bgcolor="#EEEEEE">
                                <asp:DropDownList ID="DropDownList54" runat="server" Width="200px" Font-Names="Calibri"
                                    Font-Size="Small">
                                    <asp:ListItem Value="---">---</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left" id="t1" runat="server" visible="false">
                            <td bgcolor="#BBBBBB">
                                <asp:Label ID="Label157" runat="server" Text="Riesgos globales" Font-Names="Calibri"
                                    Font-Size="Small"></asp:Label>
                            </td>
                            <td bgcolor="#EEEEEE">
                                <asp:DropDownList ID="DropDownList56" runat="server" Width="455px" Font-Names="Calibri"
                                    Font-Size="Small" AutoPostBack="True" OnSelectedIndexChanged="DropDownList56_SelectedIndexChanged">
                                    <asp:ListItem Value="---">---</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left" id="t2" runat="server" visible="false">
                            <td bgcolor="#BBBBBB">
                                <asp:Label ID="Label158" runat="server" Text="Clasificación general" Font-Names="Calibri"
                                    Font-Size="Small"></asp:Label>
                            </td>
                            <td bgcolor="#EEEEEE">
                                <asp:DropDownList ID="DropDownList57" runat="server" Width="455px" Font-Names="Calibri"
                                    Font-Size="Small">
                                    <asp:ListItem Value="---">---</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left" id="t3" runat="server" visible="false">
                            <td bgcolor="#BBBBBB">
                                <asp:Label ID="Label2" runat="server" Text="Riesgo inherente" Font-Names="Calibri"
                                    Font-Size="Small"></asp:Label>
                            </td>
                            <td bgcolor="#EEEEEE">
                                <asp:DropDownList ID="DropDownList2" runat="server" Width="200px" Font-Names="Calibri"
                                    Font-Size="Small">
                                    <asp:ListItem Value="---">---</asp:ListItem>
                                    <asp:ListItem Value="Extremo">Extremo</asp:ListItem>
                                    <asp:ListItem Value="Alto">Alto</asp:ListItem>
                                    <asp:ListItem Value="Moderado">Moderado</asp:ListItem>
                                    <asp:ListItem Value="Bajo">Bajo</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left" id="t4" runat="server" visible="false">
                            <td bgcolor="#BBBBBB">
                                <asp:Label ID="Label3" runat="server" Text="Riesgo residual" Font-Names="Calibri"
                                    Font-Size="Small"></asp:Label>
                            </td>
                            <td bgcolor="#EEEEEE">
                                <asp:DropDownList ID="DropDownList3" runat="server" Width="200px" Font-Names="Calibri"
                                    Font-Size="Small">
                                    <asp:ListItem Value="---">---</asp:ListItem>
                                    <asp:ListItem Value="Extremo">Extremo</asp:ListItem>
                                    <asp:ListItem Value="Alto">Alto</asp:ListItem>
                                    <asp:ListItem Value="Moderado">Moderado</asp:ListItem>
                                    <asp:ListItem Value="Bajo">Bajo</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left" id="Tr1" runat="server">
                            <td bgcolor="#BBBBBB">
                                <asp:Label ID="Label5" runat="server" Text="Fecha Inicio" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td bgcolor="#EEEEEE">
                                <asp:TextBox ID="TextBox1" runat="server" Width="195px" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                                <asp:CalendarExtender ID="CalendarExtender4" runat="server" Enabled="True" TargetControlID="TextBox1"
                                    Format="yyyy-MM-dd">
                                </asp:CalendarExtender>
                            </td>
                        </tr>
                        <tr align="left" id="Tr2" runat="server">
                            <td bgcolor="#BBBBBB">
                                <asp:Label ID="Label6" runat="server" Text="Fecha Fin" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td bgcolor="#EEEEEE">
                                <asp:TextBox ID="TextBox2" runat="server" Width="195px" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                                <asp:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" TargetControlID="TextBox2"
                                    Format="yyyy-MM-dd">
                                </asp:CalendarExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td bgcolor="#BBBBBB">
                                <asp:Label ID="Label4" runat="server" Text="Empresa" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td bgcolor="#EEEEEE">
                                <asp:DropDownList ID="DropDownList4" runat="server" Width="200px" Font-Names="Calibri"
                                    Font-Size="Small">
                                    <asp:ListItem Value="---">---</asp:ListItem>
                                    <%--<asp:ListItem Value="1">Vida</asp:ListItem>
                                    <asp:ListItem Value="2">Generales</asp:ListItem>--%>
                                    <asp:ListItem Value="3">Empresa</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr align="center">
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Imagenes/Icons/lupa.png"
                                    ToolTip="Consultar" ValidationGroup="consultar" OnClick="ImageButton1_Click" />
                            </td>
                            <td>
                                <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/Imagenes/Icons/cancel.png"
                                    ToolTip="Cancelar" OnClick="ImageButton5_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr align="center" id="ReporteRiesgos" runat="server" visible="false">
                <td>
                    <table>
                        <tr align="left">
                            <td>
                                <asp:Button ID="Button6" runat="server" Text="Exportar" ToolTip="Exportar" Font-Names="Calibri"
                                    Font-Size="Small" OnClick="Button6_Click" />
                            </td>
                        </tr>
                        <tr align="center">
                            <td>
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                    ForeColor="#333333" GridLines="Vertical" ShowHeaderWhenEmpty="True" HeaderStyle-CssClass="gridViewHeader"
                                    BorderStyle="Solid" HorizontalAlign="Center" Font-Names="Calibri" Font-Size="Small"
                                    AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <Columns>
                                        <asp:BoundField HeaderText="Codigo Evento" DataField="CodigoEvento" />
                                        <asp:BoundField HeaderText="Empresa" DataField="Empresa" />
                                        <asp:BoundField HeaderText="Fecha No Hubo Evento" DataField="FechaNoHuboEvento" />
                                        <asp:BoundField HeaderText="Nombre Responsable" DataField="NombreResponsable" />
                                        <asp:BoundField HeaderText="Cargo" DataField="Cargo" />
                                        <asp:BoundField HeaderText="Área" DataField="Area" />
                                    </Columns>
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="White" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr align="center" id="ReporteRiesgosControles" runat="server" visible="false">
                <td>
                    <table>
                        <tr align="left">
                            <td>
                                <asp:Button ID="Button1" runat="server" Text="Exportar" ToolTip="Exportar" Font-Names="Calibri"
                                    Font-Size="Small" OnClick="Button1_Click" />
                            </td>
                        </tr>
                        <tr align="center">
                            <td>
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                    ForeColor="#333333" GridLines="Vertical" ShowHeaderWhenEmpty="True" HeaderStyle-CssClass="gridViewHeader"
                                    BorderStyle="Solid" HorizontalAlign="Center" Font-Names="Calibri" Font-Size="Small"
                                    AllowPaging="True" OnPageIndexChanging="GridView2_PageIndexChanging">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <Columns>
                                        <asp:BoundField HeaderText="Código" DataField="Código" />
                                        <asp:BoundField HeaderText="Empresa" DataField="Empresa" />
                                        <asp:BoundField HeaderText="Cadena Valor" DataField="Cadena Valor" />
                                        <asp:BoundField DataField="MacroProceso" HeaderText="Macroproceso" />
                                        <asp:BoundField DataField="Estado" HeaderText="Estado" />
                                        <asp:BoundField DataField="Proceso" HeaderText="Proceso" />
                                        <asp:BoundField DataField="SubProceso" HeaderText="SubProceso" />
                                        <asp:BoundField DataField="Actividad" HeaderText="Actividad" />
                                        <asp:BoundField DataField="Responsable Solución" HeaderText="Responsable Solución" />
                                        <%--<asp:BoundField DataField="Cargo" HeaderText="Cargo" />
                                        <asp:BoundField DataField="Area" HeaderText="Área" />--%>
                                        <asp:BoundField HeaderText="Fecha Registro" DataField="Fecha Registro" />
                                    </Columns>
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="White" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr align="center" id="ReporteRiesgosEventos" runat="server" visible="false">
                <td>
                    <table>
                        <tr align="left">
                            <td>
                                <asp:Button ID="Button2" runat="server" Text="Exportar" ToolTip="Exportar" Font-Names="Calibri"
                                    Font-Size="Small" OnClick="Button2_Click" />
                            </td>
                        </tr>
                        <tr align="center">
                            <td>
                                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                    ForeColor="#333333" GridLines="Vertical" ShowHeaderWhenEmpty="True" HeaderStyle-CssClass="gridViewHeader"
                                    BorderStyle="Solid" HorizontalAlign="Center" Font-Names="Calibri" Font-Size="Small"
                                    AllowPaging="True" OnPageIndexChanging="GridView3_PageIndexChanging">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <Columns>
                                        <asp:BoundField HeaderText="Codigo Evento" DataField="Código" />
                                        <asp:BoundField HeaderText="Empresa" DataField="Empresa" />
                                        <asp:BoundField HeaderText="Cadena Valor" DataField="Cadena Valor" />
                                        <asp:BoundField DataField="MacroProceso" HeaderText="MacroProceso" />
                                        <asp:BoundField DataField="Estado" HeaderText="Estado" />
                                        <asp:BoundField DataField="Proceso" HeaderText="Proceso" />
                                        <asp:BoundField DataField="SubProceso" HeaderText="SubProceso" />
                                        <asp:BoundField DataField="Actividad" HeaderText="Actividad" />
                                        <asp:BoundField DataField="Plan Acción" HeaderText="Plan Acción" />
                                        <asp:BoundField DataField="Estado Plan Acción" HeaderText="Estado Plan Acción" />
                                        <asp:BoundField DataField="Responsable Plan Acción" HeaderText="Responsable Plan Acción" />
                                        <asp:BoundField HeaderText="Fecha Registro" DataField="Fecha Registro" />
                                    </Columns>
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="White" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr align="center" id="ReporteRiesgosPlanesAccion" runat="server" visible="false">
                <td>
                    <table>
                        <tr align="left">
                            <td>
                                <asp:Button ID="Button3" runat="server" Text="Exportar" ToolTip="Exportar" Font-Names="Calibri"
                                    Font-Size="Small" OnClick="Button3_Click" />
                            </td>
                        </tr>
                        <tr align="center">
                            <td>
                                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                    ForeColor="#333333" GridLines="Vertical" ShowHeaderWhenEmpty="True" HeaderStyle-CssClass="gridViewHeader"
                                    BorderStyle="Solid" HorizontalAlign="Center" Font-Names="Calibri" Font-Size="Small"
                                    AllowPaging="True" OnPageIndexChanging="GridView4_PageIndexChanging">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <Columns>
                                        <asp:BoundField HeaderText="Área Sin Reporte" DataField="Area" />
                                        <asp:BoundField HeaderText="Fecha Inicio" DataField="FechaInicio" />
                                        <asp:BoundField HeaderText="Fecha Final" DataField="FechaFinal" />
                                    </Columns>
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="White" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
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
                    <td colspan="2" align="center" runat="server" id="tdCaption">
                        &nbsp;
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
    <Triggers>
        <asp:PostBackTrigger ControlID="Button6" />
        <asp:PostBackTrigger ControlID="Button1" />
        <asp:PostBackTrigger ControlID="Button2" />
        <asp:PostBackTrigger ControlID="Button3" />
        <asp:PostBackTrigger ControlID="DropDownList1" />
        <asp:PostBackTrigger ControlID="ImageButton1" />
    </Triggers>
</asp:UpdatePanel>
