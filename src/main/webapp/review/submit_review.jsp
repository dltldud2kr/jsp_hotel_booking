<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="review.ReviewDAO" %>
<%@ page import="review.Review" %>
<%@ page import="java.util.Date" %>

<%
    ReviewDAO reviewDAO = new ReviewDAO();

    String memIdxStr = request.getParameter("mem_idx");
    String roomIdxStr = request.getParameter("room_idx");
    String reviewTitle = request.getParameter("review_title");
    String reviewCmt = request.getParameter("review_cmt");

    try {
        int memIdx = Integer.parseInt(memIdxStr);
        int roomIdx = Integer.parseInt(roomIdxStr);

        Review review = new Review(memIdx, roomIdx, reviewTitle, reviewCmt);

        int reviewIdx = reviewDAO.write(memIdx, roomIdx, reviewTitle, reviewCmt);

        if (reviewIdx != -1) {
            // Review successfully saved
            out.println("<p>리뷰를 작성해 주셔서 감사합니다 ~ 리뷰 ID: " + reviewIdx + "</p>");
        } else {
            // Error saving the review
            out.println("<p>리뷰를 저장하는 중 오류가 발생했습니다.</p>");
        }
    } catch (NumberFormatException e) {
        out.println("<p>유효하지 않은 회원 ID 또는 객실 ID입니다.</p>");
    }
%>

<!DOCTYPE html> 	
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 완료</title>
</head>
<body>
    <!-- 리뷰를 제출한 후 사용자를 reviews.jsp로 리디렉션합니다. -->
    <%
        // Redirect after displaying the message
        response.setHeader("Refresh", "3; URL=reviews.jsp");
    %>
</body>
</html>	