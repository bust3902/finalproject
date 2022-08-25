<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Time Picker -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">

<title>서울어때</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="row bg-secondary">
	<div class="container" style="min-width:992px; max-width:992px; height:10vh;">
		<a href="/admin" class="fs-3 text-white text-decoration-none p-2">음식점 수정</a>
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
		
			<div class="row">
				<div class="col-10 m-0">
					<input type="text" class="form-control" id="address" placeholder="주소" readonly>
					<input type="hidden" class="form-control" id="sigungu" placeholder="주소">
				</div>
				<div class="col m-0">
					<input type="button" class="btn btn-secondary mb-1" onclick="addressSearch()" value="주소 검색"><br>
				</div>
			</div>
			<div class="row p-3">
				<div id="map" style="width:100%;height:40vh;"></div>
			</div>
			
			<form id="form-restaurant-modify" class="col p-3" method="post" action="restaurantmodifycompleted" enctype="multipart/form-data">
				
				<!-- 지역(CITIES 테이블) 선택 폼 -->
				<div class="mb-3">
					<label class="form-label">지역</label>
					<div>
						<select class="form-select" name="cityId" aria-label="select box cities" id="select-cities">
							<option selected value="">지역을 선택해주세요</option>
							<option></option>
							<c:forEach var="city" items="${cities }">
								<option value="${city.id }" ${city.id eq restaurant.cityId ? 'selected' : '' }>${city.name }</option>
							</c:forEach>
						</select>			
					</div>
				</div>
				
				<!-- 레스토랑 카테고리 폼 -->
				<div class="mb-5 mt-5">
					<label class="form-label">카테고리</label>
					<div>
						<c:forEach var="category" items="${categories }">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="categories" value="${category.id }"
											<c:forEach var="restaurantCategory" items="${restaurantCategories }">
												<c:if test="${category.id eq restaurantCategory.category}">
													checked
												</c:if>
											</c:forEach>
							>
							<label class="form-check-label me-5">${category.name }</label>
						</div>
						</c:forEach>
					</div>
				</div>
				
				<!-- 정보 입력 폼 -->
				<div class="row">
					<div class="mb-3 col-6">
						<label class="form-label">음식점명</label>
						<input class="form-control " type="text" name="name" value="${restaurant.name }">
					</div>
					<div class="mb-3 col-6">
						<label class="form-label">전화번호</label>
						<input class="form-control " type="text" name="tel" value="${restaurant.tel }">
					</div>
				</div>
				<div class="row">
				<c:set var="time" value="${fn:split(restaurant.opening,'-')}" />
					<div class="mb-3 col-6">
						<label class="form-label">개점시간</label>
						<input class="form-control timepicker opening" name="openTime" type="text" value="${fn:split(restaurant.opening,'-')[0]}">
					</div>
					<div class="mb-3 col-6">
						<label class="form-label">폐점시간</label>
						<input class="form-control timepicker opening" name="closeTime" type="text" value="${fn:split(restaurant.opening,'-')[1]}">
						
						<input class="form-control" type="hidden" name="opening" id="opening-box">
					</div>
				</div>
				<div class="row">
				<c:set var="time" value="${fn:split(restaurant.breakTime,'-')}" />
					<div class="mb-3 col-6">
						<label class="form-label">브레이크타임 시작 시간</label>
						<input class="form-control breaktimepicker" type="text" name="breakTimeStart" value="${fn:split(restaurant.breakTime,'-')[0]}">
					</div>
					<div class="mb-3 col-6">
						<label class="form-label">브레이크타임 종료 시간</label>
						<input class="form-control breaktimepicker" type="text" name="breakTimeEnd" value="${fn:split(restaurant.breakTime,'-')[1]}">
						
						<input class="form-control" type="hidden" name="breakTime" id="breakTime-box">
					</div>
				</div>
				<div class="row mt-5">
					<div class="mb-3 col-12">
						<label class="form-label">휴무일</label>
						<input class="form-control " type="text" name="close" value="${restaurant.close }">
					</div>
				</div>
				
				<!-- 음식점 대표 사진 업로드 폼 -->
				<div class="row mb-5 mt-5">
					<div class="col-6 visually-hidden" id="div-mainimage">
						<label class="form-label">대표 이미지</label>
						<input class="form-control" type="file" name="imgfile" id="main-photo-add">
					</div>
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
										<img src="/resources/images/restaurant/${restaurant.imgname}" class="card-img main-image">
										<button type="button" class="btn btn-sm btn-secondary main-image-btn mt-1" onclick="deleteMainImage()">삭제</button>
									</div>
								</div>
							</div>
						</div>
					</div>
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
							<c:forEach var="restaurantTag" items="${restaurantTags }" varStatus="status">
								<button type="button" class="btn badge btn-secondary rounded-1 me-2 btn-delete-${status.index}" onclick="deleteBtnTags('${status.index}', '${restaurantTag.tag }')">${restaurantTag.tag }</button>
							</c:forEach>
						</div>
					</div>
				</div>
				
				<!-- 메뉴 입력 폼 -->
				<div class="row mb-5">
					<div class="col-6">
						<label class="form-label">메뉴</label>
						<input class="form-control mb-2" type="text" id="menu-name" >
					</div>
					<div class="col-6">
						<label class="form-label">금액</label>
						<input class="form-control mb-2" type="text" id="menu-price">
					</div>
					<div class="text-end">
						<button type="button" class="btn btn-secondary mt-3" id="btn-add-menu">추가</button>
					</div>
					<div class="mb-3 mt-2">
						<div id="menu-box"></div>
					</div>
					<div class="row">
						<div class="col-12">
							<label class="form-label">기존 메뉴</label>
						</div>
						<c:forEach var="restaurantMenu" items="${restaurantMenus }" varStatus="status">
							<div class="row p-0 btn-menu-delete-${status.index}" id="menu-box">
								<div class="col-5">
									<input class="form-control mb-2 delete-menu" type="text" value="${restaurantMenu.menuName }">
								</div>
								<div class="col-5">
									<input class="form-control mb-2 delete-price" type="text" value="${restaurantMenu.price }">
								</div>
								<div class="col text-start">
									<button type="button" class="btn btn-secondary" onclick="deleteBtnMenus('${status.index}', '${restaurantMenu.menuName }', '${restaurantMenu.price }')">삭제</button>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				
				<!-- 위치정보, 주소, 아이디등을 입력해두기 위한 히든폼 -->
				<div id="hidden-form-box">
					<input type="hidden" name="location" value="${restaurant.location }">
					<input type="hidden" name="district" value="${restaurant.district }">
					<input type="hidden" name="latitude" value="${restaurant.latitud }">
					<input type="hidden" name="longitude" value="${restaurant.longitude }">
					<input type="hidden" name="no" value="${restaurant.no }">
				</div>

				<!-- 수정완료 -->
				<div class="text-end mt-5">
					<button type="submit" class="btn btn-secondary px-5">수정완료</button>
				</div>				
			</form>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<!-- 다음 주소 검색 API 스크립트 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 카카오맵 API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1e9adb3077789558d707162df08956e7&libraries=services"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<script type="text/javascript">
