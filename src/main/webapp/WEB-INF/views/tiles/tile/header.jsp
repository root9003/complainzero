<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!-- 
Date : 19-01-10
작성자 : 고은아
내용 : 로그인 모달 추가
-->
<!DOCTYPE html>

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title></title>
<link href="css/header.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
</head>

<body>
<!-- 로그인 모달 시작 -->
	<div id="loginModal" class="modal fade bs-example-modal-sm">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				헤더헤더헤더
				<div class="modal-body">
					<form class="navbar-form navbar-left">
						<div class="form-group">
							<input type="email" class="form-control" placeholder="Email" required="required">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="password" required="required">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default">비밀번호 찾기</button>
					<!-- 비밀번호 찾기 단 구현 안됨 -->
					<button type="submit" class="btn btn-primary">로그인</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 로그인 모달 끝 -->
	
	<!-- Navigation -->
	<nav
		class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="#">Complain Zero</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">

					<!-- 시큐리티 적용할 때 session 값이 없으면 -->
					<li class="nav-item"><a class="nav-link" data-toggle="modal"
						data-target="#loginModal" id="loginBtn">로그인</a></li>
					<li class="nav-item"><a class="nav-link" href="joinForm">회원가입</a></li>

					<!-- 세션 값이 있으면 -->

					<li class="nav-item"><a class="nav-link" href="#">게시판</a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownPortfolio" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> <img alt=""
							src="https://github.githubassets.com/images/modules/open_graph/github-octocat.png"
							id="profile"> 닉네임 님
					</a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="navbarDropdownPortfolio">
							<a class="dropdown-item" href="#">작성 글 확인</a> <a
								class="dropdown-item" href="userMyPage.do">내 정보 수정</a> <a
								class="dropdown-item" href="#">로그아웃</a>
						</div></li>
						
											<li class="nav-item"><a class="nav-link" href="#"> <i
							class="far fa-bell"></i><span class="badge">0</span>
					</a>
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="far fa-comments"></i><span class="badge">0</span>
					</a></li>

				</ul>
			</div>
		</div>
	</nav>