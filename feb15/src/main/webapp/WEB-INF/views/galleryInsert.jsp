<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>갤러리 글쓰기</title>
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script type="text/javascript">
        const Toast = Swal.mixin({
        	toast: true,
        	position: 'center-center',
        	showConfirmButton: false,
        	timer: 3000,
        	timerProgressBar: true,
        	didOpen:(toast) => {
        		toast.onmouseenter = Swal.stopTimer;
        		toast.onmouseleave = Swal.resumeTimer;
        	}     	
        });
        
        function fileCheck(){
        	var fileVal = $("#file1").val();
        	if(fileVal == ""){
        		alert('파일을 선택하세요.');
        		return false;
        	} else {
        		var ext = fileVal.split('.').pop().toLowerCase(); // 파일명에서 확장자 분리
        		//아래 확장자가 있는지 체크
        		if($.inArray(ext, ['jpg', 'jpeg', 'gif', 'png' ]) == -1){
        			alert('jpg, jpeg, gif, png 파일만 업로드 할 수 있습니다.');
        			return false;
        		}
        	}
        }
        
        </script>
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <%@ include file="menu.jsp" %>
        
        <!-- 파일업로드-->
        <section class="page-section" id="gallery">
            <div class="d-flex justify-content-center">
            	<div class="text-center">
            		<form action="/galleryInsert" method="post" enctype="multipart/form-data" onsubmit="fileCheck()">
            		  	<div class="input-group mb-3">
            				<span class="input-group-text" id="basic-addon3">제목</span>
            				<input type="text" name="gtitle" class="form-control" id="basic-url" aria-describedby="basic-addon3">
            			</div>
            			<div class="input-group mb-3" style="height: 300px;">
            				<span class="input-group-text">내용</span>
            				<textarea class="form-control" aria-label="With textarea" name="gcontent"></textarea>
            			</div>
            			<div class="input-group">
  							<input type="file" accept="image/*" name="file1" class="form-control" id="file1" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
  							<button class="btn btn-outline-secondary" type="submit" id="inputGroupFileAddon04">업로드</button>
						</div>
            		</form>            		
            	</div>
            </div>
        </section>
        
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
        
    </body>
</html>
