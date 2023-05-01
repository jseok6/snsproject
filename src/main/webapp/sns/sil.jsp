<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="fileForm" method="POST" enctype="multipart/form-data" action="action.jsp">
		<p> 이름 : <input type="text" name="name"> </p>
		<p> 제목 : <input type="text" name="subject"> </p>
		<p> 파일 : <input type="file" name="filename"> </p>
		<p> <input type="submit" value="파일 올리기"> </p>
		
	</form>
</body>
</html>