<%@page import="sns.CommentBean"%>
<%@page import="sns.PostBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
<%@page import="sns.UserinfoBean"%>
<%@page import="sns.GuestBookBean" %>
<%@page import="sns.FollowBean" %>
<%@page import="sns.FriendmanagerBean" %>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id = "umgr" class = "sns.UserMgr"/>
<jsp:useBean id = "pmgr" class = "sns.ProfileMgr"/>
<jsp:useBean id="mgr" class="sns.UserinfoMgr"/>


<%-- <jsp:useBean id="umgr" class="sns.UserinfoMgr"/> --%>
<jsp:useBean id="cmgr" class="sns.CommentMgr"/>
<jsp:useBean id="fmgr" class="sns.FriemdmanagerMgr"/>
<jsp:useBean id="plmgr" class="sns.PostlikeMgr"/>
<jsp:useBean id="pomgr" class="sns.PostMgr"/>

<%
		String id= request.getParameter("id");
		if (id == null || id.trim().equals("")){
			id= (String)session.getAttribute("userEmail");
		}
		String id2 = (String)session.getAttribute("userEmail");
		UserinfoBean mbean = mgr.getPMember(id2);//유저정보 불러오기(유저이메일,이름,프로파일,별명저장)
		
		Vector<UserinfoBean> uilist = mgr.listPMember(id2);//본인을 제외한 5명리스트 불러오기(유저이메일 별명,유저이미지저장)
		Vector<PostBean> uplist=pomgr.pPrivatelist(id2);//postId 내림차순으로 전체글 다가져오기		
		
		
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필 - PhoTalk</title>
    <link rel="stylesheet" href="css/navbar.css"/>   
    <link rel="stylesheet" href="css/sidebar.css"/>    
    <link rel="stylesheet" href="css/profile2.css?after"/>
    <link rel="stylesheet" href="css/message.css?after"/>   
    <!-- <link type="text/css" rel="stylesheet" href="style.css"></link> -->     
    <link rel="shortcut icon" type="image/x-icon" href="images/mainLogo.png" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css"
    />
    <!-- Cropper CSS -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/cropper/2.3.4/cropper.min.css"
    />    
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <!-- 네브바 추가할것 !!!! -->
    <script src="js/navbar.js"></script>
    <script type="text/javascript">
		function saveguest(){
			frm = document.ProfilepostFrm;
			frm.action = "ProfileServlet";
			alert(frm.contents.value);
			frm.submit();
		}
		function photo(){
			frm2 = document.postPhoto;
			frm2.action = "ProfilePhotoServlet";
			//alert(frm2.photoId.value);
			frm2.submit();
		}
		function bgimage(){
			frm3 = document.postBgPhoto;
			frm3.action = "ProfileBgPhotoServlet";
			//alert(frm2.photoId.value);
			frm3.submit();
		}
		function update(){
			frm4 = document.updateProf
			frm4.action = "ProfileUpdateServlet";
			frm4.submit();
		}
    </script>
