<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Member.MemberBean"%>
<%@ page import="Member.MemberMgr"%>

<%
    // MemberMgr 객체 생성
    MemberMgr memberMgr = new MemberMgr();

    // 모든 회원 정보 가져오기
    List<MemberBean> allMembers = memberMgr.getAllMembers();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>전체 회원 정보</title>
</head>
<body>
    <h1>전체 회원 정보</h1>

    <% if (allMembers != null && !allMembers.isEmpty()) { %>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>PW</th>
                <th>이름</th>
                <th>휴대폰번호</th>
                <th>주소</th>
                <th>생년월일</th>
            </tr>
            <% for (MemberBean member : allMembers) { %>
                <tr>
                    <td><%= member.getMem_id() %></td>
                    <td><%= member.getMem_pw() %></td>
                    <td><%= member.getMem_name() %></td>
                    <td><%= member.getMem_phone() %></td>
                    <td><%= member.getMem_addr() %></td>
                    <td><%= member.getMem_birth() %></td>
                </tr>
            <% } %>
        </table>
    <% } else { %>
        <p>등록된 회원이 없습니다.</p>
    <% } %>

    <br>
    <a href="admin.jsp">관리자 페이지로 돌아가기</a>
</body>
</html>
