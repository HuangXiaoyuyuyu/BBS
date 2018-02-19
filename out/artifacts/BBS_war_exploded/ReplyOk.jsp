<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %><%--
  Created by IntelliJ IDEA.
  User: 25375
  Date: 2017/11/14
  Time: 22:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    int id = Integer.parseInt(request.getParameter("id"));
    int rootid = Integer.parseInt(request.getParameter("rootid"));
    String title = request.getParameter("title");
    String cont = request.getParameter("cont");

    cont = cont.replaceAll("\n","<br>");

    new com.mysql.jdbc.Driver();
    String conn = "jdbc:mysql://localhost:3306/bbs";
    Connection connection = DriverManager.getConnection(conn,"root","");

    connection.setAutoCommit(false);

    String sql =  "insert into article values(null,?,?,?,?,now(),0)";
    PreparedStatement pstm = connection.prepareStatement(sql);
    Statement statement = connection.createStatement();
    pstm.setInt(1,id);
    pstm.setInt(2,rootid);
    pstm.setString(3,title);
    pstm.setString(4,cont);
    pstm.executeUpdate();

    statement.executeUpdate("update article set isleaf = 1 where id = " + id);

    connection.commit();
    connection.setAutoCommit(true);

    statement.close();
    pstm.close();
    connection.close();

    response.sendRedirect("ShowArticleTree.jsp");
%>
OK!
</body>
</html>