</head>
<div class="modal-wrapper"></div>
<body style="overflow-x: hidden; background-color: #fbfbfb">
<!-------------------- 상단바 --------------------->
<nav>
    <div class = "navbar">
         <img src="images/mainLogo.png" alt="Image Button"/>
	     <a id = "PhoTalk" class = "navbar-brand" href="Main.jsp">PhoTalk</a>
	     <img src="images/mainSearch.svg" alt="mainSearch" style="position:relative; left:180px;"/>
	    <form method="post" id="navSearch" >
        	<span><input type="text" class = "InputBase"  placeholder="검색" name="searchWord" onkeyup="searchUser()" autocomplete="off"></span>
        	<input type="text" style="display:none;"/>
        </form>
        <!-- 모달창 -->
        <div class="absol">
        <img class="mainMessageButton" id ="mainMessageButtonfalse" src="images/mainMessageFalse.png" onclick="clickChatBtn('<%=id2%>')" alt="Image Button" style="cursor: pointer"/>
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
                <img src="images/mainHomeFalse.png"  alt="Image Button" width="25" >
                <span class = "sidebar" style="color: #747474;">홈</span>
            </a>
        </li>
        <li class = "sideLi">
            <a class = "follow" href="follow.jsp">
                <img src="images/mainFollowFalse.png" alt="Image Button" width="25">
                <span class = "sidebar" style="color: #747474;">팔로우</span>
            </a>
        </li>
        <li class = "sideLi">
            <a  class = "search" href="quest.jsp">
                <img src="images/mainExploreFalse.png" alt="Image Button" width="25" >
                <span class = "sidebar" style="color: #747474;">탐색</span>
            </a>
        </li>
        <li class = "sideLi">
            <a id = "make-post" href="#">
                <img src="images/mainMakePostFalse.png" alt="Image Button" width="25" >
                <span class = "sidebar" style="color: #747474;">만들기</span>
            </a>
        </li>
        <li class = "sideLi"> 
            <a  class = "profile" href="#">
                <img src="images/mainProfile2.png" alt="Image Button" width="25" >
                <span class = "sidebar" style="font-weight: bold; color: #747474;">프로필</span>
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
<!-------------------- 메인페이지 --------------------->
<!-- 검색 창 -->
<!-- 네브바 추가할것 !!!! -->
<table class="userTable" id="userTable">
	<tbody id="ajaxTable">
	          	         	         		          		          		          		          		          		          		          		          		          		          		          		          		          		          		          	
	</tbody>
</table>
<!------------- 상단부분 ----------------->
<%
	UserinfoBean ubean = pmgr.getInfo(id);
	GuestBookBean gbean = pmgr.getGuest(id);
%>
<div class = mainProfile>
    <div class = mainBanner style="background-image: url('<%= gbean.getGbBackGroundImage()%>'); background-size: cover; background-position: center;	">
    	<div class = mainBanner2>
    		<div class = area_up1>
            <!-- 프로필 사진 -->
            <div class = area_up2>
                <img src="<%= ubean.getUserImage() %>" style = " width: 140px; height:140px; border-radius : 70%; object-fit: cover; border: solid 2px #dedede;"  onerror="this.src ='images/profileProfileLogo.png'">
				</div>
            <div class = area_up3>
                <!-- 이름 -->
                <div class = area_up4>
					<span class = up_text><%=ubean.getUserName()%></span>
                </div>
                <!-- 이메일 -->
                <div class = area_up5>
                	<span class = up_text2><%=ubean.getUserEmail() %></span>
                </div>
                <!-- 방명록 -->
                	<div class = area_up6>
                	<span class = up_text3>
                	<%if(gbean.getGbComment()==null) { %>
                	<span></span>
                	<% } else { %>
                	<span><%=gbean.getGbComment() %></span>
                	<% } %>
                	</div>
                </div>
            </div>
        <div class = area_up7 <% if (!id.equals((String)session.getAttribute("userEmail"))) { %>style="display:none"<% } %>>
            <div>
                <button onclick="show()" type="button" class = "profileBtn3" id="show" style="cursor: pointer;">
                <img src="images/profileBtn3.png" class = "profilepng">
                </button>
  				<button type="button" class="profileBtn2" id="show2" style="cursor: pointer;"><img src="images/profileBtn2.png" class="profilepng"></button>
                <button type="button" class = "profileBtn1" style="cursor: pointer;">
                	<img src="images/profileBtn1.png" class = "profilepng"  id="show3">
                </button>
            </div>
        </div>
      </div>
   </div>
</div>
<!-- 방명록 팝업창 -->
<div class = "background">
	<div class = "window">
		<div class = "popup">
			<div class = "popup-header-div">
				<span id = "popup-header">방명록 작성</span>
				<a id = "popupclose4" ><img src = "images/profilePopupClose.svg"> </a>
			</div>
			<form name = "ProfilepostFrm" method = "post">
			<div class ="popup-body">
				<div class = "popup-content">
					<input type="hidden" name="userEmail" value="<%=id %>">
					<textarea class = "popup-textarea" name = "contents" placeholder="방명록 작성 양식입니다.(공백 포함 50자까지 작성 가능)" maxlength = "50"></textarea>
				</div>
			</div>
			</form>
			<div class = "popup-bottom">
				<button id = "popupclose" type = "submit" onclick = "javascript:saveguest()"><img src = "images/profileCoverImageSelectBtn.svg"></button>
			</div>
		</div>
	</div>
