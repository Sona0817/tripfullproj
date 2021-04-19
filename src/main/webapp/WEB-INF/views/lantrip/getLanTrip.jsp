<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../import/top.jsp" %>

<style type="text/css">	
	
	.lan_product_top{
		margin-left: 360px;
		padding: 10px;
		margin-bottom: 20px;
		width: 1000px;
		border-bottom: 1px solid gray;
	}
	
	.lan_product_title {
		display: inline-block;
		width: 800px;
		font-size: 40px;
		font-weight: 600;
		text-align: left;
	}
	
	.lan_price {
		display: inline-block;
		position: relative;
		box-sizing: border-box;
		padding: 5px;
	}
	
	.lan_buy {
		display: inline-block;
		position: relative;
		box-sizing: border-box;
		color: black;
		text-decoration: none;
		text-align: center;
		font-weight: 600;
		border-radius: 8px;
		height: 2.5em;
		line-height: 2.5em;
		padding: 0 1.25em;
		-moz-transition: background-color .2s ease-in-out;
		-webkit-transition: background-color .2s ease-in-out;
		-ms-transition: background-color .2s ease-in-out;
		transition: background-color .2s ease-in-out;
	}
	
	.lan_buy:hover {
		color: #fff !important;
		background: #383838;
	}
	
	.lan_video {
		margin-left: 360px;
	}
	
	.lan_product_detail{
		margin-left: 360px;
		width: 1000px;
		border-bottom: 1px solid gray;
		padding: 10px;
	}
	
	.lan_product_img {
		margin-left: 360px;
		width: 900px;
		height: 1000px; /* 나중에 삭제 */
		background-color: #58CCFF;
	}
	
	
</style>

<main>

<!-- 랜선여행 제목 표현식에 있는 lantrip은 컨트롤러에서 model의 키값으로 정의한 것 사용 -->
	<div type="hidden" value="getLanTrip.do?lantrip_no=${ lantrip.lantrip_no }">
		<div class="lan_product_top">
			<span class="lan_product_title">${ lantrip.lantrip_title }</span>
			<span class="lan_price">${ lantrip.lantrip_price }원</span>
			<a href="#"><span class="lan_buy">구매하기</span></a>
		</div>

<!-- 랜선여행 상세 설명 -->
		<div class="lan_product_detail">${ lantrip.lantrip_content }</div>
		<div class="lan_video">
			<iframe width="854" height="480" src="${ lantrip.lantrip_video }" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
			</iframe>
		</div>
		<div class="lan_product_img">상품 상세 이미지 ${ lantrip.lantrip_img }
		</div>
	</div>
	
		<div class="admin_content_wrap">
			<div class="admin_content_subject"><span>랜선여행 관리</span></div>
				<div class="admin_content_lantrip">
					<form  class="lan_table" action="insertLanTrip.do" method="post"  enctype="multipart/form-data">
						<table class="lan_enroll" border="1" cellpadding="0" cellspacing="0">
							<tr >
								<td bgcolor="#58CCFF" width="80%">제목</td>
								<td align="left" width="80%"><input type="text" name="lantrip_title" /></td>
							</tr>
							<tr>
								<td bgcolor="#58CCFF" width="70">지역</td>
								<td align="left"><input type="text" name="lantrip_area" /></td>
							</tr>
							<tr>
								<td bgcolor="#58CCFF" width="70">가격</td>
								<td align="left"><input type="number" name="lantrip_price" />원</td>
							</tr>
							<tr>
						.		<td bgcolor="#58CCFF">내용</td>
								<td align="left"><textarea name="lantrip_content" cols="40" rows="10"></textarea></td>
							</tr>
							<tr>
								<td bgcolor="#58CCFF">썸네일</td>
								<td><input type="file" name="lanTripImgUpload"/></td>
							</tr>
							<tr>
								<td bgcolor="#58CCFF">설명파일</td>
								<td><input type="file" name="lanTripImgUpload"/></td>
							</tr>
							<tr>
								<td colspan="2" align="center">
								<input type="submit"value=" 새글 등록 " /></td>
							</tr>
						</table>
					</form>
				</div>
	
	
	
	<br>
</main>
<%@ include file="../import/bottom.jsp" %>