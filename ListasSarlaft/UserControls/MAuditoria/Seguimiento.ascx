﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Seguimiento.ascx.cs"
    Inherits="ListasSarlaft.UserControls.MAuditoria.Seguimiento" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/UserControls/Sitio/OkMessageBox.ascx" TagPrefix="uc" TagName="OkMessageBox" %>
<%@ Register Src="~/UserControls/Riesgos/ConsolidadoRiesgos.ascx" TagPrefix="CCCR"
    TagName="ConsolidadoRiesgos" %>
<style type="text/css">
    .ajax__html_editor_extender_texteditor
    {
        background-color: White;
        font-size: small;
        font-weight: lighter;
        font-family: Calibri;
        font-style: normal;
    }

    .ajax__tab_header
    {
        text-align: center;
    }

    .popup
    {
        border: Silver 1px solid;
        color: #060F40;
        background: #ffffff;
    }

    .gridViewHeader a:link
    {
        text-decoration: none;
    }

    .popup
    {
        border: Silver 1px solid;
        color: #060F40;
        background: #ffffff;
    }

    .ajax__tab_header
    {
        color: #909090;
        background-color: #EEEEEE;
    }

    .ajax__tab_xp .ajax__tab_body
    {
        background-color: #EEEEEE;
        border: 1px solid #EAEAEA;
        padding: 5px;
        list-style-type: none;
        font-size: 20px;
    }

    .ajax__tab_default .ajax__tab_inner
    {
        height: 100%;
    }

    .ajax__tab_default .ajax__tab_tab
    {
        height: 100%;
        font-size: 12px;
        background-color: #EEEEEE;
    }

    .ajax__tab_xp .ajax__tab_hover .ajax__tab_tab
    {
        height: 100%;
    }

    .ajax__tab_xp .ajax__tab_active .ajax__tab_tab
    {
        height: 100%;
    }

    .ajax__tab_xp .ajax__tab_inner
    {
        height: 100%;
    }

    .ajax__tab_xp .ajax__tab_tab
    {
        height: 100%;
    }

    .ajax__tab_xp .ajax__tab_hover .ajax__tab_inner
    {
        height: 100%;
        color: #365F91;
    }

    .ajax__tab_xp .ajax__tab_active .ajax__tab_inner
    {
        height: 100%;
        color: #365F91;
    }
</style>
<script type="text/javascript">
    function ChangeCalendarView(sender, args) {
        sender._switchMode("months", true);
    }

    function onCalendarHidden(sender) {
        //        var cal = $find("Calendar1");

        //        if (cal._monthsBody) {
        //            for (var i = 0; i < cal._monthsBody.rows.length; i++) {
        //                var row = cal._monthsBody.rows[i];
        //                for (var j = 0; j < row.cells.length; j++) {
        //                    Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call);
        //                }
        //            }
        //        }

        if (sender._monthsBody) {
            for (var i = 0; i < sender._monthsBody.rows.length; i++) {
                var row = sender._monthsBody.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call);
                }
            }
        }

    }

    function onCalendarShown(sender) {

        //        var cal = $find("Calendar1");

        //        cal._switchMode("months", true);

        //        if (cal._monthsBody) {
        //            for (var i = 0; i < cal._monthsBody.rows.length; i++) {
        //                var row = cal._monthsBody.rows[i];
        //                for (var j = 0; j < row.cells.length; j++) {
        //                    Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call);
        //                }
        //            }
        //        }

        sender._switchMode("months", true);

        if (sender._monthsBody) {
            for (var i = 0; i < sender._monthsBody.rows.length; i++) {
                var row = sender._monthsBody.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call);
                }
            }
        }

    }

    function call(sender) {
        var target = sender.target;
        switch (target.mode) {
            case "month":
                var strId = sender.target.id;
                if (strId.indexOf("Calendar1") != -1) {
                    var cal = $find("Calendar1");
                    cal._visibleDate = target.date;
                    cal.set_selectedDate(target.date);
                    ////cal._switchMonth(target.date);
                    cal._blur.post(true);
                    cal.raiseDateSelectionChanged();
                }
                else {
                    var cal2 = $find("Calendar2");
                    cal2._visibleDate = target.date;
                    cal2.set_selectedDate(target.date);
                    ////cal2._switchMonth(target.date);
                    cal2._blur.post(true);
                    cal2.raiseDateSelectionChanged();
                }
                break;
        }
    }
</script>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    DeleteCommand="DELETE FROM [Auditoria].[Hallazgo] WHERE [IdHallazgo] = @IdHallazgo"
    InsertCommand="INSERT INTO [Auditoria].[Hallazgo] ([IdAuditoria], [IdDetalleEnfoque], [IdDetalleTipoHallazgo], [IdEstado], [Hallazgo], [ComentarioAuditado], [FechaRegistro], [IdUsuario], [Seguimiento]) VALUES (@IdAuditoria, @IdDetalleEnfoque, @IdDetalleTipoHallazgo, @IdEstado, @Hallazgo, @ComentarioAuditado, @FechaRegistro, @IdUsuario, @Seguimiento)"
    SelectCommand="SELECT [IdHallazgo], [IdAuditoria], [Hallazgo].[IdDetalleEnfoque], [IdDetalleTipoHallazgo], [IdEstado], [Hallazgo], [ComentarioAuditado], CONVERT(VARCHAR(10),[Hallazgo].[FechaRegistro],120) AS FechaRegistro, [Hallazgo].[IdUsuario], [Usuarios].[Usuario], [Seguimiento]
                    FROM [Auditoria].[Hallazgo], [Listas].[Usuarios]
                    WHERE [Hallazgo].[IdAuditoria] = @IdAuditoria AND
                          [Hallazgo].[IdDetalleEnfoque] = @IdDetalleEnfoque AND
                          [Hallazgo].[IdUsuario] = [Usuarios].[IdUsuario]"
    UpdateCommand="UPDATE [Auditoria].[Hallazgo] SET [IdDetalleTipoHallazgo] = @IdDetalleTipoHallazgo, [IdEstado] = @IdEstado, [Hallazgo] = @Hallazgo, [ComentarioAuditado] = @ComentarioAuditado WHERE [IdHallazgo] = @IdHallazgo">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtCodAuditoriaSel" Name="IdAuditoria" PropertyName="Text"
            Type="Int64" />
        <asp:ControlParameter ControlID="txtCodLiteralSel" Name="IdDetalleEnfoque" PropertyName="Text"
            Type="Int64" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="IdHallazgo" Type="Int64" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="IdAuditoria" Type="Int64" />
        <asp:Parameter Name="IdDetalleEnfoque" Type="Int64" />
        <asp:Parameter Name="IdDetalleTipoHallazgo" Type="Int64" />
        <asp:Parameter Name="IdEstado" Type="Int64" />
        <asp:Parameter Name="Hallazgo" Type="String" />
        <asp:Parameter Name="ComentarioAuditado" Type="String" />
        <asp:Parameter Name="FechaRegistro" Type="DateTime" />
        <asp:Parameter Name="IdUsuario" Type="Decimal" />
        <asp:Parameter Name="Seguimiento" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="IdDetalleTipoHallazgo" Type="Int64" />
        <asp:Parameter Name="IdEstado" Type="Int64" />
        <asp:Parameter Name="Hallazgo" Type="String" />
        <asp:Parameter Name="ComentarioAuditado" Type="String" />
        <asp:Parameter Name="IdHallazgo" Type="Int64" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdProceso], [Nombre] FROM [Procesos].[Proceso] WHERE [IdMacroProceso] = @IdMacroProceso">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlMacroProcesoRie" Name="IdMacroProceso" PropertyName="SelectedValue"
            Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdDetalleTipo], [NombreDetalle] FROM [Parametrizacion].[DetalleTipos] WHERE [IdTipo] = 7 ORDER BY NombreDetalle"></asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdDetalleTipo], [NombreDetalle] FROM [Parametrizacion].[DetalleTipos] WHERE [IdTipo] = 6 ORDER BY NombreDetalle"></asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdDetalleTipo], [NombreDetalle] FROM [Parametrizacion].[DetalleTipos] WHERE [IdTipo] = 5 ORDER BY NombreDetalle"></asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdDetalleTipo], [NombreDetalle] FROM [Parametrizacion].[DetalleTipos] WHERE [IdTipo] = 8 ORDER BY NombreDetalle"></asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdDetalleTipo], [NombreDetalle] FROM [Parametrizacion].[DetalleTipos] WHERE [IdTipo] = 9 ORDER BY NombreDetalle"></asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdPlaneacion], [Nombre] FROM [Auditoria].[Planeacion]"></asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource9" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    UpdateCommand="UPDATE [Auditoria].[Auditoria] SET [Metodologia] = @Metodologia WHERE [IdAuditoria] = @IdAuditoria">
    <UpdateParameters>
        <asp:Parameter Name="IdAuditoria" Type="Int64" />
        <asp:Parameter Name="Metodologia" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource10" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdMacroProceso], [Nombre] FROM [Procesos].[Macroproceso]"></asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource11" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdProceso], [Nombre] FROM [Procesos].[Proceso] WHERE [IdMacroProceso] = @IdMacroProceso">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlMacroProceso" Name="IdMacroProceso" PropertyName="SelectedValue"
            Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource18" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdAuditoria], [Tema], [Metodologia] 
                   FROM [Auditoria].[Auditoria] 
                   WHERE ([IdPlaneacion] = @IdPlaneacion AND [Estado] = 'SEGUIMIENTO')">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtCodPlaneacion" Name="IdPlaneacion" PropertyName="Text"
            Type="Int64" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource19" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [AuditoriaObjetivo].[IdObjetivo], [Objetivo].Nombre
                   FROM [Auditoria].[AuditoriaObjetivo], [Auditoria].[Objetivo]
                   WHERE ([IdAuditoria] = @IdAuditoria) AND
                   [AuditoriaObjetivo].IdObjetivo = [Objetivo].IdObjetivo">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtCodAuditoriaSel" Name="IdAuditoria" PropertyName="Text"
            Type="Int64" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource20" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [Enfoque].[IdEnfoque], [Enfoque].Descripcion 
                   FROM [Auditoria].[AudObjEnfoque], [Auditoria].[Enfoque] 
                   WHERE (([AudObjEnfoque].[IdAuditoria] = @IdAuditoria) AND ([AudObjEnfoque].[IdObjetivo] = @IdObjetivo)
                   AND [Enfoque].[IdEnfoque] = [AudObjEnfoque].[IdEnfoque]
                   AND [Enfoque].[IdObjetivo] = [AudObjEnfoque].[IdObjetivo])">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtCodAuditoriaSel" Name="IdAuditoria" PropertyName="Text"
            Type="Int64" />
        <asp:ControlParameter ControlID="txtCodObjetivoSel" Name="IdObjetivo" PropertyName="Text"
            Type="Int64" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource21" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdDetalleEnfoque], [Descripcion] FROM [Auditoria].[DetalleEnfoque] WHERE ([IdEnfoque] = @IdEnfoque)">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtCodEnfoqueSel" Name="IdEnfoque" PropertyName="Text"
            Type="Int64" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource22" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdRecomendacion], [Numero], [IdHallazgo], [Tipo], [IdDependenciaAuditada], J1.[NombreHijo] AS NombreDP, [IdDependenciaRespuesta], J2.[NombreHijo] AS NombreDepRes, [IdSubproceso], R.[Estado], CONVERT(VARCHAR(MAX), [Observacion]) AS Observacion, CONVERT(VARCHAR(10),R.[FechaRegistro],120) AS FechaRegistro, R.[IdUsuario], U.Usuario, [Seguimiento]
                   FROM   Listas.Usuarios AS U, [Auditoria].[Recomendacion] AS R
                   LEFT JOIN Parametrizacion.[JerarquiaOrganizacional] AS J1 ON R.[IdDependenciaAuditada] = J1.IdHijo
                   LEFT JOIN Parametrizacion.[JerarquiaOrganizacional] AS J2 ON R.[IdDependenciaRespuesta] = J2.IdHijo   
                   WHERE             
					R.IdUsuario = U.IdUsuario AND
					R.Tipo = 'Dependencia' AND
                    R.IdHallazgo = @IdHallazgo
