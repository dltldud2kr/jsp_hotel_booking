<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reply.ReplyMgr"%>
<%@ page import="reply.ReplyBean"%>
<%@ page import="review.*"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>댓글</title>
</head>
<body>
<%
// 현재 세션에 저장된 사용자 이름을 가져옴 
    String mem_id = null;
    if (session.getAttribute("mem_id") != null) {
        mem_id = (String) session.getAttribute("mem_id");
    }
    int room_id = 0;
    if (request.getParameter("room_id") != null){
        room_id = Integer.parseInt(request.getParameter("room_id"));
    }
    // room_id가 0이면 유효하지 않은 글로 판단
    if (room_id == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");
        script.println("location.href = '../member/login.jsp'");
        script.println("</script>");
    }

    // ReviewDAO를 사용하여 review 정보를 가져옴
    Review review = new ReviewDAO().getReview(room_id);
    // ReplyDAO를 사용하여 해당 review에 대한 댓글 리스트를 가져옴
    ReplyBean reply = new ReplyMgr().getReply(room_id);
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
                        ReplyMgr replyDAO = new ReplyMgr();
                                                                        ArrayList<ReplyBean> list = replyDAO.getList(room_id);
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
                                            <td align="left"><%=list.get(i).getMem_id()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=list.get(i).getCreated_at()%></td>
                                            <td colspan="2"></td>
                                            <td align="right">
                                                <!-- 댓글 작성자가 현재 로그인한 사용자와 동일하면 수정 및 삭제 버튼 표시 -->
                                                <%
                                                if (list.get(i).getMem_id() != null && list.get(i).getMem_id().equals(mem_id)) {
                                                %>
                                                <!-- 수정 버튼 -->
                                                <form name="p_search">
                                                    <a type="button"
                                                        onclick="nwindow(<%=room_id%>, <%=list.get(i).getReply_idx()%>)"
                                                        class="btn-primary">수정</a>
                                                </form>
                                                <!-- 삭제 버튼 -->
                                                <a onclick="return confirm('정말로 삭제하시겠습니까?')"
                                                href="../reply/replyDeleteAction.jsp?room_id=<%=room_id%>&reply_idx=<%=list.get(i).getReply_idx()%>"
                                                class="btn-primary">삭제</a>
                                                <%
                                                }
                                                %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <!-- 댓글 내용 표시 -->
                                            <td colspan="5" align="left"><%=list.get(i).getReply_cmt()%></td>
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
    <!-- 댓글 입력 폼 -->
    <div class="container">
        <div class="form-group">
            <form method="post" action="../reply/replyAction.jsp?room_id=<%=room_id%>">
                <table class="table table-striped"
                    style="text-align: center; border: 1px solid #dddddd">
                    <tr>
                        <td style="border-bottom: none;" valign="middle"><br>
                        <br><%=mem_id%></td>
                        <!-- 댓글 입력 텍스트 박스 -->
                        <td><input type="text" style="height: 100px;"
                           class="form-control" placeholder="상대방을 존중하는 댓글을 남깁시다."
                            name="reply_cmt"></td>
                        <td><br>
                        <br>
                        <!-- 댓글 작성 버튼 -->
                        <input type="submit" class="btn-primary pull" value="댓글 작성"></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <!-- 댓글 수정 창을 열기 위한 스크립트 -->
    <script type="text/javascript">
        function nwindow(room_id, reply_idx) {
            window.name = "commentParant";
            var url = "../reply/replyUpdate.jsp?room_id="
                    + room_id + "&reply_idx=" + reply_idx;
            window.open(url, "댓글 수정", "width=500, height=300");
        }
    </script>
</body>
</html>
