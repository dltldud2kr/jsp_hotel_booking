<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="reply.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Date" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 댓글 객체를 사용하기 위해 빈(bean)을 선언하고 설정 -->
<jsp:useBean id="comment" class="reply.Reply" scope="page" />
<jsp:setProperty name="comment" property="reply_cmt" /> <!-- 수정: commentText를 reply_cmt로 변경 -->

<%
    // 현재 세션에 저장된 사용자 이름을 가져옴
    String mem_name = null; // 수정: userID를 mem_name으로 변경
    if(session.getAttribute("mem_name") != null){
        mem_name = (String) session.getAttribute("mem_name");
    }
    
    String realFolder = "";
    String saveFolder = "commentUpload";
    String encType = "utf-8";
    int maxSize = 5 * 1024 * 1024;

    // 실제 업로드 폴더의 경로 설정
    ServletContext context = this.getServletContext();
    realFolder = context.getRealPath(saveFolder);

    // 파일 업로드를 위한 멀티파트 요청 처리
    MultipartRequest multi = null;
    multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

    // 업로드된 파일명 및 댓글 내용 가져오기
    String fileName = multi.getFilesystemName("fileName");
    String reply_cmt = multi.getParameter("reply_cmt"); // 수정: commentText를 reply_cmt로 변경

    // 로그인 여부 확인
    if(mem_name == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    } else {
        int review_idx = 0; // 수정: bbsID를 review_idx로 변경
        if (request.getParameter("review_idx") != null){
            review_idx = Integer.parseInt(request.getParameter("review_idx"));
        }

        // review_idx가 0이면 유효하지 않은 글로 판단
        if (review_idx == 0){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('유효하지 않은 글입니다.')");
            script.println("location.href = 'login.jsp'");
            script.println("</script>");
        }

        // 댓글 내용이 비어있는지 확인
        if (reply_cmt == null || reply_cmt.trim().isEmpty()){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            // 댓글 작성 DAO 호출
            ReplyDAO replyDAO = new ReplyDAO();
            int reply_idx = replyDAO.write(review_idx, reply_cmt, mem_name);

            if (reply_idx == -1){
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('댓글 쓰기에 실패했습니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                PrintWriter script = response.getWriter();
                // 업로드된 파일이 있다면 파일명 변경
                if(fileName != null){
                    File oldFile = new File(realFolder + "\\" + fileName);
                    File newFile = new File(realFolder + "\\" + review_idx + "사진" + (reply_idx - 1) + ".jpg");
                    oldFile.renameTo(newFile);
                }
                // 댓글 작성 성공 시 이전 페이지로 이동
                script.println("<script>");
                script.println("location.href=document.referrer;");
                script.println("</script>");
            }
        }
    }
%>
</body>
</html>
