<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<h1>보드</h1>
	
	<table>
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="row">
			<tr>
				<td>${row.board_no }</td>
				<td>
				<a href="./detail?no=${row.board_no }">
				${row.board_title }
				</a>&ensp;${row.comment }
				</td>
				<td>${row.mname }</td>
				<td>${row.board_date }</td>
				<td>${row.board_count }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>

</body>
</html>