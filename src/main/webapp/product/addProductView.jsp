
<!-- 상품 등록 상품 정보 수정 복붙-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>


<html>
<head>
	<title>상품등록</title>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="/css/font.css" type="text/css">

	<script type="text/javascript" src="../js/calendar.js"></script>


</head>

<body>

<form class="form-horizontal default-font" name="detailForm">

	<h1>상품등록</h1>
	<div class="form-group">
		<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		<div class="col-sm-4">
			<input type="text" id="prodName" name="prodName" class="form-control" placeholder="상품명"
				   maxLength="20">
<%--			<input type="text" class="form-control" id="userId" name="userId" placeholder="중복확인하세요" readonly>--%>
<%--			<span id="helpBlock" class="help-block">--%>
<%--		      	<strong class="text-danger">입력전 중복확인 부터..</strong>--%>
<%--		      </span>--%>
		</div>
<%--		<div class="col-sm-3">--%>
<%--			<button type="button" class="btn btn-info">중복확인</button>--%>
<%--		</div>--%>
	</div>

	<div class="form-group">
		<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		<div class="col-sm-4">
			<input type="text" id="prodDetail" name="prodDetail" class="form-control" placeholder="상품상세정보"
				   maxLength="50"/>
		</div>
	</div>

	<div class="form-group">
		<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		<div class="col-sm-4">

			<input class="form-control" id="manuDate" type="text" name="manuDate" readonly="readonly"
				   	maxLength="10" minLength="6"/>
			&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15"
					   onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>
		</div>
	</div>

	<div class="form-group">
		<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		<div class="col-sm-4">
			<input type="text" name="price" 	class="form-control" id="price" placeholder="숫자만 입력"
				    maxLength="10">
		</div>
	</div>

	<div class="form-group">
		<label for="fileList" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>

		<div class="col-sm-4">
			<input		type="file" name="fileList" multiple class="form-control" id="fileList"/>
		</div>
	</div>
	<div class="form-group">
		<label for="stockQuantity" class="col-sm-offset-1 col-sm-3 control-label">상품재고수량</label>

		<div class="col-sm-4">
			<input		type="text" name="stockQuantity" multiple class="form-control" id="stockQuantity"/>
		</div>
	</div>

	<div class="form-group">
		<div class="col-sm-offset-4  col-sm-4 text-center">
			<button type="button" class="btn btn-primary add">등&nbsp;록</button>
			<button type="button" class="btn btn-primary cancel">취&nbsp;소</button>
			<button type="button" class="btn btn-primary back">뒤로가기</button>
		</div>
	</div>
</form>
<script type="text/javascript">
	$(function () {

		console.log("실행은돼");
		function fncAddProduct() {
			//Form 유효성 검증
			// var name = document.detailForm.prodName.value;
			// var detail = document.detailForm.prodDetail.value;
			// var manuDate = document.detailForm.manuDate.value;
			// var price = document.detailForm.price.value;
			var name = $("input[name='prodName']").val();
			var detail = $("input[name='prodDetail']").val();
			var manuDate = $("input[name='manuDate']").val();
			var price = $("input[name='price']").val();

			if (name == null || name.length < 1) {
				alert("상품명은 반드시 입력하여야 합니다.");
				return;
			}
			if (detail == null || detail.length < 1) {
				alert("상품상세정보는 반드시 입력하여야 합니다.");
				return;
			}
			if (manuDate == null || manuDate.length < 1) {
				alert("제조일자는 반드시 입력하셔야 합니다.");
				return;
			}
			if (price == null || price.length < 1) {
				alert("가격은 반드시 입력하셔야 합니다.");
				return;
			}

			$("form[name='detailForm']")
					.attr("method", "post")
					.attr("action", '/product/addProduct')
					.attr("enctype", 'multipart/form-data')
					.submit();
			console.log("submit");
			// document.detailForm.action='/product/addProduct';//리퀘스트를 addProduct한테 줌
			// document.detailForm.submit();
		}//end of fncAddProduct()

		function resetData() {
			$("form[name='detailForm']")
					[0]
					.reset();
			// document.detailForm.reset(); 일반객체로 만들어야 reset() 사용가능
		}//end of resetData()



		$('.add').on('click', function () {
			fncAddProduct();
		});
		$('.cancel').on('click', function () {
			resetData();
			console.log("클릭감지 cancel");
		});
		$('.back').on('click', function () {
			history.back();
			console.log("클릭감지 back");
		});
	});//end of ready
</script>
</body>
</html>