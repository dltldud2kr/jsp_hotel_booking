<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Member.MemberBean"%>
<%@ page import="Member.MemberMgr"%>

<%
    String mem_id = (String) session.getAttribute("mem_id");

    if (mem_id == null) {
        response.sendRedirect("login.jsp");
    } else {
        MemberMgr memberMgr = new MemberMgr();
        MemberBean memberInfo = memberMgr.getMemberInfo(mem_id);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보</title>
</head>
<body>
    <h1>회원 정보</h1>
    <p>ID: <%= memberInfo.getMem_id() %></p>
    <p>PW: <%= memberInfo.getMem_pw() %></p>
    <p>이름: <%= memberInfo.getMem_name() %></p>
    <p>휴대폰 번호: <%= memberInfo.getMem_phone() %></p>
    <p>주소: <%= memberInfo.getMem_addr() %></p>
    <p>생년월일: <%= memberInfo.getMem_birth() %></p>
    <br>
    <a href="memberUpdate.jsp">회원정보 수정</a>
    <a href="logout.jsp">로그아웃</a>
</body>
</html>

<%
    }
%>
