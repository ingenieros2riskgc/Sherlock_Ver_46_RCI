﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MastersPages/Admin.Master" AutoEventWireup="true"
    CodeBehind="AudAdmReporteHallazgoVsPlanAccion.aspx.cs" Inherits="ListasSarlaft.Formularios.Auditoria.Admin.AudAdmReporteHallazgoVsPlanAccion" %>

<%@ OutputCache Location="None" %>
<%@ Register TagPrefix="CRHP" TagName="RptHallazgoVSPlan" Src="~/UserControls/MAuditoria/ReporteHallazgoVsPlanAccion.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <CRHP:RptHallazgoVSPlan ID="RptHallazgoVSPlan" runat="server" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceHolder5" runat="server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="ContentPlaceHolder6" runat="server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="ContentPlaceHolder7" runat="server">
</asp:Content>
