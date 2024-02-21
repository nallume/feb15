<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Trinity Company - Home</title>
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
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <%@ include file="menu.jsp" %>
        
        <!-- login-->
        <section class="page-section" id="services">
            <div class="container d-flex mt-5" style="flex-wrap: nowrap; justify-content: center;">
            	<div class="card" style="width: 18rem;">
            		<img alt="loginImg" class="card-img-top" src="./img/dance.gif">
            		<div class="card-body">
						<form action="./login" method="post">
							<div class="form-group row">
								<label for="inputId" class="col-form-label">아이디</label>					
								<input type="text" name="id" class="form-control" id="id" placeholder="아이디를 입력하세요">
							</div>
							<div class="form-group row">
								<label for="inputPassword" class="col-form-label">패스워드</label>
								<input type="password" name="pw" class="form-control" id="pw" placeholder="암호를 입력하세요">
							</div>
							<div class="btn-group mt-2" role="group" style="width: 100%">
								<button type="submit" class="btn btn-primary">로그인</button>
								<button type="reset" class="btn btn-primary">초기화</button>
								<a href="./join" class="btn btn-primary" role="button">회원가입</a>
							</div>
						</form>
            		</div>
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
        
        <!-- 파라미터로 오는 error가 있다면 에러 화면에 출력하기 -->
        <c:if test="${param.error ne null}">
        	<script type="text/javascript">
        		Swal.fire("OMG", "잘못된 접근입니다.", "warning");
        	</script>
        </c:if>
        <c:if test="${param.login ne null }">
        	<script type="text/javascript">
        		Swal.fire("로그인 할 수 없습니다.", "올바른 아이디와 비밀번호를 입력하세요.", "error");
        	</script>
        </c:if>
        <c:if test="${param.count ne null }">
        	<script type="text/javascript">
        		let count = ${param.count};
        		if(count < 4){
	        		Swal.fire("로그인 정보를 확인하세요", "잘못된 로그인을 "+(count+1)+" 번 시도했습니다.", "warning");    			
        		} else if (count == 4) {
	        		Swal.fire("땡!", "로그인을 "+ (count+1) +" 번 실패했습니다. 계정이 잠금처리 됩니다.", "warning");    			        			
        		} else {					
        			Swal.fire("로그인 불가", "블락처리 된 계정입니다.", "error");
				}
        	</script>
        </c:if>
    </body>
</html>
