<%@ page import="entity.*" %>
<%@ page import="static tool.Query.getAllRooms" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="config.GCON" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="tool.DataBase" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("utf-8");
    if (session.getAttribute("hoteladmin") == null) {
        response.sendRedirect("/index.jsp");
    }


    if(GCON.status==1){ //Hiệu chỉnh Quyền
        DataBase.setConnection(DataBase.MAP.get(GCON.HOTELUSERNAME));
        GCON.status=0 ;
    }
%>
<html>

<head>

    <meta charset="UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <title>Quản lý Khách sạn</title>
    <link rel="stylesheet" type="text/css" href="/semantic/dist/semantic.min.css">
    <script src="/semantic/dist/jquery.min.js"></script>
    <script src="/semantic/dist/semantic.js"></script>
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/reset.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/site.css">

    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/container.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/divider.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/grid.css">

    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/header.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/segment.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/table.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/icon.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/menu.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/message.css">

    <style type="text/css">
        h2 {
            margin: 1em 0em;
        }
        .ui.container {
            padding-top: 5em;
            padding-bottom: 5em;
        }
    </style>

    <script>
        var i=0;
        function myDate(){
            var now=new Date();
            var year=now.getFullYear();
            var month=now.getMonth()+1;
            var day=now.getDate();
            var hours=now.getHours();
            var minutes=now.getMinutes();
            var seconds=now.getSeconds();
            document.getElementById("div").innerHTML=year+"năm"+fix(month, 2)+"tháng"+fix(day, 2)+"ngày"+fix(hours, 2)+" : "+fix(minutes, 2)+" : "+fix(seconds, 2);
        }

        function fix(num, length) {
            return ('' + num).length < length ? ((new Array(length + 1)).join('0') + num).slice(-length) : '' + num;
        }
        setInterval(myDate,1000);
    </script>

</head>
<body>
<div class="ui inverted menu">

    <div class="ui simple dropdown item">
        <i class="tasks icon"></i>
        Nghiệp vụ
        <i class="dropdown icon"></i>
        <div class="menu">
            <a class="item" href="/roomOrder.jsp?op=1"><i class="arrow right icon"></i>Đặt phòng</a>
            <a class="item" href="/roomRenew.jsp?op=1"><i class="spinner icon"></i>Gia hạn</a>
            <a class="item" href="/roomCheckOut.jsp?op=1"><i class="arrow left icon"></i>Trả phòng</a>
        </div>
    </div>
    <div class="ui simple dropdown item">
        <i class="building icon"></i>
        Quản lý Phòng
        <i class="dropdown icon"></i>
        <div class="menu">
            <a class="item" href="/RoomManage?op=1"><i class="search icon"></i>Kiểm tra Phòng</a>
            <a class="item" href="/RoomManage?op=2"><i class="plus icon"></i>Thêm mới Phòng</a>
            <a class="item" href="/roomManagement/roomDisplay.jsp"><i class="zoom out icon"></i>Tổng quan Phòng</a>
        </div>
    </div>
    <div class="ui simple dropdown item">
        <i class="browser icon"></i>
        Thống kê
        <i class="dropdown icon"></i>
        <div class="menu">
            <a class="item" href="/OrderManage?op=1"><i class="book icon"></i>Tình hình Đặt phòng</a>
            <a class="item" href="/OrderManage?op=2"><i class="file icon"></i>Tình hình Check-in</a>
            <a class="item" href="/OrderManage?op=3"><i class="file text outline icon"></i>Tình hình Renew</a>
            <a class="item" href="/OrderManage?op=4"><i class="file archive outline icon"></i>Lịch sử Đặt phòng</a>
            <a class="item" href="/OrderManage?op=5"><i class="folder open icon"></i>Tất cả</a>
        </div>
    </div>
    <div class="right menu">
        <div class="ui simple dropdown item">
            <div id="div"></div>
        </div>
    </div>

    <div class="right menu">
        <div class="ui simple dropdown item">
            <i class="user icon"></i>
            <%="Quản trị Khách sạn: " + session.getAttribute("hoteladmin")%>  <%-- 后期换成session("name")  --%>
            <i class="dropdown icon"></i>
            <div class="menu">
                <a class="item" href="/ServiceManage?op=2"><i class="sign out icon"></i>Đăng xuất</a>
            </div>
        </div>
    </div>

</div>

</body>
</html>