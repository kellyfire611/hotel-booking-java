<%@ page import="display.OrderView" %>
<%@ page import="tool.Query" %>
<%@ page import="entity.Waiter" %>
<%@ page import="entity.Order" %>
<%@ page import="display.RoomCountView" %>
<%@ page import="entity.Room" %>
<%@ page import="display.RoomCountValue" %>
<%@ page import="display.InComeView" %>
<%@ page import="tool.TraverseDate" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: lhsangyf
  Date: 2018/1/5
  Time: 13:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    //Tình hình Đặt phòng数量
    int bookedOrderNumber = 0;
    //Tình hình Check-in数量
    int checkInOrderNumber = 0;
    //Trả phòng订单数量
    int checkOutOrderNumber = 0;
    //Tình hình Renew数量
    int timeExtensionOrderNumber = Query.getAllTimeExtensionOrders().size();
    //订单视图
    ArrayList<OrderView> allOrders = Query.getAllOrderViews("");

    for (int i = 0; i < allOrders.size(); i++) {
        if (allOrders.get(i).getOrderStatus().equals("Đã_đăng_ký")) {
            checkInOrderNumber++;
        } else if (allOrders.get(i).getOrderStatus().equals("Đã_thanh_toán")) {
            checkOutOrderNumber++;
        } else if (allOrders.get(i).getOrderStatus().equals("已预订")) {
            bookedOrderNumber++;
        }
    }


//--------------酒店不同Loại phòngĐặt phòng数量时间线------------------ //

    ArrayList<String> weekRoomType = new ArrayList<String>();

    weekRoomType.add("HT1-Doanh_nhân_(Đơn/Đôi)");
    weekRoomType.add("HT1-Nữ_hoàng_(Đơn/Đôi)");
    weekRoomType.add("HT1-Tiêu_chuẩn_(Đơn)");
    weekRoomType.add("HT1-Tiêu_chuẩn_(Đôi)");
    weekRoomType.add("HT1-VIP_(Đơn/Đôi)");
    //获取所有的订单，view根据视图倒序排列
    ArrayList<OrderView> weekView = Query.getAllOrderViews("");

    //String weekBeginDate = weekView.get(weekView.size() - 1).getOrderTime().toString();
    //String weekEndDate = weekView.get(0).getOrderTime().toString();
    String weekBeginDate = "2019-12-16";
    String weekEndDate = "2019-12-30";

    ArrayList<String> orderDateSequence = (ArrayList<String>)TraverseDate.getEveryday(weekBeginDate, weekEndDate);
    //ngày期->房间->Đặt phòng数量
    TreeMap<String, TreeMap<String, Integer>> weekData =  new TreeMap<String, TreeMap<String, Integer>>();

    for (int i = 0; i < orderDateSequence.size(); i++) {
        String dt = orderDateSequence.get(i);
        weekData.put(dt, new TreeMap<String, Integer>());
        for (int j = 0; j < weekRoomType.size(); j++) {
            weekData.get(dt).put(weekRoomType.get(j), 0);
        }
    }

    for (int i = 0; i < weekView.size(); i++) {
        String dt = weekView.get(i).getOrderTime().toString();
        String tp = weekView.get(i).getRoomType().toString();
        if (weekData.containsKey(dt) && weekData.get(dt).containsKey(tp)) {
            int oldn = weekData.get(dt).get(tp).intValue();
            weekData.get(dt).put(tp, oldn + 1);
        }
    }

    //生成画图数据
    ArrayList<String> genWeekDate = new ArrayList<String>();
    for (int i = 0; i < orderDateSequence.size(); i++) {
        genWeekDate.add("'" + orderDateSequence.get(i) + "'");
    }

    ArrayList<Integer> r0 = new ArrayList<Integer>();
    ArrayList<Integer> r1 = new ArrayList<Integer>();
    ArrayList<Integer> r2 = new ArrayList<Integer>();
    ArrayList<Integer> r3 = new ArrayList<Integer>();
    ArrayList<Integer> r4 = new ArrayList<Integer>();
    ArrayList<String> genrp = new ArrayList<String>();

    for (int i = 0; i < weekRoomType.size(); i++) {
        genrp.add("'" + weekRoomType.get(i) + "'");
    }



    for (String key : weekData.keySet()) {
        r0.add(weekData.get(key).get(weekRoomType.get(0)));
        r1.add(weekData.get(key).get(weekRoomType.get(1)));
        r2.add(weekData.get(key).get(weekRoomType.get(2)));
        r3.add(weekData.get(key).get(weekRoomType.get(3)));
        r4.add(weekData.get(key).get(weekRoomType.get(4)));
    }