</div>

<!-- 프로필 사진 팝업 -->
<div class = "background2">
	<div class = "window2">	
		<div class = "popup2">
			<div class = "popup-header-div">
				<span id = "popup-header2">프로필 변경</span>
				<a id = "popupclose3" ><img src = "images/profilePopupClose.svg"> </a>
			</div>
			<div class ="popup-body">
				<form name = "postPhoto" method="post" enctype="multipart/form-data">
					<div class = "photopreview">
						<img src="images/profile.svg" id="img__wrap" onerror="this.src='images/profile.svg'" src="${sessionScope.principal.userProfile }" width="280px" height="280px" />
					</div>
					<div class = "inputPhoto">
						<input type="file" name="userProfile" id="img__preview"/>
						<input type="hidden" name="photoId" value="<%=id %>"/>
					</div>
				</form>
			</div>
			<div class = "popup-bottom">
				<div>
					<button id="popupclose2" type="submit" onclick = "photo()"><img src = "images/profileCoverImageSelectBtn.svg"></button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 배경 사진 팝업 -->
<div class = "background3">
	<div class = "window3">	
		<div class = "popup3">
			<div class = "popup-header-div">
				<span id = "popup-header3">배경사진 변경</span>
				<a id = "popupclose6" ><img src = "images/profilePopupClose.svg"> </a>
			</div>
			<div class ="popup-body">
				<form name = "postBgPhoto" method="post" enctype="multipart/form-data">
					<div class = "photopreview">
						<img src="images/profile.svg" id="img__wrap2" onerror="this.src='images/profile.svg'" src="${sessionScope.principal.userProfile }" width="680px" height="280px" />
					</div>
					<div class = "inputPhoto">
						<input type="file" name="backimage" id="img__preview2"/>
						<input type="hidden" name="backId" value="<%=id %>"/>
					</div>
				</form>
			</div>
			<div class = "popup-bottom">
				<div>
					<button id="popupclose5" type="submit" onclick = "bgimage()"><img src = "images/profileCoverImageSelectBtn.svg"></button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 회원정보 수정 팝업 -->
