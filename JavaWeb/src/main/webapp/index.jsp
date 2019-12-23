<%@ page import="com.mysql.cj.api.Session" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>Quản lý Khách sạn</title>
  <link rel="stylesheet" type="text/css" href="/semantic/dist/semantic.min.css">
  <script src="/semantic/dist/jquery.min.js"></script>
  <script src="/semantic/dist/semantic.js"></script>
</head>

<style type="text/css">
  body {
    background: url("/images/bg1.jpg");
    background-color: #DADADA;
  }
  body > .grid {
    height: 100%;
  }
  .image {
    margin-top: -100px;
  }
  .column {
    max-width: 450px;
  }
</style>
<script>
    $(document).ready(function () {
        $('.ui.form').form({
                id: {
                    identifier: 'id',
                    rules: [
                        {
                            type: 'regExp[/^[a-z0-9A-Z]{1,10}$/]',
                            prompt: 'Tên tài khoản không đúng định dạng'
                        }
                    ]
                },
                password: {
                    identifier: 'password',
                    rules: [
                        {
                            type: 'regExp[/^[a-z0-9A-Z]{1,10}$/]',
                            prompt: 'Mật khẩu không đúng định dạng'
                        }
                    ]
                }
                ,onSuccess: function () {
                    document.getElementById("form1").submit();
                }
            }, {
                inline: true,
                on: 'submit'

            }

        )

        ;
    });
</script>

<body>
<div class="ui middle aligned center aligned grid">
  <div class="column">
    <h1 class="ui blue header">Quản lý Khách sạn</h1>
    <form class="ui large form" id="form1" method="post" action="/LoginServlet">
      <div class="ui form segment"  align="center">
        <%--<div class="field">--%>
        <%--<div class="ui dropdown">--%>
        <%--&lt;%&ndash;fluid search&ndash;%&gt;--%>
        <%--<select class="ui fluid search dropdown" name="admin">--%>
        <%--<option value="0">Quản trị Hệ thống</option>--%>
        <%--<option value="1">Quản trị Khách sạn</option>--%>
        <%--</select>--%>
        <%--</div>--%>
        <%--</div>--%>


        <div class="field" align="center">
          <div class="inline fields">
            <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            <div class="field" align="center">
              <div class="ui radio checkbox">
                <input type="radio" name="admin" value="0" checked="checked">
                <label><i class="user icon"></i>Quản trị Hệ thống</label>
              </div>
            </div>
            <div class="field">
              <div class="ui radio checkbox">
                <input type="radio" name="admin" value="1">
                <label><i class="users icon"></i>Quản trị Khách sạn</label>
              </div>
            </div>
          </div>
          <div class="field">
            <div class="ui left icon input">
              <i class="user icon"></i>
              <input type="text" id="id" name="id" placeholder="Tên tài khoản">
            </div>
          </div>
          <div class="field">
            <div class="ui left icon input">
              <i class="lock icon"></i>
              <input type="password" id="password" name="password" placeholder="Mật khẩu">
            </div>
          </div>
          <div >
            <%--<input   onclick="fun()" value="Đăng nhập" class="ui primary button">--%>
            <input  type="submit"  value="Đăng nhập" class="ui fluid large blue submit button">
            <%--<div class="ui fluid large button">Đăng nhập</div>--%>
          </div>
        </div>

          <% if(  request.getSession().getAttribute("error")!=null ) { %>
        <div class="ui red message">
          <%=request.getSession().getAttribute("error").toString() %>
        </div>
          <%}
                if(request.getSession().getAttribute("error")!=null )
                        request.getSession().removeAttribute("error"); %>

    </form>
  </div>
</div>
</body>

</html>