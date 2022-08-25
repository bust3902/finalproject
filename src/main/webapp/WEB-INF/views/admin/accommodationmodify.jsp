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
	<style>
	.ck.ck-editor {
    	max-width: 800px;
	}
	.ck-editor__editable {
	    min-height: 300px;
	}
	</style>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="row bg-secondary">
	<div class="container" style="min-width:992px; max-width:992px; height:10vh;">
		<a href="/admin" class="fs-3 text-white text-decoration-none p-2">숙소 수정</a>
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
		
			<!-- 주소 검색 및 지도 출력 -->
			<div class="row">
				<div class="col-10 m-0">
					<!-- 사용자가 검색버튼을 사용하지 않을 경우를 대비해 readonly 사용 -->
					<input type="text" class="form-control" id="address" placeholder="주소" readonly>
					<input type="hidden" class="form-control" id="sigungu" placeholder="주소">
				</div>
				<div class="col m-0">
					<input type="button" class="btn btn-secondary mb-1" onclick="addressSearch()" value="주소 검색"><br>
				</div>
			</div>
			<div class="row p-3 mb-5">
				<div id="map" style="width:100%;height:40vh;"></div>
			</div>
			
			<!-- 숙소 정보 작성 안내 모달창 -->
			<div class="modal fade" id="myModal" tabindex="-1">
			  <div class="modal-dialog modal-dialog-scrollable">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title">숙소 정보 입력시<br></h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
						<strong>카테고리</strong>
						<ul>
							<li>내용</li>
							<li>내용</li>
							<li>내용</li>
						</ul>
						<strong>카테고리</strong>
						<ul>
							<li>내용</li>
							<li>내용</li>
							<li>내용</li>
						</ul>
						위 형식에 맞춰 작성 부탁드립니다.
						<br>
						<br>
						<strong>사용 가능한 카테고리</strong>
						<ul>
							<li>오시는길</li>
							<li>혜택안내</li>
							<li>주차장 정보</li>
							<li>지하철 정보</li>
							<li>주변정보</li>
							<li>객실 내부 시설</li>
							<li>프런트 및 그 외 시설</li>
							<li>추가 안내사항</li>
							<li>숙소 이용 규칙</li>
							<li>취소 및 환불 규정</li>
							<li>확인사항 및 기타</li>
							<li>공지사항</li>
							<li>기본정보</li>
							<li>투숙객 혜택</li>
							<li>부대 시설 정보</li>
							<li>인원 추가 정보</li>
							<li>캠핑 서비스</li>
							<li>바비큐 시설</li>
							<li>조식 정보</li>
							<li>취사 시설</li>
						</ul>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			      </div>
			    </div>
			  </div>
			</div>

			<!-- 숙소 정보 입력 -->
			<div class="row mb-3">
				<div class="col-3">
					숙소 상세 정보
				</div>
				<div class="col-9 text-end">
					<button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#myModal">숙소정보 작성 전 읽어주세요 !</button>
				</div>
			</div>
			<div class="row">
				
				<form method="post" action="modifyAccommdation" enctype="multipart/form-data" id="form-modify-accommdation">
				<!-- CKEditor5 텍스트 에디터 API -->
					<textarea name="detailDescription" id="editor">${accommodations.detailDescription }</textarea>
					
							
					<!-- 지역(CITIES 테이블) 선택 폼 -->
					<div class="mb-3 mt-5">
						<label class="form-label">지역</label>
						<div>
							<select class="form-select" name="cityId" aria-label="select box cities" id="select-cities">
								<option selected value="">지역을 선택해주세요</option>
								<option></option>
								<c:forEach var="city" items="${cities }">
									<option value="${city.id }" ${city.id eq accommodations.cityId ? 'selected' : '' }>${city.name }</option>
								</c:forEach>
							</select>			
						</div>
					</div>
	
					<!-- 숙소유형(ACCOMMODATION_TYPES 테이블) 선택 폼 -->
					<div class="mb-3">
						<label class="form-label">숙소 유형</label>
						<div>
							<c:forEach var="type" items="${types }" varStatus="status">
							<div class="form-check form-check-inline">
									<input class="form-check-input" type="checkbox" name="types" value="${type.id }"
										<c:forEach var="accommodationType" items="${accommodationTypes }">
											<c:if test="${type.id eq accommodationType}">
												checked
											</c:if>
										</c:forEach>
									>
									<label class="form-check-label" >${type.name }</label>
							</div>
							</c:forEach>
						</div>
					</div>
								
					<!-- 숙소 공용시설 출력 폼(숙소유형 선택시 출력) -->
					<div class="mb-5">
						<label class="form-label">공용 시설 정보</label>
						<c:forEach var="type" items="${types }">
							<div id="common-facilities-box" class="mb-3">
							
							</div>
						</c:forEach>
					</div>
					
					<!-- 정보 입력 폼 -->
					<div class="mb-3">
						<label class="form-label">숙소명</label>
						<input class="form-control " type="text" name="accoName" value="${accommodations.name}">
					</div>
					<div class="mb-5">
						<label class="form-label">객실 소개 내용</label>
						<input class="form-control " type="text" name="introduceComment" value="${accommodations.introduceComment}">
					</div>
					
					<!-- 태그 입력 폼(acco_tags 테이블에 저장) -->
					<div class="mb-5">
						<label class="form-label">태그를 입력해주세요.</label>
						<input class="form-control mb-2" type="text" id="input-tag">
						<div class="text-end">
							<button type="button" class="btn btn-secondary" id="btn-add-tag">추가</button>
						</div>
						<div class="mb-3 mt-2">
							<div id="tag-box">
								<c:forEach var="accommodationTag" items="${accommodationTags }" varStatus="status">
									<button type="button" class="btn badge btn-secondary rounded-1 me-2 btn-delete-${status.index}" onclick="deleteBtnTags('${status.index}', '${accommodationTag }')">${accommodationTag }</button>
								</c:forEach>
							</div>
						</div>
					</div>
					
					<!-- 숙소 메인 이미지 수정 폼 -->
					<div class="mb-2 visually-hidden" id="div-mainimage">
						<label class="form-label">메인 이미지</label>
						<input class="form-control w-50" type="file" name="thumbnailImageFile" id="main-photo-add" value="${accommodations.thumbnailImageName}">
					</div>
					
					<div class="row">
						<div class="col-lg-12">
							<div class="card mb-4">
								<div class="card-header">
					            	<span>첨부 이미지</span>
								</div>
					         	<div class="card-body">
					         		<div class="row">
					            		<div class="col-4 d-grid main-gallery">
											<img src="/resources/images/acco/thumbnail/${accommodations.thumbnailImageName}" class="card-img main-image">
											<button type="button" class="btn btn-sm btn-secondary main-image-btn mt-1" onclick="deleteMainImage()">삭제</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<!-- 숙소 상세 이미지 수정 폼 -->
					<div class="mb-2">
						<label class="form-label">상세 이미지</label>
						<input class="form-control w-50" multiple="multiple" type="file" name="detailImageFiles" id="detail-photo-add">
					</div>
					
					<div class="row">
						<div class="col-lg-12">
							<div class="card mb-4">
								<div class="card-header">
					            	<span>첨부 이미지</span>
								</div>
					         	<div class="card-body">
					         		<div class="row detail-gallery">
										<c:forEach var="accommodationImage" items="${accommodationImages }" varStatus="status">
					            			<div class="col-4 d-grid" id="img-box-${status.index}">
						            			<img src="/resources/images/acco/detail/${accommodationImage}" class="card-img" style="height:150px;">
					            				<button type="button" class="btn btn-sm btn-secondary mt-1 mb-3" onclick="detailImageDelete('${status.index}', '${accommodationImage}')">삭제</button>
											</div>
										</c:forEach>
					         		</div>
					      		</div>
							</div>
						</div>
					</div>
					<!-- 수정할 입력값들 히든폼 -->
					<div id="hidden-form-box">
						<input type="hidden" name="address" value="${accommodations.address }">
						<input type="hidden" name="district" value="${accommodations.district }">
						<input type="hidden" name="latitude" value="${accommodations.latitude }">
						<input type="hidden" name="longitude" value="${accommodations.longitude }">
						<input type="hidden" name="id" value="${accommodations.id }">
					</div>
					
					<div class="text-end mt-4">
						<input type="submit" class="btn btn-secondary" value="수정">
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<!-- ckedit5 API -->
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<!-- 다음 주소 검색 API 스크립트 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 카카오맵 API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1e9adb3077789558d707162df08956e7&libraries=services"></script>
<script>
	// 페이지 오픈시 주소, 구역, 지도 좌표 입력.
	document.addEventListener("DOMContentLoaded", function() {
		// 구역 히든 폼에서 읽어오기
		let oldDistrict = $('input[name=district]').val();
        // 주소 히든 폼에서 읽어오기
	    let oldAddress = $('input[name=address]').val();
        
        // 시/군/구 히든 폼에 입력
	    $('#sigungu').attr('value', oldDistrict);
        // 주소 히든 폼에 입력
	    $('#address').attr('value', oldAddress);

		// 페이지 로딩시 공용시설박스 오픈해두는 스크립트
		// 숙소 타입을 담을 배열
		let commonFacilityArr = [];
		$("input[name=types]:checked").each(function(){
			commonFacilityArr.length = 0;
			$('#common-facilities-box').empty();
			$("input[name=types]").each(function(){
				if (this.checked) {
				  	commonFacility = $(this).val();
				  	commonFacilityArr.push(commonFacility);
				}
			})
			
		});
	
	  	let $box = $("#common-facilities-box");
		
	  	// alert(commonFacilityArr);
		if (commonFacilityArr != '') {
	      	$.getJSON("/admin/searchCommonFacilities", {types:commonFacilityArr}).done(function(commonfacilities) {
	      		$.each(commonfacilities, function(index, commonfacility) {
	      			let content = '';
	      			
	      			content += '	<div class="form-check form-check-inline">';
	      			content += '		<input class="form-check-input" type="checkbox" name="stringCommonFacilities" value="${"'+commonfacility.id+'"}">';
	      			content += '		<label class="form-check-label" >${"'+commonfacility.name+'"}</label>';
	      			content += '	</div>';
	
	      			$box.append(content);
	      		})
	      	})
		}
		// 페이지 로드시 저장된 공용시설 체크박스 체크해주는 스크립트
		let accoId = $("input[name=id]").val();
	  	$.getJSON("/admin/searchChecked", {id:accoId}).done(function(cofacilitiesChecked) {
	  		console.log("체크된 것", cofacilitiesChecked);
	  		alert();
	  		$.each(cofacilitiesChecked, function(index, cofacilityChecked) {
	  			console.log('공용 ', $("input[name=stringCommonFacilities]"))
	  			$("input[name=stringCommonFacilities]").each(function() {
			  		if(this.value == cofacilityChecked.id){
			  			this.checked = true;
			  		}
	  			})
	  		})
		})
	})
	
	// 공용시설 체크박스 기능 일부 구현. 컨트롤제트 이 이상 넘어가지 말 것.
	// 공용시설 체크박스 중복제거해서 출력
	$(document).ready(function(){
		// 숙소 타입을 담을 배열
		let commonFacilityArr = [];
		$("input[name=types]").change(function(){
			commonFacilityArr.length = 0;
			$('#common-facilities-box').empty();
			$("input[name=types]").each(function(){
				if (this.checked) {
				  	commonFacility = $(this).val();
				  	commonFacilityArr.push(commonFacility);
				}
			})
	
		  	let $box = $("#common-facilities-box");
			
		  	// alert(commonFacilityArr);
			if (commonFacilityArr != '') {
		      	$.getJSON("/admin/searchCommonFacilities", {types:commonFacilityArr}).done(function(commonfacilities) {
		      		$.each(commonfacilities, function(index, commonfacility) {
		      			let content = '';
		      			
		      			content += '	<div class="form-check form-check-inline">';
		      			content += '		<input class="form-check-input" type="checkbox" name="stringCommonFacilities" value="${"'+commonfacility.id+'"}">';
		      			content += '		<label class="form-check-label" >${"'+commonfacility.name+'"}</label>';
		      			content += '	</div>';
		
		      			$box.append(content);
		      		})
		      	})
			}
		})
		
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
				let spanContent = '<button type="button" class="btn badge btn-secondary rounded-1 me-2 btn-delete-tag">'+value+'</button>';
				let hiddenContent = '<input type="hidden" name="tags" value="'+value+'" />'
				
				$div.append(spanContent);
				$div.append(hiddenContent);
				
				$input.val("");
			}		
		});

		// CKEditor5 텍스트 에디터
		let ckEditor;
		ClassicEditor.create(document.querySelector('#editor'))
			.then(function(editor) {
				ckEditor = editor;
		});
		
	});

    // 버튼 클릭시 태그를 화면에서 감추는 스크립트
    function deleteBtnTags(tagNum, tag) {
    	// alert(tagNum);
    	// alert(tag);
    	let $tagBox = $("#tag-box");
    	$('.btn-delete-'+tagNum).addClass("visually-hidden");
		
    	let deleteTagHidden = '<input type="hidden" name="deleteTags" value="'+tag+'" />';
    	$tagBox.append(deleteTagHidden);
    }

    // 다음 주소 검색 API
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng($('input[name=latitude]').val(), $('input[name=longitude]').val()), // 지도의 중심좌표
            level: 1 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng($('input[name=latitude]').val(), $('input[name=longitude]').val()),
        map: map
    });

    var coords; // 위도, 경도
    var addr; // 최종 주소 변수
    var sigungu // 시/군/구 정보

	// 주소 검색
    function addressSearch() {
        new daum.Postcode({
            oncomplete: function(data) {
                addr = data.address; // 최종 주소 변수
                sigungu = data.sigungu // 시/군/구 정보

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                        // console.log(coords);
                        // console.log(sigungu);
                        // console.log(addr);

                        // 시/군/구 히든 폼에 입력
                	    $('input[name=district]').attr('value', sigungu);
                        // 주소 히든 폼에 입력
                	    $('input[name=address]').attr('value', addr);
                        // 위도 히든 폼에 입력
                	    $('input[name=longitude]').attr('value', coords.La);
                        // 경도 히든 폼에 입력
						$('input[name=latitude]').attr('value', coords.Ma);
                    }
                });
            }
        }).open();
    }
    
	$("#form-modify-accommdation").submit(function() {
	 			
	 	// 주소가 입력되었는지 확인하기
	 	let addressValue = $("#address").val();
	 	if (addressValue === "") {
	 		alert("주소를 입력해주세요.");
	 		return false;
	 	}
	 			
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
	 	if (!$('#div-mainimage').is(".visually-hidden") == true && thumbnailImageFileValue === '') {
	 		alert("숙소 메인 이미지를 첨부해주세요");
	 		return false;
	 	}
  			return true;
  		});
    
    // 수정화면에서 메인이미지 삭제 버튼 클릭시 이미지를 화면에서 지워주기 위한 스크립트
    function deleteMainImage() {
    	$("#div-mainimage").removeClass("visually-hidden");
    	$(".main-image").addClass("visually-hidden");
    	$(".main-image-btn").addClass("visually-hidden");
    }
    // 메인이미지 삭제 후 다른이미지 업로드 시 화면에 출력시켜주는 코드
    $('#main-photo-add').on('change', function() {

		let input = $("#main-photo-add");
		let ImagePreview = $(".main-gallery");
        var imagesPreview = function(input, ImagePreview) {
        	$(".main-gallery img").remove();
            if (input.files != null) {
            	var filesAmount = input.files.length;

            	for (i = 0; i < filesAmount; i++) {
             	var reader = new FileReader();
             		
                 reader.onload = function(event) {
                     $($.parseHTML('<img>')).attr('src', event.target.result).attr('class', "card-img main-img").appendTo(ImagePreview);
                 }

                 reader.readAsDataURL(input.files[i]);
            	}
            }
        };
        imagesPreview(this, ImagePreview);
    });
    
    // 버튼 클릭시 상세이미지 화면에서 감추는 스크립트
    function detailImageDelete(ImgNum, imgFileName) {
    	// alert(ImgNum);
    	// alert(imgFileName);
    	let $gallery = $(".detail-gallery");
    	$('#img-box-' + ImgNum).addClass("visually-hidden");
		
    	let hiddenContent = '<input type="hidden" name="deleteImgNames" value="'+imgFileName+'" />'
		$gallery.append(hiddenContent);
    }
    // 상세이미지 삭제 후 다른이미지 업로드 시 화면에 출력시켜주는 코드
    $('#detail-photo-add').on('change', function() {

		let inputDetail = $("#detail-photo-add");
		let detailImagePreview = $(".detail-gallery");
		let $DIP = detailImagePreview;
		
        var detailImagesPreview = function(inputDetail, detailImagePreview) {
            if (inputDetail.files) {
            	var detailFilesAmount = inputDetail.files.length;

            	for (i = 0; i < detailFilesAmount; i++) {
             	var detailImgReader = new FileReader();
             		
             	detailImgReader.onload = function(event) {

					let spanContent = '';
					
					spanContent += '<div class="col-4 mb-3">';
					spanContent += '<img src="'+event.target.result+'" class="card-img d-grid" style="height:150px;">';
					spanContent += '</div>';
         			
					$DIP.append(spanContent);
                }

             	detailImgReader.readAsDataURL(inputDetail.files[i]);
            	}
            }
        };
        detailImagesPreview(this, detailImagePreview);
    });
</script>
</body>
</html>