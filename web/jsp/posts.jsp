<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>我的博客</title>
    <style>
        /* 通用样式 */
        body {
            margin: 0;
        }
        a {
            color: black;
            text-decoration: none;
        }
        a:hover {
            color: red;
        }

        /* 导航栏 */
        #nav {
            padding: 1em;
            display: flex;
            background: aliceblue;
            border-bottom: 1px solid skyblue;
        }
        #nav a {
            display: block;
            padding: 5px;
            margin-right: 1em;
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
            width: 300px;
            margin-top: 1em;
        }
        #main > aside a {
            display: block;
            padding: 5px;
            margin-right: 1em;
        }

        /* 主体页面 - 内容 */
        #main .content {
            padding: 0 2em;
        }

        /* 添加表单 */
        .add .g1 {
            display: flex;
            margin-top: 1em;
        }
        .add .g2 {
            display: flex;
            margin-top: 1em;
        }
        .add input {
            width: 200px;
            margin-right: 2em;
            padding: 5px;
        }
        .add textarea {
            width: 100%;
            height: 100px;
        }
        .add button {
            border: 0;
            outline: 0;
            padding: 8px 12px;
            border-radius: 5px;
            box-shadow: 0 0 4px #333333;
            cursor: pointer;
        }
        .add .previewImg {
            width: 100px;
            margin-left: 1em;
        }
        .add #fileInput {
            display: none;
        }

        /* 文章列表 */
        .list {
            display: flex;
            flex-flow: row;
            justify-content: space-between;
            box-shadow: 0 0 3px #999;
            background-color: white;
            padding: 1em;
            border-radius: 5px;
            margin: 2em auto;
        }
        .list a {
            font-size: 20px;
            font-weight: bold;
        }
        .list .desc {
            font-size: 10px;
            color: gray;
        }
        .list img {
            height: 100%;
            max-height: 150px;
            width: auto;
            border-radius: 50%;
        }
    </style>
</head>

<body>
<header>
    <nav id="nav">
        <a href="#">首页</a>
        <a href="#">新闻</a>
        <a href="#">博问</a>
        <a href="#">专区</a>
        <a href="#">闪存</a>
        <a href="#">发现</a>
    </nav>
</header>

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
        <section class="add">
            <header>
                <h3>添加博客</h3>
            </header>
            <form action="${pageContext.request.contextPath}/post/add" method="post" enctype="multipart/form-data">
                <input id="fileInput" type="file" name="cover" accept="image/*">
                <div class="g1">
                    <input name="title" placeholder="标题">
                    <input name="author" placeholder="作者">
                    <button>发表博客</button>
                </div>
                <div class="g2">
                    <textarea name="content" placeholder="内容"></textarea>
                    <img class="previewImg" src="${pageContext.request.contextPath}/img/mm.jpg" title="图片" alt="图片">
                </div>
            </form>
        </section>

        <section class="posts">
            <c:forEach items="${posts}" var="post">
                <article class="list">
                    <div>
                        <header>
                            <a Target="_blank"
                               href="${pageContext.request.contextPath}/post?id=${post.id}">${post.title}</a>
                        </header>
                        <p class="desc"><span>来自${post.author}</span> ${post.created} </p>
                        <p class="content"> ${post.content} </p>
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
    let fileInput = document.querySelector("#fileInput");
    fileInput.addEventListener("change", () => {
        let preview = document.querySelector(".previewImg");
        preview.src = URL.createObjectURL(fileInput.files[0]);
    });

    document.querySelector(".previewImg").addEventListener("click", () => {
        fileInput.click();
    })
</script>

</body>
</html>

