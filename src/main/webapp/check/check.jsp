<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방 예약</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String startdate = request.getParameter("start_date");
	String enddate = request.getParameter("end_date");
	String people = request.getParameter("people");
	%>
	<%=startdate %>
	<%=enddate %>
	<%=people %>명
</body>
</html>