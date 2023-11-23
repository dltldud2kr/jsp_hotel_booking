<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*, room.*"%>

<jsp:useBean id="RoomMgrP" class="room.RoomMgr" scope="page"/>

<html>
<head> 
<title>객실 리스트</title>
<script src="https://cdn.tailwindcss.com"></script>

<style>
.room-info {
	width: 80%;
	margin: 100px auto;
}
@media (max-width: 960px) {
    .room-info {
        flex-direction: column;
        width: 100%;
    }
}
</style>
</head>
<body class="bg-gray-100">
<div class="container mx-auto py-10">
<h2 class="text-3xl font-bold text-center mb-6">객실 리스트</h2>
<%
	Vector<RoomBean> vlist = RoomMgrP.getRoomList();
	int counter = vlist.size();
	for(int i=0; i<vlist.size(); i++){
   		RoomBean RoomList = vlist.get(i);
%>
<div class="flex mb-4 room-info">
	<div class="w-full sm:w-1/2 md:w-1/3 lg:w-1/4 xl:w-1/5">
		<img src="/MaNolja/img/<%=RoomList.getRoom_title()%>1.jpg" alt="배치도" class="w-full h-56 object-cover object-center rounded-lg shadow">
	</div>
	<div class="w-full sm:w-1/2 md:w-2/3 lg:w-3/4 xl:w-4/5 pl-4">
		<h4 class="font-bold text-2xl mb-2"><%=RoomList.getRoom_title()%></h4>
		<p class="text-gray-700 text-sm mb-2"><%=RoomList.getRoom_detail()%></p>
		<p class="text-gray-700 text-sm mb-2"><%=RoomList.getRoom_area()%>㎡</p>
		<p class="text-red-500 font-bold text-lg">₩ <%=RoomList.getRoom_price()%></p>
		<form action="/MaNolja/room/roomdetail.jsp" method="POST" name="detail">
		<input type="hidden" value="<%=RoomList.getRoom_idx()%>" name="room_id">
		<button class="bg-red-500 text-white px-4 py-2 rounded-lg" onClick="submit">자세히보기</button>
		</form>
	</div>
</div>
<%
   }
%>
<h3 class="text-center mt-6">총 객실 수: <%= counter %></h3>
</div>
</body>
</html>
