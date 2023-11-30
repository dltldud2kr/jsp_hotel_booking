<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="review.Review" %>
<%@ page import="review.ReviewDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 목록</title>
    <!-- Tailwind CSS를 가져옵니다 -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto py-10">
        <h1 class="text-3xl font-bold text-center mb-6">리뷰 목록</h1>

        <%-- ReviewDAO를 통해 모든 리뷰를 가져옵니다 --%>
        <%
            ReviewDAO reviewDAO = new ReviewDAO();	
            ArrayList<Review> reviewList = reviewDAO.getAllReviews();
        %>

        <%-- 리뷰가 하나 이상 있는 경우에만 테이블을 표시합니다 --%>
        <% if (!reviewList.isEmpty()) { %>
            <table class="w-full bg-white border border-gray-300">
                <thead>
                    <tr>
                        <th class="border border-gray-300 px-4 py-2">리뷰 제목</th>
                        <th class="border border-gray-300 px-4 py-2">리뷰 내용</th>
                        <th class="border border-gray-300 px-4 py-2">작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- 각 리뷰에 대한 행을 반복합니다 --%>
                    <% for (Review review : reviewList) { %>
                        <tr>
                            <td class="border border-gray-300 px-4 py-2"><%= review.getReview_title() %></td>
                            <td class="border border-gray-300 px-4 py-2"><%= review.getReview_cmt() %></td>
                            <td class="border border-gray-300 px-4 py-2"><%= review.getCreated_at() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <p class="text-center text-gray-500">리뷰가 없습니다.</p>
        <% } %>

        <!-- 여기에 자바스크립트 또는 부트스트랩 스크립트를 추가합니다 -->

    </div>
</body>
</html>