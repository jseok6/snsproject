<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Vector,sns.*"%>
<jsp:useBean id="umgr" class="sns.UserinfoMgr"/>
<jsp:useBean id="cmgr" class="sns.CommentMgr"/>
<jsp:useBean id="fmgr" class="sns.FriemdmanagerMgr"/>
<%
		String email = (String)session.getAttribute("userEmail");
		//String email="jseok@aaa.com";
		if(email==null) {
			response.sendRedirect("login.jsp");
		}
		UserinfoBean mbean = umgr.getPMember(email);
		Vector<FriendmanagerBean> flist=fmgr.listfMember(email);
		Vector<UserinfoBean> fcommand=umgr.followrecommend(email);
		
		
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pho talk</title>
    <link rel="shortcut icon" type="image/x-icon" href="./images/mainLogo.png" />
    <!-- 네브바 추가할것 !!!! -->
    <link type="text/css" rel="stylesheet" href="css/navbar.css"></link>
    <link type="text/css" rel="stylesheet" href="css/sidebar.css"></link>
    <link type="text/css" rel="stylesheet" href="style.css"></link>
    <link type="text/css" rel="stylesheet" href="css/follow.css"></link>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css"
    />
    <!-- Cropper CSS -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/cropper/2.3.4/cropper.min.css"
    />  
    <link rel="stylesheet" href="css/message.css?after"/>  
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  	<script src="js/navbar.js"></script>   
    <script type="text/javascript">
    	function follow(emailnick){
    		const followmodal = document.querySelector('.followmodal');
            const followBtns=document.querySelectorAll('.followBtn');
            const followCheck=document.querySelector('.followCheck');
            const sentence=emailnick;
 			const [friendEmail,nickName,userEmail]=sentence.split(",");
 			document.frm.friendEmail.value=friendEmail;
 			document.frm.nickName.value=nickName;
 			document.frm.userEmail.value=userEmail;
            document.querySelector("#followNickName").textContent = nickName;
            for (var i = 0; i <followBtns.length ; i++) {
                followBtns[i].addEventListener('click', () => {
                	$.ajax({
                	    url: 'FollowAllow',
                	    type: 'POST',
                	    data: {
                	        userEmail: userEmail,
                	        friendEmail: friendEmail
                	    },
                	    success: function(response) {
                	        console.log(response);
                	        followmodal.style.display = 'block';
                	        
                	    },
                	    error: function(xhr, status, error) {
                	        console.log("Error: " + error);
                	    }
                	});
                });
            }
            followCheck.addEventListener('click', () => {
                followmodal.style.display = 'none';
                location.reload();
            });
    	}
    	function followCancel(emailnick){
    		const followCancelBtns=document.querySelectorAll('.followCancelBtn');
            const sentence=emailnick;
 			const [friendEmail,nickName,userEmail]=sentence.split(",");
 			document.frm.friendEmail.value=friendEmail;
 			document.frm.nickName.value=nickName;
 			document.frm.userEmail.value=userEmail;
            document.querySelector("#followNickName").textContent = nickName;
            for (var i = 0; i <followCancelBtns.length ; i++) {
            	followCancelBtns[i].addEventListener('click', () => {
                	$.ajax({
                	    url: 'FollowCancel',
                	    type: 'POST',
                	    data: {
                	        userEmail: userEmail,
                	        friendEmail: friendEmail
                	    },
                	    success: function(response) {
                	        console.log(response);
                	        location.reload()
                	    },
                	    error: function(xhr, status, error) {
                	        console.log("Error: " + error);
                	    }
                	});
                });
            }
    	}
    	
    </script>
    
</head>
<div class="modal-wrapper"></div>
<body style="overflow-x: hidden">
<form method="post" name="frm1" action="Main.jsp">
	<input type="hidden" name="gid">
