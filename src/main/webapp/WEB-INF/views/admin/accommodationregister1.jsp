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
				
				<!-- CKEditor5 텍스트 에디터 API -->
				<form action="accommodation2" method="POST">
					<textarea name="detailDescription" id="editor"></textarea>
					
					<!-- 폼2로 넘길 입력값들 히든폼 -->
					<input type="hidden" name="address" value="">
					<input type="hidden" name="district" value="">
					<input type="hidden" name="latitude" value="">
					<input type="hidden" name="longitude" value="">
					<div class="text-end mt-4">
						<input type="button" class="btn btn-secondary" onclick="nextRegister()" value="다음">
					</div>
					<button type="submit" class="visually-hidden" id="btn-submit-hidden">다음</button>
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
	// CKEditor5 텍스트 에디터
	let ckEditor;
	ClassicEditor.create(document.querySelector('#editor'))
		.then(function(editor) {
			ckEditor = editor;
		});
	
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
    
    // 폼 내용 체크 후 숙소 입력 폼2로
    function nextRegister() {
		
		// 주소가 입력되었는지 확인하기
		let addressValue = $("#address").val();
		if (addressValue === "") {
			alert("주소를 입력해주세요.");
			return false;
		}
		
		// 숙소 상세 정보가 입력되었는지 확인하기
		// let detailDescriptionValue = $("textarea[name=detailDescription]").val();
		let detailDescriptionValue = ckEditor.getData();
		if (detailDescriptionValue === "") {
			alert("숙소 상세 정보를 입력해주세요.");
			return false;
		}
		
		// 히든값이 입력이 되었는지 확인
		let districtHidden = $('input[name=district]').val();
		if (districtHidden === "") {
			alert("주소를 입력해주세요.");
			return false;
		}
		
		// 히든시켜둔 서밋버튼 클릭이벤트
		$("#btn-submit-hidden").click();
    }
</script>
</body>
</html>