<div class = "background4">
	<div class = "window4">	
		<div class = "popup4">
			<div class = "profile_content">
                <div class = "area3" style="font-size: 22px;">
                    <span class="Text-State">회원정보 수정</span>
                </div>
                <div class= "area4">
                	<div class = "area4_0">
                		<div class = "profile_img">
                            <img class = "profile_icon" src="images/profileNameIcon.svg" alt="img">
                            <% if (ubean.getUserGender().equals("남성")) { %>
                            	<img class = "profile_icon" src="images/profileGenderMan.svg" alt="img" style = "width:15.5px; height:26.9px;">
                            <% } else if (ubean.getUserGender().equals("")) { %>
                            	<img class = "profile_icon" src="images/profileGenderNull.png" alt="img" style = "width:15.5px; height: 26.9px;">
                            <% } else if (ubean.getUserGender().equals("여성")) { %>
                            	<img class = "profile_icon" src="images/profileGenderFemale.png" alt="img" style = "width:15.5px; height:26.9px;">
                            <% } %>
                            <img class = "profile_icon" src="images/profileNickName.svg" alt="img">
                            <img class = "profile_icon" src="images/profileEmailIcon.svg" alt="img" style = "margin-top: 3px;">
                            <img class = "profile_icon" src="images/profilePhoneIcon.svg" alt="img">
                            <img class = "profile_icon" src="images/profileSchoolIcon.svg" alt="img">
                            <img class = "profile_icon" src="images/profileHomeIcon.svg" alt="img">
                            <img class = "profile_icon" src="images/profileSocialInfoIcon.svg" alt="img">
                        </div>
                	</div>
                    <div class = "area4_1">
                        <div class = "profile_name">
                        	<form name = "updateProf" method="post">
                        	<input type="hidden" name="userEmail2" value="<%=id %>">
                            <ul class = "profile_ul">
                                <li style="margin-bottom: 33px;">
                                	<span class = "profile_text" >성명</span>
                                	<span class = "profile_info" style = "margin-left: 130px;"><%=ubean.getUserName() %></span>
                                </li >
                                <li style="padding-top: 2px; margin-bottom: 33px;">
                                	<span class = "profile_text">성별</span>
                                	<input class = "profile_info" name = "prof_gender" style = "margin-left: 130px;" value = "<%=ubean.getUserGender() %>">
                                </li>
                                <li style="padding-top: 5px; margin-bottom: 33px;">
                                	<span class = "profile_text" >닉네임</span>
                                	<input class = "profile_info" name = "prof_nikname" style = "margin-left: 113px;" value = "<%=ubean.getUserNickName() %>">
                                </li>
                                <li style="padding-top: 3px;">
                                	<span class = "profile_text">이메일 주소</span>
                                	<span class = "profile_info" style = "margin-left: 75px;"><%=ubean.getUserEmail() %></span>
                                </li>
                                <li style="margin-bottom: 33px;">
                                	<span class = "profile_text">휴대폰 번호</span>
                                	<input class = "profile_info" name = "prof_pn" style = "margin-left: 75px;" value = "<%=ubean.getUserPN() %>">
                                </li>
                                <li style="margin-bottom: 33px;">
                                	<span class = "profile_text">학교</span>
                                	<input class = "profile_info" name = "prof_school" style = "margin-left: 125px;" value = "<%=ubean.getUserSchool() %>">
                                </li>
                                <li style="margin-bottom: 33px;">
                                	<span class = "profile_text">거주지역</span>
                                	<input class = "profile_info" name = "prof_adress" style = "margin-left: 93px;" value = "<%=ubean.getUserAddress() %>">
                                </li>
                                <li style="margin-bottom: 33px;">
                                	<span class = "profile_text">소셜정보</span>
                                	<input class = "profile_info" name = "prof_social" style = "margin-left: 93px;" value = "<% if(ubean.getUserSocial() == null){%>""<%} else {%>"<%= ubean.getUserSocial()%>"<%}%>">
                                </li>
                            </ul>
                            </form>
                        </div>
                        <div>
							<button id="popupclose5" type="submit" onclick = "update()"><img src = "images/profileCoverImageSelectBtn.svg"></button>
						</div>
                    </div>
                </div>
            </div>
			</div>
		</div>
	</div>
</div>


<!------------- 하단부분 ----------------->



