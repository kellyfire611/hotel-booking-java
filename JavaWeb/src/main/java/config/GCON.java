package config;

import java.util.ArrayList;

public class GCON {
    //数据库连接信息
    public static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    //public static final String URL = "jdbc:mysql://localhost:3306/new?autoReconnect=true&useSSL=false&useUnicode=true&charaterEncoding=UTF";
    public static final String URL = "jdbc:mysql://localhost/hotel?useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&useUnicode=true";

    //Đăng nhập时默认使用system用户验证Đăng nhập名与Mật khẩu是否正确
    public static  String USERNAME = "root";

    public static  String PASSWORD = "root";

    public static final String SYSTEMUSERNAME = "root";

    public static final String SYSTEMPASSWORD = "root";

    public static final String HOTELUSERNAME = "root";

    public static final String HOTELPASSWORD = "root";

    public static int status = 1 ; //1是Quản trị Hệ thống  0 是Quản trị Khách sạn;
    //订单
    //查询Tất cả信息
    public static final String SQL_ALL_ORDERS = "SELECT * FROM orders";
    //查询Quản lý员
    public static final String SQL_ALL_ADMINS = "SELECT * FROM systemAdministrator";

    //查询所有房间
    public static final String SQL_ALL_ROOMS ="SELECT * FROM roomtypeandprice" ;

    public static final String SQL_ALL_WAITERS ="SELECT * FROM waiter" ;

    //查询所有Tình hình Renew
    public static final String SQL_ALL_TIME_EXTENSION_ORDERS = "SELECT * FROM timeextension";


    //----------------------jsp-----------------------//
    //Quản lý Phòng
    public static final String SEARCH_ROOM = "1";

    public static final String ADD_ROOM = "2";

    public static final String EDIT_ROOM = "3";

    public static final String DELETE_ROOM = "4";

}
