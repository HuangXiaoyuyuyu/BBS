<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- saved from url=(0046)http://demo.mycodes.net/denglu/xingkong_login/ -->


    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>login</title>
    <link rel="stylesheet" type="text/css" href="./images/login_files/normalize.css">
    <link rel="stylesheet" type="text/css" href="./images/login_files/demo.css">
    <!--必要样式-->
    <link rel="stylesheet" type="text/css" href="./images/login_files/component.css">
    <!--[if IE]>
    <script src="js/html5.js"></script>
    <![endif]-->
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String logname = request.getParameter("logname");
    String logpass = request.getParameter("logpass");
    System.out.println(logname + " " + logpass);
    if (logname == null || !logname.equals("admin")){
        out.println("用户名输入错误！");
        //return;
    }else if (logpass == null || !logpass.equals("admin")) {
        out.println("密码输入错误！");
        //return;
    }else {
        session.setAttribute("admin","true");
        response.sendRedirect("ShowArticleTree.jsp");
    }

%>
<div class="container demo-1">
    <div class="content">
        <div id="large-header" class="large-header" style="height: 686px;">
            <canvas id="demo-canvas" width="1536" height="686"></canvas>
            <div class="logo_box">
                <h3>欢迎你</h3>
                <form action="index.jsp" method="post">
                    <div class="input_outer">
                        <span class="u_user"></span>
                        <input name="logname" class="text" style="color: #FFFFFF !important"   type="text" placeholder="请输入账户">
                    </div>
                    <div class="input_outer">
                        <span class="us_uer"></span>
                        <input name="logpass" class="text" style="color: #FFFFFF !important; position:absolute; z-index:100;" value="" type="password" placeholder="请输入密码">
                    </div>
                    <%--<div class="mb2"><a class="act-but submit" href="ShowArticleTree.jsp" style="color: #FFFFFF">登录</a></div>--%>
                    <div class="mb2"><input type="submit" class="act-but submit" style="color: #FFFFFF" value="登录"></div>
                </form>
            </div>
        </div>
    </div>
</div><!-- /container -->
<script src="./images/login_files/TweenLite.min.js.下载"></script>
<script src="./images/login_files/EasePack.min.js.下载"></script>
<script src="./images/login_files/rAF.js.下载"></script>
<script src="./images/login_files/demo-1.js.下载"></script>


</body></html>