<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">

<%--		navbar-brand는 축소되도 보인다.--%>
		<a class="navbar-brand" href="/index.jsp">학습용 상품 서비스</a>

<%--		navbar-toggle은 축소될때만 보이고, 오른쪽	에 토글버튼 생성함--%>
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
<%--		navbar-collapse는 사용하는 요소들임. --%>
	<%--fadeInDown fadeInRight fadeInUp fadeInLeft 부트스트랩 드롭다운호버라는 api 구글링--%>
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target"
	       			data-hover="dropdown">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             
	              <!--  회원관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							 <c:if test="${user.role=='admin'}">
	                         <span >회원관리</span>
							 </c:if>
							 <c:if test="${!(user.role=='admin')}">
								 <span >내 정보</span>
							 </c:if>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">개인정보조회</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'admin'}">
	                         	<li><a href="#">회원정보조회</a></li>
	                         </c:if>
	                         
	                         <li class="divider"></li>
	                         <li><a href="#">etc...</a></li>
	                     </ul>
	                 </li>
	                 
	              <!-- 판매상품관리 DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >상품관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">판매상품등록</a></li>
								 <li><a href="#">판매상품관리</a></li>
		                         <li class="divider"></li>
		                         <li><a href="#">etc..</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- 구매관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >상품구매</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
							 <c:if test="${sessionScope.user.role == 'user'}">
								 <li><a href="#">구매이력조회</a></li>
								 <li><a href="#">상 품 검 색</a></li>
							 </c:if>
							 <c:if test="${sessionScope.user.role == 'admin'}">
								 <li><a href="#">판매이력조회</a></li>
								 <li><a href="#">상 품 검 색(회원 뷰 확인하기 위함)</a></li>
							 </c:if>
	                         
	                         <li><a href="#">최근 본 상품</a></li>
	                         <li class="divider"></li>
	                         <li><a href="#">etc..</a></li>
	                     </ul>
	                 </li>
	                 
	                 <li><a href="#">찜 리스트</a></li>
	             </ul>
	             
	             <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">로그아웃</a></li>
	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->


<script>
	const userId = "${user.userId}";
	console.log("userId"+userId);
</script>
<script src="${pageContext.request.contextPath}/js/layout/toolbar.js"></script>