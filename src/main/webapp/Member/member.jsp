<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script type="text/javascript" src="mem_script.js"></script>
    <link rel="stylesheet" href="../css/member.css">
</head>
<body onLoad="regFrm.mem_id.focus()">
    <div class="container mt-5">
    <jsp:include page="../header.jsp" />
        <h1 class="text-center">회원가입</h1>
        <form name="regFrm" method="post" action="memberProc.jsp" class="mt-4">
            <div class="form-group reg">
                <input type="text" name="mem_id" class="form-control" placeholder="아이디" required>
                <small class="form-text text-muted">
                    <input type="button" value="ID 중복확인" onClick="idCheck(this.form.mem_id.value)">
                </small>
            </div>

            <div class="form-group reg">
                <input type="password" name="mem_pw" class="form-control" placeholder="비밀번호" required>
            </div>

            <div class="form-group reg">
                <input type="password" name="repw" class="form-control" placeholder="비밀번호 확인" required>
            </div>

            <div class="form-group reg">
                <input type="text" name="mem_name" class="form-control" placeholder="이름" required>
            </div>

            <div class="form-group">
                <input type="text" name="mem_phone" class="form-control" placeholder="휴대폰 번호 (숫자만)" required>
            </div>

            <div class="form-group">
                <input type="text" name="mem_addr" class="form-control" placeholder="주소" required>
            </div>

            <div class="form-group">
                <input type="text" name="mem_birth" class="form-control" placeholder="생년월일 ex.19990123" required>
            </div>

            <button type="button" class="btn btn-primary" onclick="inputCheck()">회원가입</button>
            <button type="reset" class="btn btn-secondary">다시쓰기</button>
            <button type="reset" class="btn btn-secondary sk">다시쓰기</button>
            <a href="login.jsp" class="btn btn-link">로그인</a>
        </form>
    </div>
    <jsp:include page="../footer.jsp" />
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
