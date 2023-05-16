<%@page import="sns.UserinfoBean"%>
<jsp:useBean id="umgr" class="sns.UserinfoMgr"/>
<%@page contentType="text/html; charset=UTF-8"%>
<%
	String email = (String)session.getAttribute("userEmail");	
	UserinfoBean mbean = umgr.getPMember(email);//유저정보 불러오기(유저이메일,이름,프로파일,별명저장)
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <link rel="stylesheet" href="./css/profile.css"/>
    <link rel="stylesheet" href="./css/help.css" />
    <link rel="stylesheet" href="./css/modal.css"/>
    <link rel="stylesheet" href="./css/navbar.css"/>
    <link rel="stylesheet" href="css/message.css?after"/>
 	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script src="js/navbar.js"></script>    
    <title>사용법</title>
    <link
      rel="shortcut icon"
      type="image/x-icon"
      href="./images/loginLogo.png"
    />
  </head>
<div class="modal-wrapper"></div>
<body style="overflow-x: hidden">
    <nav>
    <div class = "navbar">
        <img src="images/mainLogo.png" alt="Image Button"/>
	    <a id = "PhoTalk" class = "navbar-brand" href="Main.jsp">PhoTalk</a>
	    <img src="images/mainSearch.svg" alt="mainSearch" style="position:relative; left:180px;"/>
	    <form method="post" action="searched.jsp">
        	<span><input type="text" class = "InputBase"  placeholder="검색" name="searchWord" onkeyup="searchUser()" autocomplete="off"></span>
        </form>
        <!-- 모달창 -->
        <div class="absol">
<img class="mainMessageButton" id ="mainMessageButtonfalse" src="images/mainMessageFalse.png" onclick="clickChatBtn('<%=email%>')" alt="Image Button" style="cursor: pointer"/>
        <div id="alarm" class="alarm">
        <span class="alarmBalloon"></span>
        </div>
        </div>             
        <img class="mainMessageButton" id = "mainAlarmFalse" src="images/mainAlarmFalse.png" onclick="clickFollowBtn()" alt="Image Button" style="cursor: pointer"/>
    	<img id = "mainProfile2" src="./images/mainProfile2.png" alt="Image Button" onclick="profileModal()" style="cursor: pointer"/>
    </div>	   
</nav>
    <!-- 검색 창 -->
    <!-- 네브바 추가할것 !!!! -->
	<table class="userTable" id="userTable">
		<tbody id="ajaxTable">
	          	         	         		          		          		          		          		          		          		          		          		          		          		          		          		          		          		          	
	    </tbody>
	</table>
	<!-- 프로필 모달 -->
	<table class="profile-modal" id="profile-modal" style="display: none">
		<tbody id="innerProfile">
			<tr onclick="location.href='profile.jsp'">
				<td class="profile-td"><img class= "Profile"src="./images/mainProfileModalProfile.svg"></td>
				<td class="profile-td2">프로필 보기</td>		
    		</tr>   	   				
			<tr onclick="location.href='update.jsp'">
				<td class="profile-td"><img class= "N-Info"src="./images/mainProfileModalInfo.svg"></td>
				<td class="profile-td2">개인 정보</td>		
    		</tr> 		
			<tr onclick="location.href='help.jsp'">
				<td class="profile-td"><img class= "Help"src="./images/mainProfileModalHelp.svg"><span class="Help-T"></td>
				<td class="profile-td2">도움말</td>		
    		</tr> 	
			<tr onclick="showLogout()">			    
				<td class="profile-td"><img class= "Logout" src="./images/mainProfileModalLogout.svg" id="show"></td>				   	
				<td class="profile-td2">로그아웃</td>		
    		</tr> 	    					  	         	         		          		          		          		          		          		          		          		          		          		          		          		          		          		          		          	
	    </tbody>
	</table>
	<!-- 로그아웃 모달 -->	   
	<div class="logout-modal" style="display: none" >
	  <div class="bg" >
	    <div class="logoutBox">
	    	<div class="logoutBtn" style="cursor: pointer" onclick="logout()"><span id="logoutText">로그아웃</span></div>
	    	<div class="logoutCancel" style="cursor: pointer" onclick="showLogout()"><span id="logoutCancelText">취소</span></div>
	    </div>
	  </div>    
	</div>		    
    <div class="side-bar"></div>
    <span class="Help1">PhoTalk 사용법</span>
    <span class="time1">PhoTalk 회원가입</span>
    <span class="time2">PhoTalk 프로필 </span>
    <span class="time3">PhoTalk 게시물 </span>
    <span class="time4">PhoTalk 회원정보 </span>
    <span class="time5">PhoTalk 회원 탈퇴</span>

    <!-- 비디오 삽입 -->
    <video id="player" style="position: absolute; top:101px; left:380px;" width="1500" height="800"  controls>
      <source src="./images/test.mp4"/>
    </video>

    <!-- seekToTime() 함수 정의 -->
    <script src="js/message.js"></script>
    
    <script>
      var player = document.getElementById("player");

      function seekToTime(time) {
        player.currentTime = time;
      }
      window.onload = function() {
      	ready('<%=email%>','<%=mbean.getUserName()%>');
      };
    </script>


    <!-- 1분으로 이동하는 링크 -->
    <a class="time1-1" href="#" style="text-decoration: none;" onclick="seekToTime(60)">1:00</a>
    <a class="time1-2" href="#" style="text-decoration: none;" onclick="seekToTime(90)">1:30</a>
    <a class="time1-3" href="#" style="text-decoration: none;" onclick="seekToTime(120)">2:00</a>
    <a class="time1-4" href="#" style="text-decoration: none;" onclick="seekToTime(150)">2:30</a>
    <a class="time1-5" href="#" style="text-decoration: none;" onclick="seekToTime(180)">3:00</a>
  	
  </body>
</html>