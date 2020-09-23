<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图片结果</title>
</head>
<body>

<p>
    你的图片真好看:
</p>
<p>
    <img src="${pageContext.request.contextPath}/img/${param.path}">
</p>

</body>
</html>
