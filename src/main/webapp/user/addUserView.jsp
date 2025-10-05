<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="UTF-8">

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="	https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" >
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" ></script>
<%--다음 APi--%>
	<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body > div.container{
			border: 3px solid #D6CDB7;
			margin-top: 10px;
		}
	</style>
	<link rel="stylesheet" href="/css/font.css" type="text/css">
	<!--  ///////////////////////// JavaScript ////////////////////////// -->


</head>

<body class="default-font">

<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-default">

  <div class="container">
    <a class="navbar-brand" href="/index.jsp">학습용 상품 서비스</a>
  </div>

</div>
<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

	<h1 class="bg-primary text-center">회 원 가 입</h1>

	<!-- form Start /////////////////////////////////////-->
	<form>

		<div class="row mb-3">
			<label for="userId" class="offset-sm-2 col-sm-1 col-form-label">아 이 디</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="userId" name="userId" placeholder="중복확인하세요"  readonly>
				<span id="helpBlock" class="help-block">
		      	<strong class="text-danger">입력전 중복확인 부터..</strong>
		      </span>
			</div>
			<div class="col-sm-3">
				<button type="button" class="btn btn-info">중복확인</button>
			</div>
		</div>

		<div class="row mb-3">
			<label for="password" class="offset-sm-2 col-sm-1 col-form-label">비밀번호</label>
			<div class="col-sm-4">
				<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
			</div>
		</div>

		<div class="row mb-3">
			<label for="password2" class="offset-sm-2 col-sm-1 col-form-label">비밀번호 확인</label>
			<div class="col-sm-4">
				<input type="password" class="form-control" id="password2" name="password2" placeholder="비밀번호 확인">
			</div>
		</div>

		<div class="row mb-3">
			<label for="userName" class="offset-sm-2 col-sm-1 col-form-label">이름</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="userName" name="userName" placeholder="회원이름">
			</div>
		</div>

		<div class="row mb-3">
			<label for="ssn" class="offset-sm-2 col-sm-1 col-form-label">주민번호</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="ssn" name="ssn" placeholder="주민번호">
				<span id="helpBlock2" class="help-block">
		      	 <strong class="text-danger">" -  " 제외 13자리입력하세요</strong>
		      </span>
			</div>
		</div>

		<div class="row mb-3">
			<label for="sample6_postcode" class="offset-sm-2 col-sm-1 col-form-label">주소</label>
			<div class="col-sm-4">
				<input type="text" id="sample6_postcode" placeholder="우편번호">
				<input type="button" id="daum" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="sample6_address" placeholder="주소"><br>
				<input type="text" id="sample6_detailAddress" placeholder="상세주소">
				<input type="text" id="sample6_extraAddress" placeholder="참고항목">
				<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>


			</div>
		</div>

		<div class="row mb-3">
			<label for="ssn" class="offset-sm-2 col-sm-1 col-form-label">휴대전화번호</label>
			<div class="col-sm-2">
				<select class="form-control" name="phone1" id="phone1">
					<option value="010" >010</option>
					<option value="011" >011</option>
					<option value="016" >016</option>
					<option value="018" >018</option>
					<option value="019" >019</option>
				</select>
			</div>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="phone2" name="phone2" placeholder="번호">
			</div>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="phone3" name="phone3" placeholder="번호">
			</div>
			<input type="hidden" name="phone"  />
		</div>

		<div class="row mb-3">
			<label for="ssn" class="offset-sm-2 col-sm-1 col-form-label">이메일</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="email" name="email" placeholder="이메일">
			</div>
		</div>

		<div class="row mb-3">
			<div class="offset-sm-7 col-sm-3 text-center">
				<button type="button" class="btn btn-primary"  >가 &nbsp;입</button>
				<a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
			</div>
		</div>
	</form>
	<!-- form Start /////////////////////////////////////-->

</div>
<!--  화면구성 div end /////////////////////////////////////-->
<script type="text/javascript">

	//============= "가입"  Event 연결 =============
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button.btn.btn-primary" ).on("click" , function() {
			fncAddUser();
		});
	});


	//============= "취소"  Event 처리 및  연결 =============
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#' ]").on("click" , function() {
			$("form")[0].reset();
		});
	});


	function fncAddUser() {

		var id=$("input[name='userId']").val();
		var pw=$("input[name='password']").val();
		var pw_confirm=$("input[name='password2']").val();
		var name=$("input[name='userName']").val();


		if(id == null || id.length <1){
			alert("아이디는 반드시 입력하셔야 합니다.");
			return;
		}
		if(pw == null || pw.length <1){
			alert("패스워드는  반드시 입력하셔야 합니다.");
			return;
		}
		if(pw_confirm == null || pw_confirm.length <1){
			alert("패스워드 확인은  반드시 입력하셔야 합니다.");
			return;
		}
		if(name == null || name.length <1){
			alert("이름은  반드시 입력하셔야 합니다.");
			return;
		}

		if( pw != pw_confirm ) {
			alert("비밀번호 확인이 일치하지 않습니다.");
			$("input:text[name='password2']").focus();
			return;
		}

		var value = "";
		if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
			var value = $("option:selected").val() + "-"
					+ $("input[name='phone2']").val() + "-"
					+ $("input[name='phone3']").val();
		}

		$("input:hidden[name='phone']").val( value );

		$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
	}


	//==>"이메일" 유효성Check  Event 처리 및 연결
	$(function() {

		$("input[name='email']").on("change" , function() {

			var email=$("input[name='email']").val();

			if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
				alert("이메일 형식이 아닙니다.");
			}
		});

	});


	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//==> 주민번호 유효성 check 는 이해정도로....
	function checkSsn() {
		var ssn1, ssn2;
		var nByear, nTyear;
		var today;

		ssn = document.detailForm.ssn.value;
		// 유효한 주민번호 형식인 경우만 나이 계산 진행, PortalJuminCheck 함수는 CommonScript.js 의 공통 주민번호 체크 함수임
		if(!PortalJuminCheck(ssn)) {
			alert("잘못된 주민번호입니다.");
			return false;
		}
	}

	function PortalJuminCheck(fieldValue){
		var pattern = /^([0-9]{6})-?([0-9]{7})$/;
		var num = fieldValue;
		if (!pattern.test(num)) return false;
		num = RegExp.$1 + RegExp.$2;

		var sum = 0;
		var last = num.charCodeAt(12) - 0x30;
		var bases = "234567892345";
		for (var i=0; i<12; i++) {
			if (isNaN(num.substring(i,i+1))) return false;
			sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
		}
		var mod = sum % 11;
		return ((11 - mod) % 10 == last) ? true : false;
	}
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	//==>"ID중복확인" Event 처리 및 연결
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("button.btn.btn-info").on("click" , function() {
			popWin
					= window.open("/user/checkDuplication.jsp",
					"popWin",
					"left=300,top=200,width=780,height=130,marginwidth=0,marginheight=0,"+
					"scrollbars=no,scrolling=no,menubar=no,resizable=no");
		});
	});




	// 	다음 API
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
			mapOption = {
				center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
				level: 5 // 지도의 확대 레벨
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

	function sample6_execDaumPostcode() {
		new daum.Postcode({
			oncomplete: function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if(data.userSelectedType === 'R'){
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if(data.buildingName !== '' && data.apartment === 'Y'){
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if(extraAddr !== ''){
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("sample6_extraAddress").value = extraAddr;

				} else {
					document.getElementById("sample6_extraAddress").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('sample6_postcode').value = data.zonecode;
				document.getElementById("sample6_address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("sample6_detailAddress").focus();
			}
		}).open();
	}
</script>
</body>

</html>