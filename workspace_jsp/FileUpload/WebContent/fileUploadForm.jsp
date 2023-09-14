<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 폼</title>
<style>
#container { width : 400px; margin : 20px auto;}
h2 { text-align : center;}
table { width : 100%; border : 1px solid black; border-collapse : collapse;}
tr { height : 50px;}
th, td { border : 1px solid black;}
th { background : #e9ecef;}
td { padding-left : 10px;}
.end_row { text-align : center;}
.end_row input { width : 110px; height : 35px; border : none; font-size : 14px;
      font-weight : bold; background : #000; color : #fff;}
</style>
</head>
<body>
   <div id="container">
      <h2>파일 업로드 폼</h2>
         <form action="fileUploadPro.jsp" method="post" enctype="multipart/form-data">
         <table>
            <tr>
               <th width = "20%">작성자</th>
               <td width = "80%"><input type="text" name="user" size="37"></td>
            </tr>
            <tr>
               <th>제목</th>
               <td><input type="text" name="subject" size="37"></td>
            </tr>
            <tr>
               <th>파일명</th>
               <td><input type="file" name="uploadFile"></td>
            </tr>
            <tr>
               <td colspan="2" class="end_row">
                  <input type="submit" value="파일 업로드">
               </td>
            </tr>
         </table>
      </form>
   </div>
</body>
</html>