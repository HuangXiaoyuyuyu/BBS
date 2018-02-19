<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: 25375
  Date: 2017/11/15
  Time: 18:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        String admin = (String) session.getAttribute("admin");
        if (admin ==null || !admin.equals("true")) {
            out.println("孩子放弃吧~~~");
            return;
        }
    %>
    <%!
       private void del(Connection connection,int id) {
           Statement statement = null;
           ResultSet resultSet = null;
           try {
               statement = connection.createStatement();
               resultSet = statement.executeQuery("select * from article where pid = " + id);
               while (resultSet.next()) {
                   del(connection,resultSet.getInt("id"));
               }
               statement.executeUpdate("delete from article where id = " + id);
           } catch (SQLException e) {
               e.printStackTrace();
           } finally {
               try {
                   if (resultSet != null) {
                       resultSet.close();
                       resultSet = null;
                   }
                   if (statement != null) {
                       statement.close();
                       statement = null;
                   }
               } catch (SQLException e) {
                   e.printStackTrace();
               }
           }
       }
    %>
    <%
        int id = Integer.parseInt(request.getParameter("id"));
        int pid = Integer.parseInt(request.getParameter("pid"));
        new com.mysql.jdbc.Driver();
        String conn = "jdbc:mysql://localhost:3306/bbs";
        Connection connection = DriverManager.getConnection(conn,"root","");
        connection.setAutoCommit(false);
        del(connection,id);
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("select count(*) from article where pid = "+ pid);
        resultSet.next();
        int count = resultSet.getInt(1);
        resultSet.close();
        statement.close();
        if (count<=0) {
            Statement ps = connection.createStatement();
            ps.executeUpdate("update article set isleaf = 0 where id = "+ pid);
            ps.close();
        }
        connection.commit();
        connection.setAutoCommit(true);
        connection.close();
        response.sendRedirect("ShowArticleTree.jsp");
    %>
</body>
</html>
