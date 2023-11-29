<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <title>회원가입</title>
<link rel="stylesheet" type="text/css" href="../css/member.css">
    <script type="text/javascript" src="mem_script.js"></script>
</head>
<body onLoad="regFrm.mem_id.focus()">
    <div>
        <h1>회원가입</h1>
        <form name="regFrm" method="post" action="memberProc.jsp">
            <p>
                <input name="mem_id" size="20" placeholder="아이디">
                <input type="button" value="ID중복확인" onClick="idCheck(this.form.mem_id.value)">
            </p>

            <p>
                <input type="password" name="mem_pw" size="20" placeholder="비밀번호">
            </p>
            <p>
                <input type="password" name="repw" size="20" placeholder="비밀번호 확인">
            </p>
            <p>
                <input name="mem_name" size="20" placeholder="이름">
            </p>
            <p>
                <input name="mem_phone" size="20" placeholder="휴대폰 번호 (숫자만)">
            </p>
            <p>
                <input name="mem_addr" size="50" placeholder="주소">
            </p>
            <p>
                <input name="mem_birth" size="20" placeholder="생년월일 ex.19990123">
            </p>

            <input type="button" value="회원가입" onclick="inputCheck()">
            &nbsp; &nbsp; <input type="reset" value="다시쓰기"> &nbsp; &nbsp;
            <input type="button" value="로그인" onClick="javascript:location.href='login.jsp'">
        </form>
    </div>
</body>
</html>
