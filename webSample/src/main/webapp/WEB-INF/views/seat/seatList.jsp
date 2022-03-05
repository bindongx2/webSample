<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	
	<title>Essuyo</title>
	<link rel="icon" type="image/png" sizes="16x16" href="/resources/images/backpack.png">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../resources/css/style.min.css" >
    <link rel="stylesheet" href="../resources/css/style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">
    <link rel="stylesheet" href="../resources/css/simple-line-icons.css">
	<link rel="stylesheet" href="../resources/css/themify-icons.css">
	<link rel="stylesheet" href="../resources/css/set1.css">
	<link rel="stylesheet" href="../resources/css/bootstrap1.min.css">

	<style type="text/css">
		@import url(http://fonts.googleapis.com/css?family=Reenie+Beanie);
		#gridWrap{float: left; width:83%; height:500px; overflow:auto}
		#mapArea{position:relative; background-repeat:no-repeat}
		#mapArea ul{overflow:hidden}
		 .cell{float:left;width:20px;height:20px;opacity:0.5;filter:alpha(opacity:'50')}
		 .cell span{display:block;width:18px;height:18px;border:1px solid #000; background:transparent}
		 .cellInput{position:absolute;margin:0;padding:0;color:#fff;text-align:center;line-height:18px;font-size:12px;font-weight: bold;border-top-width: 0px;border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px;cursor:pointer}
		 .cellInputFac{position:absolute;margin:0;padding:0;color:#000;text-align:center;line-height:18px;font-size:12px;font-weight: bold;border-top-width: 0px;border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px}
		 .seat{position:absolute;width:20px;height:20px;cursor:pointer}
		 .seat input{width: 20px;height: 20px;border: 0;background: transparent;font-size: 12px;font-weight: bold;color: #000;text-align: center;line-height: 20px;display: none}
	</style>
</head>

<body>
 
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
  
    <div id="main-wrapper" data-navbarbg="skin6" data-theme="light" data-layout="vertical" data-sidebartype="full" data-boxed-layout="full">
     
        <%@ include file="/pageframe/header.jsp" %>
        
    <div style="margin-top: 20px; width: 1440px;margin-left:50px; text-align: center">
        	<table class="tg" style="undefined;table-layout: fixed; width: 1380px">
	<colgroup>
		<col style="width: 100px">
		<col style="width: 250px">
		<col style="width: 150px">
		<col style="width: 200px">
		<col style="width: 150px">
		<col style="width: 200px">
	</colgroup>
	  <tr>
	    <th class="tg-9wq8">주문일자</th>
	    <th class="tg-9wq8">
	    	<input type="text" style="width: 100px; height: 30px"> ~ <input type="text" style="width: 100px; height: 30px;"> 
	    </th>
	    
	    <th class="tg-9wq8">품목</th>
	    <th class="tg-9wq8">
	    	<select style="width: 70%; height:30px;">
			    <option value="1">전체</option>
			    <option value="2">1</option>
			    <option value="3">2</option>
			</select>
	    </th>
	    
	    <th class="tg-9wq8">브랜드</th>
	    <th class="tg-9wq8">
	    	<select style="width: 70%; height:30px;">
			    <option value="1">전체</option>
			    <option value="2">1</option>
			    <option value="3">2</option>
			</select>
	    </th>
	  </tr>
	  
	  <tr>
	    <th class="tg-9wq8">상품코드</th>
	    <th class="tg-9wq8"><input type="text"style="width: 70%; height:30px;"></th>
	    <th class="tg-9wq8">상품명</th>
	    <th class="tg-9wq8">
	    	<select style="width: 70%; height:30px;">
			    <option value="1">전체</option>
			    <option value="2">1</option>
			    <option value="3">2</option>
			</select>
	    </th>
	    <th class="tg-9wq8">주문상태</th>
	    <th class="tg-9wq8">
	    	<select style="width: 70%; height:30px;">
			    <option value="1">전체</option>
			    <option value="2">1</option>
			    <option value="3">2</option>
			</select>
	    </th>
	  </tr>
	  
	</table>
       </div>
    
	<div style="margin-top: 30px; margin-left:50px; width: 1440px; text-align: center;">
	<table class = "table table-hover tg" border="1" style="margin-top: 5px; width: 1390px">
	  <thead>
	    <tr class = "table-active">
	      <th scope = "row"> <input type="checkbox"> </th>	
	      <th scope = "row">사업장</th>
	      <th scope = "row">층</th>
	      <th scope = "row">가격</th>
	      <th scope = "row">전체좌석 수</th>
	      <th scope = "row">전체좌석 수</th>
	      <th scope = "row">예매</th>
	      <th scope = "row">공석조회</th>
	    </tr>
	  </thead>
	  
	  <tbody>
	    <tr>
	        <td><input type="checkbox"></td>
	    </tr>
	   </tbody>
	</table>   
</div>   
       
    </div>
    
    <!--//END DETAIL -->
	<!--============================= FOOTER =============================-->
<%-- 	<%@ include file="/pageframe/footer.jsp"%> --%>
	<!--//END FOOTER -->
	
    <script src="../resources/js/jquery/jquery.min.js"></script>
    <script src="../resources/js/popper/umd/popper.min.js"></script>
    <script src="../resources/js/bootstrap/bootstrap.min.js"></script>
    <script src="../resources/js/sparkline.js"></script>
    <script src="../resources/js/userpage/waves.js"></script>
    <script src="../resources/js/userpage/sidebarmenu.js"></script>
    <script src="../resources/js/userpage/custom.min.js"></script>
    <script src="../resources/js/utility.js"></script>
    <script src="../resources/js/jscolor.js"></script>
  <script>
  
	$(document).ready(function(){
		
	});

	
</script>
</body>

</html>