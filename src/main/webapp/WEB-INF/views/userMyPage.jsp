<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Page Content -->
    <div class="container">

      <!-- Page Heading/Breadcrumbs -->
      <h1 class="mt-4 mb-3">개인정보
      </h1>

      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="main.do">Home</a>
        </li>
        <li class="breadcrumb-item active">개인정보</li>
      </ol>

      <!-- Content Row -->
      <div class="row">
        <!-- Sidebar Column -->
        <div class="col-lg-3 mb-4">
          <div class="list-group">
            <a href="#" class="list-group-item">개인정보수정</a>
            <a href="#" class="list-group-item">글조회</a>
            <a href="deleteMember.do" class="list-group-item">회원탈퇴</a>
          </div>
        </div>
        <!-- Content Column -->
        <div class="col-lg-9 mb-4">
          <h2>개인정보</h2>
          <div class="card h-100 text-center">
            <img class="card-img-top" src="http://placehold.it/750x450" alt="">
            <div class="card-body">
              <h4 class="card-title">${member.id}</h4>
              <p class="card-text">${member.nickname}</p>
            </div>
          </div>
        </div>
      </div>
      <!-- /.row -->

    </div>
    <!-- /.container -->