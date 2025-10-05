<!-- 상품목록조회 -->
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>상품 목록조회</title>
    <%--제이쿼리--%>
    <script src="//code.jquery.com/jquery-3.6.0.min.js"></script>

    <%--부트스트랩--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%-- 부트스트랩 Dropdown Hover CSS JS--%>
    <script
            src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"
            integrity="sha256-6XMVI0zB8cRzfZjqKcD01PBsAy3FlDASrlC8SxCpInY="
            crossorigin="anonymous"></script>
    <%--사용자--%>
    <link rel="stylesheet" href="/css/font.css" type="text/css">
    <style>
        body {
            padding-top: 50px;
        }
        .size-set{
            width:1140px;
            margin-left: 15px;
        }
        .max-size {
            max-width: 100px !important;
            max-height: 100px !important;
        }
        .no-padding{
            padding: 0;
        }
    </style>
    <link href="/css/listProduct.css" rel="stylesheet" type="text/css">

</head>
<body class="default-font">
<jsp:include page="/layout/toolbar.jsp" />
<script>

    let type = '${search.searchType}';//없으면 정말 아무것도 없는 공백이 됨.''가 됨
    let searchBoundFirst = '${search.searchBoundFirst}';//'0'이 됨
    let searchBoundEnd = '${search.searchBoundEnd}';
    let user = '${user}';
    console.log('jsp에서 user', user);

    let menu = '${menu}';
    console.log(menu);
    console.log('jsp에서 searchBoundFirst', searchBoundFirst);
    console.log('jsp에서 searchBoundEnd', searchBoundEnd);
    console.log('jsp에서 type', type);

