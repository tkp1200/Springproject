<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>이미지 목록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        #wrap {
            width: 100%;
            max-width: 800px;
            margin: auto;
        }
        #Formwrap {
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
    
</head>
<body>
<div id="wrap">
    <div id="Formwrap">
        <a href="/spring/">
            <img alt="홈으로" src="../image/1.png" width="30" height="30">
        </a>
    </div>

    <table>
        <thead>
            <tr>
                <th>
                    <input type="checkbox" id="selectAll"> 전체 선택
                </th>
                <th>번호</th>
                <th>이미지</th>
                <th>제목</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${list}">
                <tr>
                    <td>
                        <input type="checkbox" name="selectedItems" value="${user.seq}">
                    </td>
                    <td>${user.seq}</td>
                    <td>
                        <a href="/spring/user/uploadView?seq=${user.seq}">
                            <img src="https://kr.object.ncloudstorage.com/bitcamp-9th-bucket-136/storage/${user.imageFileName}" alt="${user.imageName}" width="100" height="100">
                        </a>
                    </td>
                    <td>${user.imageName}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <input type="button" value="삭제" id="deleteBtn">
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // 전체 선택 체크박스 클릭 시
            $('#selectAll').click(function() {
                // 전체 선택 체크박스 상태에 따라 개별 체크박스의 체크 상태를 설정
                $('input[name="selectedItems"]').prop('checked', this.checked);
            });

            // 개별 체크박스 클릭 시 전체 선택 체크박스 상태 업데이트
            $('input[name="selectedItems"]').click(function() {
                // 전체 선택 체크박스가 체크된 상태인지 확인
                $('#selectAll').prop('checked', $('input[name="selectedItems"]:checked').length === $('input[name="selectedItems"]').length);
            });
        });
        
        $('#deleteBtn').click(function(){
        	 var selectedSeqs = [];
             $('input[name="selectedItems"]:checked').each(function() {
                 selectedSeqs.push($(this).val());
             });
             if (selectedSeqs.length === 0) {
                 alert('삭제할 이미지를 선택하세요.');
                 return;
             }
             console.log(selectedSeqs);
             $.ajax({
                 type: 'post',
                 url: '/spring/user/uploaddelete',  // 실제 삭제 요청 URL
                 traditional: true,  // 배열 전송을 위한 설정
                 data: { seq: selectedSeqs },  // 선택된 seq 배열을 전송
                 success: function(data) {
                     alert("삭제 완료");  // 서버에서 반환한 메시지 표시
                     location.href = "/spring/user/uploadList";  // 목록 페이지로 리다이렉트
                 },
                 error: function(e) {
                     console.log(e);  // 에러 로그 출력
                 }
             });
        });
   
    </script>
</body>
</html>
