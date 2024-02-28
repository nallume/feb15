<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>회원가입</title>
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
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
        <script type="text/javascript">
        const Toast = Swal.mixin({
        	  toast: true,
        	  position: 'center-center',
        	  showConfirmButton: false,
        	  timer: 3000,
        	  timerProgressBar: true,
        	  didOpen: (toast) => {
        	    toast.onmouseenter = Swal.stopTimer;
        	    toast.onmouseleave = Swal.resumeTimer;
        	  }
        	});
        
        $(function(){
			
        	$('.id-alert, .pw-alert, .name-alert, .email-alert').hide();
        	
        	$('#password1').on("change keyup paste", function(){
        		if($('#password1').val().length < 3){
        			$('.pw-alert').show();
        		} else {
	        		$('.pw-alert').hide();
        		}       		
        	});

        	$('#password2').on("change keyup paste", function(){
        		let pw1 = $('#password1').val();
        		let pw2 = $('#password2').val();
        		
        		if(pw1 != pw2){
        			$('.pw-alert').html('<p class="pwAlert">패스워드가 일치하지 않습니다.</p>');
        			$('.pw-alert').show();
        		} else {
	        		$('.pw-alert').hide();
        		}     		
        	});
        	
        	$('#name').on("change keyup paste", function(){
	        	$('.name-alert').show();
        		if($('#name').val().length > 2 && $('#name').val().length < 11 ){
		        	$('.name-alert').hide();
        		}        		
        	});
        	
        	$('#email').on("change keyup paste", function(){
        		let email = $('#email').val();
        		let atIndex = email.indexOf('@');
        		if(email.indexOf('@') != -1 && email.indexOf('@', atIndex + 1) == -1){				
        		} else {
        			$('.email-alert').show();	        			
        		}
        	});
        	
        	$('#join').click(function(){
        		let id = $('#id').val();
        		let pw1 = $('#password1').val();
        		let pw2 = $('#password2').val();
        		let name = $('#name').val();
        		let email = $('#email').val();
        		Swal.fire('회원가입', id + '/' + pw1 + '/' + pw2 + '/' + name + '/' + email, 'success');
        		
        		//id 중복검사, 길이 검사, 패스워드 길이, 재입력 검사, 이메일 중복 금지, @반드시 포함하는지 전부 통과하고 가입되게 하기
        		
        		//전송하기
	       		let loginForm = $('<form></form>');
        		loginForm.attr('name', 'login'); // 자바한테 보내는 폼 이름인데 굳이 필요없음...
        		loginForm.attr('method', 'post');
        		loginForm.attr('action', './join');
  	      		
        		loginForm.append($('<input>', {'type':'hidden','name':'id', 'value': id}));
        		loginForm.append($('<input>', {'type':'hidden','name':'pw', 'value': pw1}));
        		loginForm.append($('<input>', {'type':'hidden','name':'name', 'value': name}));
        		loginForm.append($('<input>', {'type':'hidden','name':'email', 'value': email}));
        		
        		loginForm.appendTo('body');
        		loginForm.submit();
        	});
        });
        
        
        </script>
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <%@ include file="menu.jsp" %>
        
        <div class="mt-10">회원가입</div>
        
        <!-- join -->
        <section class="page-section" id="mail">
            <div class="d-flex justify-content-center ">
            <div class="text-center p-5 w-50 bg-secondary">
			<div class="mb-3 row">
				<label for="id" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-7">
					<input type="text" id="id" class="form-control" placeholder="아이디를 입력하세요">
					<div class="id-alert">
						<p class="idAlert">id는 영문 5글자 이상</p>
					</div>
				</div>
				<div class="col-sm-3">
					<button type="button" id="idCheck" class="btn btn-info w-100" onclick="idCheck()">중복 검사</button>				
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
				<div class="col-sm-5">
					<input type="password" class="form-control" id="password1" placeholder="암호를 입력하세요">
				</div>
				<div class="col-sm-5">
					<input type="password" class="form-control" id="password2" placeholder="암호를 한번 더 입력하세요">
				</div>
				<div class="pw-alert">
					<p class="pwAlert">패스워드는 3글자 이상이어야 합니다.</p>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="name" class="col-sm-2 col-form-label">이 름</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="name" placeholder="이름을 입력하세요">
					<div class="name-alert">
						<p class="nameAlert">닉네임은 3글자 이상 10글자 미만이어야 합니다.</p>
					</div>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="email" class="col-sm-2 col-form-label">이메일</label>
				<div class="col-sm-10">
					<input type="email" class="form-control" id="email" placeholder="이메일을 입력하세요">
					<div class="email-alert">
						<p class="emailAlert">올바른 이메일 형식을 입력해 주세요.</p>
					</div>
				</div>
			</div>
			<div class="mb-3 row">
				<div class="col-sm-12">
					<button type="button" id="join" class="btn btn-info">회원가입</button>
				</div>
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
    </body>
</html>