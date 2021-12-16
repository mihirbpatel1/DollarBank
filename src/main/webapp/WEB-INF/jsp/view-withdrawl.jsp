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

            <c:if test="${withdrawlFailure}">
                <div>Withdrawl cannot be zero.</div>
            </c:if>
        
            <form:form action="withdrawl" method="post" modelAttribute="amount">
                <fieldset>
                    <form:label path="value">Amount: </form:label> 
                    <form:input type="text" path="value"/> <br/>
                </fieldset>
                <input type="submit" class="button" value="submit"/>
            </form:form>
        </div>
        
    </body>
</html>