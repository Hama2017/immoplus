<%--
  Created by IntelliJ IDEA.
  User: hamaba
  Date: 6/16/24
  Time: 01:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
        <h1>Your Entities</h1>
        <form action="${pageContext.request.contextPath}/user" method="post">
            <input type="text" name="name" placeholder="Name">
            <button type="submit">Add Entity</button>
        </form>
        <ul>
            <c:forEach var="entity" items="${entities}">
                <li>${entity.name}</li>
            </c:forEach>
        </ul>
</body>
</html>
