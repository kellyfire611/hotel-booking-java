<%@ page import="entity.*" %>
<%@ page import="static tool.Query.getAllRooms" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="static tool.Query.searchFullRooms" %>
<%@ page import="static tool.Query.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("utf-8");
    Map<String, String[]> map =request.getParameterMap() ;
    int op = Integer.parseInt(map.get("op")[0]) ; //通过op选项来控制页面显示的内容
    Order order =null ;
    if(op==2){
        System.out.println("房间编号:"+map.get("roomid")[0]);
        order =getOrder(map.get("roomid")[0]) ;
        System.out.println("订单编号:"+order.getOrderNumber());
    }
%>
<html>
<head>
    <meta charset="UTF-8">
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
    <script >
        function returnMainPage() {
            window.location.href="/roomCheckOut.jsp?op=1";
        }
        function fun() {
            var roomid =  document.getElementById("roomid").value ;
            var pat1 = /^[0-9]{6}$/ ;

            if( pat1.test(roomid) ){
                window.location.href="/roomCheckOut.jsp?op=2&roomid="+roomid
            }
            return false ;
        }
    </script>
</head>



<%@include file="/hotelAdmin.jsp"%>
<body>

<div class="pusher">


    <div class="ui container">
        <h2 class="ui header">Trả phòng</h2>
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical steps">

                    <div class="<%=(op<=1)?"active step ":"completed step"%>" >
                        <i class="building icon"></i>
                        <div class="content">
                            <div class="title">Nhập số phòng</div>

                        </div>
                    </div>

                    <div class="<%=(op==2)?"active step ":(op==1)?"step":"completed step"%>">
                        <i class="info icon"></i>
                        <div class="content">
                            <div class="title">Thông tin xác nhận</div>
                            <%--<div class="description">Enter billing information</div>--%>
                        </div>
                    </div>

                </div>
            </div>
            <div class="eleven wide  column" >

                <%  if(op==1){ %>
                <form class="ui form" onsubmit="return fun(this)">
                    <h4 class="ui dividing header">Lựa chọn Phòng</h4>
                    <div class="four wide column">
                        <label>Room</label>

                        <div class="five wide field">

                            <select class="ui fluid search dropdown" id="roomid">

                                <%
                                    ArrayList<String> list = searchFullRooms();
                                    if(list.size()==0){
                                %>
                                <option value="Không tim thấy phòng Checkout">Không tim thấy phòng Checkout</option>
                                <%
                                    }
                                    for(String str : list){
                                %>
                                <option value=<%=str%>> <%=str%> </option>
                                <% } %>
                            </select>
                            <%--<input type="text" name="roomid" placeholder="Số phòng">--%>
                        </div>
                    </div>
                    <br/>
                    <div class="ui right submit floated button" tabindex="0" >Submit</div>
                </form>
                <% }
                else if(op==2){%>

                <%--  Số phòng 居住时间  --%>

                <h4 class="ui dividing header">Thông tin xác nhận</h4>
                <table class="ui table">
                    <thead>
                    <tr><th class="six wide">Name</th>
                        <th class="ten wide">Info</th>
                    </tr></thead>
                    <tbody>

                    <tr>

                        <td>订单编号</td>
                        <td><%=order.getOrderNumber()%></td>

                    </tr>
                    <tr>

                        <td>住户Card ID</td>
                        <td><%=order.getCustomerIDCard()%></td>

                    </tr>
                    <tr>

                        <td>房号</td>
                        <td><%=order.getRoomNumber()%></td>

                    </tr>
                    <tr>

                        <td>订单生成时间</td>
                        <td><%=order.getOrderTime()%></td>

                    </tr>
                    <tr>

                        <td>Ngày vào</td>
                        <td><%=order.getCheckInTime()%></td>

                    </tr>
                    <tr>

                        <td>Trả phòng时间</td>
                        <td><%=order.getCheckOutTime()%></td>

                    </tr>
                    <tr>

                        <td>服务人员编号</td>
                        <td><%=order.getWaiterID()%></td>

                    </tr>
                    <tr>

                        <td>订单总金额(含Gia hạn)</td>
                        <td><%=order.getTotalMoney()%></td>

                    </tr>
                    <tr>

                        <td>Ghi chú</td>
                        <td><%=order.getRemarks()%></td>

                    </tr>
                    </tbody>
                </table>


                <h4 class="ui dividing header">完成Trả phòng</h4>

                <div class="ui right button" >
                    <%--<% if(op==2)System.out.println("打印订单编号:"+order.getOrderNumber() );%>--%>
                    <%--<a href="ServiceManage?op=5&orderNumber=<%=order.getOrderNumber()%>">Xác nhậnTrả phòng</a>--%>
                    <a href="/roomCheckOut.jsp?op=3&orderNumber=<%=order.getOrderNumber()%>">Xác nhậnTrả phòng</a>
                </div>
                <%}else if (op == 3) {
                    String orderNumber= map.get("orderNumber")[0] ;
                    System.out.println("订单:"+orderNumber);
                    checkOutRoom(orderNumber) ;
                %>
                <h4 class="ui dividing header">Trả phòng成功</h4>
                <div class="ui right button" onclick="returnMainPage()">Quay về</div>
                <%}%>
            </div>
            <%--<h1>欢迎Gia hạn</h1>--%>
            <%--  Gia hạnSố phòng 下拉列表   Gia hạn时长 缴纳金额  --%>

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
