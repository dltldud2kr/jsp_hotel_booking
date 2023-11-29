<%@ page contentType="text/html; charset=utf-8" %>
<%
    request.setCharacterEncoding("utf-8");
    String mem_id = (String) session.getAttribute("mem_id");
%>
<html>
<head>
    <jsp:include page="/header.jsp" />
    <title>로그인</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../css/login.css">
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto login-container">
                <% if (mem_id != null) { %>
                    <div class="text-center">
                        <b><%= mem_id %></b>님 환영합니다.
                        <p>제한된 기능을 사용할 수 있습니다.</p>
                        <a href="memberInfo.jsp" class="btn btn-primary login-btn">마이페이지</a>
                        <a href="logout.jsp" class="btn btn-danger login-btn">로그아웃</a>
                    </div>
                <% } else { %>
                    <div class="login-title">
                        <h4>로그인</h4>
                    </div>
                    <form name="loginFrm" method="post" action="loginProc.jsp">
                        <div class="form-group">
                            <input type="text" class="form-control" name="mem_id" placeholder="아이디">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" name="mem_pw" placeholder="비밀번호">
                        </div>
                        <button type="button" class="btn btn-black text-dark login-btn" onclick="loginCheck()">로그인</button>
                        <button type="button" class="btn btn-black text-dark login-btn" onclick="location.href='member.jsp'">회원가입</button>
                    </form>
                <% } %>
            </div>
        </div>
    </div>
    <jsp:include page="/footer.jsp" />
</body>
</html>
