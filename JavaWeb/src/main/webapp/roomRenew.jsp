<%@ page import="entity.*" %>
<%@ page import="static tool.Query.getAllRooms" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="static tool.Query.searchFullRooms" %>
<%@ page import="static tool.Query.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("utf-8");
    Map<String, String[]> map =request.getParameterMap() ;
    int op = Integer.parseInt(map.get("op")[0]) ; //通过op选项来控制页面显示的内容
    TimeExtension renew=null ;
    if(op==2){
        /**现在获得的只有 Số phòng 和 Gia hạn天数
         * 需要通过Số phòng先获得Tình hình Renew的Mã đơn hàng,
         * 通过Mã đơn hàng获得获得房间编号、房间入住和Ngày hết hạn
         * 通过房间编号获得房间价格
         *
         */
        //查询Mã đơn hàng
        Order order = getOrder(map.get("roomid")[0]);
        String orderid =order.getOrderNumber() ;
        //查询员订单截止时间
        Date olddate = order.getCheckOutTime();
        Date newdate = order.getCheckOutTime();
        Calendar calendar =Calendar.getInstance();
        calendar.setTime(newdate);
        System.out.println(Integer.parseInt(map.get("time")[0]) );
        calendar.add(5, Integer.parseInt(map.get("time")[0]));
        //算出新截止时间
        newdate = new Date(calendar.getTime().getTime()) ;
        //算出 Giá =单价*折扣*天数 ;
        double discount = searchDiscount(order.getCustomerIDCard());

        int price = 1  ;
        renew=new TimeExtension(getRenewNum()+1,orderid,olddate,newdate,(int)(discount*Integer.parseInt(map.get("time")[0])
                *getRoomPrice(order.getRoomNumber()))) ;
        request.getSession().setAttribute("renew",renew);

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

        function fun1() {

            alert("Gia hạn成功,Quay về首页!")
            window.location.href="/ServiceManage?op=4";
        }

        function fun2() {

            var roomid = document.getElementById("roomid").value
            var time = document.getElementById("time").value
            var pat1 = /^[0-9]{6}$/ ;
            var pat2 =/^[1-9][0-9]?$/ ;

            if(pat1.test(roomid) && pat2.test(time)){
                window.location.href="/roomRenew.jsp?op=2&roomid="+roomid+"&time="+time
            }
            return false
        }

    </script>
</head>

<%@include file="/hotelAdmin.jsp"%>


<body>

<div class="pusher">


    <div class="ui container">
        <h2 class="ui header">Gia hạn Phòng</h2>
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical steps">

                    <div class="<%=(op<=1)?"active step ":"completed step"%>" >
                        <i class="building icon"></i>
                        <div class="content">
                            <div class="title">Nhập số phòng</div>
                            <%--<div class="description">Choose your shipping options</div>--%>
                        </div>
                    </div>

                    <div class="<%=(op==2)?"active step ":(op==1)?"step":"completed step"%>">
                        <i class="info icon"></i>
                        <div class="content">
                            <div class="title">Xác nhận thông tin</div>
                            <%--<div class="description">Enter billing information</div>--%>
                        </div>
                    </div>

                </div>
            </div>
            <div class="eleven wide  column" >

                <%  if(op==1){ %>
                <form class="ui form" onsubmit="return fun2(this)">
                    <h4 class="ui dividing header">Lựa chọn Phòng</h4>
                    <div class="four wide column">
                        <label>Room</label>


                        <div class="five wide field">


                            <select class="ui fluid search dropdown" id="roomid" name="roomid">

                                <%
                                    ArrayList<String> list = searchFullRooms();
                                    if(list.size()==0){
                                %>
                                <option value="无房可续">无房可续</option>
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
                    <h4 class="ui dividing header">Thời gian gia hạn</h4>
                    <div class="eight wide field">
                        <label>Time</label>
                        <div class=" fields">
                            <div class="eight wide field">

                                <input type="text" maxlength="8"  placeholder="time" id="time" name="time">
                            </div>
                        </div>

                    </div>
                    <br/>
                    <div class="ui right submit floated button" tabindex="0" >Đặt phòng</div>
                </form>
                <% } else if(op==2){ %>


                <h4 class="ui dividing header">Thông tin Xác nhận</h4>
                <table class="ui table">
                    <thead>
                    <tr><th class="six wide">Name</th>
                        <th class="ten wide">Info</th>
                    </tr></thead>
                    <tbody>
                    <tr>
                        <td>Thông tin Gia hạn</td>
                        <td><%=renew.getOperatingID() %></td>
                    </tr>
                    <tr>
                        <td>Mã đơn hàng</td>
                        <td><%=renew.getOrderNumber() %></td>
                    </tr>
                    <tr>
                        <td>Ngày hết hạn</td>
                        <td><%=renew.getOldExpiryDate() %></td>
                    </tr>
                    <tr>
                        <td>Tổng tiền thanh toán</td>
                        <td><%=renew.getAddedMoney() %></td>
                    </tr>
                    <tr>
                        <td>Ngày hết hạn mới</td>
                        <td><%=renew.getNewExpiryDate() %></td>
                    </tr>
                    </tbody>
                </table>


                <h4 class="ui dividing header">Hoàn tất Thanh toán</h4>
                <div class="ui right floated labeled button" tabindex="0">
                    <a class="ui basic right pointing label">
                        <%-- 去数据库查询价格 * 天数 *相应的折扣 --%>
                        $<%=renew.getAddedMoney() %>
                    </a>
                    <div class="ui right button" onclick="fun1()">
                        <i class="shopping icon"></i> Thanh toán
                    </div>
                </div>
                <%}%>

            </div>
            <%--<h1>欢迎Gia hạn</h1>--%>
            <%--  Gia hạnSố phòng 下拉列表   Gia hạn时长 缴纳金额  Gia hạn要改相应的order表格的Trả phòngngày期 --%>

</body>
</html>
<script>
    $(document).ready(function () {
        $('.ui.form').form({
                // if( /^[0-9]{6}$/.test(room) && /^[1-9][0-9]?$/.test(time) && /^[0-9]{18}$/.test(idcard)
                //         && /^1[3|4|5|8][0-9]\d{4,8}$/.test(phonenumber) ){
                time: {
                    identifier: 'time',
                    rules: [
                        {
                            type: 'regExp[/^[1-9][0-9]?$/]',
                            prompt: 'Thời gian không đúng định dạng'
                        }
                    ]
                }
                ,roomid: {
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
