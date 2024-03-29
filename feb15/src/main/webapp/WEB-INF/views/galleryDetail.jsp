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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script type="text/javascript">
        function deletePost(){
        	Swal.fire({
        		title: "글 지우기?",
        	    text: "post를 삭제합니다.",
        	    icon: "warning",
        	    showCancelButton: true,
        	    confirmButtonColor: "#3085d6",
        	    cancelButtonColor: "#d33",
        	    confirmButtonText: "지우기"
        	    }).then((result) => { //화살표 문법
        	    	if (result.isConfirmed) {
        	    		//java에 삭제하라고 명령 내리는 코드
        	    		//가상 form 선언
        	    		let vform = $("<form></form>");
        	    		//속성지정
        	    		vform.attr("name", "vform"); // name은 필수 아닌 옵션
        	    		vform.attr('method', 'post');
        	    		vform.attr('action', './galleryDel');
        	    		//
        	    		vform.append($('<input/>', {type:'hidden', name:'no', value:${detail.gno } }));
        	    		vform.appendTo('body');
        	    		vform.submit();
        	    		
        	    		//let vform = $("<form name=''></form>");        	    		
        	    		//Swal.fire({"Deleted!", "Your file has been deleted.", "success"});
        	    		}
        	    	});
        	}
        //조아요
        function like(no){
        	Swal.fire("좋아요를 누릅니다", "", "success");
        	location.href="./galleryLike?no="+no;
        }
        </script>
    </head>
    <body id="page-top">
        <!-- Navigation-->
       	<%@ include file="menu.jsp" %>
        
        <!-- 톺아보기 -->
        <section class="page-section" id="services">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">갤러리 톺아보기</h2>
                </div>
                <div class="card mb-4" style="min-height: 500px">
                	<div class="card-body">
                		<div class="h3">${detail.gtitle}
                		<span><img alt="like" src="./img/like.png" onclick="like(${detail.gno})">${detail.glike }</span>
                		</div>
                		<div class="row p-2 bg-secondary">
                			<div class="col align-middle text-start">${detail.mname}<c:if test="${detail.mid eq sessionScope.mid }">
                			<img alt="edit" src="./img/edit.png" title="글 수정" onclick="edit(${detail.gno})">
                			<img alt="delete" src="./img/delete.png" title="글 삭제" onclick="deletePost(${detail.gno})"></c:if></div>
                			<div class="col align-middle text-end">${detail.gdate}</div>
                		</div>
                		<div class="mt-4 h-auto">
                		<img alt="image" class="img-fluid" src="./upfile/${detail.gfile }"><br>
                		${detail.gcontent}</div>
                	</div>					
                </div>
	        	<button class="btn btn-warning" onclick="history.back()">게시판으로</button>
            </div>
        </section>
        
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>