</script>
<div class="container">
    <div class="page-header text-info">
        <h3>${menu=='manage' ? '판매상품관리' :'상품목록조회'}</h3>
    </div>

    <div class="row">
        <%--이 폼태그를 전달하는 건 1,2,3,4클릭이나 검색할때만임. --%>
        <div class="col-md-6 text-left">
            <p class="text-primary">
                전체 ${totalCount} 건수, 현재 ${requestScope.resultPage.currentPage} 페이지
            </p>
            <div class="col-md-12 no-padding">
                <button type="button" class="btn btn-primary" data-toImage>이미지로 보기<span
                        aria-hidden="true"> &nbsp&rarr;</span></button>
            </div>
        </div>

        <form class="form-inline" name="detailForm">

            <div class="col-md-6 text-right">
                <div class="form-group">
                    <select name="searchCondition"
                            class="form-control">
                        <c:choose>
                            <c:when test="${requestScope.search.searchCondition=='0'}">
                                <option value="0" selected>상품번호</option>
                                <option value="1">상품명</option>
                                <option value="2">상품가격</option>
                            </c:when>
                            <c:when test="${requestScope.search.searchCondition=='1'}">
                                <option value="0">상품번호</option>
                                <option value="1" selected>상품명</option>
                                <option value="2">상품가격</option>
                            </c:when>
                            <c:when test="${requestScope.search.searchCondition=='2'}">
                                <option value="0">상품번호</option>
                                <option value="1">상품명</option>
                                <option value="2" selected>상품가격</option>
                            </c:when>
                            <c:otherwise>
                                <option value="0">상품번호</option>
                                <option value="1">상품명</option>
                                <option value="2">상품가격</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </div>
                <div class="form-group">
                    <label class="sr-only" for="searchKeyword">검색어</label>
                    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"
                           placeholder="검색어"
                           value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
                </div>

                <button type="button" class="btn btn-default" data-search>검색</button>
                <input type="hidden" id="currentPage" name="currentPage" value=""/>

            </div>

            <div class="col-md-12 text-right">
                <div class="form-group">

                    <input type="radio" id="searchType1" name="searchType" value="1"/>
                    <label for="searchType1" class="button">일반 검색</label>

                    <input type="radio" id="searchType2" name="searchType" value="2"/>
                    <label for="searchType2" class="button">가격 높은순 검색</label>

                    <input type="radio" id="searchType3" name="searchType" value="3"/>
                    <label for="searchType3" class="button">가격 낮은순 검색</label>

                    <input type="text" id="searchBoundFirst" name="searchBoundFirst" maxlength=9
                           value='${search.searchBoundFirst}'/>
                    부터

                    <input type="text" id="searchBoundEnd" name="searchBoundEnd" value='${search.searchBoundEnd}' maxlength=9/>
                    까지

                    <button type="button" data-searchBound>검색</button>

                </div>
            </div>
        </form>

        <table class="table table-hover table-striped size-set">
            <thead>
            <tr>
                <td>No</td>
                <td>상품명</td>
                <td>가격</td>
                <td>남은수량</td>
                <td>등록일</td>
                <td>현재상태</td>
                <td>찜하기</td>
            </tr>
            </thead>

            <tbody>
            <c:set var="i" value="0"/>
            <c:forEach var="product" items="${list}">
                <c:set var="i" value="${i+1 }"/>
                <tr>
                    <td align="center">${i}</td>

                    <c:if test="${(user.role!='admin'&&product.proTranCode!='a')}">
                    <td align="left">${product.prodName}</td>
                    </c:if>

                    <c:if test="${user.role=='admin'}">
                    <td align="left">
                        <button class="btn btn-primary" type="button" data-getProduct data-prodNo="${product.prodNo}">
                                ${product.prodName}
                        </button>
                    </td>
                    </c:if>

                    <c:if test="${user.role!='admin'&&product.proTranCode=='a'}">
                    <td align="left">
                        <button class="btn btn-primary" type="button" data-getProduct data-prodNo="${product.prodNo}">
                                ${product.prodName}
                        </button>
                    </td>
                    </c:if>
                    <td align="left">${product.price}</td>
                    <!-- 가격 -->
                    <td align="left">${product.stockQuantity}</td>
                    <!-- 남은수량 -->
                    <td align="left">${product.regDate}</td>
                    <c:if test="${product.proTranCode!=null}">

                        <c:set var="resultA" value="${product.proTranCode.trim() == 'a' ? '구매가능' : ''}"/>
                        <c:set var="resultB" value="${product.proTranCode.trim() == 'b' ? '구매불가' : ''}"/>

                    <td align="left">
                            ${resultA}${resultB}${(!empty resultB) ? '&nbsp;&nbsp;' : ''}
                    </td>
                    </c:if>
                    <td>
                        <button type="button" data-setLike data-prodNo="${product.prodNo}">
                            찜하기
                        </button>
                    </td>
                <tr/>
            </c:forEach>
            </tbody>
        </table>

        <jsp:include page="${pageContext.request.contextPath}/common/pageNavigator_new.jsp"/>





        <!--  페이지 Navigator 끝 -->


    </div>
</div>


