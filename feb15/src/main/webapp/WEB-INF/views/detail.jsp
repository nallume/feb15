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
        <!-- summer note -->
		<script src="/js/summernote/summernote-lite.js"></script>
		<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
		<script src="/js/summernote/summernote-bs4.min.js"></script>
		<link href="/css/summernote/summernote-lite.css" rel="stylesheet">
		<link href="/css/summernote/summernote-bs4.min.css" rel="stylesheet">
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
        	    		vform.attr('action', './postDel');
        	    		//
        	    		vform.append($('<input/>', {type:'hidden', name:'no', value:${detail.board_no } }));
        	    		vform.appendTo('body');
        	    		vform.submit();
        	    		
        	    		//let vform = $("<form name=''></form>");        	    		
        	    		//Swal.fire({"Deleted!", "Your file has been deleted.", "success"});
        	    		}
        	    	});
        	}

        function edit(no){
        	//모달 보이기
    		let detailModal = new bootstrap.Modal('#edit', {});  // {옵션}  		
    		detailModal.show(); //함수 실행되면 detailModal이 나타나게
        }        
        
        //제이쿼리
        $(function(){
        	//댓글 글자수 확인하는 코드
        	$("#comment").keyup(function(){
        		let text = $(this).val();
     			$("#comment-input").text("댓글쓰기 " + text.length + "/500");
        		if(text.length > 500){
        			//alert("댓글은 500자를 초과할 수 없습니다");
        			Swal.fire("말이 너무 많습니다", "댓글은 500자까지만 가능합니다.", "warning");
        			$(this).val(text.substr(0,500));
        		}
        	});
        });
        
        //댓글 공백 금지
        function commentCheck(){
        	let commentText = document.querySelector("#comment");
        	let comment = commentText.value.replaceAll(" ", "");
        	if(comment.length < 1){
        		alert("내용을 입력하세욥.");
        		commentText.focus();
        		return false;
        	}
        }
        
        //댓글 지우기
        function deleteComment(no){
        	//Swal.fire("정말?", no + "번 글을 삭제합니다.", "warning");
        	if(confirm("댓삭?")){
	        	location.href="./deleteComment?no=${detail.board_no}&cno="+no; // 글번호 + 댓글번호 그냥 get으로 보냈다. 나중에 post로 보내주면 좋겠지        		
        	}
        	//ajax로 화면전환없이 고 부분만 없애주기(예전에 했엇음)
        }
        
        //조아요
        function like(no){
        	Swal.fire("좋아요를 누릅니다", "", "success");
        	location.href="./likeUp?no=${detail.board_no}&cno="+no;
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
                    <h2 class="section-heading text-uppercase">톺아보기</h2>
                </div>
                <div class="card mb-4" style="min-height: 500px">
                	<div class="card-body">
                		<div class="h3">${detail.board_title}
                		</div>
                		<div class="row p-2 bg-secondary">
                			<div class="col align-middle text-start">${detail.mname}<c:if test="${detail.mid eq sessionScope.mid }">
                			<button type="button" data-bs-toggle="modal" data-bs-target="#edit">
                			<img alt="edit" src="./img/edit.png" title="글 수정"></button>                			
                			<img alt="delete" src="./img/delete.png" title="글 삭제" onclick="deletePost(${detail.board_no})"></c:if></div>
                			<div class="col align-middle text-end">${detail.board_date}/${detail.board_ip }</div>
                		</div>
                		<div class="mt-4 h-auto">${detail.board_content}</div>
                	</div>					
                </div>
	        	<button class="btn btn-warning" onclick="history.back()">게시판으로</button>
	        
	        	<hr>
	        	<!-- 댓글쓰기창  / 24-02-20 스크립트로 빈칸 검사하기 -->
	        	<div class="">
	        		<form action="./commentWrite" method="post" onsubmit="return commentCheck()">
	     	   		<div class="row">
	        			<div class="input-group mb-3">
		        			<textarea class="form-control" name="comment" id="comment" aria-describedby="comment-input"></textarea>
		        			<button class="btn btn-secondary" type="submit" id="comment-input">댓글쓰기 0/500</button>
	        			</div>
	        		</div>
	        		<input type="hidden" name="no" value="${detail.board_no }">
	        		</form>
	        	</div>
	        	<!-- 댓글출력창 -->
	        	<div class="mt-2">
		        	<c:forEach items="${commentsList }" var="c">
	        		<div class="my-4 shadow md-5 bg-body rounded">
	        			<div class="bg-warning text-dark row p-2">
	        				<div class="col-7">${c.mname }
	        				<c:if test="${c.mid eq sessionScope.mid }">
	        				<img alt="edit" src="./img/edit.png" title="댓글 수정">
                			<img alt="delete" src="./img/delete.png" title="댓글 삭제" onclick="deleteComment(${c.no})">
	        				</c:if>
	        				</div>
	        				<div class="col-2">${c.cip }</div>
	        				<div class="col-2">${c.cdate }</div>
	        				<div class="col-1">
	        				<img alt="like" src="./img/like.png" onclick="like(${c.no})">
	        				${c.clike }</div>
	        			</div>
	        			<div class="mx-5 mt-1" style="min-height:80px">${c.comment }</div>
	        		</div>
		        	</c:forEach>
	        	</div>
            </div>            
        </section>
        <!-- 글 수정 모달 -->
        <div class="modal" id="edit">
        	<div class="modal-dialog modal-xl">
        		<div class="modal-content">
        			<div class="modal-header">
        				<h4 class="modal-title">글 수정</h4>
        				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        			</div>
        			<div class="modal-body">
        				<div class="mt-2">
	        				<form action="./detailUpdate" method="post" name="frm">
	        					<input type="hidden" name="board_no" value="${detail.board_no }">
	        					<input type="text" name="board_title" class="form-control mb-2" id="title" required="required" value="${detail.board_title}">
	        					<textarea name="board_content" class="form-control mb-2 vh-500" id="summernote" required="required">${detail.board_content}</textarea>
	        					<button type="submit" class="btn btn-info">수정하기</button>
	        				</form>
        				</div>
        			</div>
        			<div class="modal-footer">
        				모달 foot
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
