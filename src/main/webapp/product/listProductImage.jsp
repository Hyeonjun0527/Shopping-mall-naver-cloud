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
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <script src="/js/bootstrap-dropdownhover.min.js"></script>
    <%--사용자--%>
    <script
            src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"
            integrity="sha256-6XMVI0zB8cRzfZjqKcD01PBsAy3FlDASrlC8SxCpInY="
            crossorigin="anonymous"></script>
    <script src="/js/thumbnailEvent.js"></script>
    <link rel="stylesheet" href="/css/font.css" type="text/css">
    <link rel="stylesheet" href="/css/loading.css" type="text/css">
    <style>
        body {
            padding-top: 50px;
        }
        .no-padding{
            padding: 0;
        }
        .thumbnail .carousel-inner>.imgWrapper.active.item{
            display: inline-block;
            width:300px;
            height:300px;
        }
        .carousel-inner>.item.imgWrapper{
            width: 300px;
            height: 300px;
            position: relative;
            display:none;
        }

        .thumbnail .imgWrapper img.threeD {
            height: 100%;
            width: 100%;
            border-radius: 10px;
        }
        img.threeD{
            position:relative;
        }
        #carousel-example-generic, .custom{
            height:300px;
            width:300px;
        }
        .item ,.carousel-inner{
            height:100%;
            width:100%;
        }
    </style>
    <link href="/css/listProduct.css" rel="stylesheet" type="text/css">

</head>

<body class="default-font">

<jsp:include page="/layout/toolbar.jsp"/>
<script>



</script>
<div class="container main">

    <div class="page-header text-info">
        <h3>${menu=='manage' ? '상품관리' :'상품목록조회'}</h3>
    </div>

    <div class="row">
        <%--이 폼태그를 전달하는 건 1,2,3,4클릭이나 검색할때만임. --%>
            <div class="col-md-6 text-left">
                <p class="text-primary">
                    전체 ${totalCount} 건수, 현재 ${requestScope.resultPage.currentPage} 페이지
                </p>
                <div class="col-md-12 no-padding">
                    <button type="button" class="btn btn-primary" data-toTable>테이블로 보기<span aria-hidden="true"> &nbsp&rarr;</span>
                    </button>
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

                <button type="button" class="btn btn-default">검색</button>
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

                    <input type="text" id="searchBoundFirst" name="searchBoundFirst"
                           value='${search.searchBoundFirst}'/>
                    부터
                    <input type="text" id="searchBoundEnd" name="searchBoundEnd" value='${search.searchBoundEnd}'/>
                    까지

                    <button type="button" data-searchBound>검색</button>

                </div>
            </div>
        </form>
    </div>


    <div class="row">
        <c:set var="i" value="0"/>
        <c:set var="j" value="0"/>
        <c:forEach var="product" items="${list}">
            <c:set var="i" value="${i+1}"/>
            <div class="col-sm-6 col-md-4">
                <p>No : ${i}</p>
                <div class="thumbnail">

                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner" role="listbox">

                            <c:set var="k" value="0"/>

                    <c:forEach var="fileName" items="${fileNameListList[j]}">
                        <c:if test="${fileName!='null'}">
                            <c:if test="${k==0}">
                            <div class="item active imgWrapper">
                                <img class="threeD" src="${pageContext.request.contextPath}/images/uploadFiles/${fileName}">
                            </div>
                            </c:if>
                            <c:if test="${k!=0}">
                                <div class="item imgWrapper">
                                    <img class="threeD" src="${pageContext.request.contextPath}/images/uploadFiles/${fileName}">
                                </div>
                            </c:if>
                        </c:if>
                        <c:set var="k" value="${k+1}"/>
                    </c:forEach>

                    <c:if test="${fileNameListList[j]==null}">
                        <div class="item active imgWrapper">
                            <img class="threeD" src="${pageContext.request.contextPath}/images/uploadFiles/피카츄.jpg">
                        </div>
                    </c:if>

                        </div>
                    </div>
