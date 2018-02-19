<%--
  Created by IntelliJ IDEA.
  User: 25375
  Date: 2017/11/14
  Time: 17:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        String s = request.getParameter("id");
        int id = Integer.parseInt(s);
        new com.mysql.jdbc.Driver();
        String conn = "jdbc:mysql://localhost:3306/bbs";
        Connection connection = DriverManager.getConnection(conn,"root","");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("select * from article where id = " + id);
        if (resultSet.next()) {
    %>
        <table border="1">
            <tr>
                <td>ID</td>
                <td><%=resultSet.getInt("id") %></td>
            </tr>
            <tr>
                <td>Title</td>
                <td><%=resultSet.getString("title") %></td>
            </tr>
            <tr>
                <td>Cont</td>
                <td><%=resultSet.getString("cont") %></td>
            </tr>
            <tr>
                <td>Date</td>
                <td><%=resultSet.getString("pdate") %></td>
            </tr>
        </table>
    <a href="Reply.jsp?id=<%=resultSet.getInt("id")%>&rootid=<%=resultSet.getInt("rootid")%>">回复</a>
    <%
        }
        resultSet.close();
        statement.close();
        connection.close();
    %>
</body>
</html>
