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
	<form  id="uploadUpdateForm">
		
			<input type="text" name="seq" value="${userUploadDTO.seq}">
		<table border="1">
			<tr>
				
				<td>싱품명</td>
				<td>
					<input type="text" name="imageName" size="35" value="${userUploadDTO.imageName}">
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<textarea name="imageContent" rows="10" cols="50" >${userUploadDTO.imageContent}</textarea>
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
				
                   <div id="showImageList">
                    <img src="https://kr.object.ncloudstorage.com/bitcamp-9th-bucket-136/storage/${userUploadDTO.imageFileName}" alt="${user.imageName}" width="70" height="70" style="cursor: pointer;">
                    </div>
                    <input type="file" name="img" id="img" >
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
					<input type="button" value="이미지 업데이트" id="upDateBtn">
					<input type="reset" value="취소"> 
				</td>
			</tr>
			
			
		</table>
	</form>
	
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<!-- <script type="text/javascript" src="../js/update.jsp"></script> -->
<script type="text/javascript">
        $('#camera').click(function() {
            $('#img').trigger('click'); // 강제 파일 선택 이벤트 발생
        });

        $('#img').change(function() {
            $('#showImageList').empty(); // 미리보기 영역 초기화

            for (var i = 0; i < this.files.length; i++) {
                readURL(this.files[i]); // 각 파일에 대해 미리보기 함수 호출
            }
        });

        function readURL(file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var img = document.createElement('img');
                img.src = e.target.result;
                img.width = 70;
                img.height = 70;
                $('#showImageList').append(img); // 미리보기 영역에 이미지 추가
            }
            reader.readAsDataURL(file);
        }
        $('#upDateBtn').click(function(){
    		let formData = new FormData($('#uploadUpdateForm')[0]);
    		
    		$.ajax({
    			type: 'post',
    			enctype: 'multipart/form-data',
    			processData: false,
    			contentType: false,
    			url: '/spring/user/uploadUpdate',
    			data: formData,
    			success: function(data) {
    				alert(data);
    				location.href = "/spring/user/uploadList";
    			},
    			error: function(e) {
    				console.log(e);
    			}
    		});//$.ajax
    	});
        	            
        	     
    </script>
</body>
</html>