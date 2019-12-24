package servlet;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

import com.mysql.cj.api.Session;
import config.GCON;
import tool.DataBase ;

@WebServlet(name="LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
request.setCharacterEncoding("utf-8");
        Connection conn;
        Statement stmt ;
        String userid =request.getParameter("id");
        String userpassword =request.getParameter("password") ;
        String admin = request.getParameter("admin") ;
        String hotelID = request.getParameter("hotelID");
        
        System.out.println(userid+" "+userpassword+" "+admin);
        String sql = "" ;
        if(admin.equals("0")){
            sql ="select * from systemadministrator where userID= '"+userid+"' and userPassword='"+userpassword+"'" ;
        }else if (admin.equals("1")) {
            sql ="select * from waiter where waiterID= '"+userid+"' and waiterPassword='"+userpassword+"' and hotelID='"+hotelID+"'" ;
        }
        try {
            try {
                Class.forName(GCON.DRIVER);

            } catch (Exception exception) {
                exception.printStackTrace();
            }
            conn = DriverManager.getConnection(
                    GCON.URL,
                    GCON.USERNAME ,GCON.PASSWORD) ;
            stmt= conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            if(rs.next()){
                //登陆成功
                HttpSession session = request.getSession();
                if(admin.equals("1")) {
                    System.out.println("正在进入宾馆Quản lý界面");

                    Connection connection =null ;
                    session.setAttribute("hoteladmin",userid);
                    session.setAttribute("hotelpassword",userpassword);
                    session.setAttribute("hotelID",hotelID);
//                    if(GCON.MAP.get(GCON.HOTELUSERNAME)!=null) {
                    connection = DriverManager.getConnection(
                            GCON.URL,
                            GCON.HOTELUSERNAME, GCON.HOTELPASSWORD);
                    GCON.status =0 ;
                    DataBase.setConnection(connection);
                    response.sendRedirect("/roomOrder.jsp?op=1");

                } else {
                    System.out.println("正在进入系统Quản lý页面");

                    session.setAttribute("systemadmin",userid);
                    session.setAttribute("systempassword",userpassword);
                    session.setAttribute("hotelID",hotelID);

                    Connection connection =DriverManager.getConnection(
                            GCON.URL,
                            GCON.SYSTEMUSERNAME ,GCON.SYSTEMPASSWORD) ;
                    GCON.status =1 ;
                    DataBase.setConnection(connection);
                    response.sendRedirect("/systemManagement/waiterShow.jsp?mop=7");
                }


            }
            else {
                request.getSession().setAttribute("error","Tài khoản hoặc Mật khẩu không chính xác!");
                response.sendRedirect("/index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
request.setCharacterEncoding("utf-8");
        System.out.print("LoginServlet");

    }
}
