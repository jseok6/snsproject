<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Vector,sns.*"%>
<jsp:useBean id="umgr" class="sns.UserinfoMgr"/>
<jsp:useBean id="cmgr" class="sns.CommentMgr"/>
<%
		//String email = (String)session.getAttribute("idKey");
		String email="jseok@aaa.com";
		//if(email==null) {
			//response.sendRedirect("login.jsp");
		//}
		UserinfoBean mbean = umgr.getPMember(email);
		Vector<UserinfoBean> uilist = umgr.listPMember(email);
		Vector<PostBean> pvlist = umgr.listPBlog(email);
		
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pho talk</title>
    <link rel="shortcut icon" type="image/x-icon" href="mainLogo.png" />
    <link href="profile.css" rel="stylesheet" type="text/css">
 	<script type="text/javascript">
 		function goURL(url, gid) {
			document.frm1.action=url;
			document.frm1.gid.value=gid;
			document.frm1.submit();
		}
 		function dofriend(url,gid){
 			document.frm1.action=url;
			document.frm1.gid.value=gid;
			document.frm1.submit();
 		}
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
            <a href="#">
                <img class = "homeTrue" src="./images/mainHomeTrue.png"  alt="Image Button" width="25" >
                <span class = "sidebar">홈</span>
            </a>
        </li>
        <li><a href="#"><img src="./images/mainFollowFalse.png" alt="Image Button" width="25"><span class = "sidebar">팔로우</span></a></li>
        <li><a href="#"><img src="./images/mainExploreFalse.png" alt="Image Button" width="25" ><span class = "sidebar">탐색</span></a></li>
        <li><a href="#"><img src="./images/mainMakePostFalse.png" alt="Image Button" width="25" ><span class = "sidebar">만들기</span></a></li>
        <li><a href="#"><img src="./images/mainProfile2.png" alt="Image Button" width="25" ><span class = "sidebar">프로필</span></a></li>
    </ul>
    <div class="sss">
    	<table>
		<tr>
		<%
				for(int i=0;i<uilist.size();i++){
					UserinfoBean ubean = uilist.get(i);
		%>
			<td width="80">
				<div class="box1">
					<a href="javascript:goURL('guest.jsp','<%=ubean.getUserEmail()%>')"><!-- 여기에 jsp파일 -->
						<img class="profile1" src="./photo/profile1.jpg" width="80" height="50">
					</a>
				</div>
				<div>
					<h4><%=ubean.getUserNickName()%></h4>
				</div>
			</td>
		<%}%>	
		</tr>
		</table>
    </div>
    <div class="-\32 18">
    	<table>
		<%
				for(int i=0;i<pvlist.size();i++){
					PostBean pbean = pvlist.get(i);
					UserinfoBean uibean = umgr.getPMember(pbean.getUserEmail());
		%>
		<tr>
			<td width="30">
				<div class="box" style="background: #BDBDBD;">
					<img class="profile" src="photo/<%=uibean.getUserImage()%>" width="30" height="30">
				</div>
			</td>
			<td width="250"><b><%=uibean.getUserNickName()%></b></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">
				<img src="photo/<%=pbean.getImageName()%>" width="350" height="150">
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<a href="javascript:heart('<%=pbean.getPostId()%>')">
			<img src="img/heart.jpg" align="top"></a> 좋아요 <%=pbean.getLikeNum() %>개</td>
			<td align="center"><a href="javascript:del('<%=pbean.getPostId()%>')">DEL</a></td>
		</tr>
		<tr>
			<td colspan="3" width="200"> 
				<%
						Vector<CommentBean> cvlist = cmgr.listPReply(pbean.getPostId());
						for(int j=0;j<cvlist.size();j++){
							CommentBean cbean = cvlist.get(j);
				%>
				<b><%=cbean.getUserEmail()%></b> <%=cbean.getCommentDetail()%>&nbsp;
				<%if(email.equals(cbean.getUserEmail())){%>
					<a href="javascript:rDel('<%=cbean.getCommentId()%>')">x</a><%}%><br>			
				<%}%>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input id="comment<%=pbean.getPostId()%>" placeholder="댓글달기..." size="50">
			</td>
			<td align="center">
				<a href="javascript:cmtPost('<%=pbean.getPostId()%>')">게시</a>
			</td>
		</tr>
		<tr>
			<td colspan="3"><br></td>
		</tr>
		<%}%>
	</table>
    	
    </div>
    <div class="bbb">
    	<p>회원님을 위한 추천</p>
    	<hr>
    	<table>
    	<%
				for(int i=0;i<uilist.size();i++){
					UserinfoBean uibean = uilist.get(i);
		%>
		<tr>
			<td width="350">
				<div class="box1">
					<a href="javascript:goURL('guest.jsp','<%=uibean.getUserEmail()%>')"><!-- 여기에 jsp파일 -->
						<img class="profile1" src="./photo/profile1.jpg" width="80" height="50">
					</a>
				</div>
				<h5><%=uibean.getUserNickName()%></h5> <a href="#" onclick="dofriend()"><h5>팔로우</h5></a>
			</td>
		</tr>
		<%}%>
		</table>
		
    </div>
</body>
</html>