<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>我的博客</title>
    <style>
        /* 通用样式 */
        body {
            margin: 0;
            padding: 0;
        }
        a {
            color: black;
            text-decoration: none;
        }
        a:hover {
            color: red;
        }

        /* 导航栏 */
        #banner {
            margin: 0;
            padding: 1em;
            font-size: 40px;
            font-family: Serif;
            background: aliceblue;
            border-bottom: 1px solid skyblue;
        }
        #nav {
            margin: 0;
            display: inline-flex;
            width: 100%;
            background: #333333;

            position: sticky; top: 0;
        }
        #nav a {
            color: white;
            padding: 10px 20px;
        }
        #nav a:hover {
            background: green;
        }

        /* 主体页面 */
        #main {
            display: flex;
            margin: 0 auto;
            width: 85%;
        }

        /* 主体页面 - 左侧栏 */
        #main > aside {
            display: flex;
            flex-flow: column nowrap;
            flex: 0 0 140px;
            margin-top: 1em;
        }
        #main > aside a {
            padding: 8px;
        }

        /* 主体页面 - 内容 */
        #main #content {
            padding: 0 2em;
        }

        /* 添加表单 */
        .post-add .g1 {
            display: flex;
            margin-top: 1em;
        }
        .post-add .g2 {
            display: flex;
            margin-top: 1em;
        }
        .post-add input {
            width: 200px;
            margin-right: 2em;
            padding: 5px;
        }
        .post-add textarea {
            width: 100%;
            height: 100px;
        }
        .post-add button {
            border: 0;
            outline: 0;
            padding: 8px 12px;
            border-radius: 5px;
            box-shadow: 0 0 4px #333333;
            cursor: pointer;
        }
        .post-add .preview-img {
            width: 100px;
            margin-left: 1em;
        }
        .post-add .file-input {
            display: none;
        }

        /* 文章列表 */
        .post {
            display: flex;
            flex-flow: row;
            justify-content: space-between;
            box-shadow: 0 0 3px #999;
            background-color: white;
            padding: 1em;
            border-radius: 5px;
            margin: 2em auto;
        }
        .post a {
            font-size: 20px;
            font-weight: bold;
        }
        .post img {
            height: 100%;
            max-height: 150px;
            width: auto;
            border-radius: 50%;
        }
        .post .desc {
            font-size: 10px;
            color: gray;
        }
        .post .del {
            cursor: pointer;
            color: cornflowerblue;
        }
    </style>
</head>

<body>

<div id="banner">
    My Private Blog
</div>
<nav id="nav">
    <a href="#">首页</a>
    <a href="#">新闻</a>
    <a href="#">博问</a>
    <a href="#">专区</a>
    <a href="#">闪存</a>
    <a href="#">发现</a>
</nav>

<div id="main">
    <aside>
        <a href="#">首页</a>
        <a href="#">我的收藏</a>
        <a href="#">我的赞</a>
        <a href="#">热门博客</a>
        <a href="#">热门视频</a>
        <a href="#">最新博客</a>
    </aside>

    <div id="content">
        <section class="post-add">
            <header>
                <h3>添加博客</h3>
            </header>
            <div class="form">
                <input class="file-input" type="file" name="cover" accept="image/*">
                <div class="g1">
                    <input name="title" class="title" placeholder="标题">
                    <input name="author" class="author" placeholder="作者">
                    <button class="submit-post">发表博客</button>
                </div>
                <div class="g2">
                    <textarea name="content" class="cont" placeholder="内容"></textarea>
                    <img class="preview-img" src="${pageContext.request.contextPath}/img/mm.jpg" title="图片" alt="图片">
                </div>
            </div>
        </section>

        <section class="posts">
            <c:forEach items="${posts}" var="post">
                <article class="post" data-id="${post.id}" onclick="postAction(event)">
                    <div>
                        <header>
                            <a Target="_blank"
                               href="${pageContext.request.contextPath}/post?id=${post.id}">${post.title}</a>
                        </header>
                        <p class="desc">
                            <span>来自${post.author}</span>
                            <span>${post.created}</span>
                            <i class="del">删除</i>
                            <i class="likeit">点赞</i>
                        <p class="cont"> ${post.content} </p>
                    </div>
                    <c:if test="${post.cover != null}">
                        <img class="cover" src="${post.cover}" alt="封面">
                    </c:if>
                </article>
            </c:forEach>
        </section>
    </div>
</div>

<script>
    let fileInput = document.querySelector(".file-input");
    fileInput.addEventListener("change", () => {
        let preview = document.querySelector(".preview-img");
        preview.src = URL.createObjectURL(fileInput.files[0]);
    });

    document.querySelector(".preview-img").addEventListener("click", () => {
        fileInput.click();
    })

    // 发表博客

    document.querySelector("button.submit-post").addEventListener('click', () => {
        var fileInput = document.querySelector(".form .file-input");
        var title = document.querySelector(".form .title");
        var author = document.querySelector(".form .author");
        var content = document.querySelector(".form .cont");

        // 组装数据
        var formData = new FormData();
        formData.append("cover", fileInput.files[0]); // type=file
        formData.append("title", title.value);
        formData.append("author", author.value);
        formData.append("content", content.value);

        // 发送请求
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "${pageContext.request.contextPath}/post/add");
        xhr.onload = function (ev) {
            var id = this.responseText;
            if (id === "-1") {
                alert("添加失败!");
            } else {
                alert("添加成功！");
                window.location.href="${pageContext.request.contextPath}/post?id=" + id;
            }
        };
        xhr.send(formData);

        // 清理工作
        fileInput.value = "";
        content.value = "";
        title.value = "";
        author.value = "";
    });

    // 删除博客 (事件代理)

    function postAction(ev) {
        if (ev.target.classList.contains("del")) {
            var post = ev.currentTarget; // ev.target 事件源 ev.currentTarget 事件绑到哪里了
            var id = post.dataset["id"];

            if (window.confirm("你是不是要删除 id 为 " + id + " 的博客?")) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "${pageContext.request.contextPath}/post/del?id=" + id);
                xhr.onload = function (ev) {
                    if (this.responseText === "-1") {
                        alert("删除失败");
                    } else {
                        post.parentNode.removeChild(post);
                        alert("删除成功");
                    }
                };
                xhr.send(null);
            }
        } else if (ev.target.classList.contains("likeit")) {
            alert("可是我不喜欢你")
        }
    }
</script>

</body>
</html>

