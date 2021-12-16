<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head>
        <title>Your Account</title>
        <link href="<c:url value="/css/style.css"/>" rel="stylesheet" type="text/css">
    </head>
    <body>
    	

        <div class="content">
                
        	<div  class="topnav">
        		
               <a href="/account">Home</a>
               <a href="/deposit">Make a Deposit</a>
               <a class="active" href="/withdrawl">Make a Withdrawl</a>
               <a href="/transfer">Transfer Funds</a>
               <a href="/logout">Logout</a>
        
        	</div>
        
            <h2>Your Account</h2> <br>
        
            Name: ${account.name} <br>
            Email: ${account.email} <br>
            Account ID: ${account.accountId} <br>
            Balance: ${account.balance} <br>
            <br/>
  
            <br/>
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Message</th>
                        <th>Amount</th>
                        <th>Balance Before</th>
                        <th>New Balance</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${transactions}" var="transaction">
                        <tr>
                            <td>${transaction.date}</td>
                            <td>${transaction.message}</td>
                            <td>${transaction.amount}</td>
                            <td>${transaction.prevBalance}</td>
                            <td>${transaction.newBalance}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
    </body>
</html>