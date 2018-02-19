<%--
  Created by IntelliJ IDEA.
  User: 25375
  Date: 2017/11/14
  Time: 21:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    int rootid = Integer.parseInt(request.getParameter("rootid"));
%>
<form action="ReplyOk.jsp" method="post">
    <input type="hidden" name="id" value="<%=id %>">
    <input type="hidden" name="rootid" value="<%=rootid %>">
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
