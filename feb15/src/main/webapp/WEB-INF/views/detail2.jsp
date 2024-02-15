<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<h1>톺아보기</h1>
	${detail.board_no }
	${detail.board_title}
	${detail.mname}
	${detail.board_date}
	${detail.board_content}

</body>
</html>