<script type="text/javascript" src="${pageContext.request.contextPath}/js/variousSearch.js"></script>
<script>
    // variousSearch.js의 fncGetList를 오버라이드(재정의)합니다.
    function fncGetList(currentPage) {
        console.log(`listProduct.jsp의 fncGetList실행`);

        $("#currentPage").val(currentPage)
        
        // 테이블 뷰이므로 항상 image=no를 유지하도록 URL을 구성합니다.
        const url = "/product/listProduct?menu="+menu+"&image=no";
        console.log("form action url : " + url);
        $("form").attr("method" , "POST").attr("action" , url).submit();
    }

    $(document).ready(function () {
        $('button.btn[data-search]:contains("검색")').click(function () {
            console.log('실행됫나보자.')
            fncGetList('1');
        });
        $('button[data-searchBound]:contains("검색")').click(function () {
            fncGetList('${resultPage.currentPage}');
        });
        $('button[data-getProduct]').click(function () {
            let prodNo = $(this).data('prodno');
            window.location.href = "/product/getProduct?prodNo=" + prodNo + "&menu=${menu}";
        });
        // $('span.clickableSpan').click(function () {
        //     let prodNo = $(this).data('prodno');
        //     window.location.href = "/purchase/updateTranCode?prodNo=" + prodNo + "&navigationPage=listProduct&menu=manage";
        // })
        $('button[data-setLike]').click(function () {
            let prodNo = $(this).data('prodno');
            window.location.href = "/product/setLikeProduct?prodNo=" + prodNo + "&menu=${menu}&currentPage=${resultPage.currentPage}";
        })
        $('input[name=searchType]').click(function () {
            fncGetList('1');
        })
        $('button[data-toImage]').click(function () {
            window.location.href = "/product/listProduct?menu=${menu}&image=ok";
        })
        
        $('input[name="searchKeyword"]').autocomplete({
            source: function (request, response) {

                function createLabelValueMapper(Prop) {
                    return function (object) {
                        return {
                            label: object[Prop],
                            value: object[Prop]
                        }
                    }
                };
                let searchCondition = $('select[name=searchCondition]').val()

                console.log("소스가 호출됩니다.");
                console.log("줄 데이터 : request.term : " + request.term);

                console.log("줄 데이터 : Condition : " + searchCondition);
                console.log(JSON.stringify({
                    searchKeyword: request.term,
                    searchCondition: searchCondition
                }));
                $.ajax({
                    url: '/product/json/autoComplete',
                    type: 'post',
                    dataType: 'json',
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    data: JSON.stringify({
                        searchKeyword: request.term,
                        searchCondition: searchCondition
                    }),
                }).done(function (rawData, textStatus, jqXHR) {
                    console.log('받은 데이터 : ' + rawData);
                    if (rawData.length !== 0) {
                        // 서버로부터 받은 데이터 (Product 객체의 리스트)를 처리
                        console.log('데이터가 존재 data : ' + rawData);
                        //번호, 명, 가격 $.map은 요소에 function 다 적용시키고 배열 반환
                        //그 function을 만드는 function을 만들면 더 편하겠다. 그게 mapper변수

                        switch (searchCondition) {
                            case '0':
                                mapper = createLabelValueMapper("prodNo");
                                break;
                            case "1":
                                mapper = createLabelValueMapper("prodName");
                                break;
                            case "2":
                                mapper = createLabelValueMapper("price");
                                break;
                        }

                        let data = $.map(rawData, mapper);
                        console.log('data : ' + data);
                        //데이터 각 항목마다 콜백함수 호출한다.
                        $.each(data, function (index, obj) {
                            console.log(obj);
                        })
                        console.log("data[0] : " + JSON.stringify(data[0]));
                        //RegExp 정규표현식. ^는 시작을 의미. i는 대소문자 구분없이 escapeRegex는 특수문자를 이스케이프
                        //.test는 정규표현식에 맞는지 확인하고 true반환, $.grep은 true만 모아서 새 배열
                        let matcher = new RegExp("^" + $.ui.autocomplete.escapeRegex(request.term), "i");
                        console.log($.grep(data, function (item) {
                            return matcher.test(item.label);
                        }));
                        response($.grep(data, function (item) {
                            return matcher.test(item.label);
                        }).slice(0, 5));
                        //.slice(0,7)
                        //response(data); // 처리된 데이터를 자동완성 목록으로 표시
                    } else {
                        // 서버로부터 받은 데이터가 없을 때는 빈 배열을 전달하여 자동완성을 제안하지 않음
                        response([]);
                    }

                }).fail(function (jqXHR, textStatus, errorThrown) {
                    console.log('실패');
                    console.log(jqXHR);
                    console.log(textStatus);
                    console.log(errorThrown);
                });
            },//end of source
            select: function (event, ui) {
                // 옵션을 선택했을 때, 원하는 동작을 정의할 수 있음
                // 예를 들어, 선택된 Product의 id를 어딘가에 저장하거나 다른 작업을 수행
                console.log("Selected: " + ui.item.label + ", id: " + ui.item.value);
                let $element = $('input[name="searchKeyword"]');

                $element.addClass('flash-effect');
                $element.one('animationed', function () {
                    $element.removeClass('flash-effect');
                });
            },//end of select event
            classes: {
                "ui-autocomplete": "custom-ui-autocomplete",
            },

            autoFocus: true,//end of autoFocus

        });//end of autocomplete

        // $.ui.autocomplete.prototype._close = function(event) {
        //     // 닫힘 동작을 무시하거나 조건에 따라 처리
        // };
    });//end of ready
</script>

</body>
</html>