<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../import/admintop.jsp" %>

<style type="text/css">

	.top_story_list{
		color: white;
		background-color: #58CCFF;
	.admin_subtitle {
		background-color: lightgray;
		padding: 10px 10px 10px 20px;
	}
	.story_top{
	
	.admin_subtitle_name_story {
		font-size: 30px;
		display: inline-block;
		width: 1000px;
	 	border: 1px solid gray;
	 	text-align: center;
	 	padding: 7px;
		font-weight: 600;
		padding: 10px 10px 10px 0px;
	}
	
	.list_table {
		width: 1160px;
		margin: 20px;
		border-collapse: collapse;
		border-bottom: 3px solid gray;
	}
	
	.list_table th{
		border-bottom: 3px solid gray;
		padding: 5px;
	}

	.story_subject_title{
		text-align: left;
		padding: 5px;
		padding-left: 20px;
	}

	.story_subject{
		width: 60%;
	}
	.story_writer{
		width: 15%;
	}
	.story_date{
		width: 15%;
	}
	.story_views{
		width: 10%;
	}
	.new_story_post{
	
	td{
		padding: 5px;
		text-align: center;
	}
/*	.story_top a:hover {
		color: #fff !important;
		background: #58CCFF;
	}
*/

</style>


<!-- 페이징 JSP 추가작업 1 -->
<!-- 페이징 옵션 처리 자바스크립트 시작 -->
<script>
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="getStoryList.do?nowPage=${paging.nowPage}&cntPerPage="+sel;
	}
</script>
<!-- 페이징 옵션 처리 자바스크립트 끝 -->


<main>

	<br><h1>여행 이야기 관리하기</h1>
	<div class="admin_subtitle">
		<span class="admin_subtitle_name_story">여행이야기 관리</span>
	</div>

	<!-- 페이징 JSP 추가작업 2 -->
	<!-- 페이징 옵션 시작 -->
	<select id="cntPerPage" name="sel" onchange="selChange()" class="AdminStorycntPerPage">
		<option value="5"
			<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5개 보기</option>
		<option value="10"
			<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10개 보기</option>
		<option value="15"
			<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15개 보기</option>
		<option value="20"
			<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20개 보기</option>
	</select>
	<!-- 페이징 옵션 끝 -->
	
	<br><br>
	
	<table class = "story_top">

		<tr class="top_story_list">
	<table class = "list_table">
		<tr>
			<th class="story_subject">제목</th>
			<th class="story_writer">작성자</th>
			<th class="story_date">등록일</th>
			<th class="story_views">조회수</th>
		</tr>

		<c:forEach items="${ storyList }" var="story">
			<tr>
				<td class="story_subject_title"><a href="adminStoryDetail.do?story_no=${ story.story_no }"> ${ story.story_title }</a></td>
				<td>${ story.story_writer }</td>
				<td><fmt:formatDate value="${ story.story_date }" pattern="yy-MM-dd"/>
				</td>
				<td>${ story.story_cnt }</td>
				<td><fmt:formatDate value="${ story.story_date }" pattern="yy-MM-dd"/></td>
				<td>${ story.story_cnt }회</td>
			</tr>
		</c:forEach>

	</table>

	<br><br>
	
<!-- 페이징 JSP 추가작업 3 -->
	<!-- 페이징 JSP 추가작업 3 -->
	<!-- 페이징 하단 숫자 시작 -->
	<div style="display: block; text-align: center;">		
		<c:if test="${paging.startPage != 1 }">
			<a href="<c:url value='/adminStory/adminStory.do?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}'/>">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">							
					<a href="<c:url value='/adminStory/adminStory.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}'/>">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">					
			<a href="<c:url value='/adminStory/adminStory.do?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}'/>">&gt;</a>
		</c:if>
	</div>
	<!-- 페이징 하단 숫자 끝 -->
	
</main>

<%@ include file="../import/bottom.jsp" %>