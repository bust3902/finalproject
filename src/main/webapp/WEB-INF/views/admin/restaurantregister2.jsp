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
		<h1 class="fs-3 text-white p-2">음식점 등록</h1>
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
					<input type="text" class="form-control" id="address" placeholder="주소">
				</div>
				<div class="col m-0">
					<input type="button" class="btn btn-secondary mb-1" onclick="addressSearch()" value="주소 검색"><br>
				</div>
			</div>
			<div class="row p-3">
				<div id="map" style="width:100%;height:40vh;"></div>
			</div>
				
			<form id="form-restaurant" class="col p-3" method="post" action="restauinsert">
				
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
				
				<!-- 메뉴 입력 폼 -->
				<div class="row mb-5">
					<div class="col-6">
						<label class="form-label">메뉴</label>
						<input class="form-control mb-2" type="text" id="menu-name">
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
				</div>
									
				<!-- 폼2로 넘길 입력값들 히든폼 -->
				<input type="hidden" name="location" value="">
				<input type="hidden" name="district" value="">
				<input type="hidden" name="latitude" value="">
				<input type="hidden" name="longitude" value="">
					
				<!-- submit -->
				<div class="text-end mt-5">
					<button type="submit" class="btn btn-secondary px-5">등록</button>
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
<script>
// 다음 주소 검색 API
var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = {
        center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
        level: 1 // 지도의 확대 레벨
    };

//지도를 미리 생성
var map = new daum.maps.Map(mapContainer, mapOption);
//주소-좌표 변환 객체를 생성
var geocoder = new daum.maps.services.Geocoder();
//마커를 미리 생성
var marker = new daum.maps.Marker({
    position: new daum.maps.LatLng(37.537187, 127.005476),
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
            	    $('input[name=latitude]').attr('value', coords.La);
                    // 경도 히든 폼에 입력
					$('input[name=longitude]').attr('value', coords.Ma);
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
		let spanContent = '<span class="badge text-bg-secondary rounded-1 p-2 me-2">'+value+'</span>';
		let hiddenContent = '<input type="hidden" name="tags" value="'+value+'" />'
		
		$div.before(spanContent);
		$div.append(hiddenContent);
		
		$input.val("");
	}		
});

</script>
</body>
</html>