// 페이지 오픈시 주소, 구역, 지도 좌표 입력.
document.addEventListener("DOMContentLoaded", function() {
	// 구역 히든 폼에서 읽어오기
	let oldDistrict = $('input[name=district]').val();
    // 주소 히든 폼에서 읽어오기
    let oldAddress = $('input[name=location]').val();
    
    // 시/군/구 히든 폼에 입력
    $('#sigungu').attr('value', oldDistrict);
    // 주소 히든 폼에 입력
    $('#address').attr('value', oldAddress);
})
$(function() {
	$("#form-restaurant-modify").submit(function() {
		
		// 지역 셀렉트박스가 설정되어있는지 체크하기
		let citiesValue = $("#select-cities option:selected").val();
		if (citiesValue === "") {
			alert("지역을 선택해주세요.");
			return false;
		}

		// 카테고리 체크박스가 체크되어있는지 확인하기
		let categoriesFieldLength = $(":input[name=categories]:checked").length;
		if (categoriesFieldLength < 1) {
			alert("카테고리를 선택해주세요.");
			return false;
		}
		
		// 음식점필드에 값이 있는지 체크하기
		let nameValue = $.trim( $(":input[name=name]").val() );
		if (nameValue === "") {
			alert("음식점명을 입력해주세요.");
			return false;
		}
		
		// 전화번호 필드에 값이 있는지 체크하기
		let telValue = $.trim( $(":input[name=tel]").val() );
		if (telValue === "") {
			alert("전화번호를 입력해주세요.");
			return false;
		}
		
		// 개점시간 필드에 값이 있는지 체크하기
		let openingValue = $.trim( $(":input[name=openTime]").val() );
		if (openingValue === "") {
			alert("개점시간을 입력해주세요.");
			return false;
		}
		
		// 브레이크타임 필드에 값이 있는지 체크하기
		// let breakTimeValue = $.trim( $(":input[name=breakTime]").val() );
		// if (breakTimeValue === "") {
		//	alert("브레이크타임을 입력해주세요.");
		//	return false;
		//}
		
		// 폐점시간 필드에 값이 있는지 체크하기
		let closeValue = $.trim( $(":input[name=closeTime]").val() );
		if (closeValue === "") {
			alert("폐점시간을 입력해주세요.");
			return false;
		}
	 	
	 	// 숙소 메인 이미지가 설정되어있는지 체크하기
	 	let thumbnailImageFileValue = $.trim( $(":file[name=imgfile]").val() );
	 	if (!$('#div-mainimage').is(".visually-hidden") == true && thumbnailImageFileValue === '') {
	 		alert("숙소 메인 이미지를 첨부해주세요");
	 		return false;
	 	}
		
		// 영업시간 데이터 저장
		// let $box = $("#opening-box");
		let $openTime = $(":input[name=openTime]");
		let $closeTime = $(":input[name=closeTime]");
		
		let open = $openTime.val();
		let close = $closeTime.val();

		let $data = $(":input[name=opening]").val(open+'-'+close);
		let data = $(":input[name=opening]").val();
		// alert(data);
		
		// 브레이크타임 데이터 저장
		// let $breakBox = $("#breakTime-box");
		let $startTime = $(":input[name=breakTimeStart]");
		let $endTime = $(":input[name=breakTimeEnd]");
		
		let start = $startTime.val();
		let end = $endTime.val();

		let $breakData = $(":input[name=breakTime]").val(start+'-'+end);
		let breakData = $(":input[name=breakTime]").val();
		// alert(breakData);
	});
})

