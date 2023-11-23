<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, room.*"%>

<jsp:useBean id="RoomMgr" class="room.RoomMgr" scope="page"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방 자세히 보기</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=YouTube+Sans:wght@400;500;600;700;800&display=swap');
* {
	font-family: 'YouTube Sans', sans-serif;
	
}
.carousel {
  maring-top: 2vh;
  margin: 0 auto;
  overflow: hidden;
  justify-content: center;
  display: flex;

}
.carousel__item {
  width: 80%;
  height: auto;
  display: none;
    border-radius: 10px;
  border: 1px solid #ccc;
}
.carousel__item--visible {
  display: block;
}

.grid-details {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 1rem;
}
.grid-details img {
height: 57px;
}
.grid-info {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 2rem;
}

.icon_div {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}

.grid-info p {
  font-size: 20px;
  margin-bottom: 10px;
}

</style>
<script>
window.addEventListener('DOMContentLoaded', function() {
  var items = document.querySelectorAll('.carousel__item');
  var index = 0;

  function updateCarousel() {
    items.forEach(function(item, i) {
      item.classList.toggle('carousel__item--visible', i === index);
    });
    index = (index + 1) % items.length;
  }

  updateCarousel();
  setInterval(updateCarousel, 3000);
});
</script>
</head>
<body class="bg-gray-100">
<%
	int room_id = Integer.parseInt(request.getParameter("room_id"));
	Vector<RoomBean> vinfo = RoomMgr.getRoominfo(room_id);
   	RoomBean RoomList = vinfo.get(0);
   	String[] details = RoomList.getRoom_detail().split("\\|");
%>
<div class="carousel">
  <img class="carousel__item carousel__item--visible" src="/MaNolja/img/<%=RoomList.getRoom_title()%>1.jpg" alt="객실 사진">
	<img class="carousel__item" src="/MaNolja/img/<%=RoomList.getRoom_title()%>2.jpg" alt="객실사진2">
	<img class="carousel__item" src="/MaNolja/img/<%=RoomList.getRoom_title()%>3.jpg" alt="객실사진3">
</div>
<div class="container mx-auto py-10">
	<h2 class="text-3xl font-bold mb-4"><%=RoomList.getRoom_title()%></h2>
	<div class="grid-info">
		<div>
			<p><strong>객실 인원:</strong> <%=RoomList.getRoom_people()%>명</p>
			<p><strong>객실 면적:</strong> <%=RoomList.getRoom_area()%></p>
		</div>
		<div>
			<p><strong>배치:</strong> <%=RoomList.getRoom_map()%></p>
			<p><strong>객실 수:</strong> <%=RoomList.getRoom_num()%>개</p>
		</div>
	</div>
		<div class="grid-details">
	<%
		int counter = 1;
		for (String detail : details) {
	%>
		<div class="icon_div">
			<img src="/MaNolja/img/icon_service0<%=counter%>.svg" alt="<%=detail.trim()%>">
			<p><%=detail.trim()%></p>
		</div>
	<%
			counter++;
		}
	%>
	</div>
	<p><strong>이용안내:</strong> <%=RoomList.getRoom_guide()%></p>
	<p class="mb-2"><strong>가격:</strong> <%=RoomList.getRoom_price()%>원</p>
	<p class="mb-2"><strong>등록일:</strong> <%=RoomList.getCreated_at()%></p>
</div>
</body>
</html>
