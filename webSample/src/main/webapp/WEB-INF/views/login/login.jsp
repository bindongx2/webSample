<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	로그인 페이지
</h1>

<div class="wrapper fadeInDown">
	<div id="formContent">

		<div class="fadeIn first">
			<h1 style="color: #0d0d0d">로그인</h1>
		</div>

		<form id="loginForm" method="post" action="/login">
		
			<input type="email" title="올바르지 않은 이메일 형식입니다." pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" id="email" name="email" class="fadeIn second" placeholder="이메일" required >
			<input type="password" id="password" name="password" class="fadeIn second" minlength="4"
				   data-msg-minlength="최소 {0} 자리 이상 입력해야 합니다."size="30" maxlength="12" placeholder="비밀번호" required>
			<input type="submit" class="fadeIn fourth" value="로그인">
		</form>

		<div id="formFooter">
			<a class="underlineHover" onclick="goRegist()">회원 가입</a>
		</div>
	</div>
</div>
	
	
	
	
<script type="text/javascript">
	function goRegist() {
		alert("회원가입갑시다.");
	}
</script>
	
</body>
</html>