// jQuery TimePicker
$('.timepicker').timepicker({
    timeFormat: 'a h시:mm분',
    interval: 30,
    minTime: '24',
    maxTime: '11:00pm',
    defaultTime: '',
    startTime: '01:00am',
    dynamic: false,
    dropdown: true,
    scrollbar: true
});

// jQuery TimePicker
$('.breaktimepicker').timepicker({
    timeFormat: 'a h시',
    interval: 30,
    minTime: '24',
    maxTime: '11:00pm',
    defaultTime: '',
    startTime: '01:00am',
    dynamic: false,
    dropdown: true,
    scrollbar: true
});
//다음 주소 검색 API
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
    position: new daum.maps.LatLng($('input[name=latitud]').val(), $('input[name=longitude]').val()),
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
            	    $('input[name=location]').attr('value', addr);
                    // 위도 히든 폼에 입력
            	    $('input[name=longitude]').attr('value', coords.La);
                    // 경도 히든 폼에 입력
					$('input[name=latitude]').attr('value', coords.Ma);
                }
            });
        }
    }).open();
}

// 메뉴 추가 버튼
$("#btn-add-menu").click(function() {
	let $div = $("#menu-box");
	let $inputName = $("#menu-name");
	let $inputPrice = $("#menu-price");

	let menuLength = $(":input[name=menus]").length;
	if (menuLength >= 10) {
		alert("최대 10개까지만 가능합니다.");
		$input.val("");
		return;
	}
	
	let menuName = $inputName.val();
	let menuPrice = $inputPrice.val();
	if (menuName != "") {
		let spanContent = '<span>메뉴명 : '+menuName+' 금액 : '+menuPrice+'</span><br>';
		let hiddenContent = '';
		hiddenContent += '<input type="hidden" name="menuNames" value="'+menuName+'">';
		hiddenContent += '<input type="hidden" name="prices" value="'+menuPrice+'">';
		
		// let hiddenContent = '<input type="hidden" name="menus" value="'+menuName+''+menuPrice+'" />'
		
		$div.before(spanContent);
		$div.append(hiddenContent);
		
		$inputName.val("");
		$inputPrice.val("");
	}		
});
// 버튼 클릭시 기존 메뉴를 화면에서 감추는 스크립트(삭제)
function deleteBtnMenus(tagNum, menu, price) {
	// alert(tagNum);
	// alert(tag);
	let $menuBox = $("#menu-box");
	$('.btn-menu-delete-'+tagNum).addClass("visually-hidden");
	
	let deleteMenuNameHidden = '<input type="hidden" name="deletMenuNames" value="'+menu+'" />';
	let deleteMenuPriceHidden = '<input type="hidden" name="deleteMenuPrices" value="'+price+'" />';
	$menuBox.append(deleteMenuNameHidden);
	$menuBox.append(deleteMenuPriceHidden);
}

//태그 추가 버튼
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
// 버튼 클릭시 태그를 화면에서 감추는 스크립트(삭제)
function deleteBtnTags(tagNum, tag) {
	// alert(tagNum);
	// alert(tag);
	let $tagBox = $("#tag-box");
	$('.btn-delete-'+tagNum).addClass("visually-hidden");
	
	let deleteTagHidden = '<input type="hidden" name="deleteTags" value="'+tag+'" />';
	$tagBox.append(deleteTagHidden);
}

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

// 인풋 텍스트 서밋 방지
$('input[type="text"]').keydown(function() {
	if (event.keyCode === 13) {
		event.preventDefault();
	};
});
</script>
</body>
</html>