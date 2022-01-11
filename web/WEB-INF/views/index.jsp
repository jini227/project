  <%--
  Created by IntelliJ IDEA.
  User: weaverloft-NB-000
  Date: 2021-12-23
  Time: 오후 7:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script src="https://kit.fontawesome.com/2d323a629b.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="../resources/css/style.css">
    <script src="../resources/script/script.js" defer></script>
    <link rel="shortcut icon" href="#">
    <title>:: MAIN ::</title>
</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

<section class="section mainSection">

    <div class="slidebox">
        <input type="radio" name="slide" id="slide01" checked>
        <input type="radio" name="slide" id="slide02">
        <input type="radio" name="slide" id="slide03">
        <input type="radio" name="slide" id="slide04">
        <ul class="slidelist">
            <li class="slideitem">
                <div>
                    <label for="slide04" class="left"></label>
                    <label for="slide02" class="right"></label>
                    <a href="https://www.peopet.co.kr/" target='_blank'><img src="resources/img/banner/banner05.png"></a>
                </div>
            </li>
            <li class="slideitem">
                <div>
                    <label for="slide01" class="left"></label>
                    <label for="slide03" class="right"></label>
                    <a href="#"><img src="resources/img/banner/banner03.png"></a>
                </div>
            </li>
            <li class="slideitem">
                <div>
                    <label for="slide02" class="left"></label>
                    <label for="slide04" class="right"></label>
                    <a><img src="resources/img/banner/banner01.png" onclick="window.scrollTo(1300,1300);"></a>
                </div>
            </li>
            <li class="slideitem">
                <div>
                    <label for="slide03" class="left"></label>
                    <label for="slide01" class="right"></label>
                    <a><img src="resources/img/banner/banner07.png"></a>
                </div>
            </li>
        </ul>
    </div>

    <div class="mainContentsWrap">
        <div class="mainLost">
            <p>다시 가족의 품으로 돌아갈 수 있도록 수원 시민 여러분의 도움이 필요합니다.</p>
            <h3 class="contentsTitle">찾아주세요</h3>
            <div class="titleLine"></div>
            <div class="mainLostImg">
                <div class="mainBoard">
                    <ul>
                        <c:forEach var="l" items="${losts}" begin="0" end="4" step="1">
                            <li>
                                <button class="mainLostImgLi" name="more" id="more" onclick="location='<c:url value="/board/boardDetail/${l.seq}"/>'">
                                    <img src="./resources/imgUpload/${l.thumbnail_file_name}" alt="사진">
                                    <span class="mainLostImgLiContents">
										<p>
											<br>
											품종 | ${l.pet_type} <br> 실종장소 | ${l.pet_location}
											<br> 실종시각 | ${l.pet_time}<br><br> 특징 | ${l.pet_memo}
										</p>
									</span>
                                </button>
                            </li>
                        </c:forEach>
                    </ul>
                    <ul>
                        <c:forEach var="l" items="${losts}" begin="5" end="9" step="1">
                            <li>
                                <button class="mainLostImgLi" name="more" id="more" onclick="location='<c:url value="/board/boardDetail/${l.seq}"/>'">
                                    <img src="./resources/imgUpload/${l.thumbnail_file_name}" alt="사진">
                                    <span class="mainLostImgLiContents">
										<p>
											<br>
											품종 | ${l.pet_type} <br> 실종장소 | ${l.pet_location}
											<br> 실종시각 | ${l.pet_time}<br><br> 특징 | ${l.pet_memo}
										</p>
									</span>
                                </button>
                                </a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="mainMore">
                    <button class="btn btn-swap" name="more" id="more" onclick="location='<c:url value="/board/boardList/lost"/>'">
                        more <span>찾아주세요</span>
                    </button>
                </div>
            </div>
        </div>

        <div class="mainReview">
            <h3 class="contentsTitle">찾았어요! 후기</h3>
            <div class="titleLine"></div>
            <div class="mainReviewImg">
                <div class="mainBoard">
                    <ul>
                        <c:forEach var="r" items="${reviews}">
                            <li>
                                <button class="mainLostImgLi" name="more" id="more" onclick="location='<c:url value="/board/boardDetail/${r.seq}"/>'">
                                    <img src="./resources/imgUpload/${r.thumbnail_file_name}" alt="사진">
                                    <span class="mainLostImgLiContents">
										<p>
											<br>
											이름 | ${r.pet_name} <br> 실종장소 | ${r.pet_location}
											<br> 실종시각 | ${r.pet_time}<br><br> 후기 | ${r.review}
										</p>
									</span>
                                </button>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>

<button class="jellybutton" type="button" onclick="goTop()">TOP</button>

</body>
<script type="text/javascript">

    if('${msg}'){
        var message="${msg}";
        alert(message);
    };

</script>
</html>