UNION
SELECT [IdRecomendacion], [Numero], [IdHallazgo], [Tipo], [IdDependenciaAuditada], P.[Nombre] AS NombreDP, [IdDependenciaRespuesta], J3.[NombreHijo] AS NombreDepRes, [IdSubproceso], R.[Estado], CONVERT(VARCHAR(MAX), [Observacion])  AS Observacion, CONVERT(VARCHAR(10),R.[FechaRegistro],120) AS FechaRegistro, R.[IdUsuario],U.Usuario, [Seguimiento]
                   FROM   [Procesos].Proceso AS P, [Listas].Usuarios AS U, [Auditoria].[Recomendacion] AS R
                   LEFT JOIN Parametrizacion.[JerarquiaOrganizacional] AS J3 ON R.[IdDependenciaRespuesta] = J3.IdHijo   
                   WHERE             
					R.IdUsuario = U.IdUsuario AND
					R.IdSubproceso = P.IdProceso AND
					R.Tipo = 'Procesos' AND
                    R.IdHallazgo = @IdHallazgo"
    DeleteCommand="DELETE FROM [Auditoria].[Recomendacion] WHERE [IdRecomendacion] = @IdRecomendacion"
    InsertCommand="INSERT INTO [Auditoria].[Recomendacion] ([Numero], [IdHallazgo], [Tipo], [IdDependenciaAuditada], [IdDependenciaRespuesta], [IdSubproceso], [Estado], [Observacion], [FechaRegistro], [IdUsuario], [Seguimiento]) VALUES (@Numero, @IdHallazgo, @Tipo, @IdDependenciaAuditada, @IdDependenciaRespuesta, @IdSubproceso, @Estado, @Observacion, @FechaRegistro, @IdUsuario, @Seguimiento)"
    UpdateCommand="UPDATE [Auditoria].[Recomendacion] SET [Tipo] = @Tipo, [IdDependenciaAuditada] = @IdDependenciaAuditada, [IdDependenciaRespuesta] = @IdDependenciaRespuesta, [IdSubproceso] = @IdSubproceso, [Observacion] = @Observacion WHERE [IdRecomendacion] = @IdRecomendacion">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtCodHallazgoGen" Name="IdHallazgo" PropertyName="Text"
            Type="Int64" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="IdRecomendacion" Type="Int64" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Numero" Type="Int32" />
        <asp:Parameter Name="IdHallazgo" Type="Int64" />
        <asp:Parameter Name="Tipo" Type="String" />
        <asp:Parameter Name="IdDependenciaAuditada" Type="Int64" />
        <asp:Parameter Name="IdDependenciaRespuesta" Type="Int64" />
        <asp:Parameter Name="IdSubproceso" Type="Int64" />
        <asp:Parameter Name="Estado" Type="String" />
        <asp:Parameter Name="Observacion" Type="String" />
        <asp:Parameter Name="FechaRegistro" Type="DateTime" />
        <asp:Parameter Name="IdUsuario" Type="Decimal" />
        <asp:Parameter Name="Seguimiento" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="Tipo" Type="String" />
        <asp:Parameter Name="IdDependenciaAuditada" Type="Int64" />
        <asp:Parameter Name="IdDependenciaRespuesta" Type="Int64" />
        <asp:Parameter Name="IdSubproceso" Type="Int64" />
        <asp:Parameter Name="Observacion" Type="String" />
        <asp:Parameter Name="IdRecomendacion" Type="Int64" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource23" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdRiesgo], [NumeroRiesgo], R.[Nombre], [IdDetalleTipoRiesgo], DT.NombreDetalle as NombreTipoRiesgo, [Tipo], [IdDependencia], [IdSubproceso],  J1.NombreHijo AS NombreDP, R.[Estado], CONVERT(VARCHAR(MAX), [Observacion]) AS Observacion, [IdDetalleTipoProbabilidad], [IdDetalleTipoImpacto], CONVERT(VARCHAR(10), R.[FechaRegistro],120) AS FechaRegistro, R.[IdUsuario], [Usuario], [Seguimiento]
                    FROM   [Auditoria].[Riesgo] AS R, [Auditoria].[Estandar], [Listas].[Usuarios] AS U, [Parametrizacion].[JerarquiaOrganizacional] AS J1, Parametrizacion.DetalleTipos as DT
                    WHERE  R.IdUsuario = U.IdUsuario AND
	                       R.IdDependencia = J1.IdHijo AND
	                       R.Tipo = 'Dependencia' AND
	                       R.IdDetalleTipoRiesgo = DT.IdDetalleTipo AND
                           R.IdHallazgo = @IdHallazgo
                    UNION
    			   SELECT [IdRiesgo], [NumeroRiesgo], R.[Nombre], [IdDetalleTipoRiesgo], DT.NombreDetalle as NombreTipoRiesgo, [Tipo], [IdDependencia], [IdSubproceso],  P.Nombre AS NombreDP, R.[Estado], CONVERT(VARCHAR(MAX), [Observacion]) AS Observacion, [IdDetalleTipoProbabilidad], [IdDetalleTipoImpacto], CONVERT(VARCHAR(10), R.[FechaRegistro],120) AS FechaRegistro, R.[IdUsuario], [Usuario], [Seguimiento]
				   FROM Parametrizacion.DetalleTipos as DT, [Procesos].Proceso AS P, [Listas].Usuarios AS U, [Auditoria].[Riesgo] AS R
                   LEFT JOIN Parametrizacion.[JerarquiaOrganizacional] AS J2 ON R.[IdDependencia] = J2.IdHijo   
                   WHERE             
					R.IdUsuario = U.IdUsuario AND
					R.IdSubproceso = P.IdProceso AND
	                R.IdDetalleTipoRiesgo = DT.IdDetalleTipo AND					
					R.Tipo = 'Procesos' AND
                    R.IdHallazgo = @IdHallazgo"
    DeleteCommand="DELETE FROM [Auditoria].[Riesgo] WHERE [IdRiesgo] = @IdRiesgo"
    InsertCommand="INSERT INTO [Auditoria].[Riesgo] ([NumeroRiesgo], [IdHallazgo], [Nombre], [IdDetalleTipoRiesgo], [Tipo], [IdDependencia], [IdSubproceso], [Estado], [Observacion], [IdDetalleTipoProbabilidad], [IdDetalleTipoImpacto], [FechaRegistro], [IdUsuario], [Seguimiento]) VALUES (@NumeroRiesgo, @IdHallazgo, @Nombre, @IdDetalleTipoRiesgo, @Tipo, @IdDependencia, @IdSubproceso, @Estado, @Observacion, @IdDetalleTipoProbabilidad, @IdDetalleTipoImpacto, @FechaRegistro, @IdUsuario, @Seguimiento)"
    UpdateCommand="UPDATE [Auditoria].[Riesgo] SET [Nombre] = @Nombre, [IdDetalleTipoRiesgo] = @IdDetalleTipoRiesgo, [Tipo] = @Tipo, [IdDependencia] = @IdDependencia, [IdSubproceso] = @IdSubproceso, [Observacion] = @Observacion, [IdDetalleTipoProbabilidad] = @IdDetalleTipoProbabilidad, [IdDetalleTipoImpacto] = @IdDetalleTipoImpacto WHERE [IdRiesgo] = @IdRiesgo">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtCodHallazgoGen" Name="IdHallazgo" PropertyName="Text"
            Type="Int64" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="IdRiesgo" Type="Int64" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="NumeroRiesgo" Type="Int32" />
        <asp:Parameter Name="IdHallazgo" Type="Int64" />
        <asp:Parameter Name="Nombre" Type="String" />
        <asp:Parameter Name="IdDetalleTipoRiesgo" Type="Int64" />
        <asp:Parameter Name="Tipo" Type="String" />
        <asp:Parameter Name="IdDependencia" Type="Int64" />
        <asp:Parameter Name="IdSubproceso" Type="Int64" />
        <asp:Parameter Name="Estado" Type="String" />
        <asp:Parameter Name="Observacion" Type="String" />
        <asp:Parameter Name="IdDetalleTipoProbabilidad" Type="Int64" />
        <asp:Parameter Name="IdDetalleTipoImpacto" Type="Int64" />
        <asp:Parameter Name="FechaRegistro" Type="DateTime" />
        <asp:Parameter Name="IdUsuario" Type="Decimal" />
        <asp:Parameter Name="Seguimiento" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="Nombre" Type="String" />
        <asp:Parameter Name="IdDetalleTipoRiesgo" Type="Int64" />
        <asp:Parameter Name="Tipo" Type="String" />
        <asp:Parameter Name="IdDependencia" Type="Int64" />
        <asp:Parameter Name="IdSubproceso" Type="Int64" />
        <asp:Parameter Name="Observacion" Type="String" />
        <asp:Parameter Name="IdDetalleTipoProbabilidad" Type="Int64" />
        <asp:Parameter Name="IdDetalleTipoImpacto" Type="Int64" />
        <asp:Parameter Name="IdRiesgo" Type="Int64" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource24" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    DeleteCommand="DELETE FROM [Auditoria].[Auditoria] WHERE [IdAuditoria] = @IdAuditoria"
    InsertCommand="INSERT INTO [Auditoria].[Auditoria] ([Estado]) VALUES (@Estado)"
    SelectCommand="SELECT [Estado], [IdAuditoria] FROM [Auditoria].[Auditoria]" UpdateCommand="UPDATE [Auditoria].[Auditoria] SET [Estado] = @Estado WHERE [IdAuditoria] = @IdAuditoria">
    <DeleteParameters>
        <asp:Parameter Name="IdAuditoria" Type="Int64" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Estado" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="Estado" Type="String" />
        <asp:Parameter Name="IdAuditoria" Type="Int64" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource25" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdPlanAccion], [EstadoAuditado], [IdForanea], [Descripcion], CONVERT(VARCHAR(10), [FechaCompromiso],120) AS FechaCompromiso, CONVERT(VARCHAR(10), [FechaRegistro],120) AS FechaRegistro, [PlanAccion].[IdUsuario], [TipoForanea],[EstadoAuditor], CONVERT(VARCHAR(10), [FechaCierreAuditado],120) AS FechaCierreAuditado, CONVERT(VARCHAR(10), [FechaCierreAuditor],120) AS FechaCierreAuditor, [Usuario]
                   FROM   [Auditoria].[PlanAccion], [Listas].[Usuarios] AS LU
                   WHERE  [IdForanea] = @IdForanea AND
                          [TipoForanea] = @TipoForanea AND
                          [PlanAccion].[IdUsuario] = LU.[IdUsuario]">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtCodForaneaGen" Name="IdForanea" PropertyName="Text"
            Type="Int64" />
        <asp:ControlParameter ControlID="txtTipoForanea" Name="TipoForanea" PropertyName="Text"
            Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource26" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="SELECT [IdPlanAccionAvance], [IdPlanAccion], [Avance], FechaRegistro, PAA.[IdUsuario], LU.Usuario
                   FROM [Auditoria].[PlanAccionAvance] AS PAA, [Listas].[Usuarios] AS LU
                   WHERE PAA.IdUsuario = LU.[IdUsuario] AND
                         PAA.IdPlanAccion = @IdPlanAccion">
    <SelectParameters>
        <asp:ControlParameter ControlID="lblIdPlanAccion" Name="IdPlanAccion" PropertyName="Text"
            Type="Int64" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource100" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    DeleteCommand="DELETE FROM [Auditoria].[Archivo] WHERE [IdArchivo] = @IdArchivo"
    InsertCommand="INSERT INTO [Auditoria].[Archivo] ([UrlArchivo], [Descripcion], [FechaRegistro], [IdUsuario], [IdRegistro], [IdControlUsuario]) 
                   VALUES (@UrlArchivo, @Descripcion, @FechaRegistro, @IdUsuario, @IdRegistro, @IdControlUsuario)"
    SelectCommand="SELECT A.[IdArchivo], A.[UrlArchivo], A.[Descripcion], CONVERT(VARCHAR(10), A.[FechaRegistro],120) AS FechaRegistro, A.[IdUsuario], LU.[Usuario] 
                   FROM   [Auditoria].[Archivo] AS A, [Listas].[Usuarios] AS LU 
                   WHERE  ((A.[IdControlUsuario] = @IdControlUsuario OR A.[IdControlUsuario] = @IdControlUsuario2) AND A.[IdRegistro] = @IdRegistro AND A.IdUsuario = LU.[IdUsuario])"
    UpdateCommand="UPDATE [Auditoria].[Archivo] SET [UrlArchivo] = @UrlArchivo, [Descripcion] = @Descripcion, [FechaRegistro] = @FechaRegistro, [IdUsuario] = @IdUsuario WHERE [IdArchivo] = @IdArchivo">
    <DeleteParameters>
        <asp:Parameter Name="IdArchivo" Type="Decimal" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="UrlArchivo" Type="String" />
        <asp:Parameter Name="Descripcion" Type="String" />
        <asp:Parameter Name="FechaRegistro" Type="DateTime" />
        <asp:Parameter Name="IdUsuario" Type="Decimal" />
        <asp:Parameter Name="IdRegistro" Type="Decimal" />
        <asp:Parameter Name="IdControlUsuario" Type="Decimal" />
    </InsertParameters>
    <SelectParameters>
        <asp:Parameter DefaultValue="9" Name="IdControlUsuario" Type="Decimal" />
        <asp:Parameter DefaultValue="10" Name="IdControlUsuario2" Type="Decimal" />
        <asp:ControlParameter ControlID="lblIdHallazgo" Name="IdRegistro" PropertyName="Text"
            Type="Int64" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="UrlArchivo" Type="String" />
        <asp:Parameter Name="Descripcion" Type="String" />
        <asp:Parameter Name="FechaRegistro" Type="DateTime" />
        <asp:Parameter Name="IdUsuario" Type="Decimal" />
        <asp:Parameter Name="IdArchivo" Type="Decimal" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource101" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    SelectCommand="Select IDENT_CURRENT('Auditoria.Archivo')+1 AS Maximo"></asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceSeguimiento" runat="server" ConnectionString="<%$ ConnectionStrings:SarlaftConnectionString %>"
    InsertCommand="INSERT INTO [Auditoria].[AuditoriaSeguimiento] ([IdAuditoria], [Seguimiento], [FechaSeguimiento], [IdUsuario]) VALUES (@IdAuditoria, @Seguimiento, @FechaSeguimiento, @IdUsuario)"
    SelectCommand="SELECT A.IdAuditoriaSeguimiento, A.IdAuditoria, A.Seguimiento, CONVERT (varchar(10), A.FechaSeguimiento, 120) AS FechaSeguimiento, U.Usuario FROM Auditoria.AuditoriaSeguimiento AS A INNER JOIN Listas.Usuarios AS U ON A.IdUsuario = U.IdUsuario WHERE (A.IdAuditoria = @IdAuditoria)"
    UpdateCommand="UPDATE [Auditoria].[AuditoriaSeguimiento] SET [Seguimiento] = @Seguimiento, [FechaSeguimiento] = @FechaSeguimiento, [IdUsuario] = @IdUsuario WHERE [IdAuditoriaSeguimiento] = @IdAuditoriaSeguimiento ">
    <InsertParameters>
        <asp:Parameter Name="IdAuditoria" Type="Int32" />
        <asp:Parameter Name="Seguimiento" Type="String" />
        <asp:Parameter Name="FechaSeguimiento" Type="DateTime" />
        <asp:Parameter Name="IdUsuario" Type="Int32" />
    </InsertParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="txtCodAuditoriaSel" Name="IdAuditoria" PropertyName="Text" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="Seguimiento" Type="String" />
        <asp:Parameter Name="FechaSeguimiento" Type="DateTime" />
        <asp:Parameter Name="IdUsuario" Type="Int32" />
        <asp:Parameter Name="IdAuditoriaSeguimiento" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <uc:OkMessageBox ID="omb" runat="server" />
        <asp:Panel ID="pnlMsgBox" runat="server" Width="400px" CssClass="modalPopup" Style="display: none;">
            <table width="100%">
                <tr class="topHandle">
                    <td colspan="2" align="center" runat="server" id="tdCaption">
                        <asp:Label ID="lblCaption" runat="server" Text="Atención" Font-Bold="False" Font-Names="Tahoma"
                            Font-Size="11px"></asp:Label><br />
                    </td>
                </tr>
                <tr>
                    <td style="width: 60px" valign="middle" align="center">
                        <asp:Image ID="imgInfo" runat="server" ImageUrl="~/Imagenes/Icons/icontexto-webdev-about.png" />
                    </td>
                    <td valign="middle" align="left">
                        <asp:Label ID="lblMsgBox" runat="server" Font-Bold="False" Font-Names="Tahoma" Font-Size="11px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2">
                        <asp:Button ID="btnImgokEliminar" runat="server" Text="Ok" OnClick="btnImgokEliminar_Click" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" OnClientClick="$find('mypopup').hide(); return false;" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:ModalPopupExtender ID="mpeMsgBox" runat="server" PopupControlID="pnlMsgBox"
            BehaviorID="mypopup" Enabled="True" TargetControlID="btndummy" BackgroundCssClass="modalBackground"
            DropShadow="true">
        </asp:ModalPopupExtender>
        <asp:Button ID="btndummy" runat="server" Text="Button" Style="display: none" />
        <asp:Label ID="lblOk" runat="server" Text="Label" Visible="False"></asp:Label>
        <asp:Label ID="lblCancelar" runat="server" Text="Label" Visible="False"></asp:Label>
        <asp:Label ID="lblIdHallazgo" runat="server" Text="Label" Visible="False"></asp:Label>
        <asp:Label ID="lblAccion" runat="server" Text="Label" Visible="False"></asp:Label>
        <div id="TreeDIV" runat="server">
            <asp:Panel ID="pnlDependenciaRec" runat="server" CssClass="popup" Width="400px" Style="display: none">
                <table width="100%" class="tablaSinBordes">
                    <tr align="right" bgcolor="#5D7B9D">
                        <td>
                            <asp:ImageButton ID="ImageButton7" runat="server" ImageUrl="~/Imagenes/Icons/dialog-close2.png"
                                OnClientClick="$find('popupDepRec').hidePopup(); return false;" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TreeView ID="TreeView1" ExpandDepth="3" runat="server" Font-Names="Calibri"
                                Style="overflow: auto" Font-Size="Small" LineImagesFolder="~/TreeLineImages"
                                ForeColor="Black" ShowLines="True" Target="_self" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged"
                                Font-Bold="False" Height="400px">
                                <SelectedNodeStyle BackColor="Silver" BorderColor="#66CCFF" BorderStyle="Inset" />
                            </asp:TreeView>
                        </td>
                    </tr>
                    <tr align="center">
                        <td>
                            <asp:Button ID="BtnOk" runat="server" Text="Aceptar" CssClass="Apariencia" OnClientClick="$find('popupDepRec').hidePopup(); return false;" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:TextBox ID="txtCodAuditoriaGen" runat="server" Visible="False">0</asp:TextBox>
            <asp:TextBox runat="server" ID="txtCodObjetivo" Visible="False"></asp:TextBox>
            <asp:TextBox runat="server" ID="txtMetodologiaGen" Visible="False"></asp:TextBox>
            <asp:Label ID="lblTipoUA" runat="server" Text="Label" Visible="False"></asp:Label>
        </div>
        <asp:Panel ID="pnlDependenciaRec2" runat="server" CssClass="popup" Width="400px"
            Style="display: none">
            <table width="100%" class="tablaSinBordes">
                <tr align="right" bgcolor="#5D7B9D">
                    <td>
                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Imagenes/Icons/dialog-close2.png"
                            OnClientClick="$find('popupDepRec2').hidePopup(); return false;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TreeView ID="TreeView2" ExpandDepth="3" runat="server" Font-Names="Calibri"
                            Style="overflow: auto" Font-Size="Small" LineImagesFolder="~/TreeLineImages"
                            ForeColor="Black" ShowLines="True" Target="_self" OnSelectedNodeChanged="TreeView2_SelectedNodeChanged"
                            Font-Bold="False" Height="400px">
                            <SelectedNodeStyle BackColor="Silver" BorderColor="#66CCFF" BorderStyle="Inset" />
                        </asp:TreeView>
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:Button ID="Button2" runat="server" Text="Aceptar" CssClass="Apariencia" OnClientClick="$find('popupDepRec2').hidePopup(); return false;" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlDependenciaRie" runat="server" CssClass="popup" Width="400px" Style="display: none">
            <table width="100%" class="tablaSinBordes">
                <tr align="right" bgcolor="#5D7B9D">
                    <td>
                        <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/Imagenes/Icons/dialog-close2.png"
                            OnClientClick="$find('popupDepRie').hidePopup(); return false;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TreeView ID="TreeView3" ExpandDepth="3" runat="server" Font-Names="Calibri"
                            Style="overflow: auto" Font-Size="Small" LineImagesFolder="~/TreeLineImages"
                            ForeColor="Black" ShowLines="True" Target="_self" OnSelectedNodeChanged="TreeView3_SelectedNodeChanged"
                            Font-Bold="False" Height="400px">
                            <SelectedNodeStyle BackColor="Silver" BorderColor="#66CCFF" BorderStyle="Inset" />
                        </asp:TreeView>
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:Button ID="Button8" runat="server" Text="Aceptar" CssClass="Apariencia" OnClientClick="$find('popupDepRie').hidePopup(); return false;" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlImpacto" runat="server" CssClass="popup" Width="400px" Style="display: none">
            <table width="100%" class="tablaSinBordes">
                <tr align="right" bgcolor="#5D7B9D">
                    <td>
                        <asp:ImageButton ID="btnClosepp1" runat="server" ImageUrl="~/Imagenes/Icons/dialog-close2.png"
                            OnClientClick="$find('popup').hidePopup(); return false;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" align="left" border="1" cellspacing="0" cellpadding="2" bordercolor="White">
                            <tr>
                                <td>
                                    <asp:Label ID="Label60" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Poco Probable:"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label61" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Es remoto y poco probable de que suceda."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label62" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Eventual:"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label63" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Esta sujeto a la conjución de circunstancias."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label64" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Probable:"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label65" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Puede ocurrir en algún momento."></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlProbabilidad" runat="server" CssClass="popup" Width="400px" Style="display: none">
            <table width="100%" class="tablaSinBordes">
                <tr align="right" bgcolor="#5D7B9D">
                    <td>
                        <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/Imagenes/Icons/dialog-close2.png"
                            OnClientClick="$find('popup1').hidePopup(); return false;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <table align="left" border="1" cellspacing="0" cellpadding="2" bordercolor="White">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label56" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Insignificante:"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label57" runat="server" Font-Names="Calibri" Font-Size="Small" Text="De poca importancia, no repercute negativamente en el Good Will de la empresa y puede acompañarse de perdidas financieras mínimas."></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label58" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Mínimo:"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label59" runat="server" Font-Names="Calibri" Font-Size="Small" Text="De poca importancia, con leve impacto y puede acompañarse de perdidas financieras bajas."></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <br />
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlPlaneacion" runat="server" CssClass="popup" Width="400px" Style="display: none">
            <table width="100%" class="tablaSinBordes">
                <tr align="right" bgcolor="#5D7B9D">
                    <td>
                        <asp:ImageButton ID="ImageButton8" runat="server" ImageUrl="~/Imagenes/Icons/dialog-close2.png"
                            OnClientClick="$find('popupPlaneacion').hidePopup(); return false;" />
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <table>
                            <tr align="center">
                                <td>
                                    <asp:GridView ID="GridView8" runat="server" DataSourceID="SqlDataSource8" Font-Names="Calibri"
                                        Font-Size="Small" HeaderStyle-CssClass="gridViewHeader" AutoGenerateColumns="False"
                                        BorderStyle="Solid" DataKeyNames="IdPlaneacion" AllowPaging="True" AllowSorting="True"
                                        ShowHeaderWhenEmpty="True" ForeColor="#333333" Font-Bold="False" GridLines="Vertical"
                                        CellPadding="4" OnSelectedIndexChanged="GridView8_SelectedIndexChanged">
                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                        <Columns>
                                            <asp:BoundField DataField="IdPlaneacion" HeaderText="Código" InsertVisible="False"
                                                ReadOnly="True" SortExpression="IdPlaneacion">
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" HtmlEncode="False"
                                                HtmlEncodeFormatString="False">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:CommandField ButtonType="Image" HeaderText="Acción" SelectImageUrl="~/Imagenes/Icons/Audit.png"
                                                ShowSelectButton="True">
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:CommandField>
                                        </Columns>
                                        <EditRowStyle BackColor="#999999" />
                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#5D7B9D" CssClass="gridViewHeader" ForeColor="White" Font-Bold="True" />
                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <asp:Button ID="Button1" runat="server" Text="Aceptar" CssClass="Apariencia" OnClientClick="$find('popupPlaneacion').hidePopup(); return false;" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlAuditoria" runat="server" CssClass="popup" Width="400px">
            <table width="100%" class="tablaSinBordes">
                <tr align="right" bgcolor="#5D7B9D">
                    <td>
                        <asp:ImageButton ID="ImageButton12" runat="server" ImageUrl="~/Imagenes/Icons/dialog-close2.png"
                            OnClientClick="$find('popupAuditoria').hidePopup(); return false;" />
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:GridView ID="GridView6" runat="server" DataSourceID="SqlDataSource18" Font-Names="Calibri"
                            Font-Size="Small" HeaderStyle-CssClass="gridViewHeader" AutoGenerateColumns="False"
                            BorderStyle="Solid" DataKeyNames="Metodologia" AllowPaging="True" AllowSorting="True"
                            ShowHeaderWhenEmpty="True" ForeColor="#333333" Font-Bold="False" GridLines="Vertical"
                            CellPadding="4" OnSelectedIndexChanged="GridView6_SelectedIndexChanged">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="IdAuditoria" HeaderText="Código" InsertVisible="False"
                                    ReadOnly="True" SortExpression="IdAuditoria">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Tema" HeaderText="Tema" SortExpression="Tema" HtmlEncode="False"
                                    HtmlEncodeFormatString="False">
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Metodologia" HeaderText="Metodologia" SortExpression="Metodologia"
                                    Visible="false" />
                                <asp:CommandField ButtonType="Image" HeaderText="Acción" SelectImageUrl="~/Imagenes/Icons/audit.png"
                                    ShowSelectButton="True">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:CommandField>
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" CssClass="gridViewHeader" ForeColor="White" Font-Bold="True" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:Button ID="Button4" runat="server" Text="Aceptar" CssClass="Apariencia" OnClientClick="$find('popupAuditoria').hidePopup(); return false;" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlObjetivo" runat="server" CssClass="popup" Width="400px" Style="display: none">
            <table width="100%" class="tablaSinBordes">
                <tr align="right" bgcolor="#5D7B9D">
                    <td>
                        <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/Imagenes/Icons/dialog-close2.png"
                            OnClientClick="$find('popupObjetivo').hidePopup(); return false;" />
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:GridView ID="GridView7" runat="server" DataSourceID="SqlDataSource19" Font-Names="Calibri"
                            Font-Size="Small" HeaderStyle-CssClass="gridViewHeader" AutoGenerateColumns="False"
                            BorderStyle="Solid" DataKeyNames="IdObjetivo" AllowPaging="True" AllowSorting="True"
                            ShowHeaderWhenEmpty="True" ForeColor="#333333" Font-Bold="False" GridLines="Vertical"
                            CellPadding="4" OnSelectedIndexChanged="GridView7_SelectedIndexChanged">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="IdObjetivo" HeaderText="Código" InsertVisible="False"
                                    ReadOnly="True" SortExpression="IdObjetivo">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" HtmlEncode="False"
                                    HtmlEncodeFormatString="False">
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:CommandField ButtonType="Image" HeaderText="Acción" SelectImageUrl="~/Imagenes/Icons/audit.png"
                                    ShowSelectButton="True">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:CommandField>
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" CssClass="gridViewHeader" ForeColor="White" Font-Bold="True" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:Button ID="Button5" runat="server" Text="Aceptar" CssClass="Apariencia" OnClientClick="$find('popupObjetivo').hidePopup(); return false;" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlEnfoque" runat="server" CssClass="popup" Style="display: none">
            <table width="100%" class="tablaSinBordes">
                <tr align="right" bgcolor="#5D7B9D">
                    <td>
                        <asp:ImageButton ID="ImageButton6" runat="server" ImageUrl="~/Imagenes/Icons/dialog-close2.png"
                            OnClientClick="$find('popupEnfoque').hidePopup(); return false;" />
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:GridView ID="GridView9" runat="server" DataSourceID="SqlDataSource20" Font-Names="Calibri"
                            Font-Size="Small" HeaderStyle-CssClass="gridViewHeader" AutoGenerateColumns="False"
                            BorderStyle="Solid" DataKeyNames="IdEnfoque" AllowPaging="True" AllowSorting="True"
                            ShowHeaderWhenEmpty="True" ForeColor="#333333" Font-Bold="False" GridLines="Vertical"
                            CellPadding="4" OnSelectedIndexChanged="GridView9_SelectedIndexChanged">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="IdEnfoque" HeaderText="Código" InsertVisible="False" ReadOnly="True"
                                    SortExpression="IdEnfoque">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" SortExpression="Descripcion"
                                    HtmlEncode="False" HtmlEncodeFormatString="False">
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:CommandField ButtonType="Image" HeaderText="Acción" SelectImageUrl="~/Imagenes/Icons/audit.png"
                                    ShowSelectButton="True">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:CommandField>
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" CssClass="gridViewHeader" ForeColor="White" Font-Bold="True" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:Button ID="Button6" runat="server" Text="Aceptar" CssClass="Apariencia" OnClientClick="$find('popupEnfoque').hidePopup(); return false;" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlLiteral" runat="server" CssClass="popup" Style="display: none"
            Width="600px">
            <table width="100%" class="tablaSinBordes">
                <tr align="right" bgcolor="#5D7B9D">
                    <td>
                        <asp:ImageButton ID="ImageButton10" runat="server" ImageUrl="~/Imagenes/Icons/dialog-close2.png"
                            OnClientClick="$find('popupLiteral').hidePopup(); return false;" />
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:GridView ID="GridView10" runat="server" DataSourceID="SqlDataSource21" Font-Names="Calibri"
                            Font-Size="Small" HeaderStyle-CssClass="gridViewHeader" AutoGenerateColumns="False"
                            BorderStyle="Solid" DataKeyNames="IdDetalleEnfoque" AllowPaging="True" AllowSorting="True"
                            ShowHeaderWhenEmpty="True" ForeColor="#333333" Font-Bold="False" GridLines="Vertical"
                            CellPadding="4" OnSelectedIndexChanged="GridView10_SelectedIndexChanged" PageSize="3">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="IdDetalleEnfoque" HeaderText="Código" InsertVisible="False"
                                    ReadOnly="True" SortExpression="IdDetalleEnfoque">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" SortExpression="Descripcion"
                                    HtmlEncode="False" HtmlEncodeFormatString="False">
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:CommandField ButtonType="Image" HeaderText="Acción" SelectImageUrl="~/Imagenes/Icons/audit.png"
                                    ShowSelectButton="True">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:CommandField>
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" CssClass="gridViewHeader" ForeColor="White" Font-Bold="True" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:Button ID="Button7" runat="server" Text="Aceptar" CssClass="Apariencia" OnClientClick="$find('popupLiteral').hidePopup(); return false;" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlProcesoRec" runat="server" CssClass="popup" Width="350px" Style="display: none">
            <table width="100%" class="tablaSinBordes">
                <tr align="right" bgcolor="#5D7B9D">
                    <td colspan="2">
                        <asp:ImageButton ID="ImageButton9" runat="server" ImageUrl="~/Imagenes/Icons/dialog-close2.png"
                            OnClientClick="$find('popupProcesoRec').hidePopup(); return false;" />
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#BBBBBB">
                        <asp:Label ID="Label7" runat="server" Text="Macroproceso:" CssClass="Apariencia"></asp:Label>
                    </td>
                    <td align="center" bgcolor="#EEEEEE">
                        <asp:DropDownList ID="ddlMacroProceso" runat="server" Width="250px" CssClass="Apariencia"
                            OnDataBound="ddlMacroProceso_DataBound" DataSourceID="SqlDataSource10" DataTextField="Nombre"
                            DataValueField="IdMacroProceso" AutoPostBack="True" OnSelectedIndexChanged="ddlMacroProceso_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#BBBBBB">
                        <asp:Label ID="Label25" runat="server" Text="Proceso:" CssClass="Apariencia"></asp:Label>
                    </td>
                    <td align="center" bgcolor="#EEEEEE">
                        <asp:DropDownList ID="ddlProceso" runat="server" Width="250px" CssClass="Apariencia"
                            OnDataBound="ddlProceso_DataBound" AutoPostBack="True" DataSourceID="SqlDataSource11"
                            DataTextField="Nombre" OnSelectedIndexChanged="ddlProceso_SelectedIndexChanged"
                            DataValueField="IdProceso">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr align="center">
                    <td colspan="2">
                        <asp:Button ID="Button3" runat="server" Text="Aceptar" CssClass="Apariencia" OnClientClick="$find('popupProcesoRec').hidePopup(); return false;" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlProcesoRie" runat="server" CssClass="popup" Width="350px" Style="display: none">
            <table width="100%" class="tablaSinBordes">
                <tr align="right" bgcolor="#5D7B9D">
                    <td colspan="2">
                        <asp:ImageButton ID="ImageButton11" runat="server" ImageUrl="~/Imagenes/Icons/dialog-close2.png"
                            OnClientClick="$find('popupProcesoRie').hidePopup(); return false;" />
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#BBBBBB">
                        <asp:Label ID="Label2" runat="server" Text="Macroproceso:" CssClass="Apariencia"></asp:Label>
                    </td>
                    <td align="center" bgcolor="#EEEEEE">
                        <asp:DropDownList ID="ddlMacroProcesoRie" runat="server" Width="250px" CssClass="Apariencia"
                            OnDataBound="ddlMacroProcesoRie_DataBound" DataSourceID="SqlDataSource10" DataTextField="Nombre"
                            DataValueField="IdMacroProceso" AutoPostBack="True" OnSelectedIndexChanged="ddlMacroProcesoRie_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#BBBBBB">
                        <asp:Label ID="Label4" runat="server" Text="Proceso:" CssClass="Apariencia"></asp:Label>
                    </td>
                    <td align="center" bgcolor="#EEEEEE">
                        <asp:DropDownList ID="ddlProcesoRie" runat="server" Width="250px" CssClass="Apariencia"
                            OnDataBound="ddlProcesoRie_DataBound" AutoPostBack="True" DataSourceID="SqlDataSource4"
                            DataTextField="Nombre" OnSelectedIndexChanged="ddlProcesoRie_SelectedIndexChanged"
                            DataValueField="IdProceso">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr align="center">
                    <td colspan="2">
                        <asp:Button ID="Button9" runat="server" Text="Aceptar" CssClass="Apariencia" OnClientClick="$find('popupProcesoRie').hidePopup(); return false;" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:TextBox ID="txtCodForaneaGen" runat="server" Visible="False"></asp:TextBox>
        <asp:TextBox ID="txtTipoForanea" runat="server" Visible="False"></asp:TextBox>
        <asp:TextBox ID="txtCodPlanAccion" runat="server" Visible="False"></asp:TextBox>
        <asp:Label ID="lblIdPlanAccion" runat="server" Text="Label" Visible="False"></asp:Label>
        <table width="70%" align="center">
            <tr align="center" bgcolor="#333399">
                <td>
                    <asp:Label ID="Label6" runat="server" ForeColor="White" Text="Seguimiento de Auditoría"
                        Font-Bold="False" Font-Names="Calibri" Font-Size="Large"></asp:Label>
                </td>
            </tr>
            <tr visible="true">
                <td>
                    <table align="center" width="100%">
                        <tr align="center" bgcolor="#EEEEEE" id="filaLiteral" runat="server">
                            <td>
                                <table class="tabla">
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label67" runat="server" CssClass="Apariencia" Text="Código:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCodPlaneacion" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="40px"></asp:TextBox>
                                        </td>
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label66" runat="server" CssClass="Apariencia" Text="Planeación:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtNomPlaneacion" runat="server" CssClass="Apariencia" Width="400px"
                                                Enabled="false"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="imgBtnPlaneacion" runat="server" ImageUrl="~/Imagenes/Icons/table_select_row.png"
                                                OnClientClick="return false;" />
                                            <asp:PopupControlExtender ID="popupPlanea" runat="server" BehaviorID="popupPlaneacion"
                                                Enabled="True" ExtenderControlID="" PopupControlID="pnlPlaneacion" Position="Bottom"
                                                TargetControlID="imgBtnPlaneacion" OffsetX="-200">
                                            </asp:PopupControlExtender>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label55" runat="server" CssClass="Apariencia" Text="Código:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCodAuditoriaSel" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="40px"></asp:TextBox>
                                        </td>
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label68" runat="server" CssClass="Apariencia" Text="Auditoría:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtNomAuditoriaSel" runat="server" CssClass="Apariencia" Width="400px"
                                                Enabled="false"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="imgBtnAuditoria" runat="server" ImageUrl="~/Imagenes/Icons/table_select_row.png"
                                                OnClientClick="return false;" />
                                            <asp:PopupControlExtender ID="popupAuditoria" runat="server" BehaviorID="popupAuditoria"
                                                Enabled="True" ExtenderControlID="" PopupControlID="pnlAuditoria" Position="Bottom"
                                                TargetControlID="imgBtnAuditoria" OffsetX="-200">
                                            </asp:PopupControlExtender>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label69" runat="server" CssClass="Apariencia" Text="Código:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCodObjetivoSel" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="40px"></asp:TextBox>
                                        </td>
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label70" runat="server" CssClass="Apariencia" Text="Objetivo:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtNomObjetivoSel" runat="server" CssClass="Apariencia" Width="400px"
                                                Enabled="false"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="imgBtnObjetivo" runat="server" ImageUrl="~/Imagenes/Icons/table_select_row.png"
                                                OnClientClick="return false;" />
                                            <asp:PopupControlExtender ID="popupObjetivo" runat="server" BehaviorID="popupObjetivo"
                                                Enabled="True" ExtenderControlID="" PopupControlID="pnlObjetivo" Position="Bottom"
                                                TargetControlID="imgBtnObjetivo" OffsetX="-200">
                                            </asp:PopupControlExtender>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label71" runat="server" CssClass="Apariencia" Text="Código:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCodEnfoqueSel" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="40px"></asp:TextBox>
                                        </td>
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label72" runat="server" CssClass="Apariencia" Text="Enfoque:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="txtNomEnfoqueSel" CssClass="Apariencia" Width="402px" runat="server"
                                                ForeColor="#666666" BorderColor="Silver" BorderStyle="Ridge" BorderWidth="1px"
                                                Font-Bold="False" Height="18px"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="imgBtnEnfoque" runat="server" ImageUrl="~/Imagenes/Icons/table_select_row.png"
                                                OnClientClick="return false;" />
                                            <asp:PopupControlExtender ID="popupEnfoque" runat="server" BehaviorID="popupEnfoque"
                                                Enabled="True" ExtenderControlID="" PopupControlID="pnlEnfoque" Position="Bottom"
                                                TargetControlID="imgBtnEnfoque" OffsetX="-200">
                                            </asp:PopupControlExtender>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label73" runat="server" CssClass="Apariencia" Text="Código:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCodLiteralSel" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="40px"></asp:TextBox>
                                        </td>
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label74" runat="server" CssClass="Apariencia" Text="Literal:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="txtNomLiteralSel" runat="server" CssClass="Apariencia" Width="402px"
                                                ForeColor="#666666" BorderColor="Silver" BorderStyle="Ridge" BorderWidth="1px"
                                                Font-Bold="False" Height="18px"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="imgBtnLiteral" runat="server" ImageUrl="~/Imagenes/Icons/table_select_row.png"
                                                OnClientClick="return false;" />
                                            <asp:PopupControlExtender ID="popupLiteral" runat="server" BehaviorID="popupLiteral"
                                                Enabled="True" ExtenderControlID="" PopupControlID="pnlLiteral" Position="Left"
                                                TargetControlID="imgBtnLiteral" OffsetX="-300">
                                            </asp:PopupControlExtender>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="filaTabGestion" runat="server" bgcolor="#EEEEEE" visible="false">
                            <td>
                                <asp:TextBox ID="txtCodHallazgoGen" runat="server" Visible="False"></asp:TextBox>
                                <asp:Label ID="txtHallazgoGen" runat="server" Text="" CssClass="Apariencia" Font-Bold="False"
                                    Width="377px" Visible="False"></asp:Label>
                                <br />
                                <asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" AutoPostBack="True"
                                    OnActiveTabChanged="TabContainer1_ActiveTabChanged">
                                    <asp:TabPanel ID="TabPanel1" runat="server" Font-Underline="True" HeaderText="Hallazgos">
                                        <ContentTemplate>
                                            <table width="100%" bgcolor="#EEEEEE">
                                                <tr align="center">
                                                    <td>
                                                        <table class="tablaSinBordes">
                                                            <tr align="center">
                                                                <td>
                                                                    <br />
                                                                    <br />
                                                                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                                                                        AutoGenerateColumns="False" BorderStyle="Solid" CellPadding="4" DataSourceID="SqlDataSource1"
                                                                        Font-Names="Calibri" Font-Size="Small" ForeColor="#333333" GridLines="Vertical"
                                                                        HorizontalAlign="Center" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                                                                        Font-Bold="False" OnRowCommand="GridView1_RowCommand" ShowHeaderWhenEmpty="True"
                                                                        OnRowDataBound="GridView1_RowDataBound" DataKeyNames="IdHallazgo,IdDetalleTipoHallazgo,IdEstado,ComentarioAuditado,IdUsuario,Usuario,Seguimiento">
                                                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                                        <Columns>
                                                                            <asp:BoundField DataField="IdHallazgo" HeaderText="Código" InsertVisible="False"
                                                                                ReadOnly="True" SortExpression="IdHallazgo">
                                                                                <ItemStyle HorizontalAlign="Center" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="IdAuditoria" HeaderText="IdAuditoria" SortExpression="IdAuditoria"
                                                                                Visible="False" />
                                                                            <asp:BoundField DataField="IdDetalleEnfoque" HeaderText="IdDetalleEnfoque" SortExpression="IdDetalleEnfoque"
                                                                                Visible="False" />
                                                                            <asp:BoundField DataField="IdDetalleTipoHallazgo" HeaderText="IdDetalleTipoHallazgo"
                                                                                SortExpression="IdDetalleTipoHallazgo" Visible="False" />
                                                                            <asp:BoundField DataField="IdEstado" HeaderText="IdEstado" SortExpression="IdEstado"
                                                                                Visible="False" />
                                                                            <asp:BoundField DataField="Hallazgo" HeaderText="Hallazgo" SortExpression="Hallazgo"
                                                                                HtmlEncode="False" HtmlEncodeFormatString="False" HeaderStyle-Width="480px">
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ComentarioAuditado" HeaderText="ComentarioAuditado" SortExpression="ComentarioAuditado"
                                                                                Visible="False" HtmlEncode="False" HtmlEncodeFormatString="False" />
                                                                            <asp:BoundField DataField="FechaRegistro" HeaderText="Fecha de Creación" SortExpression="FechaRegistro">
                                                                                <ItemStyle HorizontalAlign="Center" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="IdUsuario" HeaderText="IdUsuario" SortExpression="IdUsuario"
                                                                                Visible="False" />
                                                                            <asp:BoundField DataField="Usuario" HeaderText="Usuario" SortExpression="Usuario"
                                                                                Visible="False" />
                                                                            <asp:BoundField DataField="Seguimiento" HeaderText="Seguimiento" SortExpression="Seguimiento"
                                                                                Visible="False" />
                                                                            <asp:TemplateField HeaderText="Seguimiento" ShowHeader="False">
                                                                                <ItemTemplate>
                                                                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/Icons/apply.png" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Gestión">
                                                                                <ItemTemplate>
                                                                                    <asp:ImageButton ID="imgBtnRecomendacion" runat="server" CausesValidation="False"
                                                                                        CommandName="Select" CommandArgument="Recomendacion" ImageUrl="~/Imagenes/Icons/regular_folder (16).png"
                                                                                        OnClick="imgBtnRecomendacion_Click" ToolTip="Recomendaciones" /><asp:ImageButton
                                                                                            ID="imgBtnRiesgo" runat="server" CausesValidation="False" CommandName="Select"
                                                                                            ImageUrl="~/Imagenes/Icons/Light_Alert.png" CommandArgument="Riesgo" OnClick="imgBtnRiesgo_Click"
                                                                                            ToolTip="Riesgos" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Anexos" ShowHeader="False">
                                                                                <ItemTemplate>
                                                                                    <asp:ImageButton ID="btnImgSubirDoc" runat="server" CausesValidation="False" ImageUrl="~/Imagenes/Icons/file.png"
                                                                                        CommandArgument="Anexar" CommandName="Select" ToolTip="Anexar" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Acción" ShowHeader="False">
                                                                                <ItemTemplate>
                                                                                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandArgument="Editar"
                                                                                        CommandName="Select" ImageUrl="~/Imagenes/Icons/edit.png" ToolTip="Editar" /><asp:ImageButton
                                                                                            ID="btnImgEliminarHallazgo" runat="server" CausesValidation="False" CommandArgument="<%# Container.DataItemIndex %>"
                                                                                            CommandName="Select" ImageUrl="~/Imagenes/Icons/delete.png" OnClick="btnImgEliminarHallazgo_Click"
                                                                                            Text="Eliminar" ToolTip="Eliminar" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <EditRowStyle BackColor="#999999" />
                                                                        <FooterStyle BackColor="White" Font-Bold="True" ForeColor="White" />
                                                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="gridViewHeader" />
                                                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                                                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                                                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                                                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right">
                                                                    <asp:ImageButton ID="imgBtnInsertarHallazgo" runat="server" CausesValidation="False"
                                                                        CommandName="Insert" ToolTip="Insertar" ImageUrl="~/Imagenes/Icons/Add.png" OnClick="imgBtnInsertarHallazgo_Click"
                                                                        Text="Insert" /><br />
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:TabPanel>
                                    <asp:TabPanel ID="TabPanel2" runat="server" Font-Underline="True" HeaderText="Recomendaciones">
                                        <ContentTemplate>
                                            <table width="100%" bgcolor="#EEEEEE">
                                                <tr align="center">
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <table align="center" class="tabla">
                                                                        <tr align="left">
                                                                            <td bgcolor="#BBBBBB">
                                                                                <asp:Label ID="Label3" runat="server" CssClass="Apariencia" Text="Hallazgo:"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="txtHallazgoRec" runat="server" CssClass="Apariencia" Font-Bold="False"
                                                                                    Width="377px" ForeColor="#666666"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr align="center">
                                                                <td>
                                                                    <br />
                                                                    <br />
                                                                    <table class="tablaSinBordes">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="GridView11" runat="server" AllowPaging="True" AllowSorting="True"
                                                                                    AutoGenerateColumns="False" BorderStyle="Solid" CellPadding="4" DataSourceID="SqlDataSource22"
                                                                                    Font-Names="Calibri" Font-Size="Small" ForeColor="#333333" GridLines="Vertical"
                                                                                    HorizontalAlign="Center" OnSelectedIndexChanged="GridView11_SelectedIndexChanged"
                                                                                    Font-Bold="False" OnRowCommand="GridView11_RowCommand" ShowHeaderWhenEmpty="True"
                                                                                    OnRowDataBound="GridView11_RowDataBound" DataKeyNames="IdDependenciaAuditada,NombreDP,IdDependenciaRespuesta,NombreDepRes,IdSubproceso,Estado,IdUsuario,Usuario,Seguimiento">
                                                                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="IdRecomendacion" HeaderText="Código" InsertVisible="False"
                                                                                            ReadOnly="True" SortExpression="IdRecomendacion">
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Numero" HeaderText="Numero" SortExpression="Numero" Visible="False" />
                                                                                        <asp:BoundField DataField="IdHallazgo" HeaderText="IdHallazgo" SortExpression="IdHallazgo"
                                                                                            Visible="False" />
                                                                                        <asp:BoundField DataField="Tipo" HeaderText="Tipo" SortExpression="Tipo" />
                                                                                        <asp:BoundField DataField="IdDependenciaAuditada" HeaderText="IdDependenciaAuditada"
                                                                                            SortExpression="IdDependenciaAuditada" Visible="False" />
                                                                                        <asp:BoundField DataField="NombreDP" HeaderText="NombreDP" SortExpression="NombreDP"
                                                                                            Visible="False" />
                                                                                        <asp:BoundField DataField="IdDependenciaRespuesta" HeaderText="IdDependenciaRespuesta"
                                                                                            SortExpression="IdDependenciaRespuesta" Visible="False" />
                                                                                        <asp:BoundField DataField="NombreDepRes" HeaderText="NombreDepRes" SortExpression="NombreDepRes"
                                                                                            Visible="False" />
                                                                                        <asp:BoundField DataField="IdSubproceso" HeaderText="IdSubproceso" SortExpression="IdSubproceso"
                                                                                            Visible="False" />
                                                                                        <asp:BoundField DataField="Estado" HeaderText="Estado" SortExpression="Estado" Visible="False" />
                                                                                        <asp:BoundField DataField="Observacion" HeaderText="Recomendación" SortExpression="Observacion"
                                                                                            HtmlEncode="False" HtmlEncodeFormatString="False">
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="FechaRegistro" HeaderText="Fecha de Creación" SortExpression="FechaRegistro">
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="IdUsuario" HeaderText="IdUsuario" SortExpression="IdUsuario"
                                                                                            Visible="False" />
                                                                                        <asp:BoundField DataField="Usuario" HeaderText="Usuario" SortExpression="Usuario"
                                                                                            Visible="False" />
                                                                                        <asp:BoundField DataField="Seguimiento" HeaderText="Seguimiento" SortExpression="Seguimiento"
                                                                                            Visible="False" />
                                                                                        <asp:TemplateField HeaderText="Seguimiento" ShowHeader="False">
                                                                                            <ItemTemplate>
                                                                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/Icons/apply.png" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Plan de Acción" ShowHeader="False">
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="imgBtnPARec" runat="server" CausesValidation="False" CommandArgument="PlanAccion"
                                                                                                    CommandName="Select" ImageUrl="~/Imagenes/Icons/Planner.png" ToolTip="Plan de Acción" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Acción" ShowHeader="False">
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandArgument="Editar"
                                                                                                    CommandName="Select" ImageUrl="~/Imagenes/Icons/edit.png" Text="Editar" ToolTip="Editar" /><asp:ImageButton
                                                                                                        ID="btnImgEliminarRec" runat="server" CausesValidation="False" CommandArgument="<%# Container.DataItemIndex %>"
                                                                                                        CommandName="Select" ImageUrl="~/Imagenes/Icons/delete.png" OnClick="btnImgEliminarRec_Click"
                                                                                                        Text="Eliminar" ToolTip="Eliminar" />
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                    </Columns>
                                                                                    <EditRowStyle BackColor="#999999" />
                                                                                    <FooterStyle BackColor="White" Font-Bold="True" ForeColor="White" />
                                                                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="gridViewHeader" />
                                                                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                                                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                                                                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                                                                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                                                                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right">
                                                                                <asp:ImageButton ID="imgBtnInsertarRec" runat="server" CausesValidation="False" CommandName="Insert"
                                                                                    ToolTip="Insertar" ImageUrl="~/Imagenes/Icons/Add.png" OnClick="imgBtnInsertarRec_Click"
                                                                                    Text="Insert" /><br />
                                                                                <br />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:TabPanel>
                                    <asp:TabPanel ID="TabPanel3" runat="server" Font-Underline="True" HeaderText="Riesgos de Auditoría">
                                        <ContentTemplate>
                                            <table width="100%" bgcolor="#EEEEEE">
                                                <tr align="center">
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <table align="center" class="tabla">
                                                                        <tr align="left">
                                                                            <td bgcolor="#BBBBBB">
                                                                                <asp:Label ID="Label1" runat="server" CssClass="Apariencia" Text="Hallazgo:"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="txtHallazgoRie" runat="server" CssClass="Apariencia" Font-Bold="False"
                                                                                    Width="377px" ForeColor="#666666"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr align="center">
                                                                <td>
                                                                    <br />
                                                                    <br />
                                                                    <table class="tablaSinBordes">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="GridView13" runat="server" AllowPaging="True" AllowSorting="True"
                                                                                    AutoGenerateColumns="False" BorderStyle="Solid" CellPadding="4" DataSourceID="SqlDataSource23"
                                                                                    Font-Names="Calibri" Font-Size="Small" ForeColor="#333333" GridLines="Vertical"
                                                                                    HorizontalAlign="Center" OnSelectedIndexChanged="GridView13_SelectedIndexChanged"
                                                                                    Font-Bold="False" OnRowCommand="GridView13_RowCommand" OnRowDataBound="GridView13_RowDataBound"
                                                                                    DataKeyNames="IdDetalleTipoRiesgo,Tipo,IdDependencia,IdSubproceso,NombreDP,Estado,Observacion,IdDetalleTipoProbabilidad,IdDetalleTipoImpacto,IdUsuario,Usuario,Seguimiento"
                                                                                    ShowHeaderWhenEmpty="True">
                                                                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="IdRiesgo" HeaderText="Código" ReadOnly="True" SortExpression="IdRiesgo">
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="NumeroRiesgo" HeaderText="NumeroRiesgo" SortExpression="NumeroRiesgo"
                                                                                            ReadOnly="True" Visible="False" />
                                                                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" HtmlEncode="False" HtmlEncodeFormatString="False"
                                                                                            SortExpression="Nombre" ReadOnly="True">
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="IdDetalleTipoRiesgo" HeaderText="IdDetalleTipoRiesgo"
                                                                                            SortExpression="IdDetalleTipoRiesgo" Visible="False" ReadOnly="True" />
                                                                                        <asp:BoundField DataField="NombreTipoRiesgo" HeaderText="Tipo de Riesgo" SortExpression="NombreTipoRiesgo"
                                                                                            ReadOnly="True" />
                                                                                        <asp:BoundField DataField="Tipo" HeaderText="Tipo" SortExpression="Tipo" Visible="False"
                                                                                            ReadOnly="True" />
                                                                                        <asp:BoundField DataField="IdDependencia" HeaderText="IdDependencia" SortExpression="IdDependencia"
                                                                                            Visible="False" ReadOnly="True" />
                                                                                        <asp:BoundField DataField="IdSubproceso" HeaderText="IdSubproceso" SortExpression="IdSubproceso"
                                                                                            Visible="False" ReadOnly="True" />
                                                                                        <asp:BoundField DataField="NombreDP" HeaderText="NombreDP" SortExpression="NombreDP"
                                                                                            ReadOnly="True" Visible="False" />
                                                                                        <asp:BoundField DataField="Estado" HeaderText="Estado" SortExpression="Estado" ReadOnly="True"
                                                                                            Visible="False" />
                                                                                        <asp:BoundField DataField="Observacion" HeaderText="Observacion" SortExpression="Observacion"
                                                                                            ReadOnly="True" Visible="False" />
                                                                                        <asp:BoundField DataField="IdDetalleTipoProbabilidad" HeaderText="IdDetalleTipoProbabilidad"
                                                                                            SortExpression="IdDetalleTipoProbabilidad" ReadOnly="True" Visible="False" />
                                                                                        <asp:BoundField DataField="IdDetalleTipoImpacto" HeaderText="IdDetalleTipoImpacto"
                                                                                            SortExpression="IdDetalleTipoImpacto" ReadOnly="True" Visible="False" />
                                                                                        <asp:BoundField DataField="FechaRegistro" HeaderText="Fecha de Creación" ReadOnly="True"
                                                                                            SortExpression="FechaRegistro">
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="IdUsuario" HeaderText="IdUsuario" ReadOnly="True" SortExpression="IdUsuario"
                                                                                            Visible="False" />
                                                                                        <asp:BoundField DataField="Usuario" HeaderText="Usuario" ReadOnly="True" SortExpression="Usuario"
                                                                                            Visible="False" />
                                                                                        <asp:BoundField DataField="Seguimiento" HeaderText="Seguimiento" SortExpression="Seguimiento"
                                                                                            Visible="False" />
                                                                                        <asp:TemplateField HeaderText="Seguimiento" ShowHeader="False">
                                                                                            <ItemTemplate>
                                                                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/Icons/apply.png" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Plan de Acción" ShowHeader="False">
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="imgBtnPARie" runat="server" CausesValidation="False" CommandArgument="PlanAccion"
                                                                                                    CommandName="Select" ImageUrl="~/Imagenes/Icons/Planner.png" ToolTip="Plan de Acción" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Acción" ShowHeader="False">
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandArgument="Editar"
                                                                                                    CommandName="Select" ImageUrl="~/Imagenes/Icons/edit.png" Text="Seleccionar"
                                                                                                    ToolTip="Editar" /><asp:ImageButton ID="btnImgEliminarRie" runat="server" CausesValidation="False"
                                                                                                        CommandArgument="<%# Container.DataItemIndex %>" CommandName="Select" ImageUrl="~/Imagenes/Icons/delete.png"
                                                                                                        OnClick="btnImgEliminarRie_Click" Text="Eliminar" ToolTip="Eliminar" />
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                    </Columns>
                                                                                    <EditRowStyle BackColor="#999999" />
                                                                                    <FooterStyle BackColor="White" Font-Bold="True" ForeColor="White" />
                                                                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="gridViewHeader" />
                                                                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                                                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                                                                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                                                                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                                                                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right">
                                                                                <asp:ImageButton ID="imgBtnInsertarRie" runat="server" CausesValidation="False" CommandName="Insert"
                                                                                    ToolTip="Insertar" ImageUrl="~/Imagenes/Icons/Add.png" OnClick="imgBtnInsertarRie_Click"
                                                                                    Text="Insert" /><br />
                                                                                <br />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:TabPanel>
                                    <asp:TabPanel ID="TabPanel4" runat="server" Font-Underline="True" HeaderText="Metodología">
                                        <ContentTemplate>
                                        </ContentTemplate>
                                    </asp:TabPanel>
                                    <asp:TabPanel ID="TabPanel5" runat="server" Font-Underline="True" HeaderText="Modulo Riesgos">
                                        <ContentTemplate>
                                            <table width="100%" bgcolor="#EEEEEE">
                                                <tr>
                                                    <td>
                                                        <CCCR:ConsolidadoRiesgos ID="ConsolidadoRiesgos" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:TabPanel>
                                    <asp:TabPanel ID="TabPanel6" runat="server" Font-Underline="True" HeaderText="Seguimientos">
                                        <ContentTemplate>
                                            <table width="100%" bgcolor="#EEEEEE">
                                                <tr align="center" bgcolor="#5D7B9D">
                                                    <td>
                                                        <asp:Label ID="Label38" runat="server" Font-Bold="False" Font-Names="Calibri" Font-Size="Small"
                                                            ForeColor="White" Text="Seguimiento Auditoría"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="FilaSeguimiento" runat="server" align="center">
                                                    <td runat="server">
                                                        <br />
                                                        <asp:GridView ID="GridViewSeguimiento" runat="server" AutoGenerateColumns="False"
                                                            BorderStyle="Solid" Font-Bold="False" CellPadding="4" Font-Names="Calibri" Font-Size="Small"
                                                            ForeColor="#333333" GridLines="Vertical" HorizontalAlign="Center" ShowHeaderWhenEmpty="True"
                                                            DataSourceID="SqlDataSourceSeguimiento" OnSelectedIndexChanged="GridViewSeguimiento_SelectedIndexChanged"
                                                            OnRowCommand="GridViewSeguimiento_RowCommand">
                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                            <Columns>
                                                                <asp:BoundField DataField="IdAuditoriaSeguimiento" HeaderText="Número">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Seguimiento" HeaderText="Seguimiento">
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="FechaSeguimiento" HeaderText="Fecha Registro">
                                                                    <ControlStyle Width="100px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Usuario" HeaderText="Usuario">
                                                                    <ControlStyle Width="100px" />
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Acción" ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="btnImgActSeg" runat="server" CausesValidation="False" CommandArgument="Actualizar"
                                                                            CommandName="Select" ImageUrl="~/Imagenes/Icons/edit.png" ToolTip="Actualizar" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <EditRowStyle BackColor="#999999" />
                                                            <FooterStyle BackColor="White" Font-Bold="True" ForeColor="White" />
                                                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="gridViewHeader" />
                                                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr align="center">
                                                    <td>
                                                        <asp:ImageButton ID="ImBtAdd" runat="server" ImageUrl="~/Imagenes/Icons/Add.png"
                                                            ToolTip="Nuevo Seguimiento" OnClick="ImBtAdd_Click" />
                                                    </td>
                                                </tr>
                                                <tr align="center">
                                                    <td>
                                                        <table id="TbNuevoSeguimiento" runat="server" visible="False">
                                                            <tr align="center" bgcolor="#BBBBBB" runat="server">
                                                                <td colspan="2" runat="server">
                                                                    <asp:Label ID="Label34" runat="server" Font-Bold="False" Font-Names="Calibri" Font-Size="Small"
                                                                        ForeColor="White" Text="Nuevo Seguimiento de Auditoría"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr align="left" runat="server">
                                                                <td bgcolor="#BBBBBB" runat="server">
                                                                    <asp:Label ID="Label35" runat="server" CssClass="Apariencia" Text="Seguimiento:"
                                                                        Font-Bold="False"></asp:Label>
                                                                </td>
                                                                <td runat="server">
                                                                    <asp:TextBox ID="TextBox1" runat="server" Height="80px" TextMode="MultiLine" Width="400px"
                                                                        Font-Names="Calibri"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr align="left" runat="server">
                                                                <td bgcolor="#BBBBBB" runat="server">
                                                                    <asp:Label ID="Label36" runat="server" CssClass="Apariencia" Text="Fecha:" Font-Bold="False"></asp:Label>
                                                                </td>
                                                                <td runat="server">
                                                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="Apariencia" Enabled="False"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr align="left" runat="server">
                                                                <td bgcolor="#BBBBBB" runat="server">
                                                                    <asp:Label ID="Label37" runat="server" CssClass="Apariencia" Text="Usuario:" Font-Bold="False"></asp:Label>
                                                                </td>
                                                                <td runat="server">
                                                                    <asp:TextBox ID="TextBox3" runat="server" CssClass="Apariencia" Enabled="False"></asp:TextBox>
                                                                    <asp:Label ID="LabelIdSeguimientoAuditoria" runat="server" Text="Label" Visible="False"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr runat="server">
                                                                <td colspan="2" runat="server">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:ImageButton ID="ImBtGurdarSeguimiento" runat="server" ImageUrl="~/Imagenes/Icons/guardar.png"
                                                                                    OnClick="ImBtGurdarSeguimiento_Click" ToolTip="Guardar" Visible="False" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:ImageButton ID="ImBtUpdateSeguimiento" runat="server" ImageUrl="~/Imagenes/Icons/guardar.png"
                                                                                    OnClick="ImBtUpdateSeguimiento_Click" ToolTip="Modificar" Visible="False" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:ImageButton ID="ImBtCancelSeguimiento" runat="server" ImageUrl="~/Imagenes/Icons/cancel.png"
                                                                                    OnClick="ImBtCancelSeguimiento_Click" ToolTip="Cancelar" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:TabPanel>
                                </asp:TabContainer>
                            </td>
                        </tr>
                        <tr align="center" id="filaMetodologia" runat="server" visible="false">
                            <td bgcolor="#EEEEEE">
                                <table class="tabla" width="100%">
                                    <tr align="center">
                                        <td>
                                            <asp:TextBox ID="txtMetodologia" runat="server" Enabled="True" Columns="100" TextMode="MultiLine"
                                                Font-Names="Calibri" Rows="15"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            <table class="tablaSinBordes">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="btnImgActualizarMetodologia" runat="server" ImageUrl="~/Imagenes/Icons/guardar.png"
                                                            OnClick="btnImgActualizarMetodologia_Click" Style="height: 20px; margin-bottom: 0px;"
                                                            ToolTip="Guardar" Visible="true" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr align="center" id="filaDetalleHallazgo" runat="server" visible="false">
                            <td bgcolor="#EEEEEE">
                                <br />
                                <table class="tabla" width="100%">
                                    <tr align="center" bgcolor="#5D7B9D">
                                        <td colspan="2">
                                            <asp:Label ID="Label77" runat="server" Font-Bold="False" Font-Names="Calibri" Font-Size="Small"
                                                ForeColor="White" Text="Hallazgo"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label76" runat="server" CssClass="Apariencia" Text="Código:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCodHallazgo" runat="server" CssClass="Apariencia" Width="50px"
                                                Enabled="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label45" runat="server" CssClass="Apariencia" Text="Tipo de Hallazgo:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTipoHallazgo" runat="server" CssClass="Apariencia" DataSourceID="SqlDataSource7"
                                                DataTextField="NombreDetalle" DataValueField="IdDetalleTipo" OnDataBound="ddlTipoHallazgo_DataBound"
                                                Width="300px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label51" runat="server" CssClass="Apariencia" Text="Hallazgo:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtHallazgo" runat="server" Enabled="True" Columns="100" TextMode="MultiLine"
                                                Font-Names="Calibri" Rows="8"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label52" runat="server" CssClass="Apariencia" Text="Comentario del Auditado:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtComentario" runat="server" Enabled="True" Columns="100" TextMode="MultiLine"
                                                Font-Names="Calibri" Rows="8"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label75" runat="server" CssClass="Apariencia" Text="Estado del Hallazgo:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlEstadoHallazgo" runat="server" CssClass="Apariencia" DataSourceID="SqlDataSource6"
                                                DataTextField="NombreDetalle" DataValueField="IdDetalleTipo" OnDataBound="ddlEstadoHallazgo_DataBound"
                                                Width="300px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td align="left" bgcolor="#BBBBBB">
                                            <asp:Label ID="Label53" runat="server" CssClass="Apariencia" Text="Usuario:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtUsuarioHallazgo" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td align="left" bgcolor="#BBBBBB">
                                            <asp:Label ID="Label54" runat="server" CssClass="Apariencia" Text="Fecha de Creación:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFecCreacionHallazgo" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="2">
                                            <table class="tablaSinBordes">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="btnImgActualizarHallazgo" runat="server" ImageUrl="~/Imagenes/Icons/guardar.png"
                                                            OnClick="btnImgActualizarHallazgo_Click" ToolTip="Guardar" Style="height: 20px; margin-bottom: 0px;"
                                                            Visible="False" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="btnImgInsertarHallazgo" runat="server" ImageUrl="~/Imagenes/Icons/guardar.png"
                                                            OnClick="btnImgInsertarHallazgo_Click" Style="text-align: right" ToolTip="Guardar" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="btnImgCancelarHallazgo" runat="server" ImageUrl="~/Imagenes/Icons/cancel.png"
                                                            OnClick="btnImgCancelarHallazgo_Click" ToolTip="Cancelar" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr align="center" id="filaDetalleRecomendacion" runat="server" visible="false">
                            <td bgcolor="#EEEEEE">
                                <br />
                                <table class="tabla" width="100%">
                                    <tr align="center" bgcolor="#5D7B9D">
                                        <td colspan="2">
                                            <asp:Label ID="Label78" runat="server" Font-Bold="False" Font-Names="Calibri" Font-Size="Small"
                                                ForeColor="White" Text="Recomendación"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label79" runat="server" CssClass="Apariencia" Text="Código:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCodRec" runat="server" CssClass="Apariencia" Width="50px" Enabled="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label86" runat="server" Text="Tipo:" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                        </td>
                                        <td bgcolor="#EEEEEE">
                                            <asp:DropDownList ID="ddlRecPoD" runat="server" AutoPostBack="True" Font-Names="Calibri"
                                                Font-Size="Small" OnSelectedIndexChanged="ddlRecPoD_SelectedIndexChanged" Width="221px">
                                                <asp:ListItem>Procesos</asp:ListItem>
                                                <asp:ListItem>Dependencia</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr id="filaDependenciaRec" runat="server" align="left" visible="False">
                                        <td id="Td7" runat="server" bgcolor="#BBBBBB">
                                            <asp:Label ID="Label87" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Dependencia Auditada:"></asp:Label>
                                        </td>
                                        <td id="Td8" runat="server">
                                            <table>
                                                <tr>
                                                    <td bgcolor="#EEEEEE">
                                                        <asp:TextBox ID="txtDependenciaRec2" runat="server" Enabled="False" Font-Names="Calibri"
                                                            Font-Size="Small" Width="377px"></asp:TextBox>
                                                        <asp:Label ID="lblIdDependenciaRec2" runat="server" Visible="False"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgDependenciaRec2" runat="server" ImageUrl="~/Imagenes/Icons/Organization-Chart.png" />
                                                        <asp:PopupControlExtender ID="PopupControlExtender1" runat="server" BehaviorID="popupDepRec2"
                                                            DynamicServicePath="" Enabled="True" ExtenderControlID="" OffsetY="-200" PopupControlID="pnlDependenciaRec2"
                                                            Position="Right" TargetControlID="imgDependenciaRec2">
                                                        </asp:PopupControlExtender>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="filaProcesoRec" runat="server" align="left">
                                        <td id="Td9" runat="server" align="left" bgcolor="#BBBBBB">
                                            <asp:Label ID="Label89" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Proceso Auditado:"></asp:Label>
                                        </td>
                                        <td id="Td10" runat="server">
                                            <table>
                                                <tr>
                                                    <td bgcolor="#EEEEEE">
                                                        <asp:TextBox ID="txtProcesoRec" runat="server" Enabled="False" Font-Names="Calibri"
                                                            Font-Size="Small" Width="377px"></asp:TextBox>
                                                    </td>
                                                    <td align="left">
                                                        <asp:ImageButton ID="imgProcesoRec" runat="server" ImageUrl="~/Imagenes/Icons/FlowChart.png"
                                                            OnClientClick="return false;" />
                                                        <asp:PopupControlExtender ID="PopupControlExtender2" runat="server" BehaviorID="popupProcesoRec"
                                                            DynamicServicePath="" Enabled="True" ExtenderControlID="" PopupControlID="pnlProcesoRec"
                                                            Position="Right" TargetControlID="imgProcesoRec">
                                                        </asp:PopupControlExtender>
                                                        <asp:Label ID="lblIdProcesoRec" runat="server" Visible="False"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label80" runat="server" CssClass="Apariencia" Text="Dependencia Respuesta:"></asp:Label>
                                        </td>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td bgcolor="#EEEEEE">
                                                        <asp:TextBox ID="txtDependenciaRec1" runat="server" Enabled="False" Font-Names="Calibri"
                                                            Font-Size="Small" Width="377px"></asp:TextBox>
                                                        <asp:Label ID="lblIdDependenciaRec1" runat="server" Visible="False"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgDependenciaRec1" runat="server" ImageUrl="~/Imagenes/Icons/Organization-Chart.png"
                                                            OnClientClick="return false;" /><asp:PopupControlExtender ID="PopupControlExtender3"
                                                                runat="server" BehaviorID="popupDepRec" DynamicServicePath="" Enabled="True"
                                                                ExtenderControlID="" OffsetY="-200" PopupControlID="pnlDependenciaRec" Position="Right"
                                                                TargetControlID="imgDependenciaRec1">
                                                            </asp:PopupControlExtender>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label81" runat="server" CssClass="Apariencia" Text="Recomendación:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRecomendacion" runat="server" Enabled="True" Columns="100" TextMode="MultiLine"
                                                Font-Names="Calibri" Rows="8"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td align="left" bgcolor="#BBBBBB">
                                            <asp:Label ID="Label84" runat="server" CssClass="Apariencia" Text="Usuario:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtUsuarioRec" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td align="left" bgcolor="#BBBBBB">
                                            <asp:Label ID="Label85" runat="server" CssClass="Apariencia" Text="Fecha de Creación:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFecCreacionRec" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="2">
                                            <table class="tablaSinBordes">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="btnImgActualizarRec" runat="server" ImageUrl="~/Imagenes/Icons/guardar.png"
                                                            OnClick="btnImgActualizarRec_Click" Style="height: 20px" Visible="False" ToolTip="Guardar" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="btnImgInsertarRec" runat="server" ImageUrl="~/Imagenes/Icons/guardar.png"
                                                            OnClick="btnImgInsertarRec_Click" Style="text-align: right" ToolTip="Guardar" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="btnImgCancelarRec" runat="server" ImageUrl="~/Imagenes/Icons/cancel.png"
                                                            OnClick="btnImgCancelarRec_Click" ToolTip="Cancelar" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr align="center" id="filaDetalleRiesgo" runat="server" visible="false">
                            <td bgcolor="#EEEEEE">
                                <br />
                                <table class="tabla" width="100%">
                                    <tr align="center" bgcolor="#5D7B9D">
                                        <td colspan="2">
                                            <asp:Label ID="Label82" runat="server" Font-Bold="False" Font-Names="Calibri" Font-Size="Small"
                                                ForeColor="White" Text="Riesgo"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label83" runat="server" CssClass="Apariencia" Text="Código:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCodRiesgo" runat="server" CssClass="Apariencia" Width="50px"
                                                Enabled="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label102" runat="server" CssClass="Apariencia" Text="Tipo de Riesgo:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTipoRiesgo" runat="server" CssClass="Apariencia" DataSourceID="SqlDataSource5"
                                                DataTextField="NombreDetalle" DataValueField="IdDetalleTipo" OnDataBound="ddlTipoRiesgo_DataBound"
                                                Width="300px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label92" runat="server" CssClass="Apariencia" Text="Nombre:"></asp:Label>
                                        </td>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td bgcolor="#EEEEEE">
                                                        <asp:TextBox ID="txtNomRiesgo" runat="server" Font-Names="Calibri" Font-Size="Small"
                                                            Width="377px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label99" runat="server" CssClass="Apariencia" Text="Descripción:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDescRiesgo" runat="server" Enabled="True" Columns="100" TextMode="MultiLine"
                                                Font-Names="Calibri" Rows="8"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label94" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Tipo:"></asp:Label>
                                        </td>
                                        <td bgcolor="#EEEEEE">
                                            <asp:DropDownList ID="ddlRiePoD" runat="server" AutoPostBack="True" Font-Names="Calibri"
                                                Font-Size="Small" OnSelectedIndexChanged="ddlRiePoD_SelectedIndexChanged" Width="221px">
                                                <asp:ListItem>Procesos</asp:ListItem>
                                                <asp:ListItem>Dependencia</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr id="filaDependenciaRie" runat="server" align="left" visible="False">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label95" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Dependencia Auditada:"></asp:Label>
                                        </td>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td bgcolor="#EEEEEE">
                                                        <asp:TextBox ID="txtDependenciaRie" runat="server" Enabled="False" Font-Names="Calibri"
                                                            Font-Size="Small" Width="377px"></asp:TextBox><asp:Label ID="lblIdDependenciaRie"
                                                                runat="server" Visible="False"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgDependenciaRie" runat="server" ImageUrl="~/Imagenes/Icons/Organization-Chart.png"
                                                            OnClientClick="return false;" /><asp:PopupControlExtender ID="PopupControlExtender5"
                                                                runat="server" BehaviorID="popupDepRie" DynamicServicePath="" Enabled="True"
                                                                ExtenderControlID="" OffsetY="-400" PopupControlID="pnlDependenciaRie" Position="Right"
                                                                TargetControlID="imgDependenciaRie">
                                                            </asp:PopupControlExtender>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="filaProcesoRie" runat="server" align="left">
                                        <td align="left" bgcolor="#BBBBBB">
                                            <asp:Label ID="Label97" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Proceso Auditado:"></asp:Label>
                                        </td>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td bgcolor="#EEEEEE">
                                                        <asp:TextBox ID="txtProcesoRie" runat="server" Enabled="False" Font-Names="Calibri"
                                                            Font-Size="Small" Width="377px"></asp:TextBox>
                                                    </td>
                                                    <td align="left">
                                                        <asp:ImageButton ID="imgProcesoRie" runat="server" ImageUrl="~/Imagenes/Icons/FlowChart.png"
                                                            OnClientClick="return false;" /><asp:PopupControlExtender ID="PopupControlExtender6"
                                                                runat="server" BehaviorID="popupProcesoRie" DynamicServicePath="" Enabled="True"
                                                                ExtenderControlID="" PopupControlID="pnlProcesoRie" Position="Right" TargetControlID="imgProcesoRie">
                                                            </asp:PopupControlExtender>
                                                        <asp:Label ID="lblIdProcesoRie" runat="server" Visible="False"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label103" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Probabilidad:"></asp:Label>
                                        </td>
                                        <td bgcolor="#EEEEEE">
                                            <asp:DropDownList ID="ddlProbabilidad" runat="server" Width="250px" CssClass="Apariencia"
                                                DataSourceID="SqlDataSource2" DataTextField="NombreDetalle" DataValueField="IdDetalleTipo"
                                                OnDataBound="ddlProbabilidad_DataBound">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label104" runat="server" Font-Names="Calibri" Font-Size="Small" Text="Impacto:"></asp:Label>
                                        </td>
                                        <td bgcolor="#EEEEEE">
                                            <asp:DropDownList ID="ddlImpacto" runat="server" Width="250px" CssClass="Apariencia"
                                                DataSourceID="SqlDataSource3" DataTextField="NombreDetalle" DataValueField="IdDetalleTipo"
                                                OnDataBound="ddlImpacto_DataBound">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td align="left" bgcolor="#BBBBBB">
                                            <asp:Label ID="Label100" runat="server" CssClass="Apariencia" Text="Usuario:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtUsuarioRie" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td align="left" bgcolor="#BBBBBB">
                                            <asp:Label ID="Label101" runat="server" CssClass="Apariencia" Text="Fecha de Creación:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFecCreacionRie" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="2">
                                            <table class="tablaSinBordes">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="btnImgInsertarRie" runat="server" ImageUrl="~/Imagenes/Icons/guardar.png"
                                                            OnClick="btnImgInsertarRie_Click" Style="height: 20px" Visible="False" ToolTip="Guardar" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="btnImgActualizarRie" runat="server" ImageUrl="~/Imagenes/Icons/guardar.png"
                                                            OnClick="btnImgActualizarRie_Click" Style="text-align: right" ToolTip="Guardar" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="ImageButton24" runat="server" ImageUrl="~/Imagenes/Icons/cancel.png"
                                                            OnClick="btnImgCancelarRie_Click" ToolTip="Cancelar" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server" id="filaAnexos" align="center" visible="false">
                            <td>
                                <table width="100%" bgcolor="#EEEEEE">
                                    <tr align="center" bgcolor="#5D7B9D">
                                        <td>
                                            <asp:Label ID="Label27" runat="server" Font-Bold="False" Font-Names="Calibri" Font-Size="Small"
                                                ForeColor="White" Text="Documentos Adjuntos"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr runat="server" id="filaGridAnexos" align="center">
                                        <td>
                                            <table class="tablaSinBordes">
                                                <tr>
                                                    <td>
                                                        <br />
                                                        <asp:GridView ID="GridView100" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                            DataSourceID="SqlDataSource100" ForeColor="#333333" GridLines="Vertical" ShowHeaderWhenEmpty="True"
                                                            HeaderStyle-CssClass="gridViewHeader" BorderStyle="Solid" HorizontalAlign="Center"
                                                            Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="GridView100_SelectedIndexChanged"
                                                            AllowPaging="True" AllowSorting="True" Font-Bold="False" DataKeyNames="IdArchivo">
                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                            <Columns>
                                                                <asp:BoundField DataField="IdArchivo" HeaderText="IdArchivo" SortExpression="IdArchivo"
                                                                    InsertVisible="False" ReadOnly="True" Visible="False" />
                                                                <asp:BoundField DataField="UrlArchivo" HeaderText="Archivo" SortExpression="UrlArchivo" />
                                                                <asp:BoundField DataField="Descripcion" HeaderText="Descripción" SortExpression="Descripcion" />
                                                                <asp:BoundField DataField="FechaRegistro" HeaderText="Fecha de Carga" SortExpression="FechaRegistro">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="IdUsuario" HeaderText="IdUsuario" SortExpression="IdUsuario"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="Usuario" HeaderText="Usuario" SortExpression="Usuario">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Acción" ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="btnImgDownloadDoc" runat="server" CausesValidation="False" ImageUrl="~/Imagenes/Icons/download_folder.png"
                                                                            Text="Descargar" ToolTip="Descargar Archivo" CommandArgument="Descargar" CommandName="Select" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <EditRowStyle BackColor="#999999" />
                                                            <FooterStyle BackColor="White" Font-Bold="True" ForeColor="White" />
                                                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:ImageButton ID="imgBtnInsertarArchivo" runat="server" CausesValidation="False"
                                                            ToolTip="Insertar" CommandName="Insert" ImageUrl="~/Imagenes/Icons/Add.png" OnClick="imgBtnInsertarArchivo_Click"
                                                            Text="Insert" />
                                                        <br />
                                                    </td>
                                                </tr>
                                                <tr align="center">
                                                    <td>
                                                        <asp:Button ID="btnVolverArchivo" runat="server" Text="Volver" OnClick="btnVolverArchivo_Click" />
                                                    </td>
                                                </tr>
                                                <tr align="center">
                                                    <td>
                                                        <br>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr runat="server" id="filaSubirAnexos" align="center" visible="false">
                                        <td>
                                            <br />
                                            <table class="tabla">
                                                <tr>
                                                    <td bgcolor="#BBBBBB">
                                                        <asp:Label ID="Label26" runat="server" Text="Adjuntar documento:" Font-Names="Calibri"
                                                            Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:FileUpload ID="FileUpload1" runat="server" Font-Names="Calibri" Font-Size="Small"
                                                            Width="400px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#BBBBBB">
                                                        <asp:Label ID="Label28" runat="server" Text="Descripción:" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDescArchivo" runat="server" Width="400" MaxLength="100"></asp:TextBox>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr align="center">
                                                    <td colspan="2">
                                                        <table class="tablaSinBordes">
                                                            <tr>
                                                                <td>
                                                                    <asp:ImageButton ID="imgBtnAdjuntar" runat="server" ImageUrl="~/Imagenes/Icons/uploads_folder (1).png"
                                                                        ToolTip="Adjuntar" OnClick="imgBtnAdjuntar_Click" />
                                                                </td>
                                                                <td>
                                                                    <asp:ImageButton ID="btnImgCancelarArchivo" runat="server" ImageUrl="~/Imagenes/Icons/cancel.png"
                                                                        ToolTip="Cancelar" OnClick="btnImgCancelarArchivo_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr align="center" id="filaDetallePlan" runat="server" visible="false">
                            <td bgcolor="#EEEEEE">
                                <table class="tabla" width="100%">
                                    <tr align="center" bgcolor="#5D7B9D">
                                        <td colspan="2">
                                            <asp:Label ID="Label5" runat="server" Font-Bold="False" Font-Names="Calibri" Font-Size="Small"
                                                ForeColor="White" Text="Creación del Plan"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label8" runat="server" CssClass="Apariencia" Text="Objetivo:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtObjetivo" runat="server" CssClass="Apariencia" Width="402px"
                                                Enabled="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label9" runat="server" CssClass="Apariencia" Text="Código:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCodRecPA" runat="server" CssClass="Apariencia" Width="50px" Enabled="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label10" runat="server" Text="Tipo:" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                        </td>
                                        <td bgcolor="#EEEEEE">
                                            <asp:TextBox ID="txtTipoPoD" runat="server" CssClass="Apariencia" Width="150px" Enabled="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="lblPoD" runat="server" Text="Proceso:" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                        </td>
                                        <td bgcolor="#EEEEEE">
                                            <asp:TextBox ID="txtNombrePoD" runat="server" CssClass="Apariencia" Width="402px"
                                                Enabled="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="lblRR" runat="server" CssClass="Apariencia" Text="Recomendación:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="txtRecomendacionPA" CssClass="Apariencia" Width="402px" runat="server"
                                                ForeColor="#666666" BorderColor="Silver" BorderStyle="Ridge" BorderWidth="1px"
                                                Font-Bold="False" Height="18px"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label12" runat="server" Text="Fecha de Compromiso:" Font-Names="Calibri"
                                                Font-Size="Small"></asp:Label>
                                        </td>
                                        <td bgcolor="#EEEEEE">
                                            <asp:TextBox ID="txtFecPlan" runat="server" Enabled="False" CssClass="Apariencia"></asp:TextBox>
                                        </td>
                                        <asp:CalendarExtender ID="txtFecPlan_CalendarExtender" runat="server" Enabled="True"
                                            Format="dd/MM/yyyy" TargetControlID="txtFecPlan"></asp:CalendarExtender>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label13" runat="server" CssClass="Apariencia" Text="Acción:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDescPlan" runat="server" Enabled="False" Columns="100" TextMode="MultiLine"
                                                Font-Names="Calibri" Rows="8"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label11" runat="server" Text="Fecha de Cierre Auditado:" Font-Names="Calibri"
                                                Font-Size="Small"></asp:Label>
                                        </td>
                                        <td bgcolor="#EEEEEE">
                                            <asp:TextBox ID="txtFecCierreAuditado" runat="server" Enabled="False" CssClass="Apariencia"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label33" runat="server" Text="Fecha de Cierre Auditor:" Font-Names="Calibri"
                                                Font-Size="Small"></asp:Label>
                                        </td>
                                        <td bgcolor="#EEEEEE">
                                            <asp:TextBox ID="txtFecCierreAuditor" runat="server" Enabled="False" CssClass="Apariencia"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td align="left" bgcolor="#BBBBBB">
                                            <asp:Label ID="Label14" runat="server" CssClass="Apariencia" Text="Usuario:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtUsuarioPlan" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td align="left" bgcolor="#BBBBBB">
                                            <asp:Label ID="Label15" runat="server" CssClass="Apariencia" Text="Fecha de Creación:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFecCreacionPlan" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="2">
                                            <table class="tablaSinBordes">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="btnImgCancelarDetPlan" runat="server" ImageUrl="~/Imagenes/Icons/cancel.png"
                                                            OnClick="btnImgCancelarDetPlan_Click" ToolTip="Cancelar" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="#EEEEEE" id="filaPlanAccion" runat="server" visible="false">
                            <td>
                                <table width="100%">
                                    <tr align="center" bgcolor="#5D7B9D">
                                        <td>
                                            <asp:Label ID="Label16" runat="server" Font-Bold="False" Font-Names="Calibri" Font-Size="Small"
                                                ForeColor="White" Text="Listado de Planes de Acción por Recomendación"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            <br />
                                            <table class="tabla">
                                                <tr align="left">
                                                    <td bgcolor="#BBBBBB">
                                                        <asp:Label ID="Label17" runat="server" CssClass="Apariencia" Text="Código:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtCodRecPlan" runat="server" CssClass="Apariencia" Width="50px"
                                                            Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr align="left">
                                                    <td bgcolor="#BBBBBB">
                                                        <asp:Label ID="Label18" runat="server" CssClass="Apariencia" Text="Recomendación:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="txtRecPlan" CssClass="Apariencia" Width="402px" runat="server" Text=""
                                                            ForeColor="#666666" BorderColor="Silver" BorderStyle="Ridge" BorderWidth="1px"
                                                            Font-Bold="False" Height="18px"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            <table class="tablaSinBordes">
                                                <tr align="center">
                                                    <td>
                                                        <br />
                                                        <asp:GridView ID="GridView4" runat="server" AllowPaging="True" AllowSorting="True"
                                                            AutoGenerateColumns="False" BorderStyle="Solid" CellPadding="4" DataSourceID="SqlDataSource25"
                                                            Font-Names="Calibri" Font-Size="Small" ForeColor="#333333" GridLines="Vertical"
                                                            HorizontalAlign="Center" OnSelectedIndexChanged="GridView4_SelectedIndexChanged"
                                                            Font-Bold="False" OnRowCommand="GridView4_RowCommand" ShowHeaderWhenEmpty="True"
                                                            DataKeyNames="EstadoAuditado,EstadoAuditor,FechaCierreAuditado,FechaCierreAuditor,Usuario"
                                                            OnRowDataBound="GridView4_RowDataBound">
                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                            <Columns>
                                                                <asp:BoundField DataField="IdPlanAccion" HeaderText="Código" InsertVisible="False"
                                                                    ReadOnly="True" SortExpression="IdPlanAccion">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="EstadoAuditado" HeaderText="EstadoAuditado" SortExpression="EstadoAuditado"
                                                                    Visible="false" />
                                                                <asp:BoundField DataField="IdForanea" HeaderText="IdForanea" SortExpression="IdForanea"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="Descripcion" HeaderText="Descripción" SortExpression="Descripcion"
                                                                    HtmlEncode="False" HtmlEncodeFormatString="False">
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="FechaCompromiso" HeaderText="Fecha de Compromiso" SortExpression="FechaCompromiso">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="FechaRegistro" HeaderText="Fecha de Creación" SortExpression="FechaRegistro">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="IdUsuario" HeaderText="IdUsuario" SortExpression="IdUsuario"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="TipoForanea" HeaderText="TipoForanea" SortExpression="TipoForanea"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="EstadoAuditor" HeaderText="EstadoAuditor" SortExpression="EstadoAuditor"
                                                                    Visible="false" />
                                                                <asp:BoundField DataField="FechaCierreAuditado" HeaderText="Fecha Cierre Auditado"
                                                                    SortExpression="FechaCierreAuditado">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="FechaCierreAuditor" HeaderText="Fecha Cierre Auditor"
                                                                    SortExpression="FechaCierreAuditor">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Avances" ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="imgbtnLog" runat="server" CausesValidation="False" CommandArgument="Avances"
                                                                            CommandName="Select" ImageUrl="~/Imagenes/Icons/history.png" ToolTip="Log de Avances" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Anexos" ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="btnImgSubirDoc" runat="server" CausesValidation="False" ImageUrl="~/Imagenes/Icons/file.png"
                                                                            CommandArgument="Anexar" CommandName="Select" ToolTip="Anexar" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Acción" ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="btnImgActPlan" runat="server" CausesValidation="False" CommandArgument="Actualizar"
                                                                            CommandName="Select" ImageUrl="~/Imagenes/Icons/edit.png" ToolTip="Editar" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="Usuario" HeaderText="Usuario" SortExpression="Usuario"
                                                                    Visible="False" />
                                                            </Columns>
                                                            <EditRowStyle BackColor="#999999" />
                                                            <FooterStyle BackColor="White" Font-Bold="True" ForeColor="White" />
                                                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="gridViewHeader" />
                                                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
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
                            </td>
                        </tr>
                        <tr align="center" bgcolor="#EEEEEE" id="filaAvance" runat="server" visible="false">
                            <td>
                                <table width="100%">
                                    <tr align="center" bgcolor="#5D7B9D">
                                        <td>
                                            <asp:Label ID="Label19" runat="server" Font-Bold="False" Font-Names="Calibri" Font-Size="Small"
                                                ForeColor="White" Text="Listado de Avances por Plan de Acción"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            <br />
                                            <table class="tabla">
                                                <tr align="left">
                                                    <td bgcolor="#BBBBBB">
                                                        <asp:Label ID="lblPARR" runat="server" CssClass="Apariencia" Text="Recomendación:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="txtPlanRec" CssClass="Apariencia" Width="402px" runat="server" Text=""
                                                            ForeColor="#666666" BorderColor="Silver" BorderStyle="Ridge" BorderWidth="1px"
                                                            Font-Bold="False" Height="18px"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr align="left">
                                                    <td bgcolor="#BBBBBB">
                                                        <asp:Label ID="Label20" runat="server" CssClass="Apariencia" Text="Plan de Acción:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="txtPlanPlan" CssClass="Apariencia" Width="402px" runat="server" Text=""
                                                            ForeColor="#666666" BorderColor="Silver" BorderStyle="Ridge" BorderWidth="1px"
                                                            Font-Bold="False" Height="18px"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            <table class="tablaSinBordes">
                                                <tr align="center">
                                                    <td>
                                                        <br />
                                                        <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True"
                                                            AutoGenerateColumns="False" BorderStyle="Solid" CellPadding="4" DataSourceID="SqlDataSource26"
                                                            Font-Names="Calibri" Font-Size="Small" ForeColor="#333333" GridLines="Vertical"
                                                            HorizontalAlign="Center" Font-Bold="False" ShowHeaderWhenEmpty="True" DataKeyNames="IdPlanAccionAvance">
                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                            <Columns>
                                                                <asp:BoundField DataField="IdPlanAccionAvance" HeaderText="Código" InsertVisible="False"
                                                                    ReadOnly="True" SortExpression="IdPlanAccionAvance">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="IdPlanAccion" HeaderText="IdPlanAccion" SortExpression="IdPlanAccion"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="Avance" HeaderText="Avance" SortExpression="Avance" HtmlEncode="False"
                                                                    HtmlEncodeFormatString="False" />
                                                                <asp:BoundField DataField="FechaRegistro" HeaderText="Fecha de Creación" SortExpression="FechaRegistro">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="IdUsuario" HeaderText="IdUsuario" SortExpression="IdUsuario"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="Usuario" HeaderText="Usuario" SortExpression="Usuario">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                            </Columns>
                                                            <EditRowStyle BackColor="#999999" />
                                                            <FooterStyle BackColor="White" Font-Bold="True" ForeColor="White" />
                                                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="gridViewHeader" />
                                                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
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
                                    <tr align="center">
                                        <td>
                                            <asp:Button ID="btnVolverPlanes" runat="server" Text="Volver a Listado de Planes"
                                                OnClick="btnVolverPlanes_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr align="center" id="filaRegistrarAvances" runat="server" visible="false">
                            <td bgcolor="#EEEEEE">
                                <table class="tabla" width="100%">
                                    <tr align="center" bgcolor="#5D7B9D">
                                        <td colspan="2">
                                            <asp:Label ID="Label21" runat="server" Font-Bold="False" Font-Names="Calibri" Font-Size="Small"
                                                ForeColor="White" Text="Registro de Avances"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="lblAvanceRR" runat="server" CssClass="Apariencia" Text="Recomendación:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="txtAvanceRec" CssClass="Apariencia" Width="402px" runat="server" Text=""
                                                ForeColor="#666666" BorderColor="Silver" BorderStyle="Ridge" BorderWidth="1px"
                                                Font-Bold="False" Height="18px"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label22" runat="server" CssClass="Apariencia" Text="Plan de Acción:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="txtAvancePlan" CssClass="Apariencia" Width="402px" runat="server"
                                                Text="" ForeColor="#666666" BorderColor="Silver" BorderStyle="Ridge" BorderWidth="1px"
                                                Font-Bold="False" Height="18px"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td bgcolor="#BBBBBB">
                                            <asp:Label ID="Label23" runat="server" CssClass="Apariencia" Text="Avance:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAvance" runat="server" Enabled="True" Columns="100" TextMode="MultiLine"
                                                Font-Names="Calibri" Rows="8"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td align="left" bgcolor="#BBBBBB">
                                            <asp:Label ID="Label24" runat="server" CssClass="Apariencia" Text="Usuario:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtUsuarioAvance" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td align="left" bgcolor="#BBBBBB">
                                            <asp:Label ID="Label29" runat="server" CssClass="Apariencia" Text="Fecha de Creación:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFecCreacionAvance" runat="server" CssClass="Apariencia" Enabled="False"
                                                Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="2">
                                            <table class="tablaSinBordes">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="btnImgCancelarRegAvances" runat="server" ImageUrl="~/Imagenes/Icons/cancel.png"
                                                            OnClick="btnImgCancelarRegAvances_Click" ToolTip="Cancelar" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="#EEEEEE" id="filaPlanAccionRiesgo" runat="server" visible="false">
                            <td>
                                <table width="100%">
                                    <tr align="center" bgcolor="#5D7B9D">
                                        <td>
                                            <asp:Label ID="Label30" runat="server" Font-Bold="False" Font-Names="Calibri" Font-Size="Small"
                                                ForeColor="White" Text="Listado de Planes de Acción por Riesgo"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            <br />
                                            <table class="tabla">
                                                <tr align="left">
                                                    <td bgcolor="#BBBBBB">
                                                        <asp:Label ID="Label31" runat="server" CssClass="Apariencia" Text="Código:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtCodRiesgoPlan" runat="server" CssClass="Apariencia" Width="50px"
                                                            Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr align="left">
                                                    <td bgcolor="#BBBBBB">
                                                        <asp:Label ID="Label32" runat="server" CssClass="Apariencia" Text="Riesgo:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtRiesgoPlan" runat="server" Enabled="False" CssClass="Apariencia"
                                                            Font-Names="Calibri" Rows="1" Width="400px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            <table class="tablaSinBordes">
                                                <tr align="center">
                                                    <td>
                                                        <br />
                                                        <asp:GridView ID="GridView5" runat="server" AllowPaging="True" AllowSorting="True"
                                                            AutoGenerateColumns="False" BorderStyle="Solid" CellPadding="4" DataSourceID="SqlDataSource25"
                                                            Font-Names="Calibri" Font-Size="Small" ForeColor="#333333" GridLines="Vertical"
                                                            HorizontalAlign="Center" OnSelectedIndexChanged="GridView5_SelectedIndexChanged"
                                                            Font-Bold="False" OnRowCommand="GridView5_RowCommand" ShowHeaderWhenEmpty="True"
                                                            DataKeyNames="EstadoAuditado,EstadoAuditor,FechaCierreAuditado,FechaCierreAuditor,Usuario"
                                                            OnRowDataBound="GridView5_RowDataBound">
                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                            <Columns>
                                                                <asp:BoundField DataField="IdPlanAccion" HeaderText="Código" InsertVisible="False"
                                                                    ReadOnly="True" SortExpression="IdPlanAccion">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="EstadoAuditado" HeaderText="EstadoAuditado" SortExpression="EstadoAuditado"
                                                                    Visible="false" />
                                                                <asp:BoundField DataField="IdForanea" HeaderText="IdForanea" SortExpression="IdForanea"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="Descripcion" HeaderText="Descripción" SortExpression="Descripcion"
                                                                    HtmlEncode="False" HtmlEncodeFormatString="False"></asp:BoundField>
                                                                <asp:BoundField DataField="FechaCompromiso" HeaderText="Fecha de Compromiso" SortExpression="FechaCompromiso">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="FechaRegistro" HeaderText="Fecha de Creación" SortExpression="FechaRegistro">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="IdUsuario" HeaderText="IdUsuario" SortExpression="IdUsuario"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="TipoForanea" HeaderText="TipoForanea" SortExpression="TipoForanea"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="EstadoAuditor" HeaderText="EstadoAuditor" SortExpression="EstadoAuditor"
                                                                    Visible="false" />
                                                                <asp:BoundField DataField="FechaCierreAuditado" HeaderText="Fecha Cierre Auditado"
                                                                    SortExpression="FechaCierreAuditado">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="FechaCierreAuditor" HeaderText="Fecha Cierre Auditor"
                                                                    SortExpression="FechaCierreAuditor">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Avances" ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="imgbtnLog" runat="server" CausesValidation="False" CommandArgument="Avances"
                                                                            CommandName="Select" ImageUrl="~/Imagenes/Icons/history.png" ToolTip="Log de Avances" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Anexos" ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="btnImgSubirDoc2" runat="server" CausesValidation="False" ImageUrl="~/Imagenes/Icons/file.png"
                                                                            CommandArgument="Anexar" CommandName="Select" ToolTip="Anexar" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Acción" ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="btnImgActPlan2" runat="server" CausesValidation="False" CommandArgument="Actualizar"
                                                                            CommandName="Select" ImageUrl="~/Imagenes/Icons/edit.png" ToolTip="Actualizar" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="Usuario" HeaderText="Usuario" SortExpression="Usuario"
                                                                    Visible="False" />
                                                            </Columns>
                                                            <EditRowStyle BackColor="#999999" />
                                                            <FooterStyle BackColor="White" Font-Bold="True" ForeColor="White" />
                                                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="gridViewHeader" />
                                                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
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
                            </td>
                        </tr>
                        <tr align="center" id="filaVolver" runat="server" visible="false" bgcolor="#EEEEEE">
                            <td>
                                <table class="tablaSinBordes">
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnVolverRec" runat="server" OnClick="btnVolverRec_Click" Text="Volver a Recomendaciones" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="filaAcciones" runat="server" align="center" bgcolor="#EEEEEE" visible="false">
                            <td>
                                <table class="tablaSinBordes">
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnCierre" runat="server" OnClick="btnCierre_Click" Text="Cerrar Seguimiento" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnImformeAud" runat="server" Text="Informe de Seguimiento" OnClick="btnImformeAud_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </td> </tr>
        <tr id="filaDetalle" runat="server" align="left" visible="false">
            <td bgcolor="#EEEEEE"></td>
        </tr>
        <tr id="filaBtnTemas" runat="server" align="center" bgcolor="#EEEEEE" visible="false">
            <td>
                <asp:Button ID="btnTemasAud" runat="server" OnClick="btnTemasAud_Click" Text="Volver a Temas de Auditoría" />
            </td>
        </tr>
        </table>
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="btnImformeAud" />
    </Triggers>
</asp:UpdatePanel>
<script type="text/javascript">
    function fnClick(sender, e) {
        __doPostBack(sender, e);
    }
</script>
