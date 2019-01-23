<!-- 
date : 2019-01-11
내용 : 게시글 상세보기 뷰단 초기 구현
date : 2019-01-18
내용 : 제안서 모달 뷰단 초기 구현
작성자 : 고은아
 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<link href="css/boardDetail.css" rel="stylesheet">
<!-- 신고 모달 -->

<div class="modal" id="reportModal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">신고하기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<input type="hidden" id="targetCode" value="${boardDetail.bno}">
			<div class="modal-body">
				<div class="form-group">
					<label for="reasonCode">신고사유</label> <select class="form-control"
						id="reasonCode">
						<option>신고사유 선택</option>
						<option value = "RC01">무분별한 비속어 사용</option>
						<option value = "RC02">광고성 게시물</option>
						<option value = "RC03">음란성 게시물</option>
						<option value = "RC04">명예훼손 게시물</option>
						<option value = "RC00">기타 사유</option>
					</select>
				</div>
				<div class="form-group">
					<textarea class="form-control" rows="3" placeholder="자세한 내용을 적어주세요" id="rContent"></textarea>
				</div>
			</div>

			<div class="alert alert-info">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
				<strong>허위 신고 시</strong> 회원 활동에 있어 불이익이 발생할 수 있습니다.
			</div>
			<div class="modal-footer">
				<button type="button" id="report" class="btn btn-danger">전송</button>
			</div>
		</div>
	</div>
</div>

<!-- 신고 모달 끝  -->

<!-- 제안모달 -->
<div class="modal fade" id="suggestModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">제안하기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<form id="suggest" name="suggest">
					<input type="hidden" name="bno" value="${boardDetail.bno}">
					<div class="form-group">
						<label for="link">판매링크</label>
						<textarea id="link" name="link" class="form-control" rows="3"
							placeholder="게시글 하단에 안내할 링크를 써주세요" required="required"></textarea>
					</div>
					<div class="form-group">
						<label for="tel">담당자 연락처</label> <input type="tel" id="tel"
							name="tel" class="form-control" required="required"
							placeholder="하이픈을 제외한 숫자로만 입력해주세요">
					</div>
					<div class="form-group">
						<label for="etc">기타사항</label>
						<textarea id="etc" name="etc" class="form-control" rows="3"
							placeholder="자세한 내용을 적어주세요"></textarea>
					</div>
				</form>
			</div>
			<div class="alert alert-info">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
				제안 승인 후 회원들에게 알림이 발송됩니다. <strong>판매링크를 정확히 기재해주세요.</strong>
			</div>
			<div class="modal-footer">
				<button type="button" id="suggestSubmitBtn" class="btn btn-primary"
					disabled="disabled">전송</button>
			</div>
		</div>
	</div>
</div>

<!-- 신고 모달 끝  -->

