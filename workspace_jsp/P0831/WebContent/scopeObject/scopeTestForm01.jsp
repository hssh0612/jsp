<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scopeTestForm01</title>
<style>
	table { width : 300px; border : 1px solid black; border-collapse: collapse;}
	tr { height : 40px;}
	th, td { border : 1px solid black;}
</style>
</head>
<body>
	<h2>영역 객체 테스트 폼</h2>
	<form action="scopeTestPro01.jsp" method="post">
		<table>
			<tr><th colspan="2">Application 영역에 저장할 값</th></tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" value="전송">
				</th>
			</tr>
		</table>
	</form>
</body>
</html>