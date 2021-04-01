<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
.divListBody {
	padding: 30px;
	margin-top:5%;
}

.board_list_head, .board_list_body .item {
	padding: 10px 0;
	font-size: 0;
}

.board_list_head {
	border-bottom: 2px solid black;
	background-color: white;
	color: white;
	border-radius: 10px;
}

.board_list_body .item {
	border-bottom: 2px solid gray;
	background-color: white;
	border-radius: 10px;
	font-weight:bold;
}

.board_list_head>div, .board_list_body .item>div {
	display: inline-block;
	text-align: center;
	font-size: 14px; 
}

.board_list_head>div {
	font-weight: 600;
}

.board_list .col {
	width: 15%; 
	padding-top: 1%; 
	padding-bottom: 1%;
	font-size: 20px; 
	color:black;
}

.item:hover {
	opacity: 2.5;
	background-color:gray;
}

.item:focus{
	color: white;
}

#bbtn{
	float:right;
	margin-right:4%;
	border-color: black;
    color: black; 
    background-color: white;
	margin-top:0%;
	width:7%;
	font-weight:bold;
}

#bbtn:hover,
#bbtn:focus {
    background-color: black;
    border-color: blue;
    color: white; 
}

.empty{
	text-align:center;
	font-weight:bold;
	font-size:20px;
	margin:30px 0  10px 0;
}
</style>	
<section id="content" >        
<button type="button" value="글쓰기" id="bbtn" class="btn btn-outline-info" onclick="location.href = '${path}/write'">글쓰기</button>

<!-- 현재 페이지 -->
	<input id="cPageInput" type="hidden" value="1">
<!-- 리스트를 쏴줄 Div -->
	<div class="divListBody"></div> 
<!-- 페이징 처리 Div -->
	<div id="pagingDiv"></div>
	
</section>
<script>

"use strict";

// 게시물의 전체 갯수
let totalData = 0;
// 한 페이지에 보여줄 게시물의 갯수
let numPerPage = 5;

	//게시글 상세 보기
	function board_click(e){	
			if(!e.target.innerHTML.includes("col")){
				const num = e.target.parentNode.firstChild.innerHTML;
				console.log(num);
				location.href="${path}/pageView?id="+num;
				
			}
		}

 
	function rePage(){
		// 리스트를 현재 페이지 기준으로 프린트
		listPrint($("#cPageInput").val());
		// 페이지바 프린트
		pageBar();
	}

	// 시작시 온로드로 페이지바랑 리스트를 프린트 해옴
	$(function(){
		rePage();
	});
	
	// 번호를 클릭
	function cpaging(e){
		//눌린 번호를 input 태그에 넣어줘서 현재 페이지 저장
		$("#cPageInput").val($(e.target).html());
		rePage();
	}
	
	//페이지 바 클릭
	function barClick(n, pageNo){
		if(n){
			//오른쪽으로 넘어갈경우
			$("#cPageInput").val(pageNo + 5);
		}else{
			//왼쪽으로 넘어갈경우
			$("#cPageInput").val(pageNo - 1);
		}
		rePage();
	}
		
	//리스트 프린트
	function listPrint(cpage){
		console.log("cpage : "+cpage+", numPerPage : "+numPerPage);
		//db에서 가져온 리스트를 저장
		let list = new Array();
		list = "${boardList}";
		//html이랑 total 갯수 변수 선언
		let pbhtml = "";
		let total = 0;

		//리스트가 비어있는 경우
		if(list.length == 2){
			console.log("비었음");
			pbhtml += printBoard(true);
		}

		//리스트가 비어있지 않은 경우
		if(list.length != 2){
			console.log("안비었음");
			//출력할 게시물들의 시작과 끝값을 정함, 1페이지면 1~5 이런식
			let start =  ((cpage-1)*numPerPage);
			let end = numPerPage*cpage;
			console.log("start : "+start+", end : "+end);
			//리스트를 순회하면서 맞는 부분만 html에 넣고 뿌려줌
			<c:forEach items="${boardList}" var="item" varStatus="s">
				if("${s.index}" >= start && "${s.index}" < end){
					console.log("${s.index}: "+"${item.title}");
					//start값을 넣어주는 이유는 딱 한번 맨 위 메뉴를 생성하기 위해서임
					pbhtml += printBoard(false,"${s.index}","${item.id}","${item.title}","${item.writer_id}","${item.content}","${item.regdate}","${item.hit}",start);
				}
				//게시글 토탈값을 알아와서 넘버로 변환 후 변수에 집어넣기
				//이걸로 페이징 처리에 쓰임
				<c:if test="${s.last}">total = "${s.index}"</c:if>
			</c:forEach>
			totalData = Number(total) + 1;
			console.log("total 길이 : "+totalData);
		}
		$(".divListBody").html(pbhtml);

};

