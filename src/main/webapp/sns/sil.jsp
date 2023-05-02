<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.css">
	
	<title>Ajax</title>
	<script src="js/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript">
		var request = new XMLHttpRequest();
		function searchFunction(){
			request.open("post","./UserListServlet?userName="+encodeURIComponent(document.getElementById("userName").value));
			//onreadystatechange => 서버와의 통신이 끝났을 때 호출되는 이벤트
			request.onreadystatechange = function(){
				var table = document.getElementById("ajaxTable");
				table.innerHTML = "";
				//readyState => 현재 통신상태(4=통신완료)/status=>HTTP와의 통신결과(200=통신성공)
				if(request.readyState == 4 && request.status == 200){
					//responseText=>서버에서 통신한 자료를 담고 있다
					//eval =>서버에서 받은 자료를 JSON오브젝트로 변환해준다.
					//eval()으로만 사용 할 경우 단순히 그안의 스트링을 그대로 실행시켜 주는 것이기 때문에 리턴값으로 자바스크립트 명령문이 온다면 그대로 실행시켜버리기 때문에 보안이슈가 발생할 수 있다.  
					var object = eval('(' + request.responseText + ')');
					var result = object.result;
					for(var i = 0; i < result.length; i++){
						var row = table.insertRow(0);
						for(var j = 0; j < result[i].length; j++){
							var cell = row.insertCell(j);
							cell.innerHTML = result[i][j].value;
						}
					}
				}
			}	
			request.send();
		}
		
		window.onload = function(){
			searchFunction();
		}
	</script>
</head>
<body>
	<br>
	<div class="container">
		<div class="form-group row pull-right">
			<div class="col-xs-8">
				<input class="form-control" id=userName type="text" onkeyup="searchFunction();" size="20">
			</div>
			<div class="col-xs-2">
				<button class="btn btn-primary" type="button" onclick="searchFunction();">검색</button>
			</div>
		</div>
		<table class="table" style="border:1px solid #ccc">
			<thead>
				<th style="background-color:#fafafa">이름</th>
				<th style="background-color:#fafafa">나이</th>
				<th style="background-color:#fafafa">성별</th>
				<th style="background-color:#fafafa">이메일</th>
			</thead>
			<tbody id="ajaxTable">
				<tr>
					<td>홍길동</td>
					<td>32</td>
					<td>남</td>
					<td>kildong@naver.com</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="container">
		<table class="table" style="border:1px solid #ccc;text-aling:center">
			<thead>
				<tr>
					<th colspan="2" style="background-color:#fafafa">회원등록양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="background-color:#fafafa">이름</td>
					<td><input class="form-control" type="text" id="registerName" size="20"></td>
				</tr>
				<tr>
					<td style="background-color:#fafafa">나이</td>
					<td><input class="form-control" type="text" id="registerAge" size="20"></td>
				</tr>
				<tr>
					<td style="background-color:#fafafa">성별</td>
					<td>
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active">
								<input type="radio" name="registerGender" autocomplete="off" value="남자" checked>남자
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="registerGender" autocomplete="off" value="여자">여자
							</label>
						</div>
					</td>
				</tr>
				<tr>
					<td style="background-color:#fafafa">이메일</td>
					<td><input class="form-control" type="text" id="registerEmail" size="20"></td>
				</tr>
				<tr>
					<td colspan="2"><button class="btn btn-primary pull-right" onclick="registerFunction();" type="button">등록</button>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>