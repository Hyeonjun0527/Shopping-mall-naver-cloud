<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <title>학습용 상품 서비스</title>

  <!-- 참조 : http://getbootstrap.com/css/   참조 -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link href="${pageContext.request.contextPath}/css/layout/left.css" rel="stylesheet" type="text/css">

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script>
		const userId = "${user.userId}";
		console.log("userId"+userId);
	</script>
	<script src="${pageContext.request.contextPath}/js/layout/toolbar.js">
	</script>
</head>

<body leftmargin="0"
	topmargin="0" marginwidth="0" marginheight="0">


	<div class="container">
		<c:if test="${user != null}">
			<div class="item button">
				개인정보조회
			</div>
		</c:if>

		<c:if test="${user.role == 'admin'}">
			<div class="item button">
				회원정보조회
			</div>
		</c:if>

		<c:if test="${user.role == 'admin'}">
			<div class="item button">
				판매상품등록
			</div>
			<div class="item button">
				판매상품관리
			</div>
		</c:if>
		<div class="item button">
			상 품 검 색
		</div>

		<c:if test="${user != null && user.role == 'admin'}">
			<div class="item button">
				판매이력조회
			</div>
		</c:if>

		<c:if test="${user != null && user.role == 'user'}">
			<div class="item button">
				구매이력조회
			</div>

		</c:if>

		<c:if test="${user != null && user.role == 'user'}">
		<div class="item button">
			찜 리스트
		</div>
		</c:if>
		<div class="item button">
			최근 본 상품
		</div>
	</div>





</body>

</html>
