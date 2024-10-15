<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">


    @charset "UTF-8";

    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background-color: #f8f9fa; /* 연한 회색 배경 */
    }

    h2 {
        text-align: center;
        color: #333; /* 제목 색상 */
    }

    table {
        width: 400px;
        margin: auto;
        border-collapse: collapse;
        background-color: #fff; /* 흰색 배경 */
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    td {
        padding: 10px;
        border: 1px solid #4CAF50; /* 초록색 테두리 */
    }

    label {
        font-weight: bold;
        color: #333; /* 레이블 색상 */
    }

    input[type="text"], textarea, input[type="file"] {
        width: 90%;
        padding: 10px;
        border: 1px solid #4CAF50; /* 초록색 테두리 */
        border-radius: 4px;
        transition: border-color 0.3s;
        margin-bottom: 10px; /* 입력 필드 간격 */
    }

    input[type="text"]:focus, textarea:focus {
        border-color: #45a049; /* 포커스 시 더 진한 초록색 */
        outline: none;
    }

    input[type="submit"], input[type="reset"] {
        background-color: #4CAF50; /* 초록색 배경 */
        color: white;
        padding: 10px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        width: 48%;
        transition: background-color 0.3s;
        margin: 0 1%;
    }

    input[type="submit"]:hover, input[type="reset"]:hover {
        background-color: #45a049; /* 마우스 오버 시 더 진한 초록색 */
    }

    input[type="reset"] {
        background-color: #f44336; /* 취소 버튼 빨간색 */
    }

    input[type="reset"]:hover {
        background-color: #e53935; /* 취소 버튼 마우스 오버 */
    }
</style>

</head>
<body>
	<form action="/spring/user/upload" method="post" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td rowspan="3">
				  <img src="https://kr.object.ncloudstorage.com/bitcamp-9th-bucket-136/storage/${userUploadDTO.imageFileName}" alt="${user.imageName}" width="100" height="100">
                   		
				</td>
				<td>
				번호 : ${userUploadDTO.seq}
				</td>
			</tr>
			
			<tr>
				<td >
				상품명 : ${userUploadDTO.imageName}
				</td>
			</tr>
			<!--한번ㅇ에 1개 또는 여러개 선택  -->
			<!-- <tr>
				<td colspan="2">
					<input type="file" name="img">
				</td>
			</tr> -->
			<tr>
				<td >
				파일명 : ${userUploadDTO.imageOriginalFileName}
				</td>
			</tr> 
			<!-- 다중 업로드  name 속성의 이름이 같아야한다.-->
			<!-- <tr>
				<td colspan="2">
					<input type="file" name="img">
				</td>
			</tr> -->
			<tr>
			<td colspan="2">
			<pre>${userUploadDTO.imageContent}</pre>
			</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" id="update" value="수정">
					 <input type="button" id="list" value="목록">
					 <input type="button" id="delet" value="삭제"> 
				</td>
			</tr>
			
			
		</table>
	</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $('#update').click(function() {
            window.location.href = '/spring/user/uploadUpdateForm?seq=${userUploadDTO.seq}';
        });

        $('#list').click(function() {
            window.location.href = '/spring/user/uploadList';
        });

        $('#delete').click(function() {
            if (confirm('정말 삭제하시겠습니까?')) {
                window.location.href = '/spring/user/delete?seq=${userUploadDTO.seq}';
            }
        });
    });
</script>
</body>

</html>