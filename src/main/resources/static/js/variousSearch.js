
console.log("1번째줄")
//console.log(type); // 서버로부터 받은 'type' 값 로그 출력

// 동적으로 'id'를 구성하여 해당 요소 선택
if(type !== ''){
	// const searchTypeElement = document.getElementById("searchType"+type);
	const searchTypeElement = $("searchType"+type);
	if (searchTypeElement.length > 0) { // 요소가 존재하는지 확인
		console.log("실행되는지 확인해보자. 8번째 라인 variousSearch.js");
	    // searchTypeElement.style.backgroundColor = "#0056b3";
		searchTypeElement.css({
			backgroundColor : "#0056b3"
		})
	    // searchTypeElement.type = "hidden";
		searchTypeElement.prop("type","hidden");
	}
}

function fncGetList(currentPage) {
	console.log(`fncGetList실행`);

	const urlParams = new URLSearchParams(window.location.search);
	const imageParam = urlParams.get('image');

	$("#currentPage").val(currentPage)
	//언제나 인풋을 보내고 언제나 처리하는 전략 : 서버가 언제나 처리하도록 로직을 짬. 얘는 서버로부터 받았던걸 모두 다시 보냄.
	//인풋이 있으면 보내고 없으면 안보내는 전략 : 서버가 인풋이 있으면 처리하고, 인풋이 없을때는 원래 있던걸 쓰도록 로직을 짬.
	// if(인풋있음){
	// 	인풋 내보낸다
	// }else{//인풋이 없어
	// 	if(${}있음){
	// 		인풋 ${}내보낸다.
	// 	}else{//인풋도없고 ${}도없어
	// 		인풋 안내보낸다.
	// 	}
	// }
	console.log(`searchBoundFirst값` + searchBoundFirst);
	console.log(`searchBoundEnd값` + searchBoundEnd);
	console.log(typeof(searchBoundFirst));
	console.log(typeof(searchBoundEnd));


	console.log("type값은 뭘가요?");
	console.log("type :: ",type);
	if(type===''){
		console.log("type은 undefined");
		type=`1`;
	}
//
	//if(document.getElementById("searchBoundFirst").value !== '' && document.getElementById("searchBoundEnd").value !== ''){
	if($("#searchBoundFirst").val() !== '' && $("#searchBoundEnd").val() !== ''){
		console.log("if 1번째 실행");
	}else {
		console.log("else 1번째 실행");
		if (searchBoundFirst !== "0" || searchBoundEnd !== "0") {
			console.log("if 2번째 실행");
			// document.getElementById("searchBoundFirst").value = searchBoundFirst;
			// document.getElementById("searchBoundEnd").value = searchBoundEnd;
			$("#searchBoundFirst").val(searchBoundFirst);
		} else {
			console.log("else 2번째 실행");
			$("#searchBoundFisrt").val(0);
			$("#searchBoundEnd").val(0);
			// document.getElementById("searchBoundFirst").value=0;
			// document.getElementById("searchBoundEnd").value=0;
			//유령인풋을 보내서 그거로 서버가 판단하도록 하는 로직은 매우 별로임.
		}
	}
	//if(인풋있음){
	//인풋내보낸다.
	//else{//인풋없음
	//if(${}있음){
	//이 경우가 실행될 경우의 수는 0이다. 왜냐하면 라디오는 한번 누르면 끄는게 불가능하여 인풋(시작)이 없으면 ${}(다음)도 없다.
	//}
	//var radios = document.getElementsByName('searchType');
	//console.log("radios",radios);
	//var isSelected = Array.from(radios).some(radio => radio.checked);
	if ($("input[name='searchType']").is(":checked")) {
		console.log("if 3번째 실행");
	}else{
		console.log("else 3번째 실행");
		console.log("searchType에 type값 : ",type,"할당");
		document.getElementById("searchType"+type).checked = true;
		$("#searchType"+type).prop("checked",true);

	}

	//액션에게 잘 줬나? 액션은 받았나? 확인하기, 액션이 잘 줬나? 확인하기
	let url = "/product/listProduct?menu="+menu;
	if (imageParam) {
		url += "&image=" + imageParam;
	}
	console.log(url);
	$("form").attr("method" , "POST").attr("action" , url).submit();
}