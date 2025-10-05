<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%-- taglib--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="UTF-8">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   <link href="/css/animate.min.css" rel="stylesheet">

	<script src="/js/bootstrap-dropdownhover.min.js"></script>
	<!-- Bootstrap Dropdown Hover JS -->

	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
    <link rel="stylesheet" href="/css/font.css" type="text/css">
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	 	
	
</head>
	
<body class="default-font">

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">

	  <div class="jumbotron">
	    <h1>학습용 상품 서비스 </h1>
	    <p>회원정보는 왼쪽상단 네비게이션바의 '내 정보' 또는 '회원관리'에서 확인 할 수 있습니다.</p>
	  </div>

	</div>
	<!-- 참조 : http://getbootstrap.com/css/   : container part..... -->
	<div class="container">
  	 </div>

</body>

</html>