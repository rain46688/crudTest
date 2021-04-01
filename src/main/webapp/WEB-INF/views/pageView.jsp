<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/23.1.0/decoupled-document/ckeditor.js"></script>

<style>

	body{
		display:flex;
		justify-content:center;
		align-items:center;
	}

	#content{
		/* border:1px solid black; */
		width:50%;
		height:50%;
		text-align:center;
	}
	
	#title{
		width:100%;
	}
	
		#content #edit {
		width: 100%;
		height: 80%;
		overflow-x: hidden;
		-ms-overflow-style: none;
		border:1px solid black;
	}
	
	#top{
	 display: flex;
	 flex-direction:row;
	 border:1px solid black;
	 border-width:1px 1px 0px 1px
	}
	
	#top div{
		padding:2px;
		margin:2px;
		border-right:1px solid black;
	}
	
</style>
<section id="content">
<div id="top">
<div>글 번호 : ${boardPage.id}</div> <div>작성자 : ${boardPage.writer_id}</div> <div>작성일 : ${boardPage.regdate}</div> <div>조회수 : ${boardPage.hit}</div>
</div>
<input id="title" name="title" type="text" value="${boardPage.title}"><br>
<div id="toolbar-container"></div>
<div id="edit">${boardPage.content}</div>
			<button type="button" class="btn btn-primary" onclick="update_Page()">수정하기</button>
			<button type="button" class="btn btn-primary" onclick="delete_Page()">삭제하기</button>
			<button type="button" class="btn btn-primary" onclick="location.href = '${path}/'">취소하기</button>
</section>
<script>
"use strict";
function update_Page(){
	console.log("수정");
	const title = document.getElementById('title').value;
	const content = document.getElementById('edit').innerHTML;
	  $.ajax({
	 	   type:"POST",
	 	   url:"${path}/update",
		   data:{
	 		   "title" : title,
	 		  "content" : content,
	 		 "id" : "${boardPage.id}"
		   },
	 	   success:function (data){
	 		   console.log("data : "+data);
	 		   if(data == "1"){
	 			   alert("수정완료");
	 			   //수정완료시 게시판으로 보내기
	 			  location.replace('${path}/');
	 		   }else{
	 			  alert("수정실패");
	 		   }		 	
	 	   }
	});
}

function delete_Page(){
	console.log("삭제");
	  $.ajax({
	 	   type:"POST",
	 	   url:"${path}/delete",
		   data:{
	 		   "id" : "${boardPage.id}"
		   },
	 	   success:function (data){
	 		   console.log("data : "+data);
	 		   if(data == "1"){
	 			   alert("삭제완료");
	 			   //삭제완료시 게시판으로 보내기
	 			  location.replace('${path}/');
	 		   }else{
	 			  alert("삭제실패");
	 		   }		 	
	 	   }
	});
}

//editor 사용하기
DecoupledEditor
.create( document.querySelector( '#edit' ) )
.then( editor => {
    const toolbarContainer = document.querySelector( '#toolbar-container' );

    toolbarContainer.appendChild( editor.ui.view.toolbar.element );
} )
.catch( error => {
    console.error( error );
} );

</script>