<%--                    여기서 carousel은 끝 --%>
                    <c:set var="j" value="${j+1}"/>


                    <div class="caption">

                        <h3>상품명 : ${product.prodName}</h3>
                        <p>상품설명 : </p>
                        <p>가격 : ${product.price}</p>
                        <p>남은 수량 : ${product.stockQuantity}</p>

                        <p>현재상태 :
                            <c:if test="${product.proTranCode!=null}">

                                <c:set var="resultA" value="${product.proTranCode.trim() == 'a' ? '구매가능' : ''}"/>
                                <c:set var="resultB" value="${product.proTranCode.trim() == 'b' ? '구매불가' : ''}"/>

                                <td align="left">
                                        ${resultA}${resultB}${(!empty resultB) ? '&nbsp;&nbsp;' : ''}
                                </td>
                            </c:if>
                        </p>

                        <c:if test="${product.proTranCode=='a'}">
                            <button type="button" class="abled btn btn-primary" data-getProduct
                                    data-prodNo="${product.prodNo}">상품보기
                            </button>
                        </c:if>
                        <c:if test="${!(product.proTranCode=='a')}">
                            <button type="button" class="disabled btn btn-primary" data-getProduct
                                    data-prodNo="${product.prodNo}">상품보기
                            </button>
                        </c:if>
                        <button type="button" class="btn btn-primary" data-setLike data-prodNo="${product.prodNo}">
                            찜하기
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>



</div>

<div class="loading-container" style="display: none">
    <div class="loading"></div>
    <div id="loading-text">loading</div>
</div>


