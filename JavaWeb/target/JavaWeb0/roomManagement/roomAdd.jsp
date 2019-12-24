<%--
  Created by IntelliJ IDEA.
  User: lhsangyf
  Date: 2017/12/26
  Time: 08:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.*" %>
<%@ page import="static tool.Query.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="config.GCON" %>
<%@ page import="java.util.Map" %>
<%@ page import="tool.Query" %>
<%
response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("utf-8");
    Map<String, String[]> map = request.getParameterMap() ;
    int op = Integer.parseInt(map.get("op")[0]) ; //通过op选项来控制页面显示的内容
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Phòng</title>
    <script>

        function returnMainPage() {
            window.location.href="/roomManagement/roomAdd.jsp?op=2";
        }

        function submitNewRoomInfo() {

            var roomNumber = document.getElementById("roomNumber").value;
            var roomType = document.getElementById("roomType").value;
            var remarks = document.getElementById("remarks").value;
            if( /^[0-9]{6}$/.test(roomNumber)){
                var url = "&roomNumber=" + roomNumber + "&roomType=" + roomType + "&remarks=" + remarks;
                window.location.href = "/roomManagement/roomAdd.jsp?op=3" + url;
            }
            return false ;
        }

        function ensureButtonClicked() {

            // var roomnumber = document.getElementById('roomNumber')
            // var roomtype= document.getElementById('roomType')

            var urlNew = window.location.href.split("&")[1] + "&" + window.location.href.split("&")[2]
                + "&" + window.location.href.split("&")[3];

            window.location.href = "/roomManagement/roomAdd.jsp?op=4&" + urlNew;


        }

    </script>

</head>
<%@include file="/hotelAdmin.jsp"%>
<body>

<div class="pusher">

    <div class="ui container">
        <h2 class="ui header">Thêm Phòng</h2>
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical steps">

                    <div class="<%=(op == 2) ? "active step ":"completed step"%>" >
                        <i class="add circle icon"></i>
                        <div class="content">
                            <div class="title">Thông tin Phòng</div>
                        </div>
                    </div>

                    <div class="<%=(op == 3) ? "active step ":(op== 2)?"step":"completed step"%>">
                        <i class="check circle icon"></i>
                        <div class="content">
                            <div class="title">Thông tin Xác nhận</div>
                        </div>
                    </div>

                </div>

            </div>

            <div class="eleven wide  column" >

                <%//Thêm Phòng信息
                    if (op == 2) {
                %>
                <form class="ui form" onsubmit="return submitNewRoomInfo(this)">
                    <h2 class="ui dividing header">Nhập thông tin Thêm mới Phòng</h2>
                    <div class="two fields">
                        <div class="field">
                            <label>Số phòng</label>
                            <input type="text" id="roomNumber" name="roomid" placeholder="Nhập số phòng">
                        </div>
                        <div class="field">
                            <label>Loại phòng</label>
                            <% ArrayList<RoomTypeAndPrice> rooms = getAllRooms();%>
                            <select class="ui fluid dropdown" id="roomType">
                                <%for(RoomTypeAndPrice room :rooms){%>
                                <option value=<%=room.getRoomType()%>><%=room.getRoomType()%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                    <div class="field">
                        <label>Ghi chú</label>
                        <input type="text" id="remarks" placeholder="Nhập Ghi chú">
                    </div>
                    <div class="ui submit button">Gởi dữ liệu</div>
                </form>

                <%} else if (op == 3) {
                %>

                <h2 class="ui dividing header">待Thêm PhòngThông tin Xác nhận</h2>
                <form class="ui form">
                    <table class="ui table">
                        <thead>
                        <tr><th class="six wide">Số phòng</th>
                            <th class="six wide">Loại phòng</th>
                            <th class="six wide">Ghi chú</th>
                        </tr></thead>
                        <tbody>
                        <tr>
                            <td><%=request.getParameter("roomNumber")%></td>
                            <td><%=request.getParameter("roomType")%></td>
                            <td><%=request.getParameter("remarks")%></td>
                        </tr>
                        </tbody>
                    </table>

                    <div class="ui button" onclick="ensureButtonClicked()">Xác nhận</div>
                </form>

                <%} else if (op == 4) {
                    Room newRoom = new Room();
                    newRoom.setRoomStatus("còn_trống");
                    newRoom.setRoomNumber(request.getParameter("roomNumber"));
                    newRoom.setRoomType(request.getParameter("roomType"));
                    newRoom.setRemarks(request.getParameter("remarks"));
                    Query.insertRoom(newRoom);
                %>
                <h4 class="ui dividing header">Thêm mới dữ liệu Thành công</h4>
                <div class="ui right button" onclick="returnMainPage()">Quay về</div>
                <%}%>
            </div>
        </div>
    </div>

    <%--<h1>欢迎Quản trị Khách sạnĐăng nhập！</h1>--%>

</div>

</body>
</html>
<script>
    $(document).ready(function () {
        $('.ui.form').form({
                // if( /^[0-9]{6}$/.test(room) && /^[1-9][0-9]?$/.test(time) && /^[0-9]{18}$/.test(idcard)
                //         && /^1[3|4|5|8][0-9]\d{4,8}$/.test(phonenumber) ){
                roomid: {
                    identifier: 'roomid',
                    rules: [
                        {
                            type: 'regExp[/^[0-9]{6}$/]',
                            prompt: 'Số phòng không đúng định dạng'
                        }
                    ]
                }

            }, {

                inline : true,
                on     : 'submit'

            }
        )

        ;
    });
</script>