<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	메인 화면 
</h1>
<P>  The time on the server is ${serverTime}. </P>
<div class="wrapper fadeInDown">
	<div id="formContent">

		<div class="fadeIn first">
			<h1 style="color: #0d0d0d">로그인</h1>
		</div>


		<div>
			<a class="underlineHover" onclick="goRegist()">회원 가입</a>
		</div>
		<div >
			<a class="underlineHover" href="/seat/seat">seat</a>
		</div>
		<div >
			<a class="underlineHover" href="/seat/seatList">seatList</a>
		</div>
		<div >
			<a class="underlineHover" href="/seat/seatView">seatView</a>
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


