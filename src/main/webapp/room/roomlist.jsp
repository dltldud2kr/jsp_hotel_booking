<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*, room.*"%>

<jsp:useBean id="RoomMgrP" class="room.RoomMgr" scope="page"/>

<html>
<head> 
<title>객실 리스트</title>
<script src="https://cdn.tailwindcss.com"></script>

<style>
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
<body class="bg-gray-100">
<div class="container mx-auto py-10">
<h2 class="text-2xl font-bold text-center mb-6">객실 리스트</h2>
<%
	Vector<RoomBean> vlist = RoomMgrP.getRoomList();
	int counter = vlist.size();
	for(int i=0; i<vlist.size(); i++){
   		RoomBean RoomList = vlist.get(i);
%>
<div class="flex mb-4 card">
	<div class="w-full sm:w-1/2 md:w-1/3 lg:w-1/4 xl:w-1/5">
		<div>
			<img src="/MaNolja/img/<%=RoomList.getRoom_title()%>1.jpg" alt="배치도">
		</div>
	</div>
	<div class="w-full sm:w-1/2 md:w-2/3 lg:w-3/4 xl:w-4/5 content">
		<h4 class="font-bold text-2xl mb-2"><%=RoomList.getRoom_title()%></h4>
		<p class="text-gray-700 text-sm mb-2"><%=RoomList.getRoom_detail()%></p>
		<p class="text-gray-700 text-sm mb-2"><%=RoomList.getRoom_area()%>㎡</p>
		<p class="text-red-500 font-bold text-lg mb-4">₩ <%=RoomList.getRoom_price()%></p>
		<form action="/MaNolja/room/roomdetail.jsp?room_id=<%=RoomList.getRoom_idx() %>" method="GET" name="detail">
		<input type="hidden" value="<%=RoomList.getRoom_idx()%>" name="room_id">
		<button class="bg-red-500 text-white px-4 py-2 rounded-lg" onClick="submit">자세히보기</button>
		</form>
	</div>
</div>
<%
   }
%>
<h2 class="text-2xl text-center mt-6">총 객실 수: <%= counter %></h2>
</div>
</body>
</html>
