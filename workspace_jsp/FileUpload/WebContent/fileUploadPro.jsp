<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.Enumeration, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 처리</title>
</head>
<body>
   <%
      // 파일 업로드 변수
      String realFolder = ""; // 실제 파일이 업로드되는 폴더
      String saveFolder = "/uploadFolder"; // 파일이 업로드되는 폴더
      String encType = "utf-8"; // 인코딩 방식
      int maxSize = 1024*1024*5; // 업로드 파일의 최대 크기, 5MB로 설정
      
      // 파일이 저장되는 실제 경로
      ServletContext context = getServletContext();
      realFolder = context.getRealPath(saveFolder);
      out.print("realFolder 위치 : " + realFolder + "<br>");
      out.print("---------------------------------<br>");
      
      try {
         // MultipartRequest 생성자 : request, 저장위치, 파일크기, 인코딩방식, 동일 이름 정책
         MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
      
         // 폼의 input 정보
         Enumeration<?> params = multi.getParameterNames();      
         while(params.hasMoreElements()) {
            String name = (String)params.nextElement();
            String value = multi.getParameter(name);
            out.print("name : " + name + ", value : " + value + "<br>");
         }
         out.print("---------------------------------<br>");
         
         // 업로드한 파일의 정보
         Enumeration<?> files = multi.getFileNames();
         while(files.hasMoreElements()) {
            String name = (String)files.nextElement();
            
            // 원본의 파일이름
            String originFileName = multi.getOriginalFileName(name);
            
            // 업로드된 파일이름
            String uploadFileName = multi.getFilesystemName(name);
            
            // 원본의  파일 타입
            String originFileType = multi.getContentType(name);
            
            // 파일 정보 출력
            out.print("저장폴더 이름 : " + name + "<br>");
            out.print("원본파일 타입 : " + originFileType + "<br>");
            out.print("원본파일 이름 : " + originFileName + "<br>");
            out.print("저장파일 이름 : " + uploadFileName + "<br>");
            
            File file = multi.getFile(name);
            if(file != null) out.print("저장파일 크기 : " + file.length() + "<br>");
         }
         
      } catch(Exception e) {
         e.printStackTrace();
      }
   %>
</body>
</html>