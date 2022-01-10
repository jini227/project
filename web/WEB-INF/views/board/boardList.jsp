<%--
  Created by IntelliJ IDEA.
  User: weaverloft-NB-000
  Date: 2021-12-26
  Time: 오후 8:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script src="https://kit.fontawesome.com/2d323a629b.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="../../resources/css/style.css">
    <script src="../../resources/script/script.js" defer></script>
    <link rel="shortcut icon" href="#">
    <title>${contentsType}</title>
</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<div class="wrapboardPage">
    <div id="contentsTitle">
        <div>
            <h3 class="contentsTitle">${contentsType}</h3>
            <div class="titleLine"></div>
        </div>
        <div id="contentsMenu">
            <span>전체 <input type="checkbox" class="AllOkay" name="state" value="2" checked></span>
            <span>미발견 <input type="checkbox" class="okay" name="state" value="0" checked></span>
            <span>발견완료 <input type="checkbox" class="okay" name="state" value="1" checked></span> |
            <select name="search" id="search">
                <option value="title">제목</option>
                <option value="writer">작성자</option>
                <option value="name">이름</option>
            </select>
            <input type="text" name="searchkeyword" id="searchkeyword"
                   onkeypress="if (event.keyCode==13 ) {search('enter');}"/>
            <input type="hidden" name="contentsType" id="contentsType" value="${contentsType}"/>
            <span><i class="fas fa-search" id="fa-search" onclick="search('active')"></i></span>
        </div>
    </div>
    <span class="wrapBoardsearchlist">
        <%--검색 ajax 실행 후 결과 내용 출력 란--%>
    </span>

    <ul id="pagingul">
        <%-- 페이징 영역 --%>
    </ul>
</div>

<button class="jellybutton topbtn" type="button" onclick="goTop()">TOP</button>

<c:if test="${memberAuthInfo == null }">
    <div class="centerbtn">
        <div class="jellybutton centerHiddenContents" name="centerHidden" id="centerHidden"><p>INFO<br>! 로그인 후 글쓰기 가능
            합니다.<br>! 아이디 | 비밀번호 분실 시 로그인<br>페이지 하단의 찾기 버튼 클릭</p></div>
        <button class="jellybutton sidebtn1" name="write" id="write">WRITE</button>
    </div>
</c:if>
<c:if test="${memberAuthInfo != null }">
    <c:if test="${contentsType eq 'lost'}">
        <button class="jellybutton sidebtn1" name="write" id="write"
                onclick="location='<c:url value="/board/boardWrite/lost"/>'">WRITE
        </button>
    </c:if>
    <c:if test="${contentsType eq 'find'}">
        <button class="jellybutton sidebtn1" name="write" id="write"
                onclick="location='<c:url value="/board/boardWrite/find"/>'">WRITE
        </button>
    </c:if>
