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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script type="text/javascript">
        $(function(){
        	//저장된 쿠키 가져오기 = 최상단에
        	let userInputId = getCookie("userInputId");
        	let setCookieYN = getCookie("setCookieYN");
        	
        	if(setCookieYN == 'Y'){
 		       	$('#id').val(userInputId);
 		       	$('#saveID').prop("checked", "true");
        	}
        	
        	//아이디칸, pw칸 검사   
        	$('.check').click(function(){
        		let id = $('#id').val();
        		let pw = $('#pw').val();
        		
        		//id 검사
        		if(id == '' || id.length < 3){
        			Swal.fire("", "올바른 아이디를 입력하세요.", "error");
        			$('#id').focus();
        			return false;
        		}
        		//pw 검사
        		if(pw == '' || pw.length < 3){
        			Swal.fire("", "올바른 비밀번호를 입력하세요.", "error");
        			$('#pw').focus();
        			return false;
        		}
        		
        		//로그인 전에 쿠키에 id 저장하기 명령
        		//if 문 - 사용자가 체크를 했다면!
        		if($('#saveID').is(':checked')){
        			//alert(id + "를 입력했어용");
        			//입력한 id 저장하기
        			// 쿠키 저장 함수 불러와서 쓰기- setCookie("저장할 변수명", 저장할 값, 저장일수);
        			setCookie("userInputId", id, 60);
        			//id저장을 클릭했는지 저장
        			setCookie("setCookieYN", "Y", 60);
        		} else { // 사용자가 아이디저장을 클릭하지 않음
        			//쿠키 삭제
        			delCookie('userInputId');
        			delCookie('setCookieYN');
        		}
        		
        		//둘 다 통과한 뒤 로그인폼 작동
        		$('#loginForm').submit();
        	});
        });
        
        //쿠키 저장함수 (쿠키 이름, 저장할 값, 기한)
        function setCookie(cookieName, value, exdays){
        	//기한 - 오늘 날짜로부터 exdays 만큼 더한 날
        	let date = new Date(); //오늘 날짜
        	//alert(date.setDate(date.getDate()));
        	date.setDate(date.getDate() + exdays);
        	let value2 = escape(value) + "; expires=" + date.toGMTString();
        	//escape() - 아스키문자에 해당하지 않는 문자들은 모두 유니코드 형식으로 변환
        	document.cookie = cookieName + "=" + value2;  //실제 쿠키 저장명령
        }
        
        //쿠키값 가져오기
         function getCookie(cookieName){
        	let x, y;
        	//let val = document.cookie; 이러면 있는 쿠키 다 나온다(배열형태)
        	let val = document.cookie.split(';'); // 세미콜론 기준으로 쪼개줌?
         	for(let q = 0; q < val.length; q++){
        		x = val[q].substr(0, val[q].indexOf('=')); //저장한 쿠키 이름
        		y = val[q].substr(val[q].indexOf('=') + 1); //쿠키 값
        		x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
        		//쿠키값만 되돌려주기
        		if(x == cookieName){
        			return y;
        		}
        	};
        }
        
        //쿠키 삭제
        function delCookie(cookieName){
        	//let date = new Date();
        	//date.setDate(date.getDate() - 1);  //쿠키 유효기간을 하루 지나게 설정 -> 삭제
        	//document.cookie = cookieName + "=; expires=" + date.toGMTString();
        	document.cookie = cookieName + "=; max-age=0";  //남은 기간을 0으로 만드는
        }
        
        </script>
        
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
						<form action="./login" method="post" id="loginForm">
							<div class="form-group row">
								<label for="inputId" class="col-form-label">아이디</label>					
								<input type="text" name="id" class="form-control" id="id" placeholder="아이디를 입력하세요">
							</div>
							<div class="form-group row">
								<label for="inputPassword" class="col-form-label">패스워드</label>
								<input type="password" name="pw" class="form-control" id="pw" placeholder="암호를 입력하세요">
							</div>
							<div class="mt-1 row">
								<div class="col-sm-12 text-start">
									<input type="checkbox" class="saveID" id="saveID">
									<label for="saveID">아이디 저장</label>
								</div>
							</div>
							<div class="btn-group mt-2" role="group" style="width: 100%">
								<button type="button" class="btn btn-primary check">로그인</button>
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
