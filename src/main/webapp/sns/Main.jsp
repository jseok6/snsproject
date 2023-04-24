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
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
 	<script type="text/javascript">
 		function goURL(url, gid) {
			document.frm1.action=url;
			document.frm1.gid.value=gid;
			document.frm1.submit();
		}
 		function heart(postId){//햇음 하트누르면 하트올라가기
 			document.frm.action = "PostHeartCntServlet";
			document.frm.postId.value=postId;
			document.frm.submit();
 		}
 		function cdel(commentId){//햇음 코멘트삭제
			document.frm.action="cdel";
			document.frm.commentId.value=commentId;
			document.frm.submit();
		}
 		function hamberger(userEmail){//햄버거 모달 스크립트 완료
			const modal = document.querySelector('.modal');
		    const ham = document.querySelector('.ham');
		    const cancelBtn = document.querySelector('.modal_close');
		    ham.addEventListener('click', () => {
		    modal.style.display = 'block';
		    });
		    cancelBtn.addEventListener('click', () => {
		        modal.style.display = 'none';
		      });
		}
 		function share(postId){//공유하기모달 반쯤완료
 			const sharebtn=document.querySelector('.sharebtn');
 			const sharecancel=document.querySelector('.sharecancel');
 			const sharemodal=document.querySelector('.sharemodal');
 			sharebtn.addEventListener('click', () => {
 				sharemodal.style.display='block';
 			});
 			sharecancel.addEventListener('click', () => {
 				sharemodal.style.display='none';
 			});
		}
 		function dofriend(email){//팔로우
 			const sentence=email;
 			const [friendEmail,userEmail]=sentence.split(",");
 			document.frm.friendEmail.value=friendEmail;
 			document.frm.userEmail.value=userEmail;
			const followBtn = document.querySelector(".follow-btn");
			$.ajax({
				    url: "FollowServlet", 
				    type: "POST",
				    data: { friendEmail: friendEmail,
				    		userEmail:userEmail
				    },
				    success: function(result) {
				    	followBtn.addEventListener("click", function() {
					 		  followBtn.innerHTML = "팔로워";
					 	});
				    },
				    error: function(xhr, status, error) {
				    }
				  });
 		}
 		
 		var nowUrl = window.location.href;//링크 url따오기 완료
 		function copyUrl(){
 			const modal = document.querySelector('.modal');
 			navigator.clipboard.writeText(nowUrl).then(res=>{
 				  alert("주소가 복사되었습니다!");
 				  modal.style.display='none';
 				})
 		}
 		function report(postId){//신고하기 버튼 누르면 report 숫자올라가기 완료
 			const modal = document.querySelector('.modal');
 			  $.ajax({
 				    url: "postReport", 
 				    type: "POST",
 				    data: { postId: postId },
 				    success: function(result) {
 				    	modal.style.display = 'none';
 				    },
 				    error: function(xhr, status, error) {
 				    }
 				  });
 		}
 		
 		
 		document.addEventListener('DOMContentLoaded', function() {
 			  var input = document.querySelector('.postTextbox');
 			 var postId = input.dataset.postid;
 			var userEmail = '';
 			  if (input.hasAttribute('data-userEmail')) {
 			    userEmail = input.getAttribute('data-userEmail');
 			  }
 			  if (input) {
 			    input.addEventListener('keydown', function(event) {
 			      if (event.key === 'Enter') {
 			        addComment(postId,userEmail);
 			      }
 			    });
 			  }
 			 function addComment(posetId,userEmail){
 				 // Send Ajax request
 				$.ajax({
 				    url: "commentAdd", 
 				    type: "POST",
 				    data: { postId: postId,
 				    		commentDetail:input.value,
 				    		userEmail:userEmail
 				    },
 				    success: function(result) {
 				    	input.value = ""; // clear input field
 				    	
 				    },
 				    
 				    error: function(xhr, status, error) {
 				    }
 				  });
 	 		
 	 		}
 			 
 			});
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
                <img class = "homeTrue" src="./images/mainHomeTrue.png"  alt="Image Button" width="25" >
                <span class = "sidebar">홈</span>
            </a>
        </li>
        <li><a href="follow.jsp"><img src="./images/mainFollowFalse.png" alt="Image Button" width="25"><span class = "sidebar">팔로우</span></a></li>
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
    <!-- <div style="overflow:scroll; height:1900px;"> -->
