<%@ page import="entity.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="tool.Query.*" %>
<%@ page import="tool.Query" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="static tool.Query.getWaiter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/25
  Time: 23:03
  To change this template use File | Settings | File Templates.
--%>
<%

    Map<String, String[]> map =request.getParameterMap() ;
    int mop = Integer.parseInt(map.get("mop")[0]) ; //sử dụng mop option để điều khiển nội dung trang

    Waiter waiter= null ;
    if(mop==4 &&  map.get("waiterID")!=null){
        String waiterid =map.get("waiterID")[0] ;
        waiter =getWaiter(waiterid)   ;// Get waiter bởi ID ;
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Khách sạn</title>
    <link rel="stylesheet" type="text/css" href="/semantic/dist/semantic.min.css">
    <script src="/semantic/dist/jquery.min.js"></script>
    <script src="/semantic/dist/semantic.js"></script>
    <script>
        function sub1() {
            var waiterID = document.getElementById("waiterID").value
            var waiterName = document.getElementById("waiterName").value
            var waiterBirthday = document.getElementById("waiterBirthday").value;
            var waiterIDCard = document.getElementById("waiterIDCard").value
            var waiterPassword = document.getElementById("waiterPassword").value
            var waiterJoinDate = document.getElementById("waiterJoinDate").value
            var waiterPhoneNumber = document.getElementById("waiterPhoneNumber").value
            var remarks = document.getElementById("remarks").value;
            var url = "waiterID=" + waiterID +
                "&waiterName="+waiterName+
                "&waiterBirthday="+waiterBirthday+
                "&waiterIDCard="+waiterIDCard+
                "&waiterPassword="+waiterPassword+
                "&waiterJoinDate="+waiterJoinDate+
                "&waiterPhoneNumber="+waiterPhoneNumber+
                "&remarks="+remarks;
            console.log(url)

            if(/^[a-z0-9A-Z]{1,10}$/.test(waiterID)
                && /^[0-9]{9,17}$/.test(waiterIDCard)
                && /^[a-z0-9A-Z]{1,18}$/.test(waiterPassword)
                && /^0\d{9,11}$/.test(waiterPhoneNumber)
            ){

                window.location.href=encodeURI("/systemManagement/waiterUpdate.jsp?mop=5&" +url);
            }return false ;

        }


        function ensure() {
            var urln = window.location.href.split("&")[1] + "&" +
                window.location.href.split("&")[2] + "&" +
                window.location.href.split("&")[3] + "&" +
                window.location.href.split("&")[4] + "&" +
                window.location.href.split("&")[5] + "&" +
                window.location.href.split("&")[6] + "&" +
                window.location.href.split("&")[7] + "&" +
                window.location.href.split("&")[8];
            window.location.href= encodeURI("/systemManagement/waiterUpdate.jsp?mop=6&" +urln);
        }

        function returnm() {
            window.location.href="/systemManagement/waiterEdit.jsp"
        }

    </script>
</head>
<%@include file="/systemAdmin.jsp"%>
<body>


<div class="pusher">

    <div class="ui container">
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical steps">

                    <div class="<%=(mop<=4)?"active step ":"completed step"%>" >
                        <i class="add user icon"></i>
                        <div class="content">
                            <div class="title">Điền thông tin Sửa</div>
                        </div>
                    </div>

                    <div class="<%=(mop==5)?"active step":(mop==6)?"completed step":"step"%>">
                        <i class="adjust icon"></i>
                        <div class="content">
                            <div class="title">Xác nhận Thông tin Sửa</div>
                        </div>
                    </div>

                    <div class="<%=(mop==6)?"active step ":"step"%>">
                        <i class="minus icon"></i>
                        <div class="content">
                            <div class="title">Hoàn tất thông tin Sửa</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="eleven wide column">
                <%if (mop == 4) {%>

                <form class="ui form" onsubmit="return sub1(this)">
                    <div class="two fields">
                        <div class="field">
                            <label>Mã Nhân viên</label>
                            <input type="text" id="waiterID" name="waiterID" value="<%=(waiter==null)?"":waiter.getWaiterID()%>" placeholder="Mã Nhân viên" readonly="true">
                        </div>
                    </div>
                    <div class="two fields">
                        <div class="field">
                            <label>Tên</label>
                            <input type="text" id="waiterName" name="waiterName" value="<%=(waiter==null)?"":waiter.getWaiterName()%>" placeholder="Tên">
                        </div>
                    </div>
                    <div class="four fields">
                        <div class="six wide field">
                            <label>Ngày tháng năm sinh</label>
                            <%SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                                java.util.Date date = format.parse(waiter.getWaiterBirthday().toString());
                                Date sDate = new Date(date.getTime());
//                                waiter.setWaiterBirthday(sDate);
                            %>
                            <input type="date"  value="<%=(waiter==null)?"":sDate%>"  id="waiterBirthday"/>
                        </div>
                    </div>
                    <div class="two fields">
                        <div class=" field">
                            <label>Card ID</label>
                            <input type="text" id="waiterIDCard" name="waiterIDCard" value="<%=(waiter==null)?"":waiter.getWaiterIDCard()%>"  placeholder="Card ID">
                        </div>
                    </div>
                    <div class="two fields">
                        <div class="field">
                            <label>Mật khẩu</label>
                            <input type="text" id="waiterPassword" value="<%=(waiter==null)?"":waiter.getWaiterPassword()%>"  placeholder="Mật khẩu">
                        </div>
                    </div>
                    <div class="four fields">
                        <div class="six wide field">
                            <label>Ngày bắt đầu làm việc</label>
                            <%
                                java.util.Date jdate = format.parse(waiter.getWaiterJoinDate().toString());
                                Date JDate = new Date(jdate.getTime());
                            %>
                            <input type="date"  value="<%=(waiter==null)?"":JDate%>" id="waiterJoinDate"/>


                        </div>
                    </div>
                    <div class="two fields">
                        <div class="field">
                            <label>Số điện thoại</label>
                            <input type="text" id="waiterPhoneNumber" name="waiterPhoneNumber" value="<%=(waiter==null)?"":waiter.getWaiterPhoneNumber()%>" placeholder="Số điện thoại">
                        </div>
                    </div>
                    <div class="two fields">
                        <div class="field">
                            <label>Ghi chú</label>
                            <input type="text" id="remarks" value="<%=(waiter==null)?"":waiter.getRemarks()%>" placeholder="Ghi chú">
                        </div>
                    </div>
                    <div class="ui right submit floated button" tabindex="0" >Gởi dữ liệu</div>
                </form>
                <%} else if (mop == 5) {%>

                <h2 class="ui dividing header">Xác nhận thông tin vừa Sửa</h2>
                <form class="ui form">
                    <table class="ui table">
                        <%--<thead>--%>
                        <%--<tr>--%>
                        <%--<th class="six wide">Mã Nhân viên</th>--%>
                        <%--</tr></thead>--%>
                        <tbody>
                        <tr>
                            <td>Mã Nhân viên</td>
                            <td ><%=request.getParameter("waiterID")%> </td>
                        </tr>
                        <tr>
                            <td>Tên</td>
                            <td><%= request.getParameter("waiterName")%></td>
                        </tr>
                        <tr>
                            <td>Ngày tháng năm sinh</td>
                            <td><%=request.getParameter("waiterBirthday").toString()%></td>
                        </tr>
                        <tr>
                            <td>Card ID</td>
                            <td><%=request.getParameter("waiterIDCard")%></td>
                        </tr>

                        <tr>
                            <td>Mật khẩu</td>
                            <td><%=request.getParameter("waiterPassword")%></td>
                        </tr>
                        <tr>
                            <td>Ngày bắt đầu làm việc</td>
                            <td><%=request.getParameter("waiterJoinDate").toString()%></td>
                        </tr>
                        <tr>
                            <td>Số điện thoại</td>
                            <td><%=request.getParameter("waiterPhoneNumber")%></td>
                        </tr>
                        <tr>
                            <td>Ghi chú</td>
                            <td><%=request.getParameter("remarks")%></td>
                        </tr>
                        </tbody>
                    </table>

                    <div class="ui button" onClick="ensure()">Xác nhận</div>
                </form>

                <%} else if (mop == 6) {
                    waiter =new Waiter();
                    waiter.setWaiterID(request.getParameter("waiterID"));
//                    out.print(waiter.getWaiterID());
                    waiter.setWaiterName(request.getParameter("waiterName"));
//                    out.print(waiter.getWaiterName());
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date date = format.parse(request.getParameter("waiterBirthday").toString());
                    Date sDate = new Date(date.getTime());
                    waiter.setWaiterBirthday(sDate);
//                    out.print(waiter.getWaiterBirthday());
                    waiter.setWaiterIDCard(request.getParameter("waiterIDCard"));
//                    out.print(waiter.getWaiterIDCard());
                    waiter.setWaiterPassword(request.getParameter("waiterPassword"));
//                    out.print(waiter.getWaiterPassword());
                    java.util.Date Jdate = format.parse(request.getParameter("waiterJoinDate").toString());
                    Date jDate = new Date(Jdate.getTime());
                    waiter.setWaiterJoinDate(jDate);
//                    out.print(waiter.getWaiterJoinDate());
                    waiter.setWaiterPhoneNumber(request.getParameter("waiterPhoneNumber"));
//                    out.print(waiter.getWaiterPhoneNumber());
                    waiter.setRemarks(request.getParameter("remarks"));
//                    out.print(waiter.getRemarks());
                    Query.editWaiter(waiter);
                %>
                <h2 class="ui diving heade">Sửa dữ liệu Thành công</h2>

                <div class="ui right button" onClick="returnm()">Quay về</div>
                <%}%>

            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    $(document).ready(function () {
        $('.ui.form').form({
                //  if(/^[a-z0-9A-Z]{1,10}$/.test(waiterID)
                //                && /^[0-9]{17}[0-9|X]$/.test(waiterIDCard)
                //                && /^[a-z0-9A-Z]{1,18}$/.test(waiterPassword)
                //                && /^1[3|4|5|8][0-9]\d{4,8}$/.test(waiterPhoneNumber)
                //            )
                waiterID: {
                    identifier: 'waiterID',
                    rules: [
                        {
                            type: 'regExp[/^[a-z0-9A-Z]{1,10}$/]',
                            prompt: 'Mã nhân viên không đúng định dạng'
                        }
                    ]
                }
                ,waiterIDCard: {
                    identifier: 'waiterIDCard',
                    rules: [
                        {
                            type: 'regExp[/^[0-9]{9,17}$/]',
                            prompt: 'Card ID không đúng định dạng'
                        }
                    ]
                },waiterPassword: {
                    identifier: 'waiterPassword',
                    rules: [
                        {
                            type: 'regExp[/^[a-z0-9A-Z]{1,18}$/]',
                            prompt: 'Mật khẩu không đúng định dạng'
                        }
                    ]
                }

                ,waiterPhoneNumber: {
                    identifier: 'waiterPhoneNumber',
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
