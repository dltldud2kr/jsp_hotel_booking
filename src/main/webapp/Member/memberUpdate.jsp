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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보 수정</title>
</head> 
<body>
    <h1>회원 정보</h1>
    <form action="memberUpdateProc.jsp" method="post">
        <!-- 기존 회원 정보 표시 -->
        ID <input type="text" id="newId" name="newId" value="<%= memberInfo.getMem_id() %>" readonly><br>
        
        PW <input type="password" id="newPw" name="newPw" value="<%= memberInfo.getMem_pw() %>"><br>

        이름 <input type="text" id="newName" name="newName" value="<%= memberInfo.getMem_name() %>" readonly><br>

        휴대폰 번호 <input type="text" id="newPhone" name="newPhone" value="<%= memberInfo.getMem_phone() %>">
        <span class="error-message" id="phoneError"></span><br>

        주소 <input type="text" id="newAddr" name="newAddr" value="<%= memberInfo.getMem_addr() %>"><br>
        
        생년월일 <input type="text" id="newBirth" name="newBirth" value="<%= memberInfo.getMem_birth() %>" readonly><br>

        <input type="submit" value="수정">
    </form>

    <!-- 회원 탈퇴 폼 -->
    <form action="memberWithdraw.jsp" method="post">
        <input type="hidden" name="mem_id" value="<%= memberInfo.getMem_id() %>">
        <input type="submit" value="회원 탈퇴">
    </form>

    <br>
    <a href="logout.jsp">로그아웃</a>
</body>
</html>

<%
    }
%>
