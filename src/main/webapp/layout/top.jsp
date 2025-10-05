<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta charset="UTF-8">

    <title>학습용 상품 서비스</title>

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link href="${pageContext.request.contextPath}/css/layout/top.css" rel="stylesheet" type="text/css">

    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
</head>

<body topmargin="0" leftmargin="0">

<div class="container">
    <c:if test="${!empty user}">
        <div class="item button">
        logout
        </div>
    </c:if>

    <c:if test="${empty user}">
        <div class="item button">
        login
        </div>
    </c:if>
</div>
</body>

<script src="${pageContext.request.contextPath}/js/layout/top.js"></script>
</html>
