<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="../css/user.css">
</head>
<body>
<div id="wrap">
    <div id="Formwrap">
        <a href="/spring/"><img alt="shdekarha" src="../image/1.png" width="30" height="30"></a>
    </div>
</div>
<h2>회원가입</h2>
<form action="user/write" id="writeform" method="post">
    <table>
        <tr>
            <td><label for="name">이름:</label></td>
            <td><input type="text" id="name" name="name" required><div id="nameDiv"></div></td>
        </tr>
        <tr>
            <td><label for="id">아이디:</label></td>
            <td><input type="text" id="id" name="id" required> <div id="idDiv"></div></td>
        </tr>
        <tr>
            <td><label for="pwd">비밀번호:</label></td>
            <td><input type="password" id="pwd" name="pwd" required><div id="pwdDiv"></div></td>
        </tr>
        <tr>
            <td colspan="2">
                <button id="writeBtn" type="button">가입하기</button>
                <input type="reset" value="취소">
            </td>
        </tr>
    </table>
</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<script type="text/javascript" src="../js/write.js"></script>
</body>
</html>
