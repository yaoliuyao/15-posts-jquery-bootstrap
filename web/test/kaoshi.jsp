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