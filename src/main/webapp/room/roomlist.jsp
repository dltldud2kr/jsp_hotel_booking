<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*, room.*"%>

<jsp:useBean id="RoomMgrP" class="room.RoomMgr" scope="page"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<html>
<head> 
<title>객실 리스트</title>


<style>
@import
	url('https://fonts.googleapis.com/css2?family=YouTube+Sans:wght@400;500;600;700;800&display=swap')
	;

* {
	font-family: 'YouTube Sans', sans-serif;
}
.card {
	width: 80%;
	margin: 100px auto;
	box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
	border-radius: 0.375rem;
	overflow: hidden;
	transition: transform 0.3s;
}
.card:hover {
	transform: scale(1.02);
}
.card img {
	object-fit: cover;
	height: 200px;
}
.card .content {
	padding: 20px;
	border-left: 1px solid #e5e7eb;
}
@media (max-width: 960px) {
    .card {
        flex-direction: column;
        width: 100%;
    }
}
</style>
</head>
<body class="bg-light">
<jsp:include page="/header.jsp"/>
<div class="container py-5">
<h2 class="text-center mb-4">객실 리스트</h2>
<%
	String startDate = request.getParameter("start-date");
	String endDate = request.getParameter("end-date");
	String people = request.getParameter("people");
%>
<%=startDate %>
<%=endDate %>
<%
	Vector<RoomBean> vlist = RoomMgrP.getRoomList();
	int counter = vlist.size();
	for(int i=0; i<vlist.size(); i++){
   		RoomBean RoomList = vlist.get(i);
%>
<div class="card mb-3">
	<div class="row no-gutters">
		<div class="col-md-4">
			<img src="/MaNolja/img/<%=RoomList.getRoom_title()%>1.jpg" class="card-img" alt="사진">
		</div>
		<div class="col-md-8">
			<div class="card-body">
				<h5 class="card-title"><%=RoomList.getRoom_title()%></h5>
				<p class="card-text"><%=RoomList.getRoom_detail()%></p>
				<p class="card-text"><small class="text-muted"><%=RoomList.getRoom_area()%>㎡</small></p>
				<p class="card-text text-danger"><%=RoomList.getRoom_price()%>원</p>
				<%
				if (startDate != null && endDate != null && people != null) {%>
						<form action="/MaNolja/room/roomdetail.jsp?room_id=<%=RoomList.getRoom_idx()%>" method="POST" name="detail">
						<input type="hidden" value="<%=RoomList.getRoom_idx()%>" name="room_id">
						<input type="hidden" value="<%=startDate%>" name="start_date">
						<input type="hidden" value="<%=endDate%>" name="end_date">
						<input type="hidden" value="<%=people%>" name="people">
						<button class="btn btn-danger">자세히보기</button>
						</form>
					<%}else {%>
					<form action="/MaNolja/room/roomdetail.jsp?room_id=<%=RoomList.getRoom_idx()%>" method="POST" name="detail">
						<input type="hidden" value="<%=RoomList.getRoom_idx()%>" name="room_id">
						<button class="btn btn-danger">자세히보기</button>
						</form>
				<%}%>
			</div>
		</div>
	</div>
</div>
<%
   }
%>
<h2 class="text-center mt-4">총 객실 수: <%= counter %></h2>
<jsp:include page="/footer.jsp"/>
</div>
</body>

</html>
