<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*, room.*"%>

<jsp:useBean id="RoomMgrP" class="room.RoomMgr" scope="page"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<html>
<head> 
<title>객실 리스트</title>

<%
	String startDate = request.getParameter("start-date");
	String endDate = request.getParameter("end-date");
	String people = request.getParameter("people");
%>
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
	box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
}
.card:hover {
	transform: scale(1.02);
	box-shadow: 0 1rem 2rem rgba(0, 0, 0, 0.2);
}
@keyframes fadeIn {
    from {opacity: 0;}
    to {opacity: 1;}
}

.card img {
	object-fit: cover;
	height: 200px;
	animation: fadeIn 1s ease-in;
}
.card .content {
	padding: 20px;
	border-left: 1px solid #e5e7eb;
}

.btn-danger {
    background-color: #f54242;
    border-color: #f54242;
    transition: background-color 0.3s, border-color 0.3s;
}

.btn-danger:hover {
    background-color: #f52020;
    border-color: #f52020;
}
.flatpickr-calendar {
	z-index: 99 !important;
}

@media (max-width: 960px) {
    .card {
        flex-direction: column;
        width: 100%;
    }
}
</style>
<script>
window.addEventListener('DOMContentLoaded', function() {
	// Flatpickr 설정
	var fp = flatpickr("#datePickerBtn", {
		mode: "range",
		dateFormat: "Y-m-d",
		onChange: function(selectedDates, dateStr, instance) {
			if (selectedDates.length === 2) {
				var start = instance.formatDate(selectedDates[0], "Y-m-d");
				var end = instance.formatDate(selectedDates[1], "Y-m-d");

				// 날짜를 hidden input 요소에 설정
				document.getElementById('startDate').value = start;
				document.getElementById('endDate').value = end;

				// 날짜를 버튼의 텍스트로 설정
				document.getElementById('datePickerBtn').textContent = start + ' - ' + end;

				instance.close();
			}
		},
		defaultDate: [<%= startDate == null ? "null" : "\"" + startDate + "\"" %>, <%= endDate == null ? "null" : "\"" + endDate + "\"" %>]
	});

	document.getElementById('datePickerBtn').addEventListener('click', function() {
		fp.open();
	});
	
	// 인원 선택 드롭다운 메뉴 설정
	var peopleSelect = document.getElementById('peopleSelect');
	peopleSelect.value = "<%= people == null ? "0" : people %>";
	peopleSelect.addEventListener('change', function() {
		document.getElementById('people').value = this.value;
	});
});
</script>
</head>
<body class="bg-light">
<jsp:include page="/header.jsp"/>
<div class="container py-5">
<h2 class="text-center mb-4">객실 리스트</h2>
<div class="row">
    <div class="col-lg-9">
        <button id="datePickerBtn" class="btn btn-outline-secondary mr-3">
            <%= startDate != null && endDate != null ? startDate + " - " + endDate : "입실/퇴실 날짜 선택" %>
        </button>
        <select id="peopleSelect" class="btn btn-outline-secondary mr-3" id="people" name="people">
            <option selected value="0">인원 선택</option>
            <option value="1">1명</option>
            <option value="2">2명</option>
            <option value="3">3명</option>
            <option value="4">4명</option>
        </select>
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
    </div>
    <div class="col-lg-3">
        <div class="sidebar">
            <div class="sidebar-section">
                <h4 class="sidebar-section-title">Special Offers</h4>
                <img src="discount.jpg" alt="Discount Image" class="w-100">
                <p class="sidebar-section-text">Enjoy our special discount for your stay! Limited time only.</p>
            </div>
            <div class="sidebar-section">
                <h4 class="sidebar-section-title">Notice</h4>
                <ul class="sidebar-notice-list">
                    <li><a href="#">Notice 1</a></li>
                    <li><a href="#">Notice 2</a></li>
                    <li><a href="#">Notice 3</a></li>
                </ul>
            </div>
            <div class="sidebar-section">
                <h4 class="sidebar-section-title">Phone Reservation</h4>
                <p class="sidebar-section-text"><i class="fas fa-phone"></i> 053-940-5175</p>
            </div>
        </div>
    </div>
</div>
</div> <!-- 이곳이 container의 닫는 div 태그입니다. -->
<jsp:include page="/footer.jsp"/>
</body>

</html>