</form>
    <nav>
    <div class = "navbar">
         <a href="javascript:goURL('Main.jsp','')"><img src="./images/mainLogo.png"  alt="Image Button"/></a>
	     <a id = "PhoTalk" class = "navbar-brand" href="Main.jsp">PhoTalk</a>
	     <img src="images/mainSearch.svg" alt="mainSearch" style="position:relative; left:180px;"/>	     
	     <!-- 네브바 추가할것 !!!! -->
	    <form method="post" id="navSearch" >
        	<span><input type="text" class = "InputBase"  placeholder="검색" name="searchWord" onkeyup="searchUser()" autocomplete="off"></span>
        	<input type="text" style="display:none;"/>
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
<!-------------------- 사이드바 --------------------->
    <ul class = "sideUl">
        <li class = "sideLi">
            <a class = "home" href="Main.jsp">
                <img class = "homeTrue" src="./images/mainHomeFalse.png"  alt="Image Button" width="25" >
                <span class = "sidebar">홈</span>
            </a>
        </li>
        <li class = "sideLi">
            <a class = "follow" href="follow.jsp">
                <img src="images/mainFollowTrue.svg" alt="Image Button" width="25">
                <span class = "sidebar" style="font-weight: bold">팔로우</span>
            </a>
        </li>
        <li class = "sideLi">
            <a class = "search" href="quest.jsp">
                <img src="images/mainExploreFalse.png" alt="Image Button" width="25" >
                <span class = "sidebar">탐색</span>
            </a>
        </li>      
        <li class = "sideLi">
            <a id = "make-post" href="#">
                <img src="images/mainMakePostFalse.png" alt="Image Button" width="25" >
                <span class = "sidebar">만들기</span>
            </a>
        </li>    
        <li class = "sideLi"> 
            <a  class = "profile" href="profile.jsp">
                <img src="images/mainProfile2.png" alt="Image Button" width="25">
                <span class = "sidebar">프로필</span>
            </a>
        </li>                      
        <%
        	for(int i=0; i<27; i++){
        		%>
        		<br>
        		<%
        	}
        %>
        <dt>
        	&nbsp;
        	<a href="#소개"><span class="leftintroduce">소개</span></a>
        	<a href="#채용"><span class="leftintroduce">채용안내</span></a>
        	<a href="#이용"><span class="leftintroduce">이용약관</span></a>
        	<a href="#도움"><span class="leftintroduce">도움말</span></a>
        	<a href="#운영"><span class="leftintroduce">운영정책</span></a>
        	<a href="#위치"><span class="leftintroduce">위치</span></a>
        </dt>
        <dt>
        	&nbsp;
        	<span class="leftintroduce">사이트맵 © 2023 Social Net Work Project</span>
        </dt>        
    </ul>
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
    	<div class="followtext" style="position: absolute; top: 50px; left: -43px;">
    		<h5>팔로우 요청</h5>
    	</div>

    
    <table>
    <tr>
    <% for (int i = 0; i <flist.size() ; i++) { 
    	FriendmanagerBean fbean = flist.get(i);
		UserinfoBean uibean = umgr.getPMember(fbean.getFriendEmail());
    	%>
    	<td>
    		<div class="followrequest">
    			<!-- friendSign이 0일때 보이게 -->
    			<%if (fmgr.friendCheck(uibean.getUserEmail(),mbean.getUserEmail())) {%>
    			<div class="followimage">
    				<img src="<%=uibean.getUserImage()%>" width="220" height="200" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
    			</div>
    			<div class="followidtext">
    				<span style="position: relative; left: 20px; top: 15px; color: #303030; font-size: 15px"><%=uibean.getUserNickName() %></span>
    				
    				<a href="javascript:follow('<%=uibean.getUserEmail()%>,<%=uibean.getUserNickName()%>,<%=mbean.getUserEmail()%>')"><img src="./img/followBtn.svg" class="followBtn"></a>
    				<a href="javascript:followCancel('<%=uibean.getUserEmail()%>,<%=uibean.getUserNickName()%>,<%=mbean.getUserEmail()%>')"><img src="./img/followCancelBtn.svg" class="followCancelBtn"></a>
    				<!-- 팔로우 모달 -->
					<div class="followmodal">
    					<div>
    						<br>
        					<span style="position: absolute; left:40px; top: 42px;"><strong id="followNickName"></strong>님을 <b style="color: #1877f2;">팔로우</b> 하였습니다.</span>
    					</div>
    					<div style="position: absolute; left:65px; top:101px">
    						<img src="./img/followModalCheckBtn.svg" class="followCheck">
    					</div>
					</div>
    			</div>
    		</div>
    		<%} %>
    	</td>
    	<% } %>
    	<td>
    	</td>
    </tr>
    </table>
    <hr style="position: fixed; top:550px; left: 345px; width: 1530px; background: #d8d8d8; height: 1px; border: 0">
    <!-- 검색 창 -->
    <!-- 네브바 추가할것 !!!! -->
	<table class="userTable" id="userTable">
		<tbody id="ajaxTable">
	          	         	         		          		          		          		          		          		          		          		          		          		          		          		          		          		          		          	
	    </tbody>
	</table>    
    	<div class="followtext" style="position: absolute; top: 520px; left: -43px;">
    		<h5>추천 팔로우</h5>
    	</div>
    <table style="position: absolute; top:470px">
    <tr>
    <% for (int i = 0; i <fcommand.size(); i++) { 
    	UserinfoBean fbean = fcommand.get(i);
    	%>
    	<td>
    		<div class="followrequest">
    			<div class="followimage">
    				<img src="<%=fbean.getUserImage()%>" width="220" height="200" >
    			</div>
    			<div class="followidtext">
    				<span style="position: relative; left: 20px; top: 15px; color: #303030; font-size: 15px"><%=fbean.getUserNickName() %></span>
    				<a href="javascript:follow('<%=fbean.getUserEmail()%>,<%=fbean.getUserNickName()%>,<%=mbean.getUserEmail()%>')"><img src="./img/followBtn.svg" class="followBtn"></a>
    				<img src="./img/followCancelBtn.svg" class="followCancelBtn">
    			</div>
    		</div>
    	</td>
    	<% } %>
    	<td>
    	</td>
    </tr>
    </table>
