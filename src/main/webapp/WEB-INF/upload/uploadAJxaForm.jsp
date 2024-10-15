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
	<form  id="uploadAJxaForm">
		<table border="1">
			<tr>
				<td>싱품명</td>
				<td>
					<input type="text" name="imageName" size="35">
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<textarea name="imageContent" rows="10" cols="50"></textarea>
				</td>
			</tr>
			<!--한번ㅇ에 1개 또는 여러개 선택  -->
			<!-- <tr>
				<td colspan="2">
					<input type="file" name="img">
				</td>
			</tr> -->
			
			<tr>
				<td colspan="2">
					<img alt="카메라" src="../image/ca.png" width="50" height="50" id="camera">
					<span id="showImageList">이미지 미리보기</span>
					<input type="file" name="img[]" multiple="multiple" id="img" style="visibility: hidden;">
				</td>
			</tr> 
			<!-- 다중 업로드  name 속성의 이름이 같아야한다.-->
			<!-- <tr>
				<td colspan="2">
					<input type="file" name="img">
				</td>
			</tr> -->
			
			<tr>
				<td colspan="2" align="center">
					<input type="button" id="uploadAjaxBth" value="이미지 업로드">
					<input type="reset" value="취소"> 
				</td>
			</tr>
			
			
		</table>
	</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<script type="text/javascript" src="../js/uploadAjax"></script>
<script type="text/javascript">
$('#camera').click(function() {
	$('#img').trigger('click');//강제 이벤트 발생
	
	
})
//이미지 미리보기
$('#camera').change(function() {
    $('#showImageList').empty(); 

    for (var i = 0; i < this.files.length; i++) {
        readURL(this.files[i]); 
    }
});

function readURL(file) {
    var reader = new FileReader();
    var show;
    reader.onload = function(e) {
        var img = document.createElement('img');
        img.src = e.target.result; 
        img.width = 70;
        img.height = 70;
        $('#showImageList').append(img);
    }

    reader.readAsDataURL(file);
};
</script>

</body>
</html>

<!-- 
FileReader란?
FileReader는 type이 file인 input 태그 또는 API 요청과 같은 인터페이스를 통해 
File 또는 Blob 객체를 편리하게 처리할수있는 방법을 제공하는 객체이며
abort, load, error와 같은 이벤트에서 발생한 프로세스를 처리하는데 주로 사용되며,
File 또는 Blob 객체를 읽어서 result 속성에 저장한다.

FileReader도 비동기로 동작한다.

FileReader.onload()
load 이벤트의 핸들러. 이 이벤트는 읽기 동작이 성공적으로 완료되었을 때마다 발생한다.
 -->