<%@ page contentType="text/html; charset=utf-8" %>
<%
    request.setCharacterEncoding("utf-8");
    String mem_id = (String) session.getAttribute("mem_id");
    Integer mem_idx = (Integer) session.getAttribute("mem_idx");
%>
<html>
<head>
    <title>로그인</title>
    <script type="text/javascript">
        function loginCheck() {
            if (document.loginFrm.mem_id.value == "") {
                alert("아이디를 입력해 주세요.");
                document.loginFrm.mem_id.focus();
                return;
            }
            if (document.loginFrm.mem_pw.value == "") {
                alert("비밀번호를 입력해 주세요.");
                document.loginFrm.mem_pw.focus();
                return;
            }
            document.loginFrm.submit();
        }
    </script>
</head>
<body>
    <div align="left">
        <% if (mem_id != null) { %>
            <b><%= mem_id %></b>님 환영합니다.
            <a href="memberInfo.jsp">마이페이지</a>
            <a href="logout.jsp">로그아웃</a>

        <% } else { %>
            <h4>로그인</h4>
            <form name="loginFrm" method="post" action="loginProc.jsp">
                <p><input name="mem_id"></p>
                <p><input type="password" name="mem_pw"></p>
                <input type="button" value="로그인" onclick="loginCheck()">
                <input type="button" value="회원가입" onClick="javascript:location.href='member.jsp'">
            </form>
        <% } %>
    </div>
</body>
</html>
