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
        <div class="page-wrapper" style="padding-left: 15px">
             	<div style="padding-top: 5px;">
				    
					<div style="padding-bottom: 5px">
						<button type = "button" class = "btn btn-success" onclick="createSeat()">좌석등록</button>
						<button type = "button" class = "btn btn-success" onclick="deleteSeat()">좌석삭제</button>
					</div>
					
			  </div>
			  
                <div id="gridWrap">
						<div id="mapBG">
							<div id="mapArea">
							</div>
                 		  </div>
              	</div>
        </div>
    </div>
    
    <!--//END DETAIL -->
	<!--============================= FOOTER =============================-->
	<%@ include file="/pageframe/footer.jsp"%>
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
    
    <!-- 아임포트 결제API 사용 -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    
  <script>
  
	$(document).ready(function(){
		initMap();
		$('#seat-layer').hide();
		
	});

	var Map = {
		config : {
			//격자 셀 정보
			cell : {
				width :  36,
				height : 18,
				bg11 : "#6E6E6E",
				bg12 : "#D8D8D8",
				bg21 : "#A4A4A4",
				bg22 : "#FAFAFA",
				bgSeat : "#0CBD25"
			}
			
			, sizeX : 65    // 격자 X축 크기
			, sizeY : 31	// 격자 Y축 크기
		}
	}	

	
	//격자 생성
	function createCell(x,y){
		var cell = $("<div> </div>");
		cell.addClass("cell");
		cell.width(36);
		cell.height(18);
		cell.attr("x",x);
		cell.attr("y",y);
		cell.css("backgroundColor", Map.config.cell.bg21);
		return cell;
	}
	
	function getMap(){
		return $("#mapArea");
	}
	
	function getMapBG(){
		return $("#mapBG");
	}
	
	//서버로 부터 배치도 격자 크기 조회
	function initZone(){
		Map.config.sizeX = 65;
		Map.config.sizeY = 31;
	}
	
	//격자 크기에 맞춰 div 크기조정 후 셀 div를 추가
	function initMap(){
		initZone();	//격자 크기 설정
		
		var m = getMap();
		m.width(Map.config.cell.width * Map.config.sizeX);
		m.height(Map.config.cell.height * Map.config.sizeY);
		
		var bg = getMapBG();
		bg.width(Map.config.cell.width * Map.config.sizeX);
		bg.height(Map.config.cell.height * Map.config.sizeY);
		
		for(var y = 1; y <= Map.config.sizeY; y++){
			for(var x = 1; x <= Map.config.sizeX; x++){
				var cell = createCell(x,y);
				m.append(cell);
			}
		}
		installSeat();		//db에 저장된 값 가져와서 좌석목록 조회하여 격자에 셋팅
		viewCountSeat();
	}
	
	
	//현재 유효한 좌석 수 표현
	function viewCountSeat(){
		$("#inputCountSeat").val(getCountSeat());
	}
	
	//좌석(셀) 속성 값 조회
	function getSeat(x,y,num){
		var seat = $("<input type='text' class='cellInput'style='border:solid 1px;'/>");
		seat.width(Map.config.cell.width);
		seat.height(Map.config.cell.height);
		seat.css("backgroundColor", Map.config.cell.bgSeat);
		seat.css("cursor", "pointer");
		seat.attr("x", x);
		seat.attr("y", y);
		seat.val(num);
		seat.attr("onclick","seatClick('"+ num +"');");
// 		this.addEventListener($(".cellInput"), this.seatClick(num));
		return seat;
	}
	
	
	//좌석 클릭시 이벤트
	function seatClick(num){
		alert(num);
		$('#seat-Layer').show();
	}
	
	//시설물(셀) 속성 값 조회
	function getFac(x,y,name,BGColor){
		var seat = $("<input type='text' class='cellInputFac' />");
		seat.width(Map.config.cell.width);
		seat.height(Map.config.cell.height);
		seat.css("backgroundColor", BGColor);
		seat.attr("x", x);
		seat.attr("y", y);
		seat.val(name);
		return seat;
	}

	//좌석 수 조회
	function getCountSeat(){
		return $(".cellInput").length;
	}
	
	
	// DB에 있는 좌석 데이터 가져와서 데이터 뿌려주기
	function installSeat(){
		$(".cellInput").remove();
		var url = "<c:url value = '/seat/selectListSeat' />";
		var param = new Object();
		
		var r = getAjaxJSON(url, param);
		if( r && r.seatVOList && r.seatVOList.length>0){
			for(var i=0; i< r.seatVOList.length; i++){
				if(r.seatVOList[i].is_FAC == "N"){			//좌석
					var cell = $("div[x='" + r.seatVOList[i].locX + "'][y='" + r.seatVOList[i].locY + "']" );
					var seat = getSeat(r.seatVOList[i].locX, r.seatVOList[i].locY, r.seatVOList[i].seatNum);
					seat.attr("seatNum", r.seatVOList[i].seatNum);
					cell.append(seat);
				}else if(r.seatVOList[i].is_FAC == "Y"){	//시설물
					var cell = $("div[x='" + r.seatVOList[i].locX + "'][y='" + r.seatVOList[i].locY + "']" );
					var fac = getFac(r.seatVOList[i].locX, r.seatVOList[i].locY, r.seatVOList[i].seatNum, r.seatVOList[i].facBGColor);
					cell.append(fac);
				}
				
			}
		}
	}
	
</script>
</body>

</html>