<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="review.Review"%>
<%@ page import="review.ReviewDAO"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Review Home</title>
    <!-- Import Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        table {
            border-spacing: 0;
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #e2e8f0;
            padding: 8px;
            text-align: center;
        }
    </style>
</head>
<body class="bg-gray-100">
<div class="container mx-auto py-10">
    <h1 class="text-3xl font-bold text-center mb-6">Review</h1>

    <!-- Get top 3 reviews via ReviewDAO -->
    <%
        ReviewDAO reviewDAO = new ReviewDAO();
        ArrayList<Review> recentReviews = reviewDAO.getMostRecentReviews(3);
    %>

    <!-- Show table only if there is at least one review -->
    <%
        if (!recentReviews.isEmpty()) {
    %>
    <table>
        <thead>
        <tr>
            <th>Review Title</th>
            <th>Review content</th>
            <th>Created date</th>
        </tr>
        </thead>
        <tbody>
        <!-- repeat rows for top 3 reviews -->
        <%
            for (Review review : recentReviews) {
        %>
        <tr>
            <td><c:out value="${review.getReview_title()}" /></td>
            <td><c:out value="${review.getReview_cmt()}" /></td>
            <td><c:out value="${review.getCreated_at()}" /></td>
            <td>
                <a href="javascript:void(0);" onclick="showDetailedView('<c:out value="${review.getId()}" />')">View Details</a>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <!-- Detailed View Section -->
    <div id="detailedView" style="display: none;">
        <h2>Detailed Review</h2>
        <div id="detailedContent"></div>
        <button onclick="hideDetailedView()">Close</button>
    </div>

    <!-- Link to the rest of the review list -->
    <div class="mt-6 text-center">
        <a href="review_list.jsp" class="text-blue-500">See more reviews</a>
    </div>
    <%
        } else {
    %>
    <p class="text-center text-gray-500">No reviews</p>
    <%
        }
    %>

    <!-- Form to go to write a review -->
    <div class="mt-6 text-center">
        <form action="review_form.jsp" method="get">
            <input type="submit" value="Write a review"
                   class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        </form>
    </div>
</div>
<script>
   function showDetailedView(reviewId) {
        // Use AJAX to fetch detailed review content based on the reviewId
        var xhr = new XMLHttpRequest();

        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // Update the detailedContent div with the fetched content
                document.getElementById("detailedContent").innerHTML = xhr.responseText;

                // Display the detailedView div
                document.getElementById("detailedView").style.display = "block";
            }
        };

        // Replace 'your_fetch_details_url' with the actual URL to fetch detailed review content
        xhr.open("GET", "your_fetch_details_url?reviewId=" + reviewId, true);
        xhr.send();
    }

    function hideDetailedView() {
        // Hide the detailedView div
        document.getElementById("detailedView").style.display = "none";
    }
</script>

</body>
</html>