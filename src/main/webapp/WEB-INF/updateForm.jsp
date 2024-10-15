<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title> 회원정보</title>
    <link rel="stylesheet" href="../css/user.css">
    <style type="text/css">
  /* 팝업 스타일 */
        #popup {
            display: none; /* 초기에는 숨김 */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }
        #popupContent {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div id="wrap">
    <div id="Formwrap">
        <a href="/spring/"><img alt="shdekarha" src="../image/1.png" width="30" height="30"></a>
    </div>
</div>
<h2>마이페이지</h2>
<form action="user/update" id="updateform" method="post">
    <table>
        <tr>
            <td><label for="name">이름:</label></td>
            <td><input type="text" id="name" name="name" value="${user.name}" ><div id="nameDiv"></div></td>
        </tr>
        <tr>
            <td><label for="id">아이디:</label></td>
            <td><input type="text" id="id" name="id"  value="${user.id}"> <div id="idDiv"></div></td>
        </tr>
        <tr>
            <td><label for="pwd">비밀번호:</label></td>
            <td><input type="password" id="pwd" name="pwd" value="${user.pwd}" ><div id="pwdDiv"></div></td>
        </tr>
        <tr>
            <td colspan="2">
                <button id="updateBtn" type="button">수정하기</button>
                <button id="listBtn" type="button">목록</button>
                <button id="deleteBtn" type="button">회웥탈퇴</button>
                <button type="reset" value="취소"></button>
            </td>
        </tr>
    </table>
</form>

<!-- 비밀번호 입력 팝업 -->
<div id="popup">
    <div id="popupContent">
        <h2>비밀번호 입력</h2>
        <input type="password" id="deletePwd" name="deletePwd" required>
        <button id="confirmDelete">제출</button>
        <button id="closePopup">닫기</button>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<script type="text/javascript" src="../js/write.js"></script>
<script type="text/javascript">
$('#listBtn').click(function() {
	 location.href = "/spring/user/list?pg=" + ${pg};
});
$('#updateBtn').click(function() { // , 삭제
    $('#idDiv').empty();
    $('#pwdDiv').empty();
    $('#nameDiv').empty();

    if ($('#name').val() == '') {
        $('#nameDiv').html('이름 입력');
    } else if ($('#id').val() == '') {
        $('#idDiv').html('아이디 입력');
    } else if ($('#pwd').val() == '') {
        $('#pwdDiv').html('비밀번호 입력');
    } else {
    console.log($('#updateform').serialize());
        $.ajax({
            type: 'post',
            url: '/spring/user/update',
            data: $('#updateform').serialize(), 
            success: function(data) {
                alert('수정 완료 완료');
                location.href='/spring/'
            },
            error: function(e) {
                console.log(e);
            }
        });
    }
});
$('#deleteBtn').click(function() {
    $('#popup').css('display', 'flex'); // 팝업 열기
});

$('#closePopup').click(function() {
    $('#popup').css('display', 'none'); // 팝업 닫기
});

$('#confirmDelete').click(function() {
    const userId = $('#id').val();
    const password = $('#deletePwd').val();

    // 비밀번호 확인 AJAX 요청
    $.ajax({
        type: 'post',
        url: '/spring/user/check',
        data: { id: userId, pwd: password }, // 아이디와 비밀번호 전송
        success: function(data) {
            if (data === 'success') {
                alert('비밀번호 확인 완료');
                // 비밀번호 확인이 성공한 경우 삭제 요청
                $.ajax({
                    type: 'post',
                    url: '/spring/user/delete',
                    data: { id: userId }, // 삭제할 ID 전송
                    success: function(data) {
                        alert('삭제 완료');
                        location.href = '/spring/';
                    },
                    error: function(e) {
                        console.log(e);
                    }
                });
            } else {
                alert('아이디 또는 비밀번호가 틀렸습니다.'); // 오류 처리
            }
        },
        error: function(e) {
            alert('서버 오류 발생'); // 오류 처리
            console.log(e);
        }
    });

    $('#popup').css('display', 'none'); // 팝업 닫기
});

</script>
</body>
</html>
</html>