<!-- 친구들의 게시물 사진들 보여주기 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Vector,sns.*"%>
<jsp:useBean id="umgr" class="sns.UserinfoMgr"/>
<jsp:useBean id="cmgr" class="sns.CommentMgr"/>
<jsp:useBean id="fmgr" class="sns.FriemdmanagerMgr"/>
<jsp:useBean id="pmgr" class="sns.PostMgr"/>
<%
		//String email = (String)session.getAttribute("idKey");
		String email="jseok@aaa.com";
		//if(email==null) {
			//response.sendRedirect("login.jsp");
		//}
		UserinfoBean mbean = umgr.getPMember(email);
		Vector<UserinfoBean> uilist = umgr.listPMember(email);
		Vector<FriendmanagerBean> flist=fmgr.friendpost(email);//프렌드sign이 1인애들 가져오기
		Vector<PostBean> plist = umgr.listPBlog(email);
		
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
    <link type="text/css" rel="stylesheet" href="quest.css"></link>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    </script>
    
</head>
<body>
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
            <a href="Main.jsp">
                <img class = "homeTrue" src="./images/mainHomeFalse.png"  alt="Image Button" width="25" >
                <span class = "sidebar">홈</span>
            </a>
        </li>
        <li><a href="follow.jsp"><img src="./images/mainFollowFalse.png" alt="Image Button" width="25"><span class = "sidebar">팔로우</span></a></li>
        <li><a href="quest.jsp"><img src="./images/mainExploreTrue.svg" alt="Image Button" width="25" ><span class = "sidebar">탐색</span></a></li>
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
    <h5 class="quest">탐색</h5>
	
    <table>
        <% for (int i=0; i < flist.size(); i+=3) { %>
            <tr>
                <% for (int j=i; j < Math.min(i+3, flist.size()); j++) { 
           	
                %>
                    <td>
                        <div class="imagebox">
                        	<%	FriendmanagerBean bean=flist.get(j);
                        		PostBean pbean=pmgr.postImage(bean.getFriendEmail());
                        	%>
                        	<img src="./photo/<%=pbean.getImageName()%>" width="320" height="320">
                        </div>
                    </td>
                <% } %>
            </tr>
        <% } %>
   </table>
</body>
</html>