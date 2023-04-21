<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Vector,sns.*"%>
<jsp:useBean id="umgr" class="sns.UserinfoMgr"/>
<jsp:useBean id="cmgr" class="sns.CommentMgr"/>
<jsp:useBean id="fmgr" class="sns.FriemdmanagerMgr"/>
<%
		//String email = (String)session.getAttribute("idKey");
		String email="jseok@aaa.com";
		//if(email==null) {
			//response.sendRedirect("login.jsp");
		//}
		UserinfoBean mbean = umgr.getPMember(email);
		Vector<UserinfoBean> uilist = umgr.listPMember(email);
		Vector<FriendmanagerBean> flist=fmgr.listfMember(email);
		
		
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pho talk</title>
    <link rel="shortcut icon" type="image/x-icon" href="./images/mainLogo.png" />
    <link href="profile.css" rel="stylesheet" type="text/css"/>
    <link type="text/css" rel="stylesheet" href="style.css"></link>
    <link type="text/css" rel="stylesheet" href="follow.css"></link>
    <script type="text/javascript">
    	function follow(userEmail){
    		const followmodal = document.querySelector('.followmodal');
    		const followBtn=document.querySelector('.followBtn');
    		const followCheck=document.querySelector('.followCheck');
    		followBtn.addEventListener('click', () => {
    			followmodal.style.display = 'block';
    		   });
    		followCheck.addEventListener('click', () => {
    			followmodal.style.display = 'none';
    		   });
    	}
    </script>
    
</head>
<body>

<form method="post" name="frm1" action="Main.jsp">
	<input type="hidden" name="gid">
</form>
    <nav>
    <div class = "navbar">
         <a href="javascript:goURL('Main.jsp','')"><img src="./images/mainLogo.png"  alt="Image Button"/></a>
	     <a id = "PhoTalk" class = "navbar-brand" href="Main.jsp">PhoTalk</a>
        <span><input class = "InputBase" placeholder="검색"></span>
        <img id = "mainMessageFalse" src="./images/mainMessageFalse.png" alt="Image Button"/>
        <img id = "mainAlarmFalse" src="./images/mainAlarmFalse.png" alt="Image Button"/>
        <img id = "mainProfile2" src="./images/mainProfile2.png" alt="Image Button"/>
    </div>
</nav>
    <ul>
        <li>
            <a href="#">
                <img class = "homeTrue" src="./images/mainHomeFalse.png"  alt="Image Button" width="25" >
                <span class = "sidebar">홈</span>
            </a>
        </li>
        <li><a href="#"><img src="./images/mainFollowFalse.png" alt="Image Button" width="25"><span class = "sidebar">팔로우</span></a></li>
        <li><a href="#"><img src="./images/mainExploreFalse.png" alt="Image Button" width="25" ><span class = "sidebar">탐색</span></a></li>
        <li><a href="#"><img src="./images/mainMakePostFalse.png" alt="Image Button" width="25" ><span class = "sidebar">만들기</span></a></li>
        <li><a href="#"><img src="./images/mainProfile2.png" alt="Image Button" width="25" ><span class = "sidebar">프로필</span></a></li>
        <%
        	for(int i=0; i<23; i++){
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
    
    <div data-role="page">
    	<div class="followtext">
    		<h5>팔로우 요청</h5>
    	</div>
    </div>
    
    <table>
    <tr>
    <% for (int i = 0; i <flist.size() ; i++) { 
    	FriendmanagerBean fbean = flist.get(i);
		UserinfoBean uibean = umgr.getPMember(fbean.getUserEmail());
    	%>
    	<td>
    		<div class="followrequest">
    			<div class="followimage">
    				<img src="./photo/<%=uibean.getUserImage()%>" width="220" height="200" >
    			</div>
    			<div class="followidtext">
    				<p><br>&nbsp;&nbsp;<%=uibean.getUserNickName() %></p>
    				
    				<a href="javascript:follow('<%=uibean.getUserEmail()%>')"><img src="./img/followBtn.svg" class="followBtn"></a>
    				<img src="./img/followCancelBtn.svg" class="followCancelBtn">
    				<!-- 팔로우 모달 -->
					<div class="followmodal">
    					<div>
    						<br>
        					<h5><strong><%=uibean.getUserNickName() %></strong>님을 <c>팔로우</c> 하였습니다.</h5>
    					</div>
    					<div>
    						<img src="./img/followModalCheckBtn.svg" class="followCheck">
    					</div>
					</div>
    			</div>
    		</div>
    	</td>
    	
    	<% } %>
    	<td>
    	</td>
    </tr>
    </table>
    <hr>
    
    <div data-role="page">
    	<div class="followtext">
    		<h5>추천 팔로우</h5>
    	</div>
    </div>
    <table>
    <tr>
    <% for (int i = 0; i <flist.size() ; i++) { 
    	FriendmanagerBean fbean = flist.get(i);
		UserinfoBean uibean = umgr.getPMember(fbean.getUserEmail());
    	%>
    	<td>
    		<div class="followrequest">
    			<div class="followimage">
    				<img src="./photo/<%=uibean.getUserImage()%>" width="220" height="200" >
    			</div>
    			<div class="followidtext">
    				<p><br>&nbsp;&nbsp;<%=uibean.getUserNickName() %></p>
    				
    				<a href="javascript:follow('<%=uibean.getUserEmail()%>')"><img src="./img/followBtn.svg" class="followBtn"></a>
    				<img src="./img/followCancelBtn.svg" class="followCancelBtn">
    			</div>
    		</div>
    	</td>
    	<% } %>
    	<td>
    	</td>
    </tr>
    </table>
    
</body>
