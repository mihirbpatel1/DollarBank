<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
    <head>
        <title>Change Password</title>
        <link href="<c:url value="/css/style.css"/>" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div class="content">
        
           	<div  class="topnav">
        		
               <a href="/account">Home</a>
               <a href="/deposit">Make a Deposit</a>
               <a class="active" href="/withdrawl">Make a Withdrawl</a>
               <a href="/transfer">Transfer Funds</a>
               <a href="/change-password">Change Your Password</a>
               <a href="/logout">Logout</a>
        
        	</div>
   
            <br/>
            <h1>Change Your Password</h1>

            <c:if test="${passwordIncorrect}">
                <div>The old password was incorrect</div>
            </c:if>
            <c:if test="${doesNotMatch}">
                <div>Please enter the new password twice.</div>
            </c:if>
        
            <form:form action="change-password" method="post" modelAttribute="changePassword">
                <fieldset>
                    <form:label path="oldPassword">Old Password: </form:label> 
                    <form:input type="password" path="oldPassword"/> <br/>

                    <form:label path="newPassword">New Password: </form:label> 
                    <form:input type="password" path="newPassword"/> <br/>

                    <form:label path="newPasswordMatch">Confirm New Password: </form:label> 
                    <form:input type="password" path="newPasswordMatch"/> <br/>
                </fieldset>
                <input type="submit" class="button" value="submit"/>
            </form:form>
        </div> 
               
    </body>
</html>