//---------------------------------------------//
    //Nhân viên绩效
    HashMap<String, Integer> waiterCommission = new HashMap<String, Integer>();

    ArrayList<Waiter> allWaiters = Query.getAllWaiters();

    for (int i = 0; i < allWaiters.size(); i++) {
        waiterCommission.put(allWaiters.get(i).getWaiterName(), new Integer(0));
    }
    //获取所有的订单
    ArrayList<Order> orders = Query.getAllOrders();

    for (int i = 0; i < orders.size(); i++) {
        String wi = orders.get(i).getWaiterID();
        String wn = Query.getWaiter(wi).getWaiterName();
        if (waiterCommission.containsKey(wn)) {
            int old = waiterCommission.get(wn).intValue();
            //更新value
            System.out.println("---------------------++++++");
            waiterCommission.put(wn, new Integer(old + 1));
        }
    }

    ArrayList<String> waiterNameArray = new ArrayList<String>();

    ArrayList<Integer> waiterCommissionArray = new ArrayList<Integer>();

    for (String key : waiterCommission.keySet()) {
        waiterNameArray.add("'" + key + "'");
        waiterCommissionArray.add(waiterCommission.get(key));
    }
//---------------------------------------------------------------------------//
    //查询各种房间数量
//    ArrayList<RoomCountView> roomCountViews = Query.getAllRoomCountView();
//    String s = "";
    ArrayList<Room> roomsNew = Query.getAllRoomsInfo("", "");

