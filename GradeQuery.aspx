﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GradeQuery.aspx.cs" Inherits="GradeQuery" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="text-align:center">
    <form id="form1" runat="server">
    <div style="text-align: center">
        <label style="font-size: x-large; font-weight: 600;">教师成绩查询</label></div>
    <p>
    <asp:Label ID="TIDNameLabel" runat="server" Text="Label"></asp:Label>
    </p>
    <asp:GridView ID="TGradeGView" runat="server" CellPadding="4" 
        ForeColor="#333333" GridLines="None" HorizontalAlign="Center">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <br />
    <br />
    
    </form>
    <a href="javascript:history.go(-1);">返回菜单</a>&nbsp; <a href="Index.aspx">退出登录</a>
</body>
</html>
