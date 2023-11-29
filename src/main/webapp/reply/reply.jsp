<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reply.ReplyDAO"%>
<%@ page import="reply.Reply"%>
<%@ page import="review.*"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>댓글</title>
</head>
<body>
<%
    // 현재 세션에 저장된 사용자 이름을 가져옴 
    String mem_name = null;
    if (session.getAttribute("mem_name") != null) {
        mem_name = (String) session.getAttribute("mem_name");
    }
    int review_idx = 0;
    if (request.getParameter("review_idx") != null){
        review_idx = Integer.parseInt(request.getParameter("review_idx"));
    }
    // review_idx가 0이면 유효하지 않은 글로 판단
    if (review_idx == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }

    // ReviewDAO를 사용하여 review 정보를 가져옴
    Review review = new ReviewDAO().getReview(review_idx);
    // ReplyDAO를 사용하여 해당 review에 대한 댓글 리스트를 가져옴
    Reply reply = new ReplyDAO().getReply(review_idx);
%>
    <!-- 댓글 표시 테이블 시작 -->
    <div class="container">
        <div class="row">
            <table class="table table-striped"
                style="text-align: center; border: 1px solid #dddddd">
                <tbody>
                    <tr>
                        <!-- 댓글 헤더 -->
                        <td align="left" bgcolor="beige">댓글</td>
                    </tr>
                    <tr>
                        <!-- 댓글 목록 -->
                        <%
                        ReplyDAO replyDAO = new ReplyDAO();
                        ArrayList<Reply> list = replyDAO.getList(review_idx);
                        for (int i = 0; i < list.size(); i++) {
                        %>
                        <!-- 각 댓글의 표시 -->
                        <div class="container">
                            <div class="row">
                                <table class="table table-striped"
                                    style="text-align: center; border: 1px solid #dddddd">
                                    <tbody>
                                        <tr>
                                            <!-- 댓글 작성자와 작성 시간 표시 -->
                                            <td align="left"><%=list.get(i).getMem_name()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=list.get(i).getCreated_at()%></td>
                                            <td colspan="2"></td>
                                            <td align="right">
                                                <!-- 댓글 작성자가 현재 로그인한 사용자와 동일하면 수정 및 삭제 버튼 표시 -->
                                                <%
                                                if (list.get(i).getMem_name() != null && list.get(i).getMem_name().equals(mem_name)) {
                                                %>
                                                <!-- 수정 버튼 -->
                                                <form name="p_search">
                                                    <a type="button"
                                                        onclick="nwindow(<%=review_idx%>, <%=list.get(i).getReply_idx()%>)"
                                                        class="btn-primary">수정</a>
                                                </form>
                                                <!-- 삭제 버튼 -->
                                                <a onclick="return confirm('정말로 삭제하시겠습니까?')"
                                                href="commentDeleteAction.jsp?review_idx=<%=review_idx%>&reply_idx=<%=list.get(i).getReply_idx()%>"
                                                class="btn-primary">삭제</a>
                                                <%
                                                }
                                                %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <!-- 댓글 내용 표시 -->
                                            <td colspan="5" align="left"><%=list.get(i).getReply_cmt()%>
                                                <!-- 댓글에 첨부된 이미지가 있으면 표시 -->
                                                <%
                                                String commentReal = "C:\\Users\\j8171\\Desktop\\studyhard\\JSP\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\BBS\\commentUpload";
                                                File commentFile = new File(commentReal + "\\" + review_idx + "사진" + list.get(i).getReply_idx() + ".jpg");
                                                if (commentFile.exists()) {
                                                %>
                                                <br>
                                                <br>
                                                <img
                                                    src="commentUpload/<%=review_idx%>사진<%=list.get(i).getReply_idx()%>.jpg"
                                                    border="300px" width="300px" height="300px"><br>
                                                <br></td>
                                                <%
                                                }
                                                %>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <%
                        }
                        %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 댓글 입력 폼 및 이미지 업로드 폼 -->
    <div class="container">
        <div class="form-group">
            <form method="post" enctype="multipart/form-data"
                action="commentAction.jsp?review_idx=<%=review_idx%>">
                <table class="table table-striped"
                    style="text-align: center; border: 1px solid #dddddd">
                    <tr>
                        <td style="border-bottom: none;" valign="middle"><br>
                        <br><%=mem_name%></td>
                        <!-- 댓글 입력 텍스트 박스 -->
                        <td><input type="text" style="height: 100px;"
                            class="form-control" placeholder="상대방을 존중하는 댓글을 남깁시다."
                            name="commentText"></td>
                        <td><br>
                        <br>
                        <!-- 댓글 작성 버튼 -->
                        <input type="submit" class="btn-primary pull" value="댓글 작성"></td>
                    </tr>
                    <tr>
                        <!-- 이미지 업로드 폼 -->
                        <td colspan="3"><input type="file" name="fileName"></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <!-- 댓글 수정 창을 열기 위한 스크립트 -->
    <script type="text/javascript">
        function nwindow(review_idx, reply_idx) {
            window.name = "commentParant";
            var url = "commentUpdate.jsp?review_idx=" + review_idx + "&reply_idx=" + reply_idx;
            window.open(url, "", "width=600,height=230,left=300");
        }
    </script>
</body>
</html>
