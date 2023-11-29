<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="reply.ReplyDAO"%>
<%@ page import="reply.Reply"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>맛집 게시판</title>
    <script type="text/javascript">
        window.name='commentUpdate';
    </script>
</head>
<body>
    <%
        String mem_name = null;
        if (session.getAttribute("mem_name") != null) {
            mem_name = (String) session.getAttribute("mem_name");
        }
        int reply_idx = 0; // 수정: commentID를 reply_idx로 변경
        if (request.getParameter("reply_idx") != null){
            reply_idx = Integer.parseInt(request.getParameter("reply_idx"));
        }
        String reply_cmt = null;
        if (request.getParameter("reply_cmt") != null){
            reply_cmt = request.getParameter("reply_cmt");
        }
        
        if (mem_name == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 하세요.')");
            script.println("location.href = 'login.jsp'");
            script.println("</script>");
        } 
        //글이 유효한지 판별
        int review_idx = 0; // 수정: bbsID를 review_idx로 변경
        if (request.getParameter("review_idx") != null) {
            review_idx = Integer.parseInt(request.getParameter("review_idx"));
        }
        if (review_idx == 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('유효하지 않은 글 입니다.')");
            script.println("location.href = 'bbs.jsp'");
            script.println("</script>");
        }
        Reply reply = new ReplyDAO().getReply(reply_idx);

        if (!mem_name.equals(reply.getMem_name())) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('권한이 없습니다.')");
            script.println("location.href = 'bbs.jsp'");
            script.println("</script>");                
        } else {
            if (reply.getReply_cmt().equals("")) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안된 사항이 있습니다')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                ReplyDAO replyDAO = new ReplyDAO();
                int result = replyDAO.update(reply_idx, reply_cmt);
                if (result == -1) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('글수정에 실패했습니다')");
                    script.println("history.back()");
                    script.println("</script>");
                } else {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    // 수정된 부분: 리뷰 상세 페이지로 이동
                    script.println("location.href= 'view.jsp?review_idx=" + review_idx + "'");
                    script.println("</script>");
                }
            }
        }
    %>
</body>
</html>
