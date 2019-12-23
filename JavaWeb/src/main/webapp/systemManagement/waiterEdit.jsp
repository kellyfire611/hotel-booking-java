<%@ page import="entity.*" %>
<%@ page import="static tool.Query.getAllRooms" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="static tool.Query.searchEmptyRooms" %>
<%@ page import="tool.Query" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<%--%>
<%--Map<String, String[]> map =request.getParameterMap() ;--%>
<%--int mop = Integer.parseInt(map.get("mop")[0]) ; //sử dụng mop option để điều khiển nội dung trang--%>

<%--%>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Khách sạn</title>
    <link rel="stylesheet" type="text/css" href="/semantic/dist/semantic.min.css">
    <script src="/semantic/dist/jquery.min.js"></script>
    <script src="/semantic/dist/semantic.js"></script>
    <script >

        function sub() {

            alert("Gởi dữ liệu thành công, Quay về trang Danh sách!")
            window.location.href="/systemManagement/waiterShow.jsp"
        }

        function edit(waiterid) {
            window.location.href="/systemManagement/waiterUpdate.jsp?mop=4&waiterID="+waiterid;
        }

        function del(waiterid) {
            var f=confirm("Bạn có chắc chắn muốn Xóa dữ liệu?");
            if(f){

                window.location.href="/systemManagement/waiterShow.jsp?mop=7&waiterID="+waiterid;
            }else{
                alert("Hủy bỏ Xóa dữ liệu");
            }

        }

    </script>

</head>
<%@include file="/systemAdmin.jsp"%>
<body>

<%ArrayList<Waiter> waiters = Query.getAllWaiters();%>
<div class="pusher">
    <div class="ui container">

        <h2 class="ui header">Danh sách Nhân viên</h2>
        <table class="ui selectable celled table">
            <thead>
            <tr class="center aligned"><th name="waiterID">Mã Nhân viên</th>
                <th name="waiterName">Tên</th>
                <th name="waiterBirthday">Ngày sinh</th>
                <th name="waiterIDCard">Card ID</th>
                <th name="waiterPassword">Mật khẩu</th>
                <th name="waiterJoinDate">Ngày bắt đầu làm việc</th>
                <th name="waiterPhoneNumber">Số điện thoại</th>
                <th name="remarks">Ghi chú</th>
                <th></th>
                <th></th>
            </tr></thead>
            <tbody>
            <%for (int i=0;i<waiters.size();i++) {%>
            <tr class="center aligned">
                <td>
                    <%=(waiters.get(i).getWaiterID())%>
                </td>
                <td>
                    <%out.print(waiters.get(i).getWaiterName());%>
                </td>
                <td>
                    <% out.print(waiters.get(i).getWaiterBirthday().toString());%>
                </td>
                <td>
                    <%out.print(waiters.get(i).getWaiterIDCard());%>
                </td>
                <td>
                    <%out.print(waiters.get(i).getWaiterPassword());%>
                </td>
                <td>
                    <%out.print(waiters.get(i).getWaiterJoinDate().toString());%>
                </td>
                <td>
                    <%out.print(waiters.get(i).getWaiterPhoneNumber());%>
                </td>
                <td>
                    <%out.print(waiters.get(i).getRemarks());%>
                </td>

                <td>
                    <div class="ui button" tabindex="0"  onclick="edit('<%=(waiters.get(i).getWaiterID())%>')">Sửa</div>
                </td>
                <td>
                    <div class="ui button" tabindex="0" onclick="del('<%=(waiters.get(i).getWaiterID())%>')">Xóa</div>
                </td>
            </tr>
            <%}%>

            </tbody>
            <tfoot>
            </tfoot>
        </table>
    </div>
</div>

</body>
</html>
