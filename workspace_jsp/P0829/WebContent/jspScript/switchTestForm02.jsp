<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>switchTestForm02</title>
</head>
<%--
문제3) 폼에서 이름과 지역전화번호를 입력하여, 처리하도록 하시오.
지역선택은 select 태그를 사용하시오.
지역 선택에 대한 처리는 switch ~ case문으로 처리하시오.
서울:02, 경기도:031, 인천:032, 강원도:033, 충청남도:041, 대전:042, 충청북도:043, 세종: 044
부산:051, 울산:052, 대구:053, 경상북도:054, 경상남도:055, 전라남도:061, 광주:062, 전라북도:053, 제주:064  

< 입력 페이지 화면 설계 >
이름 입력: 홍길동
지역 선택: 부산
전화번호 입력: 111-1111

< 처리 페이지 화면 설계 >
홍길동님의 지역전화번호는 051-1234-5678입니다.

--%>
<body>
   <h2>이름과 지역전화번호를 입력하는 폼</h2>
   <form action="switchTestPro02.jsp" method="get">
      이름 입력:&nbsp;<input type="text" name="name"><br>
      지역 선택:&nbsp; <select name="local">
         <option value="02">서울</option>
         <option value="031">경기도</option>
         <option value="032">인천</option>
         <option value="033">강원도</option>
         <option value="041">충청남도</option>
         <option value="042">대전</option>
         <option value="043">충청북도</option>
         <option value="044">세종</option>
         <option value="051">부산</option>
         <option value="052">울산</option>
         <option value="053">대구</option>
         <option value="054">경상북도</option>
         <option value="055">경상남도</option>
         <option value="061">전라남도</option>
         <option value="062">광주</option>
         <option value="063">전라북도</option>
         <option value="064" selected>제주</option>
         
      </select>&nbsp;&nbsp;
      전화번호 입력:&nbsp;<input type="text" name="tel">
      <input type="submit" value="입력 완료">
   </form>
   
</body>
</html>