<!-- 화면꺼지게 -->
<div class="overlay">
	<!-- 만들기모달 -->
	<div class="makemodal">
		<div class="maketexttitle">
				<b>게시물 만들기</b><img src="./img/makePostCancelBtn.svg" class="makecancel">	
		</div>
		<hr style="background: #d8d8d8;height: 1px;border:0;">
		<div class="makebody">
			<img src="./img/makePostImage.svg" class="imageposition">
			<img src="./img/makePostVideo.svg" class="imageposition2"><br>
			<h5 class="makebodytext">사진과 동영상을 선택하세요</h5>
			<img src="./img/makePostSelectImage.svg" class="imageposition3" style="cursor: pointer;">
			<img src="./img/makePostSelectVideo.svg" class="imageposition4" style="cursor: pointer;">
		</div> 				
  	</div>
  	<!-- 편집하기모달 -->
  	<form name="postFrm" method="post" action="PostInsertServlet" enctype="multipart/form-data" >
  	<input type="hidden" name="userEmail" value="<%=mbean.getUserEmail()%>">
  	<div class="fixmodal">
		<div class="maketexttitle">
		&nbsp;&nbsp;<b>편집하기</b><img src="./img/makePostBackBtn.svg" class="makeBackBtn" style="cursor: pointer;">
		</div>
		<hr style="background: #d8d8d8;height: 1px;border:0;">
		<div class="makebody">
		    <img src="./img/makePostImage.svg" class="makePostImage">
			<b class="makepostBefore" style="display: none">Before</b>
			<b class="makepostAfter" style="display: none">After</b>
			<!-- 크롭될이미지 -->
			<div class="filebox">
				<label for="imageInput">사진 선택</label> 
		    	<input type="file" accept="image/*" class="imageInput" name="imageName" id="imageInput">		
		    </div>	
			<div class="choicepicture" style="display: none">
				<div class="result"></div>
			</div>
			<div class="choiceafterpicture" style="display: none">
				<img class="cropped" src="./img/binImage.svg" alt="" />	
			</div>
			<!-- input file -->
      		<div class="box" style="display: none">
        		<div class="options hide">
          		<input type="number" class="img-w" value="300" min="100" max="400" style="display: none"/>
        		</div>
        		<!-- save btn -->
        		<button class="btn save hide" id="saveBtn" style="border-radius: 5px;cursor: pointer;">저장하기</button>
      		</div>
			<img src="./img/makePostInsertBtn.svg" class="makepostInsert" style="display: none">
		</div>				
  	</div>
  	</form>
  	<!-- 동영상모달 -->
  	<form name="videoFrm" method="post" action="VideoPostInsertServlet" enctype="multipart/form-data" >
  	<div class="videomodal">
		<div class="maketexttitle">
			<b style="position:relative;  margin-left: 10px;">동영상모달</b><img src="./img/makePostBackBtn.svg" class="makevideoBackBtn" style="cursor: pointer;">
		</div>
		<hr style="background: #d8d8d8;height: 1px;border:0;">
		<div class="makebody">
			<h5 class="videotitle">동영상을 선택하세요</h5>
			<div class="choicevideo">
				<input type="file" accept="image/*" id="videoElement" name="videoElement">
			</div>
			<img src="./img/makePostInsertBtn.svg" class="videopostInsert">
		</div>				
  	</div>
  	</form>
  	<!-- 게시물완료모달 -->
  	<div class="postcomplete">
		<div class="maketexttitle">
			<b class="postcomtitle">게시물이 올라갔습니다.</b>
		</div>
		<hr style="background: #d8d8d8;height: 1px;border:0;">
		<div class="makebody">
			<img src="./img/makePostCheckIcon.svg" class="makepostComple">
			<br>
			<span class="bodycomple">게시물이 올라갔습니다.</span>
			<br>
			<img src="./img/makePostCheckBtn.svg" class="makepostCheck" style="cursor: pointer;">
		</div>				
  	</div>
</div>
<form method="post" name="frm">
		<input type="hidden" name="userEmail">
		<input type="hidden" name="friendEmail">
		<input type="hidden" name="nickName">
</form>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/0.8.1/cropper.min.js"></script> 
	<script src="js/main.js"></script>   
	<script src="js/message.js"></script>	
	<script>
	    window.onload = function() {
	    	ready('<%=email%>','<%=mbean.getUserName()%>');
	    };
	</script>	
</body>
</html>