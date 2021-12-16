<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
    <head>
        <title>Your Account</title>
        <link href="<c:url value="/css/style.css"/>" rel="stylesheet" type="text/css">
    </head>
    <body>

        <div >
        
        	<div  class="topnav">
        		
               <a href="/account">Home</a>
               <a href="/deposit">Make a Deposit</a>
               <a class="active" href="/withdrawl">Make a Withdrawl</a>
               <a href="/transfer">Transfer Funds</a>
               <a href="/logout">Logout</a>
        
        	</div>
   
            <br/>
            <c:if test="${noTarget}">
                <div>Please select a target account.</div>
            </c:if>
            <c:if test="${amountNegative}">
                <div>The amount can't be negative or zero.</div>
            </c:if>
            <c:if test="${overdraft}">
                <div>Insufficient funds in your account. Please input a lower number.</div>
            </c:if>
    
            <form:form action="transfer" method="post" modelAttribute="transfer">
                <form:label path="amount">Amount:</form:label>
                <form:input type="text" path="amount"/><br>
    
                <input type="submit" class="button" value="Transfer"/><br>
                <table>
                    <thead>
                        <tr>
                            <th>Account ID</th>
                            <th>Name</th>
                            <th>Email</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${accounts}" var="account">
    
                            <tr>
                                <td><form:radiobutton path="targetId" value="${account.accountId}"/>${account.accountId}</td>
                                <td>${account.name}</td>
                                <td>${account.email}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </form:form>
        </div>
        
        
    </body>
</html>