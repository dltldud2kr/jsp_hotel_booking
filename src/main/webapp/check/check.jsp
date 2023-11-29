<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="check.ReservationBean"%>
<%@ page import="check.DBConnectionMgr"%>

<jsp:useBean id="checkMgr" class="check.checkMgr" scope="page" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.table-container {
	display: flex;
	align-items: flex-start;
}

table {
	border-collapse: collapse;
	width: 50%;
	margin-top: 20px;
}

th, td {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

th {
	background-color: #f2f2f2;
}

.button-container {
	margin-top: 20px;
	margin-left: 20px; /* 표와 버튼 간의 간격 조절 */
	align-self: center; /* 버튼을 세로 중앙에 정렬 */
}

.confirm-button {
	padding: 10px;
	font-size: 16px;
	cursor: pointer;
}
</style>
</head>
<body>
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
		crossorigin="anonymous">
	<jsp:include page="../header.jsp" />

	<h2>BOOKING</h2>
	<div>
		<h3>예약 정보</h3>
	</div>

	<%
	// 폼에서 전송된 파라미터 값을 얻어옴
	String startdate = request.getParameter("start_date");
	String enddate = request.getParameter("end_date");
	int room_idx = Integer.parseInt(request.getParameter("room_id"));
	int room_price = Integer.parseInt(request.getParameter("room_price"));
	int people = Integer.parseInt(request.getParameter("people"));
	int mem_idx;

	Object memIdxObj = session.getAttribute("mem_idx");
	mem_idx = (int) memIdxObj;
	// ReservationBean 객체 생성
	ReservationBean reservationBean = new ReservationBean();

	reservationBean.setEnd_date(enddate);
	reservationBean.setStart_date(startdate);
	reservationBean.setRoom_idx(room_idx);
	reservationBean.setResev_price(room_price);
	reservationBean.setPeople(people);
	reservationBean.setMem_idx(mem_idx);

	// 데이터베이스에 INSERT
	DBConnectionMgr dbManager = new DBConnectionMgr();
	boolean insertionSuccess = checkMgr.insertReservation(reservationBean);

	if (insertionSuccess) {
	%>
	<div class="table-container">
		<table>
			<tr>
				<th>체크인</th>
				<th>방 번호</th>
				<th>예약금액</th>
				<th>인원</th>
			</tr>
			<tr>
				<td><%=startdate + " - " + enddate%></td>
				<td><%=room_idx%></td>
				<td><%=room_price%></td>
				<td><%=people%></td>
			</tr>
		</table>
	</div>

	<div class="button-container">
		<button class="confirm-button" onclick="redirectToMemberInfo()">예약내역확인</button>
		<button class="confirm-button" onclick="location.href='../index.jsp'">홈으로</button>
	</div>

	<%
	} else {
	out.println("Reservation failed. Please try again.");
	}
	%>
	<jsp:include page="/footer.jsp" />

</body>
<script>
	function redirectToMemberInfo() {
		// 예약내역확인 버튼을 누를 때 memberInfo.jsp로 이동하고 content1을 표시하는 함수 호출
		location.href = '../Member/memberInfo.jsp';
		showContent1(); // 예약내역확인을 위해 content1을 표시하는 함수 호출
	}
</script>
</html>