<div class = profile_under>
    <div class = "area1">
        <div class = "area2">
            <!-- 프로필 -->
            <div class = "profile_content">
                <div class = "area3" style="font-size: 22px;">
                    <span class="Text-State-info" style="font-weight: bold;">정보</span>
                </div>
                <div class= "area4">
                	<div class = "area4_0">
                		<div class = "profile_img">
                            <img class = "profile_icon" src="images/profileNameIcon.svg" alt="img">
                            <% if (ubean.getUserGender().equals("남성")) { %>
                            	<img class = "profile_icon" src="images/profileGenderMan.svg" alt="img" style = "width:15.5px; height:26.9px;">
                            <% } else if (ubean.getUserGender().equals("")) { %>
                            	<img class = "profile_icon" src="images/profileGenderNull.png" alt="img" style = "width:15.5px; height:26.9px;">
                            <% } else if (ubean.getUserGender().equals("여성")) { %>
                            	<img class = "profile_icon" src="images/profileGenderFemale.png" alt="img" style = "width:15.5px; height:26.9px;">
                            <% } %>
                            <img class = "profile_icon" src="images/profileNickName.svg" alt="img">
                            <img class = "profile_icon" src="images/profileEmailIcon.svg" alt="img" style = "margin-top: 3px;">
                            <img class = "profile_icon" src="images/profilePhoneIcon.svg" alt="img">
                            <img class = "profile_icon" src="images/profileSchoolIcon.svg" alt="img">
                            <img class = "profile_icon" src="images/profileHomeIcon.svg" alt="img">
                            <img class = "profile_icon" src="images/profileSocialInfoIcon.svg" alt="img">
                        </div>
                	</div>
                    <div class = "area4_1">
                        <div class = "profile_name">
                            <ul class = "profile_ul">
                                <li>
                                	<span class = "profile_text" >성명</span>
                                	<span class = "profile_info" style = "margin-left: 130px;"><%=ubean.getUserName() %></span>
                                </li>
                                <li style="padding-top: 2px;">
                                	<span class = "profile_text">성별</span>
                                	<span class = "profile_info" style = "margin-left: 130px;"><%=ubean.getUserGender() %></span>
                                </li>
                                <li style="padding-top: 5px;">
                                	<span class = "profile_text" >닉네임</span>
                                	<span class = "profile_info" style = "margin-left: 113px;">
                                	<%=ubean.getUserNickName() %>
                                	</span>
                                </li>
                                <li style="padding-top: 3px;">
                                	<span class = "profile_text">이메일 주소</span>
                                	<span class = "profile_info" style = "margin-left: 75px;">
                                	<%=ubean.getUserEmail() %>
                                	</span>
                                </li>
                                <li>
                                	<span class = "profile_text">휴대폰 번호</span>
                                	<span class = "profile_info" style = "margin-left: 75px;">
                                	<%=ubean.getUserPN() %>
                                	</span>
                                </li>
                                <li>
                                	<span class = "profile_text">학교</span>
                                	<span class = "profile_info" style = "margin-left: 125px;">
                                	 <% if(ubean.getUserSchool() == null){ %>
                                	<%} else{ %> 
                                		 <%=ubean.getUserSchool() %>
                                	<%} %>
                                	</span>
                                </li>
                                <li>
                                	<span class = "profile_text">거주지역</span>
                                	<span class = "profile_info" style = "margin-left: 93px;">
                                	<% if(ubean.getUserAddress() == null){ %>
                                	<%} else{ %> 
                                		 <%=ubean.getUserAddress() %>
                                	<%} %>
                                	</span>
                                </li>
                                <li>
                                	<span class = "profile_text">소셜정보</span>
                                	<span class = "profile_info" style = "margin-left: 93px;">
                                	 <% if(ubean.getUserSocial() == null){ %>
                                	<%} else{ %> 
                                		 <%=ubean.getUserSocial() %>
                                	<%} %>
                                	 </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class= "area5" >
                    <button type="button" class = "update_btn" onclick = "location.href='update.jsp'" style="cursor: pointer;">
                        <img class = "update_btn" src="images/profileUpdateIcon.svg" alt="Image Button" >
                        <span class = "update">수정하기</span>
                    </button>
                </div>
            </div>
            <!--팔로우 부분-->
            <div class = "profile_follow">
				<div class = "follow_area1" style="font-size: 22px;">
                    <span class="Text-State-info" style="font-weight: bold;">팔로우</span>
                </div>
                <div class = "follow_area2">
                	<% List<String> vlist = pmgr.followInfo(id);%>
                    <span class="Text-State2">팔로우 <%= vlist.size() %>명</span>
                </div>
                <div class = "follow_area3">             
               		<% for ( String  v : vlist ) {%>
               		<% UserinfoBean bean2 = pmgr.getInfo(v); %>
               		<% if (id != (String)session.getAttribute("userEmail")) { %>
               		<div class = "follow_area4">
               			<a href="<%= pmgr.getUserPage(v) %>" style = "text-decoration: none;">
               			<img src="<%= bean2.getUserImage() %>" style = " width: 130px; height:130px; border-radius: 10px" onerror="this.src ='images/profileProfileLogo.png'">
               			<%= bean2.getUserName() %>
               			</a>
               		</div>
               		<% } else { %>
               		<div class = "follow_area4">
               		<a href="<%= pmgr.getUserPage(v) %>" style = "text-decoration: none;">
               			<img src="<%= bean2.getUserImage() %>" style = " width: 130px; height:130px; border-radius: 10px" onerror="this.src ='images/profileProfileLogo.png'">
               			<%= bean2.getUserName() %>
               		</a>	
               		</div>
               		<% } %>
               		<% } %>
                </div>
            </div>
        </div>
        <!--게시글 자리-->
        <div class = "area_right">
            <div class = "area_right_1">
                <div class = "area3" style="font-size: 22px;">
                    <span class="Text-State-info" style="font-weight: bold;">게시물</span>
                </div>
            </div>
        </div>
     
        
        
    </div>
