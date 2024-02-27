<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>공지사항</title>
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
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<!-- summer note -->
		<script src="/js/summernote/summernote-lite.js"></script>
		<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
		<script src="/js/summernote/summernote-bs4.min.js"></script>
		<link href="/css/summernote/summernote-lite.css" rel="stylesheet">
		<link href="/css/summernote/summernote-bs4.min.css" rel="stylesheet">
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
    	
    	function linkPage(pageNo){
        	location.href = "./notice?pageNo=" + pageNo;
        }
    	
    </script>
    </head>
    <body id="page-top">
        <!-- Navigation-->
       	<%@ include file="menu.jsp" %>
        
        <!-- 게시판 -->
        <section class="page-section" id="services">
            <div class="container">
                <div class="text-center">
                    <h3 class="section-heading text-uppercase">공지사항</h3>
                </div>
                <div class="row text-center">
                <c:set var="now" value="<%=new Date() %>"/>
				<fmt:formatDate var="today" value="${now }" pattern="yyyy-MM-dd"/>
                	<c:choose>
                		<c:when test="${fn:length(list) ne 0 }">
	                    <table class="table table-hover">
							<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>날짜</th>
								<th>읽음</th>
							</tr>
							</thead>
							<tbody>
								<c:forEach items="${list }" var="row">
								<tr onclick="location.href='./noticeDetail?no=${row.nno}'">
									<td onclick="ndetail(${row.nno})">${row.nno }</td>
									<td class="title">${row.ntitle } [${row.nlike }]</td>
									<td>
									<fmt:parseDate value="${row.ndate }" var="date" pattern="yyyy-MM-dd hh:mm"/>
									<fmt:formatDate value="${date}" var="ndate" pattern="yyyy-MM-dd"/>
									<c:choose>
									<c:when test="${ndate eq today}">
									<fmt:formatDate value="${date}" var="showdate" pattern="hh:mm"/>&#127381;${showdate }			
									</c:when>
									<c:otherwise>
									<fmt:formatDate value="${date}" var="showdate" pattern="MM/dd"/>${showdate }
									</c:otherwise>
									</c:choose></td>
									<td>${row.nread }</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
						</c:when>
                		<c:otherwise>화면에 출력할 값이 없습니다.</c:otherwise>
                	</c:choose>
                	<!-- 페이징 -->
					<div>
						<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
					</div>
					<!-- 글쓰기 -->
						<button type="button" class="btn btn-info" style="width: 100px" data-bs-toggle="modal" data-bs-target="#write">글쓰기</button>
                </div>
            </div>
        </section> 

        <!-- 톺아보기 모달 만들기 -->
        <div class="modal" id="detail">
        	<div class="modal-dialog modal-xl">
        		<div class="modal-content">
        			<div class="modal-header">
        				<h4 class="modal-title" id="modalTitle">톺아보기</h4>
        				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        			</div>
        			<div class="modal-body">
        				<div class="mt-2" id="modalContent">
	        				제목<br>
	        				본문내용
        				</div>
        			</div>
        			<div class="modal-footer">
        				톺아보기 모달 닫기
        			</div>
        		</div>
        	</div>
        </div>
               
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
        <script type="text/javascript">
        $(function(){
    		$('#summernote').summernote({
    			lang: 'ko-KR', // default: 'en-US'
    			height: 600,
    			fontNames : ['D2Coding', 'Arial Black', 'Comic Sans MS', 'Courier New'],
    			toolbar: [
    			    // [groupName, [list of button]]
    			    ['style', ['bold', 'italic', 'underline', 'clear']],
    			    /* ['font', ['strikethrough', 'superscript', 'subscript']], */
    			    ['fontname', ['fontname','fontsize', 'color']],
    			    ['para', ['ul', 'ol', 'paragraph']],
    			    /* ['height', ['height']] */
    			    ['table', ['table','link', 'picture', 'video']],
    			    ['view', ['fullscreen', 'codeview', 'help']]
    			  ]
    		});
    	});
        </script>
    </body>
</html>
