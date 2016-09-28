<%@page import="com.sample.EmployeeDAO"%>
<%@page import="com.sample.MyData"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
	<link rel="stylesheet" href="css/style.css">
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery-ias.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
        	// Infinite Ajax Scroll configuration
            jQuery.ias({
                container : '.wrap', // main container where data goes to append
                item: '.item', // single items
                pagination: '.nav', // page navigation
                next: '.nav a', // next page selector
                loader: '<img src="css/ajax-loader.gif"/>', // loading gif
                triggerPageThreshold: 3 // show load more if scroll more than this
            });
        });
    </script>
</head>
<% 
 String next="";
 int pagee=1;
 int limit=10;
 
 if(request.getParameter("p")!=null)       
   pagee=Integer.parseInt(request.getParameter("p"));
 
 EmployeeDAO dao = new EmployeeDAO();
 
 int start = (pagee * limit)-limit;
 List<MyData> list = dao.viewAllEmployees(start,limit);
 
 int rowCount = dao.getNoOfRecords();
 int noOfPages = (int) Math.ceil(rowCount * 1.0 / limit);
 if( rowCount > (pagee * limit) ){
	 next = ++pagee+"";
}

 %> 
 <body><div class="wrap">
 
<%
 for (MyData m:list) {
 
	 %>
     <div class="item" id="item-<%=m.getId()%>">
		<h2>
			<span class="num"><%= m.getId()%></span>
			<span class="name"><%= m.getName()%> <%=m.getLastname()%></span>
		</h2>
		<p><%=m.getInfo()%></p>
	</div>
     <%
 }
%>
<!--page navigation-->
	<% if (next!=null){ System.out.println(next); %>
	<div class="nav">
		<a href='index.jsp?p=<%=next%>'>Next</a>
	</div>
	<%}%>
	

</div><!--.wrap-->
</body>
</html>