//    out.print(rooms);

    HashMap<String, RoomCountValue> roomCounts = new HashMap<String, RoomCountValue>();

    for (int i = 0; i < roomsNew.size(); i++) {
        if (!roomCounts.containsKey(roomsNew.get(i).getRoomType())) {
            roomCounts.put(roomsNew.get(i).getRoomType(), new RoomCountValue(0, 0));
        }
        if (roomsNew.get(i).getRoomStatus().equals("còn_trống")) {
            int oldEmpy = roomCounts.get(roomsNew.get(i).getRoomType()).getEmptyNum();
            int oldFull = roomCounts.get(roomsNew.get(i).getRoomType()).getFullNum();
            roomCounts.put(roomsNew.get(i).getRoomType(), new RoomCountValue(oldEmpy + 1, oldFull));
        }
        if (roomsNew.get(i).getRoomStatus().equals("đã_có_người_thuê")) {
            int oldEmpy = roomCounts.get(roomsNew.get(i).getRoomType()).getEmptyNum();
            int oldFull = roomCounts.get(roomsNew.get(i).getRoomType()).getFullNum();
            roomCounts.put(roomsNew.get(i).getRoomType(), new RoomCountValue(oldEmpy, oldFull + 1));
        }

    }

    ArrayList<String> roomType = new ArrayList<String>();

    ArrayList<Integer> roomNumEmpty = new ArrayList<Integer>();

    ArrayList<Integer> roomNumFull = new ArrayList<Integer>();

    for (String key : roomCounts.keySet()) {
        roomType.add("'" + key + "'");
        roomNumEmpty.add(roomCounts.get(key).getEmptyNum());
        roomNumFull.add(roomCounts.get(key).getFullNum());
    }

    //盈利折线图，每ngày订单数以及营收
    ArrayList<InComeView> allIncomeViews = Query.getInComeView();
    String beginDate = allIncomeViews.get(0).getDate().toString();
    String endDate = allIncomeViews.get(allIncomeViews.size() - 1).getDate().toString();

    //保存原始数据
    Map<String, InComeView> incomeDatas = new TreeMap<String, InComeView>();

    //得到正确的ngày期序列，保存ngày期
    ArrayList<String> xDate = (ArrayList<String>)TraverseDate.getEveryday(beginDate, endDate);

    for (String d : xDate) {
        incomeDatas.put(d, new InComeView(d, 0, 0));
    }
    //ngày期自动排序
    for (int i = 0; i < allIncomeViews.size(); i++) {
        if (incomeDatas.containsKey(allIncomeViews.get(i).getDate())) {
            incomeDatas.put(allIncomeViews.get(i).getDate(), new InComeView(allIncomeViews.get(i).getDate(),
                    allIncomeViews.get(i).getAllPrice(),
                    allIncomeViews.get(i).getCheckOutNumber()));
        }
    }

    //map数据提取完毕，传入数组
    ArrayList<String> xincomeDate = new ArrayList<String>();
    ArrayList<Integer> incomeOrders = new ArrayList<Integer>();
    ArrayList<Integer> incomeMoney = new ArrayList<Integer>();

    for (String key : incomeDatas.keySet()) {
        xincomeDate.add("'" + key + "'");
        incomeOrders.add(incomeDatas.get(key).getCheckOutNumber());
        incomeMoney.add(incomeDatas.get(key).getAllPrice());
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Báo cáo Thống kê</title>
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

    <script src="/echarts/echarts.js"></script>
</head>

<%@include file="/systemAdmin.jsp"%>
</body>

<%--<div class="pusher">--%>
    <div class="ui fluid container">

        <div class="ui column grid">
            <%--//订单统计--%>
            <div class="nine wide">

                <%--<div id="ods" style="width: 520px;height:280px;"></div>--%>
                <%--<script type="text/javascript">--%>
                    <%--// 基于准备好的dom，初始化echarts实例--%>
                    <%--var orderChart = echarts.init(document.getElementById('ods'));--%>

                    <%--// 指定图表的配置项和数据--%>
                    <%--var waiterOption = {--%>
                        <%--title: {--%>
                            <%--text: '订单统计'--%>
                        <%--},--%>
                        <%--tooltip: {},--%>
                        <%--legend: {--%>
                            <%--data:['订单量']--%>
                        <%--},--%>
                        <%--xAxis: {--%>
                            <%--data: ["已预订", "Đã_đăng_ký","Đã_thanh_toán","Gia hạn"]--%>
                        <%--},--%>
                        <%--yAxis: {},--%>
                        <%--series: [{--%>
                            <%--name: '订单量',--%>
                            <%--type: 'bar',--%>
                            <%--data: [<%=bookedOrderNumber%>, <%=checkInOrderNumber%>, <%=checkOutOrderNumber%>, <%=timeExtensionOrderNumber%>]--%>
                        <%--}]--%>
                    <%--};--%>
                    <%--// 使用刚指定的配置项和数据显示图表。--%>
                    <%--orderChart.setOption(waiterOption);--%>
                <%--</script>--%>
                <div id="weekTypeNum" style="width:100%;height:36%;"></div>

                <script>
                    var mainContainerweekTypeNum = document.getElementById("weekTypeNum");
		var resizeMainContainerweekTypeNum = function () {
			mainContainerweekTypeNum.style.width = window.innerWidth+'px';
			mainContainerweekTypeNum.style.height = window.innerHeight*0.8+'px';
		};
		resizeMainContainerweekTypeNum();
		var weekChart = echarts.init(mainContainerweekTypeNum);
		

                    
//                    var weekChart = echarts.init(document.getElementById("weekTypeNum"));
                    weekChartOption = {
                        title: {
                            text: '',
                            x:'left',
                        },
                        tooltip : {
                            trigger: 'axis',
                            axisPointer: {
                                type: 'cross',
                                label: {
                                    backgroundColor: '#6a7985'
                                }
                            }
                        },
                        legend: {
                            data: <%=genrp%>
                        },
                        grid: {
                            left: '3%',
                            right: '4%',
                            bottom: '3%',
                            containLabel: true
                        },
                        xAxis : [
                            {
                                type : 'category',
                                boundaryGap : false,
                                data : <%=genWeekDate%>
                            }
                        ],
                        yAxis : [
                            {
                                type : 'value'
                            }
                        ],
                        series : [
                            {
                                name:<%=genrp.get(0)%>,
                                type:'line',
                                stack: 'Tổng',
                                areaStyle: {normal: {}},
                                data:<%=r0%>
                            },
                            {
                                name:<%=genrp.get(1)%>,
                                type:'line',
                                stack: 'Tổng',
                                areaStyle: {normal: {}},
                                data:<%=r1%>
                            },
                            {
                                name:<%=genrp.get(2)%>,
                                type:'line',
                                stack: 'Tổng',
                                areaStyle: {normal: {}},
                                data:<%=r2%>
                            },
                            {
                                name:<%=genrp.get(3)%>,
                                type:'line',
                                stack: 'Tổng',
                                areaStyle: {normal: {}},
                                data:<%=r3%>
                            },
                            {
                                name:<%=genrp.get(4)%>,
                                type:'line',
                                stack: 'Tổng',
                                label: {
                                    normal: {
                                        show: true,
                                        position: 'top'
                                    }
                                },
                                areaStyle: {normal: {}},
                                data:<%=r4%>
                            }
                        ]
                    };

                    weekChart.setOption(weekChartOption);

                </script>

            </div>
            <%--//Năng suất Nhân viên--%>
            <div class="seven wide">
                <div id="waiter" style="width: 90%;height:36%;"></div>
                <script>

var mainContainerwaiterChart = document.getElementById("waiter");
		var resizeMainContainerwaiterChart = function () {
			mainContainerwaiterChart.style.width = window.innerWidth+'px';
			mainContainerwaiterChart.style.height = window.innerHeight*0.8+'px';
		};
		resizeMainContainerwaiterChart();
		var waiterChart = echarts.init(mainContainerwaiterChart);
                
//                    var waiterChart = echarts.init(document.getElementById('waiter'));
                    var waiterData = genData();

                    waiterOption = {
                        title : {
                            text: 'Năng suất Nhân viên',
                            subtext: 'Xử lý theo số lượng Đơn hàng',
                            x:'left'
                        },
                        tooltip : {
                            trigger: 'item',
                            formatter: "{a} : {b} <br/> Xử lý Đơn hàng : {c} ({d}%)"
                        },
                        legend: {
                            type: 'scroll',
                            orient: 'vertical',
                            right: 10,
                            top: 20,
                            bottom: 20,
                            data: waiterData.legendData
                        },
                        series : [
                            {
                                name: 'Tên',
                                type: 'pie',
                                radius : '55%',
                                center: ['40%', '50%'],
                                data: waiterData.seriesData,
                                itemStyle: {
                                    emphasis: {
                                        shadowBlur: 10,
                                        shadowOffsetX: 0,
                                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                                    }
                                }
                            }
                        ]
                    };

                    function genData() {

                        var legendData = [];
                        var seriesData = [];
                        var jname = <%=waiterNameArray%>;
                        var jvalue = <%=waiterCommissionArray%>;

                        for (var i = 0; i < jname.length; i++) {
                            legendData.push(jname[i]);
                            seriesData.push({
                                name : jname[i],
                                value : jvalue[i]});
                        }
                        console.log('jmap' + jname);
                        return {
                            legendData: legendData,
                            seriesData: seriesData
                        };

                    }

                    waiterChart.setOption(waiterOption);

                </script>
            </div>

            <%--//营收数据统计--%>
            <div class="nine wide">
                <div id="income" style="width: 108%;height:42%;"></div>
                <script>
var mainContainerincomeChart = document.getElementById("income");
		var resizeMainContainerincomeChart = function () {
			mainContainerincomeChart.style.width = window.innerWidth+'px';
			mainContainerincomeChart.style.height = window.innerHeight*0.8+'px';
		};
		resizeMainContainerincomeChart();
		var incomeChart = echarts.init(mainContainerincomeChart);
                
//                    var incomeChart = echarts.init(document.getElementById("income"));

                    option = {

                        // Make gradient line here
                        visualMap: [{
                            show: false,
                            type: 'continuous',
                            seriesIndex: 0,
                            min: 0,
                            max: 400
                        }, {
                            show: false,
                            type: 'continuous',
                            seriesIndex: 1,
                            dimension: 0,
                            min: 0,
                            max: <%=xincomeDate.size() - 1%>
                        }],
                        title: [{
                            left: 'center',
                            text: 'Lượt đặt phòng mỗi ngày'
                        }, {
                            top: '55%',
                            left: 'center',
                            text: 'Thành tiền Mỗi ngày'
                        }],
                        tooltip: {
                            trigger: 'axis'
                        },
                        xAxis: [{
                            data: <%=xincomeDate%>
                        }, {
                            data: <%=xincomeDate%>,
                            gridIndex: 1
                        }],
                        yAxis: [{
                            splitLine: {show: false}
                        }, {
                            splitLine: {show: false},
                            gridIndex: 1
                        }],
                        grid: [{
                            bottom: '60%'
                        }, {
                            top: '60%'
                        }],
                        series: [{
                            type: 'line',
                            showSymbol: false,
                            data: <%=incomeOrders%>
                        }, {
                            type: 'line',
                            showSymbol: false,
                            data: <%=incomeMoney%>,
                            xAxisIndex: 1,
                            yAxisIndex: 1
                        }]
                    };
                    incomeChart.setOption(option);

                </script>
            </div>

            <%--//酒店房间数据统计--%>
            <div class="seven wide">
                <div id="rooms" style="width:90%;height:38%;"></div>
                <script type="text/javascript">

var mainContainerroomChart = document.getElementById("rooms");
		var resizeMainContainerroomChart = function () {
			mainContainerroomChart.style.width = window.innerWidth+'px';
			mainContainerroomChart.style.height = window.innerHeight*0.8+'px';
		};
		resizeMainContainerroomChart();
		var roomChart = echarts.init(mainContainerroomChart);
//                    var roomChart = echarts.init(document.getElementById("rooms"));

                    roomOption = {
                        title : {
                            text: 'Thống kê tình hình Phòng'
                        },
                        tooltip : {
                            trigger: 'axis',
                            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                            }
                        },
                        legend: {
                            data: ['còn_trống', 'đã_có_người_thuê']
                        },
                        grid: {
                            left: '3%',
                            right: '4%',
                            bottom: '3%',
                            containLabel: true
                        },
                        xAxis:  {
                            type: 'value'
                        },
                        yAxis: {
                            type: 'category',
                            data: <%=roomType%>
                        },
                        series: [
                            {
                                name: 'còn_trống',
                                type: 'bar',
                                stack: 'Tổng',
                                label: {
                                    normal: {
                                        show: true,
                                        position: 'insideRight'
                                    }
                                },
                                data: <%=roomNumEmpty%>
                            },
                            {
                                name: 'đã_có_người_thuê',
                                type: 'bar',
                                stack: 'Tổng',
                                label: {
                                    normal: {
                                        show: true,
                                        position: 'insideRight'
                                    }
                                },
                                data: <%=roomNumFull%>
                            },
                        ]
                    };
                    roomChart.setOption(roomOption);

                    console.log(<%=roomNumEmpty%>)
                    
                    $(window).on('resize',function(){//
			//屏幕大小自适应，重置容器高宽
		    resizeMainContainerweekTypeNum();
		    weekChart.resize();
                    
                    resizeMainContainerwaiterChart();
                    waiterChart.resize();
                    
                    resizeMainContainerincomeChart();
                    incomeChart.resize();
                    
                    resizeMainContainerroomChart();
                    roomChart.resize();
		});
                </script>
            </div>

        </div>

    </div>

<%--</div>--%>

</body>


</html>
