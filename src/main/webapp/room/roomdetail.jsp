<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, room.*"%>

<jsp:useBean id="RoomMgr" class="room.RoomMgr" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방 자세히 보기</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=YouTube+Sans:wght@400;500;600;700;800&display=swap')
	;

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
	transition: opacity 0.5s ease-in-out;
}

.carousel__item--visible {
	display: block;
	opacity: 1;
}

.carousel__item:not(.carousel__item--visible) {
	opacity: 0;
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

.guide_txt {
	margin-top: 30px;
	padding: 25px 28px;
	background: #f8f8f8;
	flex-basis: 100%;
}

.guide_txt ul li {
	display: flex;
	align-items: center;
	margin-bottom: 4px;
	font-size: 15px;
}


</style>
<script>
	window.addEventListener('DOMContentLoaded', function() {
		var items = document.querySelectorAll('.carousel__item');
		var prevBtn = document.querySelector('.prev');
		var nextBtn = document.querySelector('.next');
		var index = 0;

		function updateCarousel() {
			items.forEach(function(item, i) {
				item.classList.toggle('carousel__item--visible', i === index);
			});
		}

		prevBtn.addEventListener('click', function() {
			index = (index - 1 + items.length) % items.length;
			updateCarousel();
		});

		nextBtn.addEventListener('click', function() {
			index = (index + 1) % items.length;
			updateCarousel();
		});

		updateCarousel();
		setInterval(function() {
			index = (index + 1) % items.length;
			updateCarousel();
		}, 3000);
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
	<div class="carousel mt-2 border-2 border-gray-200 rounded-lg relative">
		<img class="carousel__item carousel__item--visible"
			src="/MaNolja/img/<%=RoomList.getRoom_title()%>1.jpg" alt="객실 사진">
		<img class="carousel__item"
			src="/MaNolja/img/<%=RoomList.getRoom_title()%>2.jpg" alt="객실사진2">
		<img class="carousel__item"
			src="/MaNolja/img/<%=RoomList.getRoom_title()%>3.jpg" alt="객실사진3">
		<button class="prev absolute top-1/2 left-2 bg-white p-2 rounded-full">
			<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" class="h-6 w-6">
  			<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
			</svg>
		</button>
		<button class="next absolute top-1/2 right-2 bg-white p-2 rounded-full">
			<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" class="h-6 w-6">
  			<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
			</svg>
		</button>
	</div>

<div class="container mx-auto py-10">
    <div class="flex justify-between items-center mb-4">
        <h2 class="text-3xl font-bold"><%=RoomList.getRoom_title()%></h2>
        <a href="/MaNolja/check/check.jsp?room_id=<%=RoomList.getRoom_idx() %>" class="bg-red-500 text-white px-4 py-2 rounded-lg">예약하기</a>
    </div>
    <p class="text-2xl text-red-500 font-bold mb-4">
        <strong>₩</strong> <%=RoomList.getRoom_price()%>
    </p>
		<div class="grid-info">
			<div>
				<p>
					<strong>객실 인원:</strong>
					<%=RoomList.getRoom_people()%>명
				</p>
				<p>
					<strong>객실 면적:</strong>
					<%=RoomList.getRoom_area()%></p>
			</div>
			<div>
				<p>
					<strong>배치:</strong>
					<%=RoomList.getRoom_map()%></p>
				<p>
					<strong>객실 수:</strong>
					<%=RoomList.getRoom_num()%>개
				</p>
			</div>
		</div>
		<div class="grid-details">
			<%
			int counter = 1;
			for (String detail : details) {
			%>
			<div class="icon_div">
				<img src="/MaNolja/img/icon_service0<%=counter%>.svg"
					alt="<%=detail.trim()%>">
				<p><%=detail.trim()%></p>
			</div>
			<%
			counter++;
			}
			%>
		</div>
		<div class="guide_txt">
			<h3>
				<strong>이용안내:</strong>
			</h3>
			<ul>
				<li class="list-style-none guide_li"><%=RoomList.getRoom_guide()%></li>
				<li>예약 및 문의는 053)602-7173으로 문의 바랍니다.</li>
				<li>반려동물 동반투숙이 불가합니다.(장애인 안내견 제외)</li>
				<li>전 객실 금연입니다.</li>
			</ul>
		</div>
		<div class="md:col-span-3 text-right mt-3">
			<p>
				<strong>등록일:</strong>
				<%=RoomList.getCreated_at()%></p>
		</div>
	</div>
</body>
</html>
