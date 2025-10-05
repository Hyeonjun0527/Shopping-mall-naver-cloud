function histories() {
	popWin = window
		.open(
			"/cookie/createHistory",
			"popWin",
			"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
}
//==> jQuery 적용 추가된 부분
	$(function() {
		console.log("안녕 툴바js는 실행됐어.")

		$("a:contains('로그아웃')").on("click" , function() {
			$(self.location).attr("href","/user/logout");
			//self.location = "/user/logout"
		});

		$("a:contains('회원정보조회')").on("click" , function() {
			//$(self.location).attr("href","/user/logout");
			self.location = "/user/listUser"
		});

		$( "a:contains('개인정보조회')" ).on("click" , function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId="+userId);
		});
		//판매상품등록
		$( "a:contains('판매상품등록')" ).on("click" , function() {
			//Debug..
			console.log("얍얍얍");
			$(self.location).attr("href","../product/addProductView.jsp");
		});
		//판매상품관리
		$( "a:contains('판매상품관리')" ).on("click" , function() {
			//Debug..
			self.location = "/product/listProduct?menu=manage&image=ok";
		});
		//상품검색
		$( "a:contains('상 품 검 색')" ).on("click" , function() {
			//Debug..
			self.location = "/product/listProduct?menu=search&image=ok";
		});
		$( "a:contains('상 품 검 색(회원 뷰 확인하기 위함)')" ).on("click" , function() {
			//Debug..
			self.location = "/product/listProduct?menu=search&image=ok";
		});


		//판매이력조회
		$( "a:contains('판매이력조회')" ).on("click" , function() {
			//Debug..
			self.location = "/purchase/listPurchase?menu=manage";
		});
		//구매이력조회
		$( "a:contains('구매이력조회')" ).on("click" , function() {
			//Debug..
			self.location = "/purchase/listPurchase?menu=search";
		});
		//찜리스트
		$( "a:contains('찜 리스트')" ).on("click" , function() {
			//Debug..
			self.location = "/cookie/createLike?menu=search&from=toolbar.jsp";
		});
		//최근본상품
		$( "a:contains('최근 본 상품')" ).on("click" , function() {
			//Debug..
			histories();
		});
		// $( ".item:contains('개인정보조회')" ).on("click" , function() {
		// 	//Debug..
		// 	//alert(  $( ".Depth03:contains('개인정보조회')" ).html() );
		// 	const value = "/user/getUser?userId="+userId;
		// 	$(window.parent.frames["rightFrame"].document.location).attr("href",value);
		// });
		//
		// //==> 회원정보조회 Event 연결처리부분
		// //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		// $( ".item:contains('회원정보조회')" ).on("click" , function() {
		// 	//Debug..
		// 	//alert(  $( ".Depth03:contains('회원정보조회')" ) );
		// 	$(window.parent.frames["rightFrame"].document.location).attr("href","/user/listUser");
		// });
	});