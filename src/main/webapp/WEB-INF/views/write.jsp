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
	
	#content #title{
		width:100%;
		height:15%;
	}

	#content #edit {
		width: 100%;
		height: 80%;
		overflow-x: hidden;
		-ms-overflow-style: none;
		border:1px solid black;
	}
	
	#content .btn{
		margin: 2% 0 0 0;
		width:15%;
		height:15%;
		font-weight:bold;
		font-size:100%;
	}

</style>

<section id="content">
	<input id="title" name="title" type="text">
		<div id="toolbar-container"></div>
			<div id="edit"></div>
			<button type="button" class="btn btn-primary" onclick="write_end()">작성하기</button>
			<button type="button" class="btn btn-primary" onclick="location.href = '${path}/'">취소하기</button>
</section>


<script>
"use strict";
	function write_end(){
		console.log("글 작성 완료");
		const title = document.getElementById('title').value;
		const content = document.getElementById('edit').innerHTML;
		console.log("제목 : "+title);
		console.log("내용 : "+content);
		 		
		  $.ajax({
		 	   type:"POST",
		 	   url:"${path}/writeEnd",
			   data:{
		 		   "title" : title,
		 		  "content" : content
			   },
		 	   success:function (data){
		 		   console.log("data : "+data);
		 		   if(data == "1"){
		 			   alert("작성완료");
		 			   //작성완료시 게시판으로 보내기
		 			  location.replace('${path}/');
		 		   }else{
		 			  alert("작성실패");
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

