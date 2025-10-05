function makeThumbnail(JsonData) {

    console.log(`JsonData :: ` + JSON.stringify(JsonData) );

    console.log("JsonData.search.currentPage :: " + JsonData.search.currentPage);
        currentPage = JsonData.search.currentPage;

        if(currentPage===1){
            currentPage++;
        }

    let No = (currentPage)*3 -2;
    let products = 0;
    let returnPage = '';



    returnPage += `
<div class="row">`;

    console.log(`JsonData.products:: ` +JSON.stringify(JsonData.products));



    $.each(JsonData.products, function (index, value) {
            const product = JsonData.products[index];
            console.log(`product :: `+JSON.stringify(product));


            returnPage += `
            <div class="col-sm-6 col-md-4">
            <p>No : ${No}</p>
                <div class="thumbnail">
                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner" role="listbox">
                `;//end of append
        No++;
        let k = 0;

            product.fileName?.split(",").forEach(function (fileName) {
                if(fileName!='null'){
                    if(k==0) {
                        returnPage += `
                        <div class="item active imgWrapper">
                            <img class="threeD" src="/images/uploadFiles/${fileName}"/>
                        </div>
                        `;
                    } else {
                        returnPage += `
                        <div class="item imgWrapper">
                            <img class="threeD" src="/images/uploadFiles/${fileName}"/>
                        </div>
                        `;
                    }
                }
                k++;
            });
            if(!product.fileName){
                returnPage += `
                        <div class="item active imgWrapper">
                            <img class="threeD" src="/images/uploadFiles/피카츄.jpg"/>
                        </div>
                `;
            }


            returnPage += `
                        </div></div>
                        <div class="caption">
                        <h3>상품명 : ${product.prodName}</h3>
                        <p>상품설명 : </p>
                        <p>가격 : ${product.price}</p>
                        
                        <p>남은 수량 : ${product.stockQuantity}</p>
            `;

            if (product.proTranCode != null) {
                let resultA = product.proTranCode.trim() === 'a' ? '구매가능' : '';
                let resultB = product.proTranCode.trim() === 'b' ? '구매불가' : '';

                returnPage += `
                <p>현재상태 : 
                ${resultA}${resultB}${(resultB) ? `&nbsp;&nbsp;` : ``}
                </p>
                `;
            }//end of if
            if (product.proTranCode == 'a') {
                returnPage += `
                <button type="button" class="abled btn btn-primary" data-getProduct
                                    data-prodNo="${product.prodNo}">상품보기
                </button>
                `;
            } else {
                returnPage += `
                <button type="button" class="disabled btn btn-primary" data-getProduct
                                    data-prodNo="${product.prodNo}">상품보기
                </button>
                `;
            }

            returnPage += `
            <button type="button" class="btn btn-primary" data-setLike data-prodNo="${product.prodNo}">
            찜하기
            </button>
            </div></div></div>
            `;
    });//end of each1

    returnPage += `</div>`;

    console.log(returnPage);
    $(`div.container.main`).append(returnPage);


};//end of function

/*
* {"search" : {"currentPage":1,"searchCondition":null,"searchKeyword":null,"searchType":null,"searchBoundFirst":0,"searchBoundEnd":0,"pageSize":3,"endRowNum":3,"startRowNum":1},
* "navigation":"forward:/product/getProduct.jsp",
* "resultPage":{"currentPage":1,"totalCount":27,"pageUnit":5,"pageSize":3,"maxPage":9,"beginUnitPage":1,"endUnitPage":5},
* "totalCount":27,"menu":null,"products":[{"fileName":"출석큐알.jpg","manuDate":"20240514","price":2000000,"prodDetail":"소니 바이오 노트북 신동품","prodName":"vaio vgn FS70B","prodNo":10000,"regDate":1710255600000,"proTranCode":"b  "}
* ,{"fileName":"다운로드.jpg,출석큐알.jpg","manuDate":"20240514","price":10000,"prodDetail":"자전거 좋아요~","prodName":"자전거","prodNo":10001,"regDate":1710774000000,"proTranCode":"a"}
* ,{"fileName":null,"manuDate":"20240201","price":1170000,"prodDetail":"최고 디자인 신품","prodName":"보르도","prodNo":10002,"regDate":1710946800000,"proTranCode":"a"}]}
*
* JsonData.products[0].fileName
* */

//여기서 파싱할건데, 파싱해서 만들거다.
//currentPage에 하나씩 더해야돼 스크롤 한번하면 다음 페이지 나오도록 만들거야.


//서버에 계속 갔다와야해. 스크롤할때마다. 그러면 currentPage를 1씩 늘려서 요청해야돼
//프로덕츠는 프로덕트를 모은 배열
//프로덕트는 객체
//JsonData는 제이슨객체, products는 배열, product는 제이슨객체
//{"fileName":"다운로드.jpg,출석큐알.jpg",
// "manuDate":"20240514",
// "price":2000000,
//
// "prodDetail":"소니 바이오 노트북 신동품",
// "prodName":"vaio vgn FS70B",
// "prodNo":10000,
// "regDate":1710255600000,
// "proTranCode":"b  "}
//3개씩 보여줘야함.