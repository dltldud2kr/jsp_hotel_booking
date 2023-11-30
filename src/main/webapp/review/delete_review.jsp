<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="review.ReviewDAO" %>
<%@ page import="review.Review" %>

<%
try {
    int review_idx = Integer.parseInt(request.getParameter("review_idx"));

    // Initialize ReviewDAO
    ReviewDAO reviewDAO = new ReviewDAO();
    Review existingReview = reviewDAO.getReview(review_idx);

    // Check if review exists
    if (existingReview != null) {
        // Delete review
        reviewDAO.delete(review_idx);
%>
        <div class="container">
            <h2>Delete review</h2>
            <p>Your review has been successfully deleted.</p>
            <p><a href="hotel_reviews.jsp">Back to hotel reviews</a></p>
        </div>
<%
    } else {
%>
        <div class="container">
            <p>No review found to delete.</p>
        </div>
<%
    }
} catch (Exception e) {
    e.printStackTrace();
    // Handle exceptions as needed.
}
%>