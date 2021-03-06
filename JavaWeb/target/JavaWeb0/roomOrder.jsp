<%@ page import="entity.*" %>
<%@ page import="static tool.Query.getAllRooms" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="static tool.Query.searchEmptyRooms" %>
<%@ page import="static tool.Query.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("utf-8");
    Map<String, String[]> map =request.getParameterMap() ;
    int op = Integer.parseInt(map.get("op")[0]) ; //通过op选项来控制页面显示的内容
    String roomid ="" ;
    if(map.get("roomid")!=null){
        roomid=map.get("roomid")[0] ;
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
            window.location.href="/roomOrder.jsp?op=1" ;
        }

        function fun4() {
            var room = document.getElementById("roomid").value
            var name = document.getElementById("name").value
            var idcard =document.getElementById("idcard").value.toString()
            var year=idcard.substring(6,10)
            var month = idcard.substring(10,12)
            var day =idcard.substring(12,14)
//            var birthdata = year+'-'+month+'-'+day
            var birthdata = document.getElementById("birthdata").value
            var sex = document.getElementById("sex").value
            var phonenumber = document.getElementById("phonenumber").value
            var time = document.getElementById("time").value
            
            var serviceID_1 = document.getElementById("serviceID_1");
            var serviceID_2 = document.getElementById("serviceID_2");
            var serviceID_3 = document.getElementById("serviceID_3");
            
            
            if( /^[0-9]{6}$/.test(room) && /^[1-9][0-9]?$/.test(time) && /^[0-9]{9,17}$/.test(idcard)
                && /^\d{9,11}$/.test(phonenumber) ){
                var url = "&roomid=" + room + "&name=" + name + "&idcard=" + idcard
                    + "&birthdata=" + birthdata + "&sex=" + sex + "&phonenumber=" + phonenumber + "&time=" + time;
            debugger;
                    if(serviceID_1.checked) {
                        url += "&serviceID_1=" + serviceID_1.value;
                    }
                    if(serviceID_2.checked) {
                        url += "&serviceID_2=" + serviceID_2.value;
                    }
                    if(serviceID_3.checked) {
                        url += "&serviceID_3=" + serviceID_3.value;
                    }

                var url1 = window.location.search.split("&")[1];

                window.location.href = "/ServiceManage?op=1&" + url1 + url;
            }
            return false ;

        }

    </script>

