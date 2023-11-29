<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Member.MemberBean"%>
<%@ page import="Member.MemberMgr"%>

<%
String mem_id = (String) session.getAttribute("mem_id");

if (mem_id == null) {
	response.sendRedirect("login.jsp");
} else {
	MemberMgr memberMgr = new MemberMgr();
	MemberBean memberInfo = memberMgr.getMemberInfo(mem_id);
	String mem_name = memberInfo.getMem_name();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 정보</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	margin: 0;
	padding: 0;
}

#main {
	display: flex;
	margin: 8%;
}

#sidebar {
	background-color: #f1f1f1;
	padding: 40px;
	width: 250px;
	height: 600px;
}

#content1, #content2, #content3, #content4, #content5 {
	display: none;
	padding: 20px;
	padding: 35px 20px; /* 40px은 위쪽 여백, 20px은 좌우 여백 */
	background-color: #f1f3f5;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	flex: 1;
}

#sidebar h2 {
	color: #333;
	padding-bottom: 10px;
}

#sidebar a {
	display: block;
	margin-bottom: 10px;
	color: #333;
	text-decoration: none;
	transition: color 0.3s;
	cursor: pointer;
}

#sidebar a:hover {
	color: #007bff;
}

#content h1, #content1 h4, #content2 h4, #content3 h1, #content4 h4,
	#content5 h4 {
	color: #333;
	text-align: left;
}

#content p {
	color: #555;
}

#content a {
	color: #007bff;
	text-decoration: none;
	transition: color 0.3s;
}

#content a:hover {
	color: #0056b3;
}

#sub div {
	position: relative;
}

#sub div img {
	display: block;
	margin: 0 auto; /* 이미지를 가로 중앙에 위치시킴 */
}

#sub div p {
	position: absolute;
	top: 50%; /* 상단 위치를 부모 요소의 50%로 설정 */
	left: 50%; /* 좌측 위치를 부모 요소의 50%로 설정 */
	transform: translate(-50%, -50%); /* 텍스트를 수평 및 수직으로 중앙에 위치시킴 */
	color: #FFFFFF;
	font-size: 50px;
}
</style>
</head>
<body>
	<div id="header">
		<jsp:include page="../header.jsp" />
	</div>
	<div id="sub">
		<div>
			<img src="../img/info.jpg" alt="이미지 설명">
			<p>MyPage</p>
		</div>
	</div>


	<div id="main">

		<div id="sidebar">
			<h2><%=mem_name%>님
			</h2>
			<hr>
			<h4>예약 확인</h4>
			<a href="#" onclick="showContent1()">예약 내역</a> <br>
			<h4>개인 정보 관리</h4>
			<a href="#" onclick="showContent3()">회원 정보</a> <a href="#"
				onclick="showContent4()">회원 정보 수정</a> <a href="#"
				onclick="showContent5()">회원 탈퇴</a>
		</div>
		<div id="content1">
			<h4>예약 내역</h4>
		</div>
		<div id="content2">
			<h4>예약 취소</h4>
		</div>
		<div id="content3">
			<h1>회원 정보</h1>
			<p>
				아이디
				<%=memberInfo.getMem_id()%></p>
			<p>
				비밀번호
				<%=memberInfo.getMem_pw()%></p>
			<p>
				이름
				<%=memberInfo.getMem_name()%></p>
			<p>
				휴대폰
				<%=memberInfo.getMem_phone()%></p>
			<p>
				주소
				<%=memberInfo.getMem_addr()%></p>
			<p>
				생년월일
				<%=memberInfo.getMem_birth()%></p>
			<button onclick="location.href='logout.jsp'">로그아웃</button>
		</div>

		<div id="content4">
			<h4>회원 정보 수정</h4>
		</div>
		<div id="content5">
			<h4>회원 탈퇴</h4>
		</div>

	</div>
	<div id="footer">
		<jsp:include page="../footer.jsp" />
	</div>

	<script>
		showContent1();
		function showContent1() {
			// AJAX를 사용하여 memberUpdate.jsp의 내용을 불러옴
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					// content4에 내용 표시
					document.getElementById("content1").innerHTML = this.responseText;
				}
			};
			xhttp.open("GET", "../check/checkList.jsp", true);
			xhttp.send();

			hideAllContent();

			// content4 
			document.getElementById("content1").style.display = "block";
		}

		function showContent2() {
			hideAllContent();
			document.getElementById("content2").style.display = "block";
		}

		function showContent3() {
			hideAllContent();
			document.getElementById("content3").style.display = "block";
		}

		function showContent4() {
			// AJAX를 사용하여 memberUpdate.jsp의 내용을 불러옴
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					// content4에 내용 표시
					document.getElementById("content4").innerHTML = this.responseText;
				}
			};
			xhttp.open("GET", "memberUpdate.jsp", true);
			xhttp.send();

			// 모든 content 숨기기
			hideAllContent();

			// content4 표시
			document.getElementById("content4").style.display = "block";
		}

		function showContent5() {
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					// content4에 내용 표시
					document.getElementById("content5").innerHTML = this.responseText;
				}
			};
			xhttp.open("GET", "memberWithdraw.jsp", true);
			xhttp.send();

			// 모든 content 숨기기
			hideAllContent();

			// content4 표시
			document.getElementById("content5").style.display = "block";
		}

		function hideAllContent() {
			document.getElementById("content1").style.display = "none";
			document.getElementById("content2").style.display = "none";
			document.getElementById("content3").style.display = "none";
			document.getElementById("content4").style.display = "none";
			document.getElementById("content5").style.display = "none";
		}
	</script>
</body>
</html>

<%
}
%>
