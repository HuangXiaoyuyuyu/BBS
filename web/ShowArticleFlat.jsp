<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: 25375
  Date: 2017/11/17
  Time: 16:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table border="1">
<a href="Post.jsp">发表新帖</a>
<%
    int pageSize = 3;
    String strPageNo = request.getParameter("pageNo");
    int pageNo  = 1;
    if (strPageNo == null || strPageNo.equals("")) {
        pageNo = 1;
    } else {
        try{
            pageNo = Integer.parseInt(strPageNo.trim());
        } catch (NumberFormatException e) {
            pageNo = 1;
        }
        if (pageNo <= 0) {
            pageNo = 1;
        }
    }

    new com.mysql.jdbc.Driver();
    String conn = "jdbc:mysql://localhost:3306/bbs";
    Connection connection = DriverManager.getConnection(conn,"root","");
    Statement statTotal = connection.createStatement();
    ResultSet rsTotal = statTotal.executeQuery("select count(*) from article where pid = 0");
    rsTotal.next();
    int total = rsTotal.getInt(1);
    int totalPage = total%pageSize==0 ? total / pageSize : total / pageSize + 1;
    if (pageNo > totalPage) {
        pageNo = totalPage;
    }
    int startPos = (pageNo - 1)*pageSize;
    Statement statement = connection.createStatement();
    ResultSet resultSet = statement.executeQuery("select * from article where pid = 0 order by pdate desc limit "+ startPos + "," + pageSize);
    while (resultSet.next()) {
%>
        <tr>
            <td><%=resultSet.getString("title") %></td>
            <td><%=resultSet.getString("pdate") %></td>
        </tr>
<%
    }
    resultSet.close();
    statement.close();
    connection.close();
%>
</table>
<a href="ShowArticleFlat.jsp?pageNo=1">首页</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="ShowArticleFlat.jsp?pageNo=<%=pageNo-1 %>">上一页</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
第<%=pageNo %>页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  共<%=totalPage %>页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="ShowArticleFlat.jsp?pageNo=<%=pageNo+1 %>">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="ShowArticleFlat.jsp?pageNo=<%=totalPage %>">尾页</a><br><br><br>

<form name="form1" action="ShowArticleFlat.jsp">
    <select name="pageNo" onchange="document.form1.submit()">
        <%
            for (int i=1; i<=totalPage; i++) {
        %>
        <option value="<%=i %>"  <%=(pageNo == i) ? "selected" : "" %>>第<%=i %>页</option>
        <%
            }
        %>
    </select>
</form>

<form name="form2">
    <input type="text" name="pageNo" value="<%=pageNo %>">
    <input type="submit" value="GO">
</form>

</body>
</html>