//리스트 출력하기
function printBoard(isEmptyArr, indexArr, n_id, n_title, n_writer_id, n_content, n_regdate, n_hit, start){
	let pb = "";

	//처음 메뉴 한번 출력하기
	if(indexArr == start){
		console.log("메뉴 출력");
		pb += "<div class='board_list'><div class='board_list_head'><div class='col'>번호</div><div class='col'>제목</div><div class='col'>닉네임</div><div class='col'>날짜</div><div class='col'>조회수</div></div>";
	}

	if(!isEmptyArr){
		//console.log("리스트 안 비어있으면 출력");
		pb += " <div class='board_list_body' style='cursor:pointer'><div class='item' onclick='board_click(event)'><div class='col'>"+n_id+"</div><div class='col'>"+n_title+"</div><div class='col'>"+n_writer_id+"</div><div class='col'>"+n_regdate+"</div><div class='col'>"+n_hit+"</div> </div>";
	}else{
		//console.log("리스트 비어있으면 출력");
		pb += "<div class='empty'>게시물이 없습니다.</div>"
	}
	return pb;
}

	
//페이지바 프린트
function pageBar(){
	//현재 페이지
	let cPage = $("#cPageInput").val();
	//페이지바에 증가하면서 넘버 출력 번호, cpage에 따라 달라짐
	let pageNo = (cPage - ((cPage - 1)%5));
	//db에서가져온 게시물 총 갯수로, 페이지 끝 번호를 알아냄
	let pageEnd = Math.ceil(totalData/numPerPage);
	console.log("토탈 : "+totalData+" cPage : "+cPage+" pageNo : "+pageNo+" pageEnd : "+pageEnd+" numPerPage : "+numPerPage);
	
	let ph = "<br><nav aria-lable='Page navigation' id='pagebar'><ul class='pagination justify-content-center'>";
	if(pageNo > 1){
		ph+="<li class='page-item'><a class='page-link' tabindex='-1' onclick='barClick(false,"+pageNo+");' aria-disabled='true' style='cursor:pointer'>이전</a></li>";
	}else if(pageNo <= 1){
		ph += "<li class='page-item disabled'><a class='page-link' tabindex='-1' aria-disabled='true'>이전</a></li>";
	}
	
	for(let i = 0; i <= (numPerPage - 1); i++){
		if(pageNo + i == cPage){
			ph += "<li class='page-item disabled'><a class='page-link' style='cursor:pointer;'>"+(pageNo + i) +"</a></li>";
		}else if((pageNo + i) <= pageEnd){	
			ph += "<li class='page-item'><a class='page-link' style='cursor:pointer;' onclick='cpaging(event);'>"+(pageNo + i) +"</a></li>";
		}
	}
	
	if(pageNo < (pageEnd - 4)){
		ph += "<li class='page-item'><a class='page-link' onclick='barClick(true,"+pageNo+");' tabindex='-1' aria-disabled='true' style='cursor:pointer'>다음</a></li>";
	}else if(pageNo >= (pageEnd - 4)){
		ph += "<li class='page-item disabled'><a class='page-link' tabindex='-1' aria-disabled='true'>다음</a></li>";
	}
	ph += "</ul></nav>";
	$("#pagingDiv").html(ph);
}


</script>

















