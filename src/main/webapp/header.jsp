<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<style>
.navbar {
  background-color: #fff !important;
}
.nav-link {
  color: #000 !important;
}
</style>
</head>

<nav class="navbar navbar-expand-lg p-4">
  <div class="container">
    <a class="navbar-brand font-weight-bold" style="color: #000;" href="<%=request.getContextPath() %>/index.jsp">Manolja Hotel</a>
    <div class="collapse navbar-collapse">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item">
          <a class="nav-link text-dark" id="loginLink" href="<%=request.getContextPath() %>/Member/login.jsp">Login</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-dark" id="signinLink" href="<%=request.getContextPath() %>/Member/member.jsp">Sign in</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-dark" id="roomLink" href="<%=request.getContextPath() %>/room/roomlist.jsp">Room</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-dark" id="reviewLink" href="<%=request.getContextPath() %>/review.jsp">Review</a>
        </li>
      </ul>
    </div>
  </div>
</nav>


<script>
// 로그인 상태에 따라 로그인/가입 링크와 마이페이지 링크를 전환하는 자바스크립트 코드
function updateNavigationLinks(isLoggedIn) {
    const loginLink = document.getElementById('loginLink');
    const signinLink = document.getElementById('signinLink');

    if (isLoggedIn) {
        // 로그인 상태일 경우, 로그인과 가입 링크를 마이페이지 링크로 변경
        loginLink.textContent = 'MyPage';
        loginLink.href = '<%=request.getContextPath() %>/mypage.do';

        signinLink.textContent = 'Logout';
        signinLink.href = '<%=request.getContextPath() %>/logout.do';
    } else {
        // 로그인 상태가 아닐 경우, 기본 링크로 재설정
        loginLink.textContent = 'Login';
        loginLink.href = '#';  // 적절한 로그인 링크 URL 설정

        signinLink.textContent = 'Signin';
        signinLink.href = '#';  // 적절한 가입 링크 URL 설정
    }
}

// 예제 사용법:
// 사용자가 로그인 상태일 때 updateNavigationLinks(true) 호출
// 사용자가 로그인 상태가 아닐 때 updateNavigationLinks(false) 호출
</script>