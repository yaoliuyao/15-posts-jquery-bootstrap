<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传的示例</title>
    <style>
        body {
            margin: 1em;
        }
        button {
            margin-right: 2em;
            margin-bottom: 2em;
            outline: 0;
            border: 0;
            color: white;
            font-family: "隶书";
            font-size: 14px;
            padding: 8px 20px;
            box-shadow: 0 0 5px #333;
            border-radius: 5px;
            background: linear-gradient(90deg, red, orange, yellow, green, blue);
            transition: all 0.5s;
            cursor: pointer;
        }

        button:hover {
            background: red;
            transform: scale(1.2);
        }

        img {
            width: 200px;
            margin-bottom: 2em;
        }
    </style>
</head>
<body>

<h3>文件上传:</h3>

<form action="${pageContext.request.contextPath}/upload" method="post" enctype="multipart/form-data">
    <input style="display: none" id="file" name="shuaige" type="file" accept="image/*">
</form>

<div>
    <button id="clickme">选我、点我</button>
    <button id="submit">点击上传</button>
</div>
<div>
    <img id="preview" src="" title="预览区域">
</div>

<script>
    document.querySelector("#clickme").addEventListener("click", () => {
        document.querySelector("#file").click();
    });

    document.querySelector("#submit").addEventListener("click", () => {
        document.querySelector("form").submit();
    });

    document.querySelector("#file").addEventListener("change", (ev) => {
        let fileInput = document.querySelector("#file");
        let file = fileInput.files[0];

        // 基本信息
        console.log(file.type)
        console.log(file.name)
        console.log(file.size)

        // 可以进行检验
        if (file.size > 10 * 1024 * 1024) {
            alert("图片太大，不能上传!");
            fileInput.value = "";
            return;
        }

        // 预览
        let url = URL.createObjectURL(file);
        console.log("Object URL: " + url);
        document.querySelector("#preview").src = url;
    });
</script>

<hr>

前情回顾:
<pre>
    1. GET 请求，参数是放在 URL 地址栏中发送到服务器的 /xxx?id=3&name=444
    2. POST 请求，参数是放在请求体中发送的，所以地址栏看不到数据
    3. enctype 表示数据的传输格式:
       - application/x-www-form-urlencoded: id=3&name=3333
       - multipart/form-data，表示数据将会被分段处理之后再发送
</pre>

预备知识:
<pre>
    HTML 中用来跟文件系统进行交互的手段只有一个:
    - input type=file

    如果想要上传的话:
    - 必须要用 POST 进行提交，这种方式，将会把数据封装在请求体中进行发送
    - 必须指定 enctype 为 multipart/form-data，这样数据才会被正确分段处理并上传
</pre>

基本步骤:
<pre>
    前端页面中:
    1. 写一个 form 表单，使用 POST 方法，并指定 enctype='multipart/form-data'
    2. 使用 input type=file 来选择文件

    后台接受:
    1. 要在 Servlet 上面添加 MultipartConfig 注解
    2. 使用 req.getPart('name') 来接受图片
    3. 使用 part.write('路径') 来保存图片到服务器的硬盘
</pre>

</body>
</html>
