<%--
  Created by IntelliJ IDEA.
  User: 25375
  Date: 2017/11/16
  Time: 16:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String post = request.getParameter("post");
    //System.out.println("12123123121313");
    if (post != null && post.equals("post")) {
        //System.out.println("12312312");
        String title = request.getParameter("title");
        String cont = request.getParameter("cont");
        cont = cont.replaceAll("\n","<br>");
        new com.mysql.jdbc.Driver();
        String conn = "jdbc:mysql://localhost:3306/bbs";
        Connection connection = DriverManager.getConnection(conn,"root","");
        connection.setAutoCommit(false);

        String sql = "insert into article values (null,0,?,?,?,now(),0)";
        PreparedStatement preparedStatement = connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
        Statement statement = connection.createStatement();
        preparedStatement.setInt(1,-1);
        preparedStatement.setString(2,title);
        preparedStatement.setString(3,cont);
        preparedStatement.executeUpdate();
        ResultSet resultSet = preparedStatement.getGeneratedKeys();
        resultSet.next();
        int key = resultSet.getInt(1);
        resultSet.close();

        statement.executeUpdate("update article set rootid = " + key + " where id = " + key);
        connection.commit();
        connection.setAutoCommit(true);
        statement.close();
        preparedStatement.close();
        connection.close();

        response.sendRedirect("ShowArticleFlat.jsp");
    }
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="Post.jsp" method="post">
    <input type="hidden" name="post" value="post" >
    <table border="1">
        <tr>
            <td>Title</td>
            <td><input type="text" size="45" name="title"></td>
        </tr>
        <tr>
            <td>Cont</td>
            <td><textarea cols="50" rows="10" name="cont"></textarea></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="提交">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