</div>

        
     <%
				for(int i=0;i<uplist.size();i++){
					PostBean pbean = uplist.get(i);
					UserinfoBean uibean = mgr.getPMember(pbean.getUserEmail());
					Vector<CommentBean> clist = cmgr.listPReply(pbean.getPostId());
					int commentCount = clist.size();
	%>	
    <div class="ccc">
    <table>
		<tr style="width: 517px; display: inline-block;">
			<td style="padding-left: 10px; width: 50px;">
				<div class="box3" style="display: inline-block;">
					<img class="profile" src="<%=uibean.getUserImage()%>">
					
				</div>
						
			</td>
			<td style="width: 100px">
			<div style="font-size: 15px; color: #303030; display: inline-block;"><b><%=uibean.getUserNickName()%></b></div>
			</td>		
			<td>
				<a href="javascript:hamberger('<%=pbean.getUserEmail()%>')" class="ham" style="margin-left: 320px;">
					<img src="./img/postCategory.svg">				
				</a>
			</td>
			
		</tr>
		<tr>
			<td colspan="3" style="border-bottom: solid 1px #eee;"	>
			<!-- 이미지가 null이면 영상불러오기 -->
				<%if (pbean.getImageName() == null || pbean.getImageName().equals("NULL")){ %>
					<embed src="photo/<%=pbean.getVideoName()%>" width="535" height="480">
				<%} else {%>
					<img src="photo/<%=pbean.getImageName()%>" width="535" height="480">
				<%} %>
			</td>
		</tr>
		<tr style="float:left; height: 25px; padding-top: 15px;">
			<td style="padding-left: 10px;">
				<%if (plmgr.postLike(mbean.getUserEmail(), pbean.getPostId())){ %>
					<a href="javascript:heartdel('<%=pbean.getPostId()%>,<%=mbean.getUserEmail() %>')" id="ddd">
					<img src="./img/postLikeTrue.svg" align="top">
					</a>
				<%}else if(!plmgr.postLike(mbean.getUserEmail(), pbean.getPostId())){ %>
					<a href="javascript:heart('<%=pbean.getPostId()%>,<%=mbean.getUserEmail() %>')" id="ddd">				
					<img src="./img/postLikeFalse.svg" align="top">
					</a>
				<%} %> 
			</td>
			<td>
			<a href="javascript:chat('<%=pbean.getPostId()%>')" id="ddd">
				<img src="./img/postMessageFalse.svg" align="top">
			</a>
			</td>
			<td>
			<a href="javascript:share('<%=pbean.getPostId()%>')" id="ddd" class="sharebtn">
				<img src="./img/postShare.svg" align="top">
			</a>
			</td>							
		</tr>
		<tr>
			<td width="250" style="padding-left:10px;"><%=uibean.getUserNickName() %>님 외 <b><%=pbean.getLikeNum() %>명</b>이 좋아합니다.</td>
		</tr>
		<tr class="commenter" style="height:<%=commentCount*50%>px;">
			<td colspan="3" width="500" style="padding-left:10px;"> 
				<%
				for(int j=0;j<clist.size();j++){
					CommentBean cbean = clist.get(j);
					if(cbean.getCommentParrent()!=null){
						
				%>
				<div id="myDIV<%=cbean.getCommentParrent()%>" style="display:none; padding-top: 10px;">	
				<c><%=cbean.getUserEmail()%></c>&nbsp;<c class="commentDetail"><%=cbean.getCommentDetail()%></c>
				<br>
				<c>&nbsp;&nbsp;&nbsp;&nbsp;<c style="font-size: 90%; color: #8e8e8e;"><%=cbean.getCommentDate()%></c>&nbsp;&nbsp; 
				<%if(id2.equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				<a href="javascript:cup('<%=cbean.getCommentId()%>')" id="box<%=cbean.getCommentId()%>" style="font-size: 90%; color: #8e8e8e;">수정</a><%}%>&nbsp;
				<%if(id2.equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				<a href="javascript:cdel('<%=cbean.getCommentId()%>,<%=pbean.getPostId()%>')" style="font-size: 90%; color: #8e8e8e;">삭제</a></c><%}%>&nbsp;
				<br>
				</div>
				<%} else {%>
					<b><%=cbean.getUserEmail()%></b>&nbsp;<c class="commentDetail" ><%=cbean.getCommentDetail()%></c>
				<br>
				<%if (cmgr.replycheck(cbean.getCommentId())) {%><a href="javascript:doDisplay('<%=cbean.getCommentId()%>');" style="font-size: 90%; color: #8e8e8e;" id="linkText<%=cbean.getCommentId()%>"><img src="img/postMessageReplyBtn.svg"/> 답글보기</a><%}%>&nbsp;<c style="font-size: 90%; color: #8e8e8e;"><%=cbean.getCommentDate()%></c>&nbsp;&nbsp; 
				<a href="javascript:creply('<%=cbean.getCommentParrent()%>,<%=mbean.getUserEmail()%>,<%=pbean.getPostId()%>,<%=cbean.getCommentId()%>')" id="rep<%=cbean.getCommentId()%>" style="font-size: 90%; color: #8e8e8e;">답글</a> &nbsp;
				<%if(id2.equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				
				<a href="javascript:cup('<%=cbean.getCommentId()%>')" id="box<%=cbean.getCommentId()%>" style="font-size: 90%; color: #8e8e8e;">수정</a><%}%>&nbsp;
				
				<%if(id2.equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				<a href="javascript:cdel('<%=cbean.getCommentId()%>,<%=pbean.getPostId()%>')" style="font-size: 90%; color: #8e8e8e;">삭제</a></b><%}%>&nbsp;
				<br>
				<%} %>
			
		<%}%>
			</td>
		</tr>
		
		<tr>
		
			<td colspan="3" width="500">
				<br>
				<div class="asdf" style="padding-left: 10px">
				
				<img src="./img/postLikeCount.svg">&nbsp;<%=pbean.getLikeNum() %>&nbsp;
				
				<img src="./img/postMessageCount.svg">&nbsp;댓글<%=pbean.getCommentNum() %>&nbsp;개
				<%
				for(int j=0;j<38;j++){
					%>
					&nbsp;
					<% 
				}
				%>
				공유하기 <%=pbean.getShareNum() %> 회
				</div>
				<hr style="background-color: #d8d8d8">
			</td>
			
		</tr>
		
		<tr>	
			<td colspan="3" width="500" style="padding-top: 15px;">
				<img src="./img/postMessageProfile.svg" class="postMessageProfile">&nbsp;
				<input class="postTextbox" id="postTextbox" placeholder="댓글을 입력하세요." data-postid="<%=pbean.getPostId()%>" data-userEmail="<%=mbean.getUserEmail() %>"/>
			</td>

		</tr>

		
	</table>
	
	</div>       
	<!-- 햄버거모달 -->
	<div class="modal">
    			<div>
        			<a href="javascript:report('<%=pbean.getPostId()%>')"><span id="main-modal-text" style="color: #fd3c56; font-weight: bold;">신고하기</span></a><br>
        			<hr style="background: #d8d8d8; height: 1px; border: 0;">
        			<a href="javascript:share('<%=pbean.getPostId()%>')" class="sharebtn"><span id="main-modal-text">공유하기</span></a><br>
        			<hr style="background: #d8d8d8; height: 1px; border: 0;">
        			<a href="javascript:copyUrl('<%=pbean.getPostId()%>')"><span id="main-modal-text">링크복사</span></a><br>
        			<hr style="background: #d8d8d8; height: 1px; border: 0;">
        			<span id="main-modal-text" class="modal_close">취소</span>
    			</div>
	</div>
	<%}%>   
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

<!-- js 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/0.8.1/cropper.min.js"></script>    
<script src="js/profile.js"></script>
<script src="js/message.js"></script>
<script src="js/main.js"></script>
<script>
    window.onload = function() {
    	ready('<%=id2%>','<%=mbean.getUserName()%>');
    };
</script>
</body>
</html>