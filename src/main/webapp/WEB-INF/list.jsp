<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px;
            text-align: center; /* 가운데 정렬 */
            border: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .pagination {
    text-align: center;
    margin: 20px auto;
}

.pagination span {
    margin: 0 5px;
    padding: 8px 12px;
    border: 1px solid #4CAF50;
    color: #4CAF50;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.3s, color 0.3s;
}

.pagination span:hover {
    background-color: #4CAF50;
    color: white;
}

#currentPaging {
    background-color: #4CAF50;
    color: white;
    font-weight: bold;
    cursor: default;
    border: none;
}
        
        
        
    </style>
</head>
<body>
<div id="wrap">
    <div id="Formwrap">
        <a href="/spring/"><img alt="shdekarha" src="../image/1.png" width="30" height="30"></a>
    </div>
</div>

	<table>
	<thead><tr >
			<th align="center">이름</th>
			<th align="center">아이디</th>
			<th align="center">비밀번호</th>
		</tr></thead>
		<tbody><c:forEach var="user" items="${map2.list}">
            <tr>
                <td>${user.name}</td>
                <td><a href="/spring/user/updateForm?id=${user.id}&pg=${map2.pg}">${user.id}</a></td>
                <td>${user.pwd}</td>
            </tr>
        </c:forEach></tbody>

        
	</table>
	
	<div class="pagination">
    ${map2.userPaging.pagingHTML}
</div>
	
	<script type="text/javascript">
	 function userPaging(pg){
         location.href = "/spring/user/list?pg=" + pg;
     }

	</script>
</body>
</html>