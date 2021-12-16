<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Register</title>
        <link href="<c:url value="/css/style.css"/>" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div class="content">
        <h1>Welcome to Dollars Bank</h1><br><hr><br>
            <c:if test="${registerFailure}">
                <div>That email is already in use.</div>
            </c:if>
        
            <form:form action="register" method="post" modelAttribute="account">
                <form:label path="email">Email: </form:label> <form:input type="email" path="email"/><br>
                <form:label path="password">Password: </form:label> <form:input type="password" path="password"/><br>
                <form:label path="name">Name: </form:label> <form:input type="text" path="name"/><br>
                <form:label path="address">Address: </form:label> <form:input type="text" path="address"/><br>
                <form:label path="balance">Initial Balance: </form:label> <form:input type="text" path="balance"/><br>
                <input type="submit" class="button" value="submit"/>
            </form:form>

            <a class="button" href="/login">Cancel</a>
        </div>        
    </body>
</html>