<div class="container">



	<h1 class="mt-4 mb-3">
		${boardDetail.title} <small>by <a href="#"> 카테고리</a>
		</small>
	</h1>
	<div class="row">
		<div class="col-lg-8">
			<img class="img-fluid rounded"
				src="http://localhost:8888/img/boardThumbNail/${boardDetail.thumbNail }"
				alt="http://placehold.it/50x50" width="200px" height="300px">
			<hr>
			
			<p><fmt:formatDate value="${boardDetail.writeDate}" pattern="yyyy.MM.dd"/></p>
			<%-- <p>${boardDetail.writeDate}</p> --%>
			<hr>
			<div class="bContentimg">
				<!-- 콘텐츠 내용 시작 -->
				${boardDetail.bContent}
				<!-- html 내용으로 뿌리는 에디터기를 찾아야 하나..? -->
			</div>
			
			<p>조회수 :  ${boardDetail.readCount}</p>
			<p id="isTo">작성자 :  ${boardDetail.mid}</p>  
	
			<hr>

			<div class="rightOutDiv">
				<button class="btn btn-outline-danger btn-sm" data-toggle="modal"
					data-target="#reportModal" targetTypeCode="BOARD">신고</button>
			</div>
			<div class="card my-4">
				<div class="card-body rightOutDiv">
					<!-- 만약 내가 쓴 글이 아니면 -->
					이 글이 공감되시나요?
					
					<c:if test="${like == 0}">
					<i id="like" class="far fa-heart"></i>
					</c:if>
					
					<c:if test="${like == 1}">
					<i id="like" class="fas fa-heart"></i>
					</c:if>
					<p id="likeCount">${likeCount}</p>
					
					<!-- 토글했을 때 class가 fa-heart로 변경되어야 함 -->
					<br> <input type="hidden" id="bno" value="${boardDetail.bno}">


					<!-- 만약 내가 쓴 글이면 -->
					<div class="btn-group btn-group-sm">
						<button type="button" class="btn btn-outline-warning">수정</button>
						<button type="button" class="btn btn-outline-danger"
							onclick="location.href='deleteBoard.do?bno=${boardDetail.bno}'">삭제</button>
						<sec:authorize ifAnyGranted="ROLE_COMPANY">
							<button type="button" class="btn btn-outline-primary"
								data-toggle="modal" data-target="#suggestModal">제안</button>
						</sec:authorize>

					</div>
				</div>
			</div>



			<!-- 댓글 작성 폼 -->
			<div class="card my-4">
				<h5 class="card-header">댓글을 남겨보세요</h5>
				<div class="card-body">
					<!-- <form> -->
					<div class="form-group">
						<textarea class="form-control" id="cContent" name="cContent"
							rows="3"></textarea>
					</div>
					<div class="rightOutDiv">
						<button type="button" onclick="insertComment()"
							class="btn btn-primary">등록</button>
					</div>
					<!-- </form> -->
				</div>
			</div>

			<!-- 기존에 달렸던 댓글들 뿌려주기 -->
			<div class="commentList">
				<c:forEach items="${commentList}" var="commentList">
					<div class="comment" seq="${commentList.cno}">
						<div class="media mb-4">
							<img class="d-flex mr-3 rounded-circle"
								src="http://placehold.it/50x50" alt="">
							<div class="media-body">
								${commentList.id}&nbsp;
								<button class="btn btn-outline-danger btn-sm"
									data-toggle="modal" data-target="#reportModal">신고</button>

								<!-- 세션 처리 해서 만약 본인이 쓴 댓글이면 -->
								<div class="btn-group btn-group-sm">
									<button type="button" onclick="updateBtn(${commentList.cno})"
										class="btn btn-outline-warning">수정</button>
									<button type="button" onclick="deleteComment(this)"
										class="btn btn-outline-danger">삭제</button>
								</div>
								<br>
								<div id="updateText${commentList.cno}" style="display: none;">
									<textarea class="form-control" rows="2">${commentList.cContent}</textarea>
									<button input="button"
										onclick="updateComment(${commentList.cno})"
										class="btn btn-outline-warning">수정</button>
								</div>
								<span id="originText${commentList.cno}">${commentList.cContent}</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>

		<!-- 좋아요 시작 -->
		<div class="d-none d-md-block floating">
			<div class="card my-4">
				<h5 class="card-header">좋아요를 눌러보세요</h5>
				<div class="card-body">
					향후 불편함이 개선되는 상품이 나오면<br> 좋아요<i class="fas fa-heart"></i> 내역을
					토대로 알림을 보내드립니다.
				</div>
			</div>
		</div>
	</div>
	
	<!-- 위로 가기 버튼 -->
	<div id="upBtn">
	<a href="#">위로</a>
	</div>


</div>

<!-- //신고하기 -->
<script>



$('#report').click(function() {
	console.log("targetTypeCode"+$('this').data("targetTypeCode"));
	console.log($('#reasonCode').val());
	console.log($('#rContent').val());
  
/*     $.ajax({
        type: "POST",
        url: "insertReport.do",
        data: { 
            "isTo" : ${boardDetail.mid},
            /* "targetTypeCode" : $('targetTypeCode').val(), 
            "targetCode" :$('#tagetCode').val(),
            "reasonCode" :$('#reasonCode').val(),
            "rContent" :$('#rContent').val()
        },
        success: function() {
            alert('신고 처리가 완료되었습니다.');
            location.reload();
        }, error: function() {
            alert('신고처리가 실패되었습니다.');
        }
    }); */
});





</script>

<script>
$(document).ready(function(){
	$('#bContentimg').find('img').width('500px').height('375px');
	
	$('#like').click(function(){
		var bno = $('#bno').val();
		
		if($('#like').attr('class') == 'far fa-heart'){
			$.ajax({
				url : 'insertLikes.do',
	  			  type : 'POST',
	  			  data : {'bno' : bno},
	  			  success : function() {
					$('#like').attr('class','fas fa-heart');
					$('#likeCount').text(Number($('#likeCount').text())+1);
	  	          },
	  	          error : function(){
	  	        	  alert("error");
	  	          }
			});
		}else{
			$.ajax({
				url : 'deleteLikes.do',
	  			  type : 'POST',
	  			  data : {'bno' : bno},
	  			  success : function() {
	  				$('#like').attr('class','far fa-heart');
	  				$('#likeCount').text(Number($('#likeCount').text())-1);
	  	          },
	  	          error : function(){
	  	        	  alert("error");
	  	          }
			});
			
		}
	});
});