<div data-role="page">
    <div class="aaa">
    	<table>
		<tr>
		<%
				for(int i=0;i<uilist.size();i++){
					UserinfoBean ubean = uilist.get(i);//정보에 뜰 사람들
		%>
			<td width="100">
				<div class="box1">
					<a href="javascript:goURL('guest.jsp','<%=ubean.getUserEmail()%>')"><!-- 여기에 jsp파일 -->
						<img class="profileimage" src="./photo/profile1.jpg">
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
    <div class="bbb">
    	<h3>회원님을 위한 추천</h3>
    	<hr>
    	<table>
    	<%
				for(int i=0;i<uilist.size();i++){
					UserinfoBean ubean = uilist.get(i);
		%>
		<tr>	
			<td width="50">
				<div class="boxnored">
					<a href="javascript:goURL('guest.jsp','<%=ubean.getUserEmail()%>')"><!-- 여기에 jsp파일 -->
						<img class="profileimage" src="./photo/profile1.jpg">
					</a>
				</div>
				
			</td>
			<td>
			<div class="box2">
					<h4 class="Nick-State"><%=ubean.getUserNickName()%></h4>
					<p class="Text-State">회원님을 팔로우합니다 </p>
			</div>
			</td>
			<td>
				<a href="javascript:dofriend('<%=ubean.getUserEmail() %>,<%=mbean.getUserEmail() %>')" class="follow-btn">
				<%
					if(fmgr.friendCheck(ubean.getUserEmail(), mbean.getUserEmail())){
						%>
						팔로워<% 
					}
					else {
						%>팔로우<% 
					}
				%>
				</a>
			</td>
		<%}%>	
		</tr>
		</table>
    </div>
    <div class="socialproject">
    	<h5>© 2023 Social Net Work Project</h5>
    </div>
    <%
				for(int i=0;i<plist.size();i++){
					PostBean pbean = plist.get(i);
					UserinfoBean uibean = umgr.getPMember(pbean.getUserEmail());
	%>
    <div class="ccc">
    <table>
		<tr>
			<td width="30">
				<div class="box3">
					<img class="profile" src="./photo/<%=uibean.getUserImage()%>" width="35" height="35">
				</div>
			</td>
			<td width="250"><b><%=uibean.getUserNickName()%></b></td>
			<td><a href="javascript:hamberger('<%=pbean.getUserEmail()%>')" class="ham">
					<img src="./img/postCategory.svg">
						
				</a>
			</td>
			
		</tr>
		<tr>
			<td colspan="3">
				<img src="photo/<%=pbean.getImageName()%>" width="515" height="480">
			</td>
		</tr>
		<tr>
			<td colspan="2" >
			
			<a href="javascript:heart('<%=pbean.getPostId()%>')" id="ddd">
				<img src="./img/heart.jpg" align="top">
			</a> 
			<a href="javascript:chat('<%=pbean.getPostId()%>')" id="ddd">
				<img src="./img/postMessageFalse.svg" align="top">
			</a>
			<a href="javascript:share('<%=pbean.getPostId()%>')" id="ddd" class="sharebtn">
				<img src="./img/postShare.svg" align="top">
			</a>
			</td>
			<td align="center"><a href="javascript:del('<%=pbean.getPostId()%>')">DEL</a></td>
		</tr>
		<tr>
			<td width="225"><%=uibean.getUserNickName() %>님 외 <b><%=pbean.getLikeNum() %>명</b>이 좋아합니다.</td>
		</tr>
		<tr>
			<td colspan="3" width="500"> 
				<%
				Vector<CommentBean> clist = cmgr.listPReply(pbean.getPostId());
				for(int j=0;j<clist.size();j++){
					CommentBean cbean = clist.get(j);
					if(!cbean.getCommentParrent().equals("0")){
		%>	
				
				<c><%=cbean.getUserEmail()%></c>&nbsp;<%=cbean.getCommentDetail()%>
				<br>
				<c>&nbsp;&nbsp;&nbsp;&nbsp;<%=cbean.getCommentDate()%>&nbsp;&nbsp; 답글 &nbsp;
				<%if(email.equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				<a href="javascript:cup('<%=cbean.getCommentId()%>')">수정</a><%}%>&nbsp;
				<%if(email.equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				<a href="javascript:cdel('<%=cbean.getCommentId()%>')">삭제</a></c><%}%>&nbsp;
				<br>
				<%} else {%>
					<b><%=cbean.getUserEmail()%></b>&nbsp;<%=cbean.getCommentDetail()%>
				<br>
				<b>&nbsp;&nbsp;&nbsp;&nbsp;<%=cbean.getCommentDate()%>&nbsp;&nbsp; 답글 &nbsp;
				<%if(email.equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				<a href="javascript:cup('<%=cbean.getCommentId()%>')">수정</a><%}%>&nbsp;
				<%if(email.equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				<a href="javascript:cdel('<%=cbean.getCommentId()%>')">삭제</a></b><%}%>&nbsp;
				<br>
				<%} %>
			
		<%}%>
			</td>
		</tr>
		
		<tr>
		
			<td colspan="3" width="500">
				<br>
				<div class="asdf">
				
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
				<hr>
			</td>
			
		</tr>
		
		<tr>	
			<td colspan="3" width="500">
				<img src="./img/postMessageProfile.svg" class="postMessageProfile">&nbsp;
				<input class="postTextbox" id="postTextbox" placeholder="댓글을 입력하세요." data-postid="<%=pbean.getPostId()%>" data-userEmail="<%=mbean.getUserEmail() %>"/>
			</td>

		</tr>
		<tr>
			<td colspan="3"></td>
		</tr>
		
	</table>
	
	</div>
	<!-- 햄버거모달 -->
	<div class="modal">
    			<div>
        			<a href="javascript:report('<%=pbean.getPostId()%>')"><span id="main-modal-text">신고하기</span></a><br>
        			<hr>
        			<a href="javascript:share('<%=pbean.getPostId()%>')" class="sharebtn"><span id="main-modal-text">공유하기</span></a><br>
        			<hr>
        			<a href="javascript:copyUrl('<%=pbean.getPostId()%>')"><span id="main-modal-text">링크복사</span></a><br>
        			<hr>
        			<span id="main-modal-text" class="modal_close">취소</span>
    			</div>
	</div>
	<%}%>
</div>

<!-- 공유하기모달 -->
<div class="sharemodal">
  <div class="share-header">
    <span>공유하기</span>
    <div class="sharecancel">x</div>
  </div>
  <hr>
  <img src="./img/postShareNaver.jpg" class="postShareNaver"/>  
  <img src="./img/postShareKakao.jpg" class="postShareKakao"/>
</div>
<form method="post" name="frm">
		<input type="hidden" name="userNickName">
		<input type="hidden" name="postId">
		<input type="hidden" name="commentId">
		<input type="hidden" name="userEmail">
		<input type="hidden" name="friendEmail">
		<input type="hidden" name="comment">
</form>
</body>
</html>