</c:if>
<script language="javascript">

    $(document).ready(function () {
        search();
    });

    // 첫 진입 시 결과란 보이지 x -> 기본값 false 세팅
    // 검색 후 페이지 이동 시에도 결과란 유지 되도록 함수 밖으로 뺌
    var resultOn = false;

    function search(active) {
        var searchKeyword = $("#searchkeyword").val(); // 검색어
        var searchOption = $("#search").val(); // 제목/작성자/이름
        var contentsType = $("#contentsType").val(); // lost/find
        var state = $("[name=state]:checked").val(); // 발견상태
        var currentPage = 1; // 현재 페이지
        var dataPerPage = 3 //한 페이지에 나타낼 글 수

        // 엔터 시 input 공란일 경우 alert -> return false
        if (active == 'enter') {
            if ($("#searchkeyword").val() == '') {
                alert('내용을 입력 해 주세요.');
                return false;
            }
        }

        if (active == 'active' || active == 'enter') {
            // 엔터나 검색 버튼 클릭을 통한 진입 시 resultOn true -> 검색 결과란 노출 되도록 함
            resultOn = true;
        } else if (active != 'active' && active != 'enter' && active != null) {
            // 첫 진입 시 페이지영역 클릭 -> 페이지 번호 세팅 및 검색 결과란 노출 되지 않도록 resultOn false 상태 유지 함
            currentPage = active;
        }

        // 체크박스 전체 미체크 시 체크 되도록 변경
        if ($("[name=state]:checked").val() == null) {
            state = 2;
            $("input:checkbox[name=state]").prop("checked", true);
        }

        $.ajax({
            type: "POST",
            url: "search",
            data: {
                "contents_type": contentsType,
                "searchKeyword": searchKeyword,
                "searchOption": searchOption,
                "state": state,
                "currentPage": currentPage,
                "dataPerPage": dataPerPage
            },
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            dataType: "json",
            success: function (posts) {
                var output = '<span class="search-result">';
                output += "<p>" + "검색결과 [" + '<span class="totalCount">' + posts.length + "</span>" + "] 개 입니다. ( ";
                if (searchOption == 'title') {
                    output += "검색조건 : 제목";
                }
                if (searchOption == 'name') {
                    output += "검색조건 : 이름";
                }
                if (searchOption == 'writer') {
                    output += "검색조건 : 작성자";
                }
                output += "  |  검색어 : " + searchKeyword + "  |  ";
                if (state == 0) {
                    output += "발견여부 : 발견완료";
                }
                if (state == 1) {
                    output += "발견여부 : 미발견";
                }
                if (state == 2) {
                    output += "발견여부 : 전체";
                }
                output += " )";
                output += "</p>" + "</span>";
                output += '<div class="wrapBoardlist">';
                output += "<ul>";
                if (posts.length != 0) {
                    for (var i in posts) {
                        var row = 3; // 한 줄에 나올 게시물 수
                        var startDiv;
                        var endDiv;
                        if (i == 0 || i % row == 0) {
                            startDiv = i
                            endDiv = (startDiv*1) + (row*1) -1;
                            output += "<div>"
                        }
                        output += "<li>" + "<a href='/board/boardDetail/" + posts[i].seq + "'>";
                        output += "<div class='post-photo-top'>";
                        output += "<div class='img_box'>";
                        output += "<img src='../../resources/imgUpload/" + posts[i].thumbnail_file_name + "' width='200' height='250'/>";
                        output += "</div>";
                        output += "</div>";
                        output += "<div class='post-contents-bottom'> ";
                        if (posts[i].pet_meet == 1) {
                            output += "<div>";
                            output += "<p class='finishText'>" + "발견완료" + "</p>";
                            output += "</div>";
                        } else {
                            output += "<div>";
                            output += "<p class='finishText' style='display: none;'>" + "미발견" + "</p>";
                            output += "</div>";
                        }
                        output += "<div>";
                        output += "<p>" + "제목 : " + posts[i].title + "</P>";
                        output += "</div>";
                        output += "<div>";
                        output += "<p>" + "이름 : " + posts[i].pet_name + "</P>";
                        output += "</div>";
                        output += "<div>";
                        output += "<p>" + "잃어버린 위치 : " + posts[i].pet_location + "</P>";
                        output += "</div>";
                        output += "<div>";
                        output += "<p>" + "실종 시각 : " + posts[i].pet_time + "</P>";
                        output += "</div>";
                        output += "<div>";
                        output += "<p>" + "종류 : " + posts[i].pet_type + "</P>";
                        output += "</div>";
                        output += "</a>" + "</li>";
                        if (i != 0 && i == endDiv) {
                            output += "</div>";
                        }
                    }
                } else {
                    output += "<li>" + "게시물이 없습니다." + "</li>";
                }
                output += "</ul>";
                output += "</div>";
                $(".wrapBoardsearchlist").html(output);
                // 검색버튼 클릭 시에만 결과 보이도록 세팅
                if (resultOn) {
                    var resultCount = document.querySelector('.search-result');
                    resultCount.classList.toggle('active');
                }
                paging(contentsType, searchKeyword, searchOption, state, currentPage, dataPerPage);

            },
            error: function () {
                var msg = "ajax 통신 실패";
                alert(msg);
            }
        });
    }

    function paging(contentsType, searchKeyword, searchOption, state, v_currentPage, v_dataPerPage) {

        $.ajax({
            type: "POST",
            url: "paging",
            data: {
                "contents_type": contentsType,
                "searchKeyword": searchKeyword,
                "searchOption": searchOption,
                "state": state
            },
            success: function (result) {
                // 검색결과 총 갯수 세팅
                $(".totalCount").text(result);

                var totalData = result; //총 데이터 수 : ajax
                var currentPage = v_currentPage; //현재 페이지
                var dataPerPage = v_dataPerPage; //한 페이지에 나타낼 글 수
                var pageCount = 10; //페이징에 나타낼 페이지 수

                var totalPage = Math.ceil(totalData / dataPerPage); //총 페이지 수

                if (totalPage < pageCount) { //총 페이지 수가 페이징에 나타낼 페이지 수 보다 작다면
                    pageCount = totalPage;
                }

                var pageGroup = Math.ceil(currentPage / pageCount); // 페이지 그룹
                var last = pageGroup * pageCount; //화면에 보여질 마지막 페이지 번호

                if (last > totalPage) {
                    last = totalPage;
                }

                var first = last - (pageCount - 1); //화면에 보여질 첫번째 페이지 번호
                var next = last + 1;
                var prev = first - 1;

                var pageHtml = "";

                if (prev > 0) {
                    pageHtml += "<li><a href='#' id='prev'> 이전 </a></li>";
                }

                //페이징 번호 표시
                for (var i = first; i <= last; i++) {
                    if (currentPage == i) {
                        pageHtml += "<li class='on'><a href='#' id='" + i + "'>" + i + "</a></li>";
                    } else {
                        pageHtml += "<li><a href='#' id='" + i + "'>" + i + "</a></li>";
                    }
                }

                if (last < totalPage) {
                    pageHtml += "<li><a href='#' id='next'> 다음 </a></li>";
                }
                $("#pagingul").html(pageHtml);

                //페이징 번호 클릭 이벤트
                $("#pagingul li a").click(function () {
                    var $id = $(this).attr("id");
                    var selectedPage = $(this).text();

                    if ($id == "next") selectedPage = next;
                    if ($id == "prev") selectedPage = prev;

                    //전역변수에 선택한 페이지 번호를 담는다.
                    currentPage = selectedPage;

                    // 페이지 클릭을 통한 리스트 재호출
                    search(currentPage);
                });
            },
            error: function () {
                var msg = "ajax 통신 실패";
                alert(msg);
            }
        });
    }

    ///////////////////////////////////////////////////////////

    $(function () {
        $("[type=checkbox][name=state]").on("change", function () {
            var check = $(this).prop("checked");
            //전체 체크
            if ($(this).hasClass("AllOkay")) {
                $("[type=checkbox][name=state]").prop("checked", check);

                //단일 체크
            } else { //3
                var all = $("[type=checkbox][name=state].AllOkay");
                var allcheck = all.prop("checked")
                if (check != allcheck) {
                    var len = $("[type=checkbox][name=state]").not(".AllOkay").length;
                    var ckLen = $("[type=checkbox][name=state]:checked").not(".AllOkay").length;
                    if (len === ckLen) {
                        all.prop("checked", true);
                    } else {
                        all.prop("checked", false);
                    }
                }
            }
        });
    });

</script>
</body>
</html>
