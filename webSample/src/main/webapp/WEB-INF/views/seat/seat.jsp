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
		 .cellInput{position:absolute;margin:0;padding:0;color:#fff;text-align:center;line-height:18px;font-size:12px;font-weight: bold;border-top-width: 0px;border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px}
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
     
        <%@ include file="/pageframe/admin-navigation.jsp" %>
        <div class="page-wrapper" style="padding-left: 15px">
             	<div style="padding-top: 5px;">
	                <div style="padding-top: 5px; text-align: right" >
							<button type = "button" class = "btn btn-danger" style="width: 80px; text-align: center; " onclick="save()">저장</button>
				    </div>	
				    
					<div style="padding-bottom: 5px">
						<button type = "button" class = "btn btn-success" onclick="createSeat()">좌석등록</button>
						<button type = "button" class = "btn btn-success" onclick="deleteSeat()">좌석삭제</button>
						<button type = "button" class = "btn btn-success" onclick="deleteAll()">전체삭제</button>
						<button type = "button" class = "btn btn-success" onclick="clearSeat()">선택취소</button>
						<input type="text" id="inputCountSeat" value="0" style="width: 30px; text-align: center;"> 석
					</div>
					
					<div id="startNumField" style="display:none; margin-bottom: 5px">
						<label>시작번호</label>	
						<input type="text" id="startNum" value="" onchange="changeStartNum()">
						<input type="hidden" id="tmpNum" value="">
					</div>
			  </div>
			  
			  <div style="padding-top: 5px; padding-bottom:5px; border-top: solid 1px; border-bottom:solid 1px;">
					 시설물 색상 <input class="jscolor" id ="facBGColor" value="AAAAAA" style="width: 80px; text-align: center;">
					<div style="padding-top: 5px">
						<button type = "button" class = "btn btn-info" onclick="createFac()">시설물등록</button>
						<button type = "button" class = "btn btn-info" onclick="deleteFac()">시설물삭제</button>
						<button type = "button" class = "btn btn-info" onclick="clearFac()">선택취소</button>
					</div>
              </div>
      
      		  <div style="padding-top: 5px; padding-bottom:5px; ">
				  <form action="/seat/saveExcelSeat" method="post" id="frm" enctype="Multipart/form-data">
						<input type="file" name="file" id="file" style="width: 200px">
						<input type="button" class = "btn btn-danger" value="등록" onclick="formSubmit()">
				  </form>
			  </div>
              
                <div id="gridWrap">
						<div id="mapBG">
							<div id="mapArea">
							</div>
                 		  </div>
              	</div>
        </div>
    </div>
    
    
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
		initMap();
		
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

	//x,y축 위치에 따른 격자 배경색상 조회
	function getCellBG(x,y){
		if(x%2 == 0 && y%2 == 0){
			return Map.config.cell.bg11;
		}else if(x%2 == 0 && y%2 !=0){
			return Map.config.cell.bg12;
		}else if(x%2 != 0 && y%2 ==0){
			return Map.config.cell.bg21;
		}else if(x%2 != 0 && y%2 !=0){
			return Map.config.cell.bg22;
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
		cell.css("backgroundColor", getCellBG(x,y));
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
	
	
	//각 셀에 좌석 삭제 이벤트 부여
	function deleteSeat(){
		this.clearClickEvent($(".cell"));
		this.addClickEvent($(".cellInput"), this.disableSeat);
		$("#startNum").val("");
		$("#tmpNum").val("");
		$("#startNumField").hide();
	}
	
	//모든 셀에 좌석 및 시석물 삭제 이벤트 부여
	function deleteAll(){
		if(confirm("화면 내 모든셀의 좌석을 삭제 하시겠습니까?")){
			$(".cell").each(function(){
				$(this).unbind("click");
				$(this).css("cursor", "default");
			});
			
			//좌석 삭제
			$(".cellInput").each(function(){
				$(this).remove();
				viewCountSeat();
			});
			
			//시설물 삭제
			$(".cellInputFac").each(function(){
				$(this).remove();
			});
			
		}
	}
	
	function deleteFac(){
		this.clearClickEvent($(".cell"));
		this.addClickEvent($(".cellInputFac"), this.disableFac);
	}
	
	//각 셀에 좌석 생성 이벤트 부여
	function createSeat(){
		this.clearClickEvent($(".cellInput"));
		this.addClickEvent($(".cell"), this.enableSeat);
		$("#startNum").val("");
		$("#tmpNum").val("");
		$("#startNumField").show();
	}
	
	function createFac(){
		this.clearClickEvent($(".cellInputFac"));
		this.addClickEvent($(".cell"), this.enableFac);
	}
	
	//셀에 좌석 생성 (이벤트 수행)
	function enableSeat(){
		if($(this).children().length == 0){
			var startNum = $("#startNum").val();
			if(startNum == "" || startNum == null){
				alert("시작번호를 입력해주세요.");
				return;
			}
			var tmpNum = $("#tmpNum").val();
			
			if(tmpNum == "" || tmpNum == null){
				tmpNum = 0;
			}
			
			if(tmpNum == 0){
				tmpNum = startNum;
			}else{
				tmpNum++;
			}
			
			var flag = true;
			
			$(".cellInput").each(function(index){
				if(this.value == tmpNum){
					alert('[' + this.value + '] 는 중복되는 좌석번호 입니다.');
					flag = false;
					return;
				}
			});
			
			if(flag == true){
				var seat = getSeat($(this).attr("x"), $(this).attr("y"), tmpNum);
				$(this).append(seat);
				
				$("#tmpNum").val(tmpNum);
			}
			
		}
		viewCountSeat();
	}
	
	function enableFac(){
		if($(this).children().length == 0){
			var facName = $("#facName").val();
			var facBGColor = '#' + $("#facBGColor").val();
			var fac = getFac($(this).attr("x"), $(this).attr("y"), facName, facBGColor);
			$(this).append(fac);
		}
	}
	
	//각 셀에 좌석 생성 이벤트 부여
	function clearSeat(){
		this.clearClickEvent($(".cellInput"));
		this.clearClickEvent($(".cell"));
		$("#startNumField").hide();
	}
	
	function clearFac(){
		this.clearClickEvent($(".cellInputFac"));
		this.clearClickEvent($(".cell"));
	}
	
	//현재 유효한 좌석 수 표현
	function viewCountSeat(){
		$("#inputCountSeat").val(getCountSeat());
	}
	
	//좌석(셀) 속성 값 조회
	function getSeat(x,y,num){
		var seat = $("<input type='text' class='cellInput' />");
		seat.width(Map.config.cell.width);
		seat.height(Map.config.cell.height);
		seat.css("backgroundColor", Map.config.cell.bgSeat);
		seat.attr("x", x);
		seat.attr("y", y);
		seat.val(num);
		return seat;
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
	
	//좌석삭제(이벤트 수행)
	function disableSeat(){
		if(!$(this).attr("isLongReservationSeat")){
			$(this).remove();
			viewCountSeat();
		}else{
			alert("장기예매 좌석은 삭제할 수 없습니다.");
			return false;
		}
	}
	
	function disableFac(){
		$(this).remove();
	}
	
	//격자 셀의 이벤트 제거 및 마우스 포인트 변경
	function clearClickEvent(obj){
		$(obj).each(function(){
			$(this).unbind("click");
			$(this).css("cursor", "default");
			
		});
	}
	
	function addClickEvent(obj, func){
		$(obj).each(function(){
			$(this).bind("click", func);
			$(this).css("cursor","pointer");
		});
	}

	//좌석 수 조회
	function getCountSeat(){
		return $(".cellInput").length;
	}
	
	//좌석 정보 저장
	function save(){
		var saveConf = confirm("저장하시겠습니까?");
		if(saveConf){
			
			var xValues = new Array();
			var yValues = new Array();
			var numValues = new Array();
			
			var facBGColorValues = new Array();
			var isFac = new Array();
			
			var isValid = true;
			$(".cellInput").each(function(){
				for(var i = 0; i < numValues.length; i++){
					if(numValues[i] == $(this).val()){
						alert("[" + $(this).val() + "] 는 중복되는 좌석번호입니다.");
						isValid = false;
						return false;
					}
				}
				
				numValues.push($(this).val());
				xValues.push($(this).attr("x"));
				yValues.push($(this).attr("y"));
				facBGColorValues.push("#0CBD25");
				isFac.push("N");
				
			});
			
			if(isValid == false){
				return false;
			}
			
			$(".cellInputFac").each(function(){
				facBGColorValues.push(hexc($(this).css("backgroundColor")));
				numValues.push($(this).val());
				xValues.push($(this).attr("x"));
				yValues.push($(this).attr("y"));
				isFac.push("Y");
			});
			
			var val = new Object();
			val.x = xValues;
			val.y = yValues;
			val.num = numValues;
			
			val.facBGColor = facBGColorValues;
			val.isFac = isFac;
			
			var url = "<c:url value = '/seat/saveSeat' />";
			
			var r = getAjaxJSON(url, val);
			
			if(r && r.result && r.result == "Y"){
				alert("저장되었습니다.");
				installSeat();
			}else{
				var msg = r && r.msg ? r.msg : "오류가 발생하여 저장에 실패하였습니다.";
				alert(msg);
			}
		}
	}
	
	//file form submit함수
	function formSubmit(){
		var fileValue = $('#file').val();
		if(fileValue == "" || fileValue == null ){
			alert("파일을 등록해주세요.");
			return false;
		}else{
			var conf = confirm("파일을 등록하시겠습니까?");
			if(conf){
				alert("등록을 완료하였습니다.");
				document.getElementById('frm').submit();
			}
		}
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
	
	
	// RGB to hex 코드로 변환 
	function hexc(rgb) {
	     if (  rgb.search("rgb") == -1 ) {
	          return rgb;
	     } else {
	          rgb = rgb.match(/^rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+))?\)$/);
	          function hex(x) {
	               return ("0" + parseInt(x).toString(16)).slice(-2);
	          }
	          
	          return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]); 
	     }
	}
		
	function changeStartNum(){
		$("#tmpNum").val("");
	}
	
</script>
</body>

</html>