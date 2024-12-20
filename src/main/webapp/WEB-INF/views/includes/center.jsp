<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="resourcesPath" value="${ contextPath }/resources" />
<jsp:useBean id="stringParser" class="Common.StringParser"/>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bxslider@4.2.17/dist/jquery.bxslider.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bxslider@4.2.17/dist/jquery.bxslider.min.js"></script>	
	<link rel="stylesheet" href="${ resourcesPath }/css/includes/center.css">
	
	<script>        
		$(function() {
			$('.bx_slider').bxSlider({
				adaptiveHeight: true,
				auto : true,
				pager : false
			});
		});
	</script>
</head>

<body>
	<div id="container">
		<div class="event_banner">
			<img src="${resourcesPath}/images/mainpage/main_banner.png" alt="이벤트 배너">
		</div>
		
		<div class="rank">
			<ul class="bx_slider">
				<li>
					<div class="slider-cell">
						<div class="slide-cell-header">
							<img src="${resourcesPath}/images/mainpage/trophy.png" alt="별모양 이미지">
							<span>레시피 BEST</span>
						</div>
						
						<c:forEach var="recipe" items="${recipes}" varStatus="status">
						    <div class="block-cell">
						        <a href="${contextPath}/Recipe/read?no=${recipe.no}">
						            <div class="image-area">
						                <img src="${resourcesPath}/images/recipe/thumbnails/${recipe.no}/${recipe.thumbnail}">
						                <div class="rank-flag">
						                    <img class="rank-flag" src="${resourcesPath}/images/mainpage/rankflag.png">
						                </div>
						                <div class="rank-label">${status.index + 1}</div>
						            </div>
						            <div class="label-area">
						                <p>
						                	<c:set var="averageRating" value="${ recipe.averageRating }" />
						                    <c:forEach begin="1" end="5" var="star">
						                        <c:choose>
						                            <c:when test="${star <= averageRating}">
						                                <img class="review_star" src="${resourcesPath}/images/recipe/full_star.png" alt="별점">
						                            </c:when>
						                            <c:when test="${star > averageRating && star < averageRating + 1}">
						                                <img class="review_star" src="${resourcesPath}/images/recipe/half_star.png" alt="별점">
						                            </c:when>
						                            <c:otherwise>
						                                <img class="review_star" src="${resourcesPath}/images/recipe/empty_star.png" alt="별점">
						                            </c:otherwise>
						                        </c:choose>
						                    </c:forEach>
						                </p>
						                <p>
						                    <c:choose>
						                        <c:when test="${recipe.category == 1}">[한식]</c:when>
						                        <c:when test="${recipe.category == 2}">[일식]</c:when>
						                        <c:when test="${recipe.category == 3}">[중식]</c:when>
						                        <c:when test="${recipe.category == 4}">[양식]</c:when>
						                        <c:otherwise>[자취]</c:otherwise>
						                    </c:choose>
						                    &nbsp;${recipe.title}
						                </p>
						                <p>${recipe.memberVO.nickname}</p>
						            </div>
						        </a>
						    </div>
						</c:forEach>
					</div>
				</li>
				<li>
					<div class="slider-cell">
						<div class="slide-cell-header">
							<img src="${resourcesPath}/images/mainpage/trophy.png" alt="별모양 이미지">
							<span>스토어 BEST</span>
						</div>
						<c:forEach var="mealkit" items="${mealkits}" varStatus="status">
						    <c:set var="thumbnail" value="${ stringParser.splitString(mealkit.pictures)[0] }" />
						    
						    <div class="block-cell">
						        <a href="${contextPath}/Mealkit/info?no=${mealkit.no}">
						            <div class="image-area">
						                <img src="${resourcesPath}/images/mealkit/thumbnails/${mealkit.no}/${thumbnail}">
						                <div class="rank-flag">
						                    <img class="rank-flag" src="${resourcesPath}/images/mainpage/rankflag.png">
						                </div>
						                <div class="rank-label">${status.index + 1}</div>
						            </div>
						            <div class="label-area">
						                <p>
						                	<c:set var="averageRating" value="${ mealkit.averageRating }" />
						                    <c:forEach var="star" begin="1" end="5" step="1">
						                        <c:choose>
						                            <c:when test="${star <= averageRating}">
						                                <img class="review_star" src="${resourcesPath}/images/recipe/full_star.png" alt="별점">
						                            </c:when>
						                            <c:when test="${star > averageRating && star < averageRating + 1}">
						                                <img class="review_star" src="${resourcesPath}/images/recipe/half_star.png" alt="별점">
						                            </c:when>
						                            <c:otherwise>
						                                <img class="review_star" src="${resourcesPath}/images/recipe/empty_star.png" alt="별점">
						                            </c:otherwise>
						                        </c:choose>
						                    </c:forEach>
						                </p>
						                <p>
						                    <c:choose>
						                        <c:when test="${mealkit.category == 1}">[한식]</c:when>
						                        <c:when test="${mealkit.category == 2}">[일식]</c:when>
						                        <c:when test="${mealkit.category == 3}">[중식]</c:when>
						                        <c:when test="${mealkit.category == 4}">[양식]</c:when>
						                        <c:otherwise>[자취]</c:otherwise>
						                    </c:choose>
						                    &nbsp;${mealkit.title}
						                </p>
						                <p>
						                    <fmt:formatNumber value="${mealkit.price}" 
						                        type="currency" 
						                        currencySymbol="₩" 
						                        groupingUsed="true" 
						                        maxFractionDigits="0" />원
						                </p>
						            </div>
						        </a>
						    </div>
						</c:forEach>
					</div>
				</li>
			</ul>
		</div>
		
		<div class="board-area">
			<table width="100%">
				<tr>
					<td width="49%">
						<div class="board-notice-area">
							<div class="board-area-head">
								<label>공지사항</label>
								<span class="board-area-more">
									<a href='${ contextPath }/Notice/list'>+더보기</a>
								</span>
							</div>
							<table class="notice-table" width="100%">
								<c:forEach var="notice" items="${notices}">
								    <tr>
								        <td width="70%">
								            <p>
								                <a href="${contextPath}/Notice/read?no=${notice.no}">
								                    ${notice.title}
								                </a>
								            </p>
								        </td>
								        <td width="30%" align="right">
								            <fmt:formatDate value="${notice.postDate}" pattern="yyyy-MM-dd" />
								        </td>
								    </tr>
								</c:forEach>
							</table>
						</div>
					</td>
					
					<td width="2%"></td>					
					
					<td width="49%">
						<div class="board-community-area">
							<div class="board-area-head">
								<input type="button" value="자유게시판" onclick="changeCommunityBoard(0)">
								<input type="button" value="공유게시판" onclick="changeCommunityBoard(1)">
								<span class="board-area-more">
									<a href='javascript:onBoardMoreButton()'>+더보기</a>
								</span>
							</div>
							<div class="board-free-area">
								<table class="free-table" width="100%">
									<c:forEach var="community" items="${communities}">
									    <tr>
									        <td align="left" width="50%">
									            <a href="${contextPath}/Community/read?no=${community.no}">
									                <p>${community.title}</p>
									            </a>
									        </td>
									        <td align="center" width="20%"><p>${community.memberVO.nickname}</p></td>
									        <td align="center" width="15%">${community.views}&nbsp;views</td>
									        <td align="center" width="15%">
									            <fmt:formatDate value="${community.postDate}" pattern="yyyy-MM-dd" />
									        </td>
									    </tr>
									</c:forEach>
								</table>
							</div>
							
							<div class=board-share-area>
								<table class="share-table" width="100%">
									<c:forEach var="share" items="${shares}">
									    <tr>
									        <td align="left" width="50%">
									            <a href="${contextPath}/Share/read?no=${share.no}">
									                <p>${share.title}</p>
									            </a>
									        </td>
									        <td align="center" width="20%"><p>${share.memberVO.nickname}</p></td>
									        <td align="center" width="15%">${share.views}&nbsp;views</td>
									        <td align="center" width="15%">
									            <fmt:formatDate value="${share.postDate}" pattern="yyyy-MM-dd" />
									        </td>
									    </tr>
									</c:forEach>
								</table>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	
	<script>
		let categoryButtons = $(".board-area-head input");
		let boardType = 0;
		
		const categoryButtonStyles = [
	        { border: 'none', backgroundColor: '#BF917E', color: 'white' },
	        { border: '1px solid #BF917E', backgroundColor: 'white', color: '#BF917E' }
	    ];
		
		function changeCommunityBoard(type) {
			boardType = type;
			
			$('.board-free-area').css('display', type == 0 ? 'block' : 'none');
			$('.board-share-area').css('display', type == 0 ? 'none' : 'block');
	
			$.each(categoryButtons, function(index, button) {
		        var style = categoryButtonStyles[type === index ? 0 : 1];
		        $(button).css(style);
		    });
		}
		
		function onBoardMoreButton() {
			let listType = (boardType == 0) ? '/Community/list' : '/Share/list';
			
			location.href = '${ contextPath }' + listType;
		}
		
		window.onload = changeCommunityBoard(boardType);
	</script>
</body>


</html>