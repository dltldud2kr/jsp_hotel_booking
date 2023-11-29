<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="reply.Reply" %>
<%@ page import="reply.ReplyDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/custom.css">

    <title>맛집 게시판</title>
</head>
<body>
    <%
        int review_idx = 0; // 수정: bbsID를 review_idx로 변경
        if (request.getParameter("review_idx") != null){
            review_idx = Integer.parseInt(request.getParameter("review_idx"));
        }
        int reply_idx = 0;
        if (request.getParameter("reply_idx") != null){
            reply_idx = Integer.parseInt(request.getParameter("reply_idx"));
        }
        ReplyDAO replyDAO = new ReplyDAO();
        Reply reply = replyDAO.getReply(reply_idx);
        String reply_cmt = reply.getReply_cmt(); // 수정: getUpdateComment 메서드 대신 reply 객체에서 직접 댓글 내용을 가져옴
    %>
    <div class="container" align="center">
        <div class="col-lg-10">
            <div class="jumbotron" style="padding-top: 1px;">               
                <h3><br>댓글수정창</h3>
                <form name="c_commentUpdate">
                    <!-- 수정된 부분: 댓글 내용을 텍스트 박스에 표시 -->
                    <input type="text" id="update" style="width:400px;height:50px;" maxlength="1024" value="<%= reply_cmt %>">
                    <input type="button" onclick="send(<%= review_idx %>,<%= reply_idx %>)" value="수정">
                    <br><br>
                    <!-- 파일 업로드를 처리하기 위한 input 추가 -->
                    <input type="file" id="updatePicture" name="updatePicture"/>        
                </form>
            </div>
        </div>
        <div class="col-lg-10"></div>
    </div>
</body>
<script>
    // 파일 업로드 input의 변화 감지 이벤트 핸들러 등록
    var upload = document.querySelector('#updatePicture');
    updatePicture.addEventListener('change', handleFileSelect);

    function send(review_idx, reply_idx){
        // 댓글 내용과 관련된 변수
        var reply_cmt = document.c_commentUpdate.update.value;
        
        // 여기에 파일 업로드 처리 로직 추가
        var file = updatePicture.files[0];
        var formData = new FormData();
        formData.append('updatePicture', file);

        // XMLHttpRequest를 사용하여 파일 업로드
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'replyUpdateAction.jsp?' + 'review_idx=' + review_idx + '&reply_idx=' + reply_idx + '&reply_cmt=' + reply_cmt, true);
        xhr.send(formData);

        // 수정된 부분: 부모 창 리로딩
        window.opener.location.reload();
        
        // 현재 창 닫기
        window.close();
    }

    function handleFileSelect() {
        // 파일 업로드 처리 로직 추가
    }
</script>
</html>