<script>

    if ('scrollRestoration' in history) {
        history.scrollRestoration = 'manual';
    }

    $(document).ready(function() {
        $(window).scrollTop(0);
    });
    // $(window).on('beforeunload', function() {
    //     $(window).scrollTop(0);
    // });

    let menu = '${param.menu}';
    let currentPage = +`${search.currentPage}`;
    let searchKeyword = '${search.searchKeyword}';
    let searchCondition = '${search.searchCondition}';
    let searchType = `${search.searchType}`;
    let searchBoundFirst = '${param.searchBoundFirst}';
    let searchBoundEnd = '${param.searchBoundEnd}';
    let type = '${search.searchType}';//없으면 정말 아무것도 없는 공백이 됨.''가 됨

    console.log(menu);
    console.log('jsp에서 searchBoundFirst', searchBoundFirst);
    console.log('jsp에서 searchBoundEnd', searchBoundEnd);
    console.log('jsp에서 type', type);

    $(document).ready(function () {


        $(document).on('click', 'td.ct_btn01[data-search] button:contains("검색")', function () {
            fncGetList('1');
        });

        $(document).on('click', 'button[data-searchBound]:contains("검색")', function () {
            fncGetList('${resultPage.currentPage}');
        });

        $(document).on('click', 'button[data-getProduct].abled', function () {
            let prodNo = $(this).data('prodno');
            window.location.href = "/product/getProduct?prodNo=" + prodNo + "&menu=${menu}";
        });

        $(document).on('click', 'button[data-update]', function () {
            let prodNo = $(this).data('prodno');
            window.location.href = "/purchase/updateTranCode?prodNo=" + prodNo + "&navigationPage=listProduct&menu=manage";
        });

        $(document).on('click', 'button[data-setLike]', function () {
            let prodNo = $(this).data('prodno');
            window.location.href = "/product/setLikeProduct?prodNo=" + prodNo + "&menu=${menu}&currentPage=${resultPage.currentPage}&navigation=listProductImage.jsp";
        });

        $(document).on('click', 'input[name=searchType]', function () {
            fncGetList('1');
        });

        $(document).on('click', 'button[data-toTable]', function () {
            window.location.href = "/product/listProduct?menu=${menu}&image=no";
        });
        
        // 이 페이지 전용 fncGetList 오버라이드
        function fncGetList(currentPage) {
            console.log(`listProductImage.jsp의 fncGetList실행`);

            $("#currentPage").val(currentPage)
            
            // 이미지 뷰이므로 항상 image=ok를 유지하도록 URL을 구성합니다.
            const url = "/product/listProduct?menu=${param.menu}&image=ok";
            console.log("form action url : " + url);
            $("form").attr("method" , "POST").attr("action" , url).submit();
        }


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
                        $.each(data, function (index, obj) {
                            console.log(obj);
                        })
                        console.log("data[0] : " + JSON.stringify(data[0]));
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

        let imgWrapper = $("div.imgWrapper");
        let oneTime = true;

        // imgWrapper.on('mouseIn', function (e) {
        //     console.log("얘는 들어올때 한번만 실행되어야 함.");
        //     //  imgWrapper.css('transition', 'transform 0.5s');
        // });
        //
        // imgWrapper.on('mousemove', function (e) {
        //     let num = 10;
        //     let x = e.offsetX//0~240  0일때 rotateY(20deg) 240일때 rotateY(-20deg)
        //     // 20 = 0*a + b  -20 = 240*a + b
        //     // b= 20 a = -20*2/240
        //
        //     let y = e.offsetY//0~300 0일때 rotateX(-20deg) 300일때 rotateX(20deg)
        //     // -20 = 0*a + b  20 = 300*a + b
        //     // b = -20 a= 40*2/240
        //
        //     console.log(x, y);
        //
        //     let rotateY = -num*2 / 240 * x + num
        //     let rotateX = num*2 / 300 * y - num
        //     console.log(rotateY, rotateX);
        //
        //     $(this).css('transform', 'perspective(350px) rotateX(' + rotateX + 'deg) rotateY(' + rotateY + 'deg)');
        //
        //     if (oneTime) {
        //         $(this).css('transition', 'transform 0.3s');
        //         oneTime = false;
        //     }
        //     console.log($(this)[0].style.transform);
        // });
        //
        // imgWrapper.on('mouseout', function (e) {
        //     oneTime = true;
        //     $(this).css('transition', 'transform 0.5s');
        //     $(this).css('transform', 'perspective(350px) rotateX(' + 0 + 'deg) rotateY(' + 0 + 'deg)');
        //     console.log($(this)[0].style.transform);
        // });
        // imgWrapper.on('transitionend', function () {
        //     // transition 효과가 끝나면 transition 속성 제거
        //     $(this).css('transition', '');
        // });

        let isLoading = false;
        $(window).scroll(function() {
            if (isLoading) return;

            console.log("도큐먼트 헤이트"+$(document).height());
            // console.log("바디 스크롤헤이트 :: " + document.body.scrollHeight);
            console.log("윈도우 헤이트"+$(window).height());
            // console.log("이너헤이트" + window.innerHeight);
            console.log("스크롤탑 :: "+$(window).scrollTop());
            console.log("=========================");
            var scrollTop = $(window).scrollTop();
            var windowHeight = $(window).height();
            var documentHeight = $(document).height();
            var offset = 5; // 새로운 콘텐츠를 로드할 스크롤 위치의 오프셋, 얘를 늘리면 하단바 끝까지 안가도 생김
            var offsetReposition = 100;
            // 스크롤이 페이지 하단에 도달했는지 확인
            if (scrollTop + windowHeight >= documentHeight - offset) {
                isLoading = true;
                // 여기서 새로운 콘텐츠를 불러오는 로직을 구현합니다.
                // 예시: 새로운 콘텐츠를 페이지에 추가
                console.log('이벤트발생');
                console.log("currentPage 이 값을 에이젝스에 보냄. :: " + currentPage);

                $('.loading-container').show();

                //에이젝스니 서버를 갔다오는데 그것도 새로운 HTTP요청, 새로운 스코프이다.
                //서버에서 currentPage에 1을 더하면 된다.

                $.ajax(
                    {
                        url:"json/listProductImg",
                        method:"POST",
                        dataType:"json",
                        headers: {
                            "Accept": "application/json",
                            "Content-Type": "application/json"
                        },
                        data: JSON.stringify({
                            currentPage : currentPage,
                            searchKeyword: searchKeyword,
                            searchCondition: searchCondition,
                            searchType:searchType,
                            searchBoundFirst:searchBoundFirst,
                            searchBoundEnd:searchBoundEnd,
                            menu:menu
                        }),
                    }).done(function (data) {
                    console.log("받은 데이터" + JSON.stringify(data));

                    setTimeout(function() {
                            $('.loading-container').hide();
                    },800);
                    if (data.products && data.products.length > 0) {
                        setTimeout(function () {
                            window.scrollTo(0, scrollTop - offsetReposition)
                            makeThumbnail(data);
                            console.log("currentPage :: " + currentPage);
                            isLoading = false;
                        }, 800);
                    }
                    }).fail(function(jqXHR, textStatus, errorThrown){
                        console.log('실패');
                        console.log(jqXHR);
                        console.log(textStatus);
                        console.log(errorThrown);
                    });



            };//end of if
        });//end of scroll



        // $.ui.autocomplete.prototype._close = function(event) {
        //     // 검색어 닫힘 동작을 무시하거나 조건에 따라 처리
        // };
    });//end of ready
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/variousSearch.js"></script>
</body>

</html>