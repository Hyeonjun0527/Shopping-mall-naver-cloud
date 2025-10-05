<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageFunction" value="${not empty param.pageFn ? param.pageFn : 'fncGetList'}" />
 
<div class="container text-center">
		 <nav>
		  <!-- 크기조절 :  pagination-lg pagination-sm-->
		  <ul class="pagination" >
		    <!--  <<== 좌측 nav 현재페이지6이고 페이지유닛 5이면 좌측 nav 생성-->
		  	<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
		 		<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
				<li>
			</c:if>
		      <a href="javascript:${pageFunction}('${resultPage.beginUnitPage-1}')" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    
		    <!--  중앙 페이지유닛 5면 5번 반복이네 현재페이지면 active 아니면 active없앰 -->
			<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				
				<c:if test="${ resultPage.currentPage == i }">
					<!--  현재 page 가르킬경우 : active -->
				    <li class="active">
				    	<a href="javascript:${pageFunction}('${ i }');">${ i }<span class="sr-only">(current)</span></a>
				    </li>
				</c:if>	
				
				<c:if test="${ resultPage.currentPage != i}">	
					<li>
						<a href="javascript:${pageFunction}('${ i }');">${ i }</a>
					</li>
				</c:if>
			</c:forEach>
		    
		     <!--  우측 nav==>> -->
		     <c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
		  		<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
				<li>
			</c:if>
		      <a href="javascript:${pageFunction}('${resultPage.endUnitPage+1}')" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</nav>
</div>
 <script>
	 $(document).ready(function() {
		 console.log("resultPage.beginUnitPage :: "+"${resultPage.beginUnitPage}");
		 console.log("resultPage.endUnitPage :: " + "${resultPage.endUnitPage}");
		 $(".disabled").click(function (event) {
			 event.preventDefault();
		 })
	 });
 </script>


<%--<div class="container">--%>
<%--		<nav>--%>
<%--		  <ul class="pager">--%>
<%--		    <li><a href="#">Previous</a></li>--%>
<%--		    <li><a href="#">Next</a></li>--%>
<%--		  </ul>--%>
<%--		</nav>--%>
<%--</div>--%>


<%--<div class="container">--%>
<%--		<nav>--%>
<%--		  <ul class="pager">--%>
<%--		    <li class="previous disabled"><a href="#"><span aria-hidden="true">&larr;</span> Older</a></li>--%>
<%--		    <!-- <li class="previous"><a href="#"><span aria-hidden="true">&larr;</span> Older</a></li>  -->--%>
<%--		    <li class="next"><a href="#">Newer <span aria-hidden="true">&rarr;</span></a></li>--%>
<%--		  </ul>--%>
<%--		</nav>--%>
<%--</div>--%>