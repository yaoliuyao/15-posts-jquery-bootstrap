<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/9/25
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传考试题</title>
    <style>
        div {
            width: 300px;
            margin: 4em auto;
        }
    </style>
</head>
<body>

<div>
    <form action="${pageContext.request.contextPath}/uploadkaoshi" method="post" enctype="multipart/form-data">
        <input type="file" accept=".rsl" name="kaoshi">
        <button>提交考试卷</button>
    </form>
</div>

</body>
</html>
