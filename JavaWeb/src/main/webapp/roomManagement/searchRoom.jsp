<%@ page import="java.util.Map" %>
<%@ page import="static tool.Query.searchRoom" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <%
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("utf-8");
        Map<String, String[]> map =request.getParameterMap() ;
        String size1="" ,size2="" ,size3="" ;
        if( map.get("size1")!=null ){
             size1 = map.get("size1")[0] ;
         }
        if( map.get("size2")!=null ){
            size2 = map.get("size2")[0] ;
        }
        if( map.get("size3")!=null ){
            size3 = map.get("size3")[0] ;
        }
        //System.out.println(size1+" "+size2+" "+size3);
        ArrayList<RoomTypeAndPrice>list =searchRoom(size1,size2,size3) ;
//        for (RoomTypeAndPrice rp : list){
//            System.out.println(rp.getRoomType());
//        }


        String rs1[] = {"Đơn","Đôi","Tất_cả"}  ;
        String rs2[] = {"Tiêu_chuẩn","Doanh_nhân","VIP","Tất_cả"}  ;
        String rs3[] = {"0-200","200-300","300-400","400-600","Tất_cả"}  ;
        // 筛选出类型 放在一个集合里  然后遍历  ;
    %>
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
    <script>
        function fun() {
            var obj = document.getElementsByName("size1");//选择所有name="id"的对象，Quay về数组
            var v='';//如果这样定义var v;变量v中会默认被赋个null值
            for(var i=0;i<obj.length;i++){
                if(obj[i].checked) {//取到对象数组后，我们来循环检测它是不是被选中
                    v+=('size1='+obj[i].value);
                }  //如果选中，将value添加到变量v中
            }
             obj = document.getElementsByName("size2");//选择所有name="id"的对象，Quay về数组
           //如果这样定义var v;变量v中会默认被赋个null值
            for(var i=0;i<obj.length;i++){
                if(obj[i].checked) {//取到对象数组后，我们来循环检测它是不是被选中
                    v+=('&size2='+obj[i].value);
                }  //如果选中，将value添加到变量v中
            }
             obj = document.getElementsByName("size3");//选择所有name="id"的对象，Quay về数组
            //如果这样定义var v;变量v中会默认被赋个null值
            for(var i=0;i<obj.length;i++){
                if(obj[i].checked) {//取到对象数组后，我们来循环检测它是不是被选中
                    v+=('&size3='+obj[i].value);
                }  //如果选中，将value添加到变量v中
            }

            // alert('/searchRoom.jsp?'+v);
            window.location.href='/roomManagement/searchRoom.jsp?'+v
        }
    </script>

    <script>
        $(document).ready(function(){
            $('.ui.accordion')
                .accordion()
            ;
        });
    </script>

</head>

<%@include file="/hotelAdmin.jsp"%>
<body>

<div class="pusher">

    <div class="ui container">
        <h2 class="ui header">Tìm kiếm Phòng theo yêu cầu</h2>
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical  menu">
                    <div class="item">
                        <a class="active title">
                            <i class="dropdown icon"></i>
                            Số lượng
                        </a>
                        <div class="active content">
                            <div class="ui form">
                                <div class="grouped fields">
                                    <%for (String s : rs1){%>
                                    <div class="field">
                                        <div class="ui radio checkbox">
                                            <input type="radio" name="size1" value=<%=s%>  <%=s.equals(size1)?"checked":""%> onclick="fun()">
                                            <label><%=s%></label>
                                        </div>
                                    </div>
                                    <%}%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <a class="active title">
                            <i class="dropdown icon"></i>
                            Hạng phòng
                        </a>
                        <div class="active content">
                            <div class="ui form">
                                <div class="grouped fields">
                                    <%for (String s : rs2){%>
                                    <div class="field">
                                        <div class="ui radio checkbox">
                                            <input type="radio" name="size2" value=<%=s%>  <%=s.equals(size2)?"checked":""%> onclick="fun()">
                                            <label><%=s%></label>
                                        </div>
                                    </div>
                                    <%}%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <a class="active title">
                            <i class="dropdown icon"></i>
                            Giá
                        </a>
                        <div class="active content">
                            <div class="ui form">
                                <div class="grouped fields">
                                    <%for (String s : rs3){%>
                                    <div class="field">
                                        <div class="ui radio checkbox">
                                            <input type="radio" name="size3" value=<%=s%>  <%=s.equals(size3)?"checked":""%> onclick="fun()">
                                            <label><%=s%></label>
                                        </div>
                                    </div>
                                    <%}%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>

            <div class="eleven wide  column" >

                <div class="ui divided items">

                    <%for( RoomTypeAndPrice rtp : list){%>
                    <div class="item">
                        <div class="image">
                            <img src=<%=rtp.getUrl()%> >
                        </div>
                        <div class="content">
                            <a class="header"><%=rtp.getRoomType()%></a>
                            <div class="meta">
                                <a class="ui teal tag label ">$<%=rtp.getPrice()%></a>
                            </div>
                            <div class="description">
                                <p><%=rtp.getDesc()%></p>
                            </div>
                            <div class="extra">
                                <div class="ui right floated  button">
                                    <a href="/roomOrder.jsp?op=2&roomtype=<%=rtp.getRoomType()%>">Đặt phòng</a>
                                    <i class="right chevron icon"></i>
                                </div>
                                <%--<div class="ui label">限制的</div>--%>
                            </div>
                        </div>
                    </div>
                    <%}%>
                </div>

            </div>
        </div>
    </div>
</div>

</body>
</html>