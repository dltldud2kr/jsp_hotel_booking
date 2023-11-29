<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="check.ReservationBean"%>
<%@ page import="check.DBConnectionMgr"%>
<%@ page import="check.checkMgr"%>

<jsp:useBean id="checkMgr" class="check.checkMgr" scope="page" />

<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Reservation Check List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

</head>
<body>

	<%
	int mem_idx;
	String mem_id;

	Object memIdxObj = session.getAttribute("mem_idx");
	mem_idx = (int) memIdxObj;
	Object memIdObj = session.getAttribute("mem_id");
	mem_id = (String) memIdObj;

	Vector<ReservationBean> checkList = checkMgr.getCheckList(mem_idx);
	%>

	<div class="container mt-5">
    <h2 class="mb-4">
        Reservation Check List for Member <%=mem_id%>
    </h2>

    <table class="table table-bordered">
        <thead>
        <tr>
            <th>예약번호</th>
            <th>방번호</th>
            <th>체크인</th>
            <th>체크아웃</th>
            <th>예약일시</th>
            <th>인원</th>
            <th>예약금액</th>
        </tr>
        </thead>
        <tbody>
        <%
        for (ReservationBean bean : checkList) {
        %>
        <tr>
            <td><%=bean.getResev_idx()%></td>
            <td><%=bean.getRoom_idx()%></td>
            <td><%=bean.getStart_date()%></td>
            <td><%=bean.getEnd_date()%></td>
            <td><%=bean.getResev_at()%></td>
            <td><%=bean.getPeople()%></td>
            <td><%=bean.getResev_price()%></td>
        </tr>
        <%
        }
        %>
        </tbody>
    </table>

    <button class="btn btn-primary" onclick="location.href='../index.jsp'">홈으로</button>
</div>


<!-- 부트스트랩 5 JS 및 Popper.js 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-WJboqJTUlcPL08dli6FOLt6YAxLxd/NmGI8aRdI4kEcFQF5G6MIUp9g+n2dI9nK" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"></script>
</body>
</html>