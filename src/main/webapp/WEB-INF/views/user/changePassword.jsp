<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- swiper css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
<style>
	#yeseok {
		width: 100%;
		padding: 0;
		margin: 0;
		max-width: inherit;
	}
	
	#category-box {
		display: block;
    	float: left;
    	width: 180px;
	}	
	
	#all-content {
		width: 1000px;
	}
	
	#text-end {
    	text-align: left!important;
	}
	
</style>
<title>내 정보</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div id="yeseok">
	<div class="row bg-secondary m-0" style="height:13vh;">
		<div class="px-3 pt-5 pb-3 mx-auto my-auto" style="min-width:992px; max-width:992px;">
			<h3 class="text-white ps-0 mb-3">내 정보</h3>
		</div>
	</div>
	<div id="all-content" class="mt-5 mx-auto">
		<!-- 카테고리 리스트 -->	
		<div id="category-box">
			<c:forEach var="category" items="${categories }">
				<a href="information?cat=${category.id }" data-category="${category.id }" class="list-group-item list-group-item-action py-3 ${param.cat eq category.id ? 'active' : '' }"> ${category.name }</a>
			</c:forEach>
		</div>
		<strong><h3>비밀번호 변경</h3></strong>
		<div class="changePw">
    		<div class="row">
    			<form class="form p-3" method="post" id="pwUpdateForm" name="pwUpdateForm" action="">
    				<div class="form-group" id="standardPassword">
      					<label for="password" class="form-label mt-4">기존 비밀번호</label>
      					<input type="password" class="form-control" name="pw" id="pw" placeholder="기존 비밀번호를 입력해 주세요." style="width: 380px; height: 50px;">
    				</div>
    				<div class="form-group2" id="ChangePassword">
      					<label for="newPassword" class="form-label2 mt-4">새 비밀번호</label>
      					<input type="password" class="form-control" name="pw1" placeholder="비밀번호(최소 8자 이상)" style="width: 380px; height: 50px;">
    				</div>
    				<div class="form-group3 mb-4" id="ChangePasswordConfirm">
      					<label for="newPasswordConfirm" class="form-label3 mt-4">새 비밀번호 확인</label>
      					<input type="password" class="form-control" name="pw2" placeholder="변경할 비밀번호를 재입력해 주세요." style="width: 380px; height: 50px;">
    				</div>
    				<div class="mt-3 text-end" id="text-end">
    					<button type="submit" id="pwUpdate" name="pwUpdate" class="btn btn-primary btn-lg">변경</button>
    				</div>
    			</form>
    		</div>
		</div>
	</div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#pwUpdate").on("click", function(){
		if($("#pw").val==""){
			alert("현재 비밀번호를 입력해주세요");
			$("#memberPw").focus();
			return false
		}
		if($("#pw1").val==""){
			alert("변경비밀번호을를 입력해주세요");
			$("#pw1").focus();
			return false
		}
		if($("#pw2").val==""){
			alert("변경비밀번호를 입력해주세요");
			$("#pw2").focus();
			return false
		}
		if ($("#pw").val() != $("#pw2").val()) {
			alert("변경비밀번호가 일치하지 않습니다.");
			$("#pw2").focus();
			 
		
		$.ajax({
			url : "user/changePassword",
			type : "POST",
			dataType : "json",
			data : $("#pwUpdateForm").serializeArray()
		})
		
	});
		
})
</script>
</body>
</html>