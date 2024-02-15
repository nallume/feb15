<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
</head>
<body>
	회원관리
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>가입날짜</th>
				<th>등급</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${list }" var="row">
			<tr>
				<td>${row.mno }</td>
				<td>${row.mid }</td>
				<td>${row.mname }</td>
				<td>${row.mdate }</td>
				<td>${row.mgrade }</td>
			</tr>
		</c:forEach>	
		</tbody>
	</table>
</body>
</html>