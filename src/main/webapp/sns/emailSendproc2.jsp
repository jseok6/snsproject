<%@page import="java.io.PrintWriter"%>
<jsp:useBean id="mgr" class="sns.UserMgr"/>
<%@page contentType="text/html; charset=UTF-8"%>
<%
	// 이메일 인증코드 검사 페이지
	
	request.setCharacterEncoding("UTF-8");
	String userCode = null; // 랜덤으로 코드를 저장하는 메소드 호출 후 code에 저장	
	int code = 0;
	String checkCode = null;
	String userEmail = null;
	if(session.getAttribute("userEmail")!=null){
		userEmail = (String)session.getAttribute("userEmail");
	}
	if(request.getParameter("num")!=null){
		userCode = request.getParameter("num");
		
	}
	if(session.getAttribute("code")!=null){
		code = ((Integer)(session.getAttribute("code"))).intValue();
		checkCode = String.valueOf(code);
	}
	PrintWriter script = response.getWriter();
	if(userCode.equals(checkCode)){
		if(mgr.deleteUserInfo(userEmail)){
			session.invalidate();
			response.sendRedirect("login.jsp");
		}else{
			script.println("<script>");
			script.println("alert('삭제할 회원정보가 존재하지 않습니다.')");
		    script.println("history.back();");
		    script.println("</script>");	
		}
		//session.invalidate();
		//script.println("<script>");
		//script.println("location.replace('login.jsp');");
		//script.println("</script>");
		
	} else{
		script.println("<script>");
		script.println("alert('인증번호가 틀립니다.')");
	    script.println("history.back();");
	    script.println("</script>");	
	}	
%>



