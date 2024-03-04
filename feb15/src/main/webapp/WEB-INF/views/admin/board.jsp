<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Blank</title>

    <!-- Custom fonts for this template-->
    <link href="/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/admin/css/sb-admin-2.min.css" rel="stylesheet">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script type="text/javascript">
	function linkPage(pageNo){
		location.href = "./board?pageNo="+pageNo+"&perPage=${perPage}&searchTitle=${searchTitle}&search=${search}"; 
	}
	
/* 	function postDel(no){
		location.href="./postDel?pageNo=${pageNo}&perPage=${perPage}&searchTitle=${searchTitle}&search=${search}&no="+no;
	} */
	
	$(function(){
		$('#perPage').change(function(){ //perPage라는 아이디를 가진 아이의 값이 변경되었다면!
			location.href="./board?pageNo=1&perPage="+$('#perPage').val()+"&searchTitle=${searchTitle}&search=${search}";
		});
		
		$('#searchBtn').click(function(){
			location.href="./board?pageNo=1&perPage=${perPage}&searchTitle="+$('#searchTitle').val()+"&search="+$('#search').val();
		});
		
		$('#reset').click(function(){
			location.href="./board";
		});
		
		$('.chDel').click(function(){
			let eyes = $(this);
			let delno = $(this).children('.del').val();
			let no = $(this).parent().children(".bno").text();
			let tableRow = $(this).parents('.tRow');
			
			$.ajax({
				url: './postDel', 
				type: 'post', 
				dataType: 'text',
				data: {'no': no},
				success: function(result){
					if(result == 1){
						if(delno == 1){
							delno.val(0);
							eyes.attr('class', 'fa fa-eye-slash');
						} else{
							delno.val(1);
							eyes.attr('class', 'fa fa-eye');							
						}
					} else {
						alert("실패");
					}
				},
				error: function(error){
					alert("통신오류");
				}
					
				
			})
			
		});
		
		
	});
	
	</script>
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
	<%@ include file="./sidebar.jsp" %>

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">
                <!-- Topbar -->
				<%@ include file="./header.jsp" %>
				
                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="m-2 row">
                    	<select name="perPage" id="perPage" class="form-control col-2">
                    		<option value="1" <c:if test="${perPage eq 1 }">selected="selected"</c:if>>10</option>
                    		<option value="2" <c:if test="${perPage eq 2 }">selected="selected"</c:if>>20</option>
                    		<option value="3" <c:if test="${perPage eq 3 }">selected="selected"</c:if>>30</option>
                    		<option value="4" <c:if test="${perPage eq 4 }">selected="selected"</c:if>>40</option>
                    		<option value="5" <c:if test="${perPage eq 5 }">selected="selected"</c:if>>50</option>
                    		<option value="10" <c:if test="${perPage eq 10 }">selected="selected"</c:if>>100</option>
                    	</select>
                    	<div class="input-group col-6">
                    		<select name="searchTitle" id="searchTitle" class="form-control col-3">
                    			<option value="1" <c:if test="${searchTitle eq 1 }">selected="selected"</c:if>>제목 검색</option>
                    			<option value="2" <c:if test="${searchTitle eq 2 }">selected="selected"</c:if>>본문 검색</option>
                    			<option value="3" <c:if test="${searchTitle eq 3 }">selected="selected"</c:if>>작성자 검색</option>
                    		</select>
	                    	<input type="text" name="search" class="form-control" id="search" value="${search }">
    	                	<button type="button" class="btn btn-secondary" id="searchBtn">검색</button>
                    	</div>
    	                <button type="button" class="btn btn-secondary col-1" id="reset">초기화</button>
                    </div>

                    <table class="table table-hover">
                    	<thead>
                    		<tr>
                    			<th>글번호</th>
                    			<th>제목</th>
                    			<th>작성자</th>
                    			<th>날짜</th>
                    			<th>ip</th>
                    			<th>삭제</th>
                    		</tr>
                    	</thead>
                    	<tbody>
                    		<c:forEach items="${list }" var="row">
	                    		<tr class="">
    	                			<td class="bno">${row.board_no }</td>
        	            			<td>${row.board_title }</td>
            	        			<td><a href="./board?searchTitle=3&search=${row.mname }">${row.mname }</a>
            	        			</td>
                	    			<td>${row.board_date }</td>
                    				<td>${row.board_ip }</td>
                    				<td class="chDel">
                    				<input type="hidden" class="del" value="${row.board_del }">
                    				<c:choose>
   	                					<c:when test="${row.board_del eq 1}">
       	            						<i class="fa fa-eye" aria-hidden="true"/>
           	        					</c:when>
               	    					<c:otherwise>                    						
                   							<i class="fa fa-eye-slash" aria-hidden="true"/>
                   						</c:otherwise>
                   					</c:choose>
                    				</td>
                    			</tr>
                    		</c:forEach>
                    	</tbody>
                    </table>
				
					<div class="m-2">
						<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="linkPage"/>
					</div>
                </div>
                
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
			<%@ include file="./footer.jsp" %>

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="/admin/vendor/jquery/jquery.min.js"></script>
    <script src="/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/admin/js/sb-admin-2.min.js"></script>

</body>

</html>