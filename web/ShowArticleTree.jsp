<%--
  Created by IntelliJ IDEA.
  User: 25375
  Date: 2017/11/13
  Time: 18:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String admin = (String) session.getAttribute("admin");
    if (admin != null && admin.equals("true")) {
        b = true;
    }
%>
<%!
    String string = "";
    boolean b = false;
    String str = "";
    private void tree(Connection connection,int id,int level) {
        Statement statement = null;
        ResultSet resultSet = null;
        String preStr = "";
        for (int i=0; i<level; i++) {
            preStr = preStr + "----";
        }
        try {
            statement = connection.createStatement();
            String sql = "select * from article where pid = " + id;
            resultSet = statement.executeQuery(sql);
            while(resultSet.next()) {
                if (b) {
                    str = "<td><a href='Delete.jsp?id="+resultSet.getInt("id")+"&pid="+resultSet.getInt("pid")+"'>删除</a>" + "</td></tr>";
                }
                string += "<tr><td>" + resultSet.getInt("id") +
                           "</td><td>" + preStr +"<a href = 'ShowArticleDetail.jsp?id=" + resultSet.getInt("id") + "'>"+
                            resultSet.getString("title")+"</a></td>" +
                            str;
                if (resultSet.getInt("isleaf") != 0) {
                    tree(connection,resultSet.getInt("id"),level+1);
                }
            }
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
        String str = "";
        new com.mysql.jdbc.Driver();
        String conn = "jdbc:mysql://localhost:3306/bbs";
        Connection connection = DriverManager.getConnection(conn,"root","");
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("select * from article where pid = 0");
        while (resultSet.next()) {
            if (b) {
                str = "<td><a href='Delete.jsp?id="+resultSet.getInt("id")+"&pid="+resultSet.getInt("pid")+"'>删除</a>" + "</td></tr>";

            }
            string += "<tr><td>" + resultSet.getInt("id") +
                    "</td><td>" + "<a href = 'ShowArticleDetail.jsp?id=" + resultSet.getInt("id") + "'>"+ resultSet.getString("title")+"</a></td>" +
                     str;
            if (resultSet.getInt("isleaf") != 0) {
                tree(connection,resultSet.getInt("id"),1);
            }
        }
        resultSet.close();
        statement.close();
        connection.close();
%>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
    <a href="Post.jsp">发表新帖</a>
    <table border="1">
        <%=string %>
        <% string = "";
            b = false;
        %>
    </table>
  </body>
</html>
