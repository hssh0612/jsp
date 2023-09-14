<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>switchTestForm01</title>
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
   <form action="switchTestPro01.jsp" method="get">
      이름 입력:&nbsp;<input type="text" name="name"><br>
      지역 선택:&nbsp;<select name="local">
         <option value="서울">서울:02</option>
         <option value="경기도">경기도:031</option>
         <option value="인천">인천:032</option>
         <option value="강원도">강원도:033</option>
         <option value="충청남도">충청남도:041</option>
         <option value="대전">대전:042</option>
         <option value="충청북도">충청북도:043</option>
         <option value="세종">세종:044</option>
         <option value="부산">부산:051</option>
         <option value="울산">울산:052</option>
         <option value="대구">대구:053</option>
         <option value="경상북도">경상북도:054</option>
         <option value="경상남도">경상남도:055</option>
         <option value="전라남도">전라남도:061</option>
         <option value="광주">광주:052</option>
         <option value="전라북도">전라북도:053</option>
         <option value="제주" selected>제주:064</option>
         
      </select>&nbsp;&nbsp;
      전화번호 입력:&nbsp;<input type="text" name="tel">
      <input type="submit" value="입력 완료">
   </form>
   
</body>
</html>