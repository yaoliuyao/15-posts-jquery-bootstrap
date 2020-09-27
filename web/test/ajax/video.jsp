<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>视频测试</title>
    <style>
        video {
            width: 300px;
        }
        .comment {
            margin-bottom: 1em;
            padding: 1em;
            background: #eeeeee;
        }
    </style>
</head>
<body>

<div class="video">
    <video controls src="${pageContext.request.contextPath}/video/idea_first.mp4"></video>
</div>
<div class="comments">
    暂无评论
</div>
<div class="comment-form">
    <input name="pinglun" placeholder="请填入您的评论">
    <button>提交评论</button>
</div>

<script>
    // 发送异步请求
    document.querySelector(".comment-form button").addEventListener('click', () => {
        // 拿到我们要发送的内容
        var pinglun = document.querySelector(".comment-form input").value;

        // 创建一个异步请求的对象
        var xhr = new XMLHttpRequest();
        // 设置使用 Post 方法进行提交，并且设置请求的 url
        xhr.open("POST", "${pageContext.request.contextPath}/ajax/video");
        // 设置发送数据的格式为 aaa=1&bbb=2 的格式
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        // 注册事件 (委托浏览器在请求结束的时候触发这个逻辑)
        xhr.onload = function (e) {
            // 充分利用 JS 的能力，更改页面的内容
            document.querySelector(".comments")
                .insertAdjacentHTML("afterbegin", this.responseText);
            document.querySelector(".comment-form input").value = "";
        };
        // 开始发送请求！
        xhr.send("pinglun=" + pinglun);
    });



</script>

</body>
</html>