function insertComment(){
	$.ajax({
		  url : 'boardCommentInsert.do',
		  type : 'POST',
		  data : {cContent : $('#cContent').val()},
		  success : function() {
			/* alert('${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}'); */
		 	alert("작성되었습니다.");
		 	//동적으로 태그 생성
		 	
		 	var output = "";

		 	
		 	output += '<div class="comment" seq="' + $('.comment').attr('seq') + '">';
		 	
			output += '<div class="media mb-4">';
			output += '<img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">';
			output += '<div class="media-body">';
			output += '${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}&nbsp;<button class="btn btn-outline-danger btn-sm" data-toggle="modal" data-target="#reportModal">신고</button>';
			output += '<div class="btn-group btn-group-sm">';
			output += '<button type="button" class="btn btn-outline-warning">수정</button>';
			output += '<button type="button" onclick="deleteComment(this)" class="btn btn-outline-danger">삭제</button>';
		    output += '</div>';
			output += '<br>';
			output += $('#cContent').val();
			output += '</div>';
			output += '</div>';
			
			
			$(".commentList").append(output);
			$('#cContent').val('');
     	  },
     	  error : function(){
    	  	alert("error");
      	  }
	});
}

function updateBtn(e){
	if($('#updateText' + e).css('display') == 'none'){
		$('#updateText' + e).show();
		$('#originText' + e).hide();
	}else{
		$('#updateText' + e).hide();
		$('#originText' + e).show();
	}
}

function updateComment(e){
	var cno = e;
	var cContent = $('#updateText' + e).children('.form-control').val();
	var parameter = JSON.stringify({cno : cno, cContent : cContent});
	
	$.ajax({
		url : 'boardCommentUpdate.do',
			  type : 'PUT',
			  data : parameter,
			  contentType : 'application/json;charset=UTF-8',
			  success : function() {
				  $('#updateText' + e).children('.form-control').val(cContent);
				  $('#originText' + e).text(cContent);
				  $('#updateText' + e).hide();
				  $('#originText' + e).show();
				  
	    		  alert("수정되었습니다.");
	          },
	          error : function(){
	        	  alert("error");
	          }
	});
}

function deleteComment(e){
	
	//임시
	var cno = e.parentNode.parentNode.parentNode.parentNode.getAttribute('seq');
	//임시
	
	$.ajax({
		url : 'boardCommentDelete.do/' + cno,
		  type : 'PUT',
		  success : function() {
		 	alert("삭제되었습니다.");
		 	//임시
			e.parentNode.parentNode.parentNode.parentNode.remove();
		 	//임시
   	  	  },
	 	  error : function(){
  	  	 	 alert("error");
    	  }
	});
}



// 링크 검사
function linkCheck() {
	// url 정규표현식
	const validateLink = /^(((http(s?))\:\/\/)?)([0-9a-zA-Z\-]+\.)+[a-zA-Z]{2,6}(\:[0-9]+)?(\/\S*)?/;
	let link = $('#link').val().trim();
	
	return new Promise(function(resolve, reject) { 
		if(link.length != 0) {
			if (validateLink.test(link)) {
				resolve();
			} else {
				$('#link').val("");
				$('#link').attr("placeholder", "유효한 링크가 아닙니다");
				$('#suggestSubmitBtn').attr("disabled", true);
				reject();
			}
		} else {
			$('#link').attr("placeholder", "판매링크를 작성하지 않았습니다");
			$('#suggestSubmitBtn').attr("disabled", true);
			reject();
		}
	});
}
// 전화번호 체크
function telCheck() {
	// 정규표현식
	const validateTel = /^[0-9]+$/;
	let tel = $('#tel').val().trim();
	
	return new Promise(function(resolve, reject) { 
		if (tel.length != 0) {
			if (validateTel.test(tel)) {
				resolve();
			} else {
				$('#tel').attr("placeholder", "하이픈을 제외한 숫자로만 입력해주세요");
				$('#suggestSubmitBtn').attr("disabled", true);
				reject();
			}
		} else {
			$('#suggestSubmitBtn').attr("disabled", true);
			$('#tel').attr("placeholder", "연락처를 작성해주세요");
			reject();
		}
	});
}

$('#suggestModal').keyup(function() {
	linkCheck()
	.then(telCheck)
	.then(function() {
		$('#suggestSubmitBtn').attr("disabled", false);
	});
});

$('#suggestSubmitBtn').click(function () {
	var suggest = $('#suggest').serialize();
	
	$.ajax({
		type: 'post',
		dataType: "json",
		url : 'writeSuggest.do',
		data : suggest,
		success : function(data) {
			if (data) {
				alert("제안 성공");
				$('#link').val("");
				$('#tel').val("");
				$('#etc').val("");
				history.go(0);
			}
		}
	});
})


/* 
$("#deleteBoard").click(function(){
	$("#modalHeader").text("삭제 여부 확인");
	$("#modalBody").text("삭제하시겠습니까?");
	$("#modalButton").text("삭제");
    $("#myModal").modal();
});
 */

</script>