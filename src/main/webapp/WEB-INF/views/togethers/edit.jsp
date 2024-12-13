<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=utf-8");
%>

<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<c:set var="resourcesPath" value="${ contextPath }/resources" />

<c:set var="id" value="${ sessionScope.userId }"/>

<jsp:useBean id="stringParser" class="Common.StringParser" />

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="${ resourcesPath }/js/together/edit.js"></script>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ug8ym1cpbw&submodules=geocoder"></script>
	
	<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200..900&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="${ resourcesPath }/css/together/edit.css">
</head>

<body>
	<div class="together-container">
		<form enctype="multipart/form-data">
			<input type="hidden" id="no" value="${ together.no }">
			<input type="hidden" id="originPictures" value=" ${ together.pictures } ">
			
			<div class="together-button-area">
				<input type="button" value="${ together.no <= 0 ? '작성' : '수정' }" onclick="onSubmit(event)">
				<input type="button" value="취소" onclick="onCancle(event)">
			</div>
			<table width="100%">
				<tr>
					<td width="20%">제목 입력</td>
					<td width="80%">
						<input type="text" id="title" value="${ together.title }">
					</td>
				</tr>
				<tr>
					<td>사진 선택</td>
					<td>
						<input type="file" id="pictureFiles" name="pictureFiles" 
								accept=".jpg,.jpeg,.png" multiple onchange="handleFileSelect(this.files)">
						<div class="together-image-preview">
							<ul>
							</ul>
						</div>
					</td>
				</tr>
				<tr>
					<td>내용 입력</td>
					<td>
						<textarea id="contents">${ together.contents }</textarea>
					</td>
				</tr>
				<tr>
					<td>날짜 선택</td>
					<td>
						<input type="datetime-local" id="joinDate">
					</td>
				</tr>
				<tr>
					<td>모임 인원</td>
					<td>
						<input type="number" id="people"> &nbsp;명
					</td>
				</tr>
				<tr>
					<td>장소 선택</td>
					<td>
						<input type="hidden" id="lat" value="${ together.lat }">
                    	<input type="hidden" id="lng" value="${ together.lng }">
						<input type="text" id="naverAddress" placeholder="도로명 주소를 입력해주세요">
						<input type="button" id="naverSearch" value="검색">
                    	<div id="map"></div>
					</td>
				</tr>
			</table>
			<div class="together-button-area">
				<input type="button" value="${ together.no <= 0 ? '작성' : '수정' }" onclick="onSubmit(event)">
				<input type="button" value="취소" onclick="onCancle(event)">
			</div>
		</form>
	</div>
	
	
    <script type="text/javascript" src="${ resourcesPath }/js/common/naverMapAPI.js"></script>
	<script>
		function initialize() {
			let no = $("#no").val();
			
			if (no <= 0) {
				return;
			}
			
			// 글 수정 부분
			
			let lat = $("#lat").val();
			let lng = $("#lng").val();
		}
		
		function onSubmit(e) {
			e.preventDefault();
			
			let alertMsg = ($("#no").val() <= 0) ? '생성' : '수정';
			
			const formData = new FormData();
			
			formData.append('cmd', ($("#no").val() <= 0) ? 'insert' : 'update');
			formData.append('no', $("#no").val());
			formData.append('id', '${ id }');
			formData.append('title', $("#title").val());
			formData.append('contents', $("#contents").val());
			formData.append('pictures', combineStrings(selectedFileNames));
			formData.append('lat', $("#lat").val());
			formData.append('lng', $("#lng").val());
			formData.append('joinDate', new Date($("#joinDate").val()).getTime());
			formData.append('people', $("#people").val());
			formData.append('originPictures', $("#originPictures").val());
			
			selectedRealFiles.forEach((file, index) => {
				formData.append('file' + index, file);
			});
			
			$.ajax({
				url: '${ contextPath }/Together/edit',
				type: 'post',
				data: formData,
				dataType: 'text',
				processData: false,
			    contentType: false,
			    success: function(responseData) {
					if (Number(responseData) <= 0) {
						alert('모임 ' + alertMsg + '에 실패했습니다.');
					}
					else {
						alert('모임을 ' + alertMsg + '했습니다.');
						location.href = '${ contextPath }/Together/read?no=' + responseData;	
					}
			    },
			    error: function(error) {
			        console.log("error", error);
					alert('모임 정보 작성 중 통신 에러 발생');
			    }
			});
		}
		
		function onCancle(e) {
			e.preventDefault();
		}
		
		window.onload = initialize();
	</script>	
</body>

</html>