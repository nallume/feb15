<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>게시판</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/favicon.ico" />
        <link rel="apple-touch-icon" sizes="57x57" href="assets/apple-icon-57x57.png">
		<link rel="apple-touch-icon" sizes="60x60" href="assets/apple-icon-60x60.png">
		<link rel="apple-touch-icon" sizes="72x72" href="assets/apple-icon-72x72.png">
		<link rel="apple-touch-icon" sizes="76x76" href="assets/apple-icon-76x76.png">
		<link rel="apple-touch-icon" sizes="114x114" href="assets/apple-icon-114x114.png">
		<link rel="apple-touch-icon" sizes="120x120" href="assets/apple-icon-120x120.png">
		<link rel="apple-touch-icon" sizes="144x144" href="assets/apple-icon-144x144.png">
		<link rel="apple-touch-icon" sizes="152x152" href="assets/apple-icon-152x152.png">
		<link rel="apple-touch-icon" sizes="180x180" href="assets/apple-icon-180x180.png">
		<link rel="icon" type="image/png" sizes="192x192"  href="assets/android-icon-192x192.png">
		<link rel="icon" type="image/png" sizes="32x32" href="assets/favicon-32x32.png">
		<link rel="icon" type="image/png" sizes="96x96" href="assets/favicon-96x96.png">
		<link rel="icon" type="image/png" sizes="16x16" href="assets/favicon-16x16.png">
		<link rel="manifest" href="assets/manifest.json">
		<meta name="msapplication-TileColor" content="#ffffff">
		<meta name="msapplication-TileImage" content="/ms-icon-144x144.png">
		<meta name="theme-color" content="#ffffff">
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/board.css" rel="stylesheet" />
    <script type="text/javascript">
    	function writeCheck(){
    		//alert("글쓰기 버튼을 눌렀습니다");
    		let title = document.querySelector("#title");
    		let content = document.querySelector("#content");
    		//alert(title.value + content.value);
    		
    		if(title.value.length < 5){
    			alert("제목은 다섯 글자 이상이어야 합니다.");
    			title.focus();
	    		return false;   			
    		}
    		if(content.value.length < 10){
    			alert("본문 내용은 열 글자 이상이어야 합니다.");
	 	   		content.focus();
    			return false;			
    		}
    	}
    </script>
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <c:import url="menu.jsp"/>
        
        <!-- 게시판 -->
        <section class="page-section" id="services">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">게시판</h2>
                </div>
                <div class="row text-center">
                    <table class="table table-hover">
						<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>글쓴이</th>
							<th>날짜</th>
							<th>읽음</th>
						</tr>
						</thead>
						<tbody>
							<c:forEach items="${list }" var="row">
							<tr>
								<td>${row.board_no }</td>
								<td class="title">
								<a href="./detail?no=${row.board_no }">${row.board_title } 
								<c:if test="${row.comment gt 0 }">[${row.comment }]</c:if></a>
								</td>
								<td>${row.mname }</td>
								<td>${row.board_date }</td>
								<td>${row.board_count }</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- 페이징 -->
					
					<!-- 글쓰기 -->
					<button type="button" class="btn btn-info" style="width: 100px" data-bs-toggle="modal" data-bs-target="#write">글쓰기</button>
                </div>
            </div>
        </section> 
        
        <!-- 글쓰기 모달 만들기 -->
        <div class="modal" id="write">
        	<div class="modal-dialog modal-xl">
        		<div class="modal-content">
        			<div class="modal-header">
        				<h4 class="modal-title">글쓰기 창입니다</h4>
        				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        			</div>
        			<div class="modal-body">
        				<div class="mt-2">
	        				<form action="./write" method="post" onsubmit="return writeCheck()" name="frm">
	        					<input type="text" name="title" class="form-control mb-2" id="title" required="required" placeholder="제목을 입력하세요.">
	        					<textarea name="content" class="form-control mb-2 vh-500" id="content" required="required"></textarea>
	        					<button type="submit" class="btn btn-info">글쓰기</button>
	        				</form>
        				</div>
        			</div>
        		</div>
        	</div>
        </div>
               
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>