</head><%@include file="hotelAdmin.jsp"%>
<body>
<div class="pusher">
    <div class="ui container">
        <h2 class="ui header">Đặt phòng</h2>
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical steps">

                    <div class="<%=(op<=1)?"active step ":"completed step"%>" >
                        <i class="building icon"></i>
                        <div class="content">
                            <div class="title">Chọn Loại phòng</div>
                            <%--<div class="description">Choose your shipping options</div>--%>
                        </div>
                    </div>

                    <div class="<%=(op==2)?"active step ":(op==1)?"step":"completed step"%>">
                        <i class="user icon"></i>
                        <div class="content">
                            <div class="title">Người dùng đăng ký phòng</div>
                            <%--<div class="description">Enter billing information</div>--%>
                        </div>
                    </div>

                    <div class="<%=(op==3|| op==4)?"active step ":"step"%>">
                        <i class="info icon"></i>
                        <div class="content">
                            <div class="title">Xác nhận thông tin</div>
                            <%--<div class="description">Verify order details</div>--%>
                        </div>
                    </div>
                </div>


            </div>

            <div class="eleven wide  column" >


                <% if(op==1){ %>
                <div class="ui three column grid" >
                    <%

                        ArrayList<RoomTypeAndPrice> allRooms = getAllRooms();

                        for(RoomTypeAndPrice rtp : allRooms){
                            ArrayList<Integer> list = getNumofRoom(rtp.getRoomType());//list [0] is not empty list [1] is empty
                    %>
                    <div class="column">
                        <div class="ui card">
                            <div class="image">
                                <img src=<%=rtp.getUrl()%> >
                            </div>
                            <div class="content">
                                <a class="header"><%=rtp.getRoomType()%></a>
                                <div class="description">
                                    <%=rtp.getDesc()%>
                                </div>
                                <div class="ui right floated statistic">
                                    <div class="value">
                                        <%=list.get(1)%>/<%=list.get(0)%>
                                    </div>
                                    <div class="label">
                                        đã đăng ký/còn_trống
                                    </div>
                                </div>
                            </div>
                            <a class="ui orange right ribbon label" href="<%=list.get(0)==0?"":"/roomOrder.jsp?op=2&roomtype="+rtp.getRoomType()%>">
                                $<%=rtp.getPrice()%>/ngày
                            </a>
                        </div>
                    </div>
                    <% }  %>
                    <%}
                    else if(op==2){
                    %>
                    <form class="ui form" onsubmit="return  fun4(this)" >
                        <h4 class="ui dividing header">Lựa chọn Phòng</h4>
                        <div class="field">
                            <label>Room</label>
                            <div class="two fields">
                                <div class="field">

                                    <select class="ui fluid search dropdown" id="roomid" name="roomid">
                                        <%
                                            String roomtype =request.getParameterMap().get("roomtype")[0].toString() ;
                                            System.out.println(roomtype);
                                            ArrayList<String> list = searchEmptyRooms(roomtype);
                                            for(String str : list){
                                                System.out.println(str);
                                        %>
                                        <option value=<%=str%>
                                                    <% if(str.equals(roomid)){ %>
                                                        selected="selected"
                                                <%}%>
                                        ><%=str%></option>

                                        <%  }  %>


                                    </select>
                                    <%--<input type="text" name="roomid" placeholder="Số phòng">--%>
                                </div>


                            </div>
                        </div>
                        <h4 class="ui dividing header">Thời gian đặt phòng</h4>
                        <div class="field">
                            <label>Số ngày thuê</label>
                            <div class="two fields">
                                <div class="field">
                                    <input type="text" maxlength="5" id="time" name="time" placeholder="Số ngày thuê phòng">

                                </div>
                            </div>
                        </div>
                        <h4 class="ui dividing header">Thông tin cá nhân</h4>
                        <div class="field">
                            <label>Họ tên</label>
                            <div class="two fields">

                                <div class="field">
                                    <input type="text" id="name" name="name" placeholder="Tên">
                                </div>
                            </div>
                        </div>
                        <%--<h4 class="ui dividing header">Billing Information</h4>--%>
                        <div class="fields">
                            <div class="seven wide field">
                                <label>Số CMND</label>
                                <input type="text" id="idcard" name="idcard" maxlength="18" placeholder="Số CMND">
                            </div>
                            <%--<div class="six wide field">--%>
                            <%--<label>Ngày tháng năm sinh</label>--%>
                            <%--&lt;%&ndash;<input type="text" name="card[cvc]" maxlength="3" placeholder="Ngày tháng năm sinh">&ndash;%&gt;--%>
                            <%--<input type="date" value="2018-01-01" id="birthdata"/>--%>
                            <%--</div>--%>
                            <div class="six wide field">
                                <label>Giới tính</label>
                                <div class="two fields">
                                    <div class="field">
                                        <select class="ui fluid search dropdown" id="sex">
                                            <option value="Nam">Nam</option>
                                            <option value="Nữ">Nữ</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="fields">
                            <div class="seven wide field">
                                <label>Số điện thoại</label>
                                <input type="text" id="phonenumber" name="phonenumber" maxlength="16" placeholder="Số điện thoại">
                            </div>
                        </div>
                        <div class="fields">
                            <div class="seven wide field">
                                <label>Ngày sinh</label>
                                <input type="date" value="2018-01-01" value="" id="birthdata" name="birthdata"/>
                            </div>
                        </div>
                            
                        <h4 class="ui dividing header">Dịch vụ Thêm</h4>
                        <div class="fields">
                            <%
                                if (session.getAttribute("hotelID").equals("HOT001")) {
                            %>
                            <input type="checkbox" name="serviceID_1" id="serviceID_1" value="1" />
                            <label><i class="user icon"></i>Giặt ủi 5$</label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="checkbox" name="serviceID_2" id="serviceID_2" value="2" />
                            <label><i class="user icon"></i>Ăn trưa 15$</label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="checkbox" name="serviceID_2" id="serviceID_3" value="3" />
                            <label><i class="user icon"></i>Ăn tối 20$</label>
                            <% } else if (session.getAttribute("hotelID").equals("HOT002")) { %>
                                <input type="checkbox" name="serviceID_1" id="serviceID_1" value="4" />
                                <label><i class="user icon"></i>Giặt ủi 15$</label>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="checkbox" name="serviceID_2" id="serviceID_2" value="5" />
                                <label><i class="user icon"></i>Ăn trưa 55$</label>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="checkbox" name="serviceID_2" id="serviceID_3" value="6" />
                                <label><i class="user icon"></i>Ăn tối 99$</label>
                            <% } %>
                        </div>
                        
                        
                        
                        <div class="ui right submit floated button" tabindex="0"  >Đặt phòng</div>
                    </form>
                    <%}
                    else if(op==3){

                    %>

                    <h4 class="ui dividing header">Thông tin Xác nhận</h4>
                    <table class="ui table">
                        <thead>
                        <tr><th class="six wide">Name</th>
                            <th class="ten wide">Info</th>
                        </tr></thead>
                        <tbody>
                        <%
                            Map<String, String[]> map1 = request.getParameterMap();
                            for(String key :  map1.keySet()) {
                                if(!key.equals("op") ){ %>
                        <tr>

                            <td><%=key%></td>
                            <td><%=map1.get(key)[0].toString()%></td>

                        </tr>
                        <%
                                }
                            } %>
                        </tbody>
                    </table>


                    <h4 class="ui dividing header">Hoàn tất Thanh toán</h4>
                    <div class="ui right floated labeled button" tabindex="0">
                        <a class="ui basic right pointing label">
                            <%-- 去数据库查询价格 * 天数 *相应的折扣 --%>
                            $<%=map.get("pay")[0]%>
                        </a>
                        <div class="ui right button">
                            <i class="shopping icon"></i> <a href="ServiceManage?<%=request.getQueryString()%>">Thanh toán</a>
                        </div>
                    </div>
                    <%} else if (op == 4) {%>
                    <h4 class="ui dividing header">Thanh toán</h4>
                    <div class="ui right button" onclick="returnMainPage()">Quay về</div>
                    <%}%>
                </div>
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
                },idcard: {
                    identifier: 'idcard',
                    rules: [
                        {
                            type: 'regExp[/^[0-9]{9,17}$/]',
                            prompt: 'Card ID không đúng định dạng'
                        }
                    ]
                }

                ,phonenumber: {
                    identifier: 'phonenumber',
                    rules: [
                        {
                            type: 'regExp[/^0\\d{9,11}$/]',
                            prompt: 'Số điện thoại không đúng định dạng'
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
