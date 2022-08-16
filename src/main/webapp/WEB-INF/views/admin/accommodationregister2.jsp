<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>서울어때</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="row bg-secondary">
	<div class="container" style="min-width:992px; max-width:992px; height:10vh;">
		<h1 class="fs-3 text-white p-2">숙소 등록</h1>
	</div>
</div>
<div class="container mt-5" style="min-width:992px; max-width:992px;">
	<div class="row mb-3 px-3">
	
		<!-- 사이드바 -->
		<div class="col-3 border rounded">
			<div class="mt-3">
				<aside>
					<jsp:include page="../common/adminsidebar.jsp" />
				</aside>
			</div>
		</div>
		
		<div class="col-9 bg-white">
				
			<form id="form-accommodation" class="col p-3" method="post" action="accommodation3" enctype="multipart/form-data">
			
				<!-- 지역(CITIES 테이블) 선택 폼 -->
				<div class="mb-3">
					<label class="form-label">지역</label>
					<div>
						<select class="form-select" name="cityId" aria-label="select box cities" id="select-cities">
							<option selected value="">지역을 선택해주세요</option>
							<option></option>
							<c:forEach var="city" items="${cities }">
								<option value="${city.id }">${city.name }</option>
							</c:forEach>
						</select>			
					</div>
				</div>

				<!-- 숙소유형(ACCOMMODATION_TYPES 테이블) 선택 폼 -->
				<div class="mb-3">
					<label class="form-label">숙소 유형</label>
					<div>
						<c:forEach var="type" items="${types }">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="types" value="${type.id }">
							<label class="form-check-label" >${type.name }</label>
						</div>
						</c:forEach>			
					</div>
				</div>
							
				<!-- 숙소 공용시설 출력 폼(숙소유형 선택시 출력) -->
				<div class="mb-5">
					<label class="form-label">공용 시설 정보</label>
					<c:forEach var="type" items="${types }">
						<div id="common-facilities-${type.id }"></div>
					</c:forEach>
				</div>
				
				<!-- 정보 입력 폼 -->
				<div class="mb-3">
					<label class="form-label">숙소명</label>
					<input class="form-control " type="text" name="accoName">
				</div>
				<div class="mb-5">
					<label class="form-label">객실 소개 내용</label>
					<input class="form-control " type="text" name="introduceComment">
				</div>
				
				<!-- 태그 입력 폼(acco_tags 테이블에 저장) -->
				<div class="mb-5">
					<label class="form-label">태그를 입력해주세요.</label>
					<input class="form-control mb-2" type="text" id="input-tag">
					<div class="text-end">
						<button type="button" class="btn btn-secondary" id="btn-add-tag">추가</button>
					</div>
					<div class="mb-3 mt-2">
						<div id="tag-box"></div>
					</div>
				</div>
				
				<!-- 숙소 메인 이미지 업로드 폼 -->
				<div class="mb-2">
					<label class="form-label">메인 이미지</label>
					<input class="form-control w-50" type="file" name="thumbnailImageFile" >
				</div>
				
				<!-- 숙소 상세 이미지 업로드 폼 -->
				<div class="mb-5">
					<label class="form-label">상세 이미지</label>
					<input class="form-control w-50" multiple="multiple" type="file" name="detailImageFiles" >
				</div>
				

				<!-- 숙소 입력폼2로 -->
				<div class="text-end mt-5">
					<button type="submit" class="btn btn-secondary px-5">다음</button>
				</div>				
			</form>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
//공용시설 체크박스 스크립트
$(document).ready(function(){
    $("input[name=types]").change(function(){

    	let commonFacility = $(this).val();
    	let $box = $("#common-facilities-"+($(this).val()));
    	console.log(commonFacility);
    	
        if($(this).is(":checked") == true){
        	$.getJSON("/admin/search", {type:commonFacility}).done(function(cofacilities) {
        		$.each(cofacilities, function(index, cofacility) {
        			let content = '';
        			
        			content += '	<div class="form-check form-check-inline">';
        			content += '		<input class="form-check-input" type="checkbox" name="stringCommonFacilities" value="${"'+cofacility.id+'"}">';
        			content += '		<label class="form-check-label" >${"'+cofacility.name+'"}</label>';
        			content += '	</div>';

        			$box.append(content);
        		})
        	})
        }
    });
});

$(document).ready(function(){
    $("input[name=types]").change(function(){

    	let commonFacility = $(this).val();
    	let $box = $("#common-facilities-"+($(this).val()));
    	console.log(commonFacility);
    	
        if($(this).is(":checked") == false){
        	$box.empty();
        }
    });
});

// 태그 추가 버튼
$("#btn-add-tag").click(function() {
	let $div = $("#tag-box");
	let $input = $("#input-tag");

	let tagLength = $(":input[name=tags]").length;
	if (tagLength >= 10) {
		alert("최대 10개까지만 가능합니다.");
		$input.val("");
		return;
	}
	
	let value = $input.val();
	if (value != "") {
		let spanContent = '<span class="badge text-bg-secondary rounded-1 p-2 me-2">'+value+'</span>';
		let hiddenContent = '<input type="hidden" name="tags" value="'+value+'" />'
		
		$div.before(spanContent);
		$div.append(hiddenContent);
		
		$input.val("");
	}		
});

$(function() {
	$("#form-accommodation").submit(function() {
		
		// 지역 셀렉트박스가 설정되어있는지 체크하기
		let citiesValue = $("#select-cities option:selected").val();
		if (citiesValue === "") {
			alert("지역을 선택해주세요.");
			return false;
		}
		
		// 숙소유형 셀렉트박스가 설정되어있는지 체크하기
		let commonFacilityValue = $("#select-common-facility").val();
		if (commonFacilityValue === "") {
			alert("숙소유형을 선택해주세요.");
			return false;
		}

		// 공용시설 체크박스가 체크되어있는지 확인하기
		let targetFieldLength = $(":input[name=stringCommonFacilities]:checked").length;
		if (targetFieldLength < 1) {
			alert("공용시설을 선택해주세요.");
			return false;
		}
		
		// 숙소필드에 값이 있는지 체크하기
		let nameValue = $.trim( $(":input[name=accoName]").val() );
		if (nameValue === "") {
			alert("숙소명을 입력해주세요.");
			return false;
		}
		
		// 객실 소개 내용에 값이 있는지 체크하기
		let introduceCommentValue = $.trim( $(":input[name=introduceComment]").val() );
		if (introduceCommentValue === "") {
			alert("객실 소개 내용을 입력해주세요.");
			return false;
		}
		
		// 숙소 메인 이미지가 설정되어있는지 체크하기
		let thumbnailImageFileValue = $.trim( $(":file[name=thumbnailImageFile]").val() );
		if (thumbnailImageFileValue === "") {
			alert("숙소 메인 이미지를 첨부해주세요");
			return false;
		}
		
		// 숙소 상세 이미지가 설정되어있는지 체크하기
		let thumbnailImageNameValue = $.trim( $(":file[name=detailImageFiles]").val() );
		if (thumbnailImageNameValue === "") {
			alert("숙소 상세 이미지를 첨부해주세요");
			return false;
		}
		
		return true;
	});
})

</script>
</body>
</html>