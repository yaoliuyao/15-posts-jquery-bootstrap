<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>我的博客</title>
    <style>
        body {
            background-size: 100% 100%;
            margin: 0px;
        }
        #a {
            width: 100%;
            height: 50px;
            position: fixed;
            background-color: white;
        }
        div#a {
            width: 1100px;
            padding-left: 40px;
            margin: 0 auto;
            background: aliceblue;
            border-bottom: 1px solid skyblue;
        }
        div#a a {
            float: left;
            color: black;
            width: 50px;
            margin: 0 auto;
        }
        div#a ul {
            list-style-type: none;
            float: left;
            height: 50px;
            padding: 0px 0px;
            margin: 0 auto;
        }
        div#a ul li {
            text-decoration: none;
            float: left;
            /*padding: 10px 0px 45px 0;*/
            margin-right: 10px;
        }
        div#a ul li a {
            width: 60px;
            text-decoration: none;
            font-size: 20px;
            padding-top: 10px;
            margin-left: 50px;
        }
        div#a ul li a:hover {
            color: red;
        }
        #d {
            float: left;
            width: 665px;
            margin-top: 1px;
            height: 1000px;
            margin-left: 250px;

        }

        #s {
            float: left;
            width: 100px;
            height: 530px;
            position: fixed;
            margin-top: 50px;
            margin-left: 100px;
        }
        div#s ul {
            list-style-type: none;
            list-style-position: inherit;
            padding: 20px;
            margin: 0px;
        }
        div#s ul li {
            text-decoration: none;
            padding: 10px 0px 20px 0px;
            width: 180px;
            height: 15px;
        }
        div#s ul li a {
            width: 100px;
            text-decoration: none;
            font-size: 15px;
            color: #333333;
        }
        .s1 {
            font-size: 20px;
        }
        div#s ul li:hover {
            background-color: LightSteelBlue;
            width: 180px;
            height: 15px;
        }
        div#h ul {
            list-style-type: none;
            list-style-position: inherit;
            padding: 8px;
            margin: 0px;

        }
        div#h ul li {
            text-decoration: none;
            float: left;
            font-size: 24px;
            padding: 13px 1px 2px 0px;
            font-weight: bold;
            color: #999999;
        }
        div#h ul li:hover {
            color: red;
        }


        article {
            display: flex;
            flex-flow: row;
            justify-content: space-between;
            box-shadow: 0 0 3px #999;
            background-color: white;
            margin-top: 2em;
            padding: 1em;
            border-radius: 5px;
        }
        article img {
            height: 100%;
            max-height: 150px;
            width: auto;
            border-radius: 50%;
        }
        article a {
            font-size: 20px;
            color: black;
            font-weight: bold;
            text-decoration: none;
        }
        article a:hover {
            color: red;
        }
        article .desc {
            font-size: 10px;
            color: gray;
        }

        section.add {
            margin-top: 5em;
            margin-bottom: 3em;
        }
        .add .g1, .add .g2 {
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
        .add label {
            display: block;
        }
        .add .previewImg {
            width: 100px;
            margin-left: 1em;
        }
        .add .g2 {
            display: flex;
        }
        .add #fileInput {
            display: none;
        }
    </style>
</head>
<body>
<div id="a">
    <ul class="aaa">
        <li align="center"><a href="#">首页</a></li>
        <li align="center"><a href="#">新闻</a></li>
        <li align="center"><a href="#">博问</a></li>
        <li align="center"><a href="#">专区</a></li>
        <li align="center"><a href="#">闪存</a></li>
        <li align="center"><a href="#">发现</a></li>
    </ul>
</div>
<div id="s">
    <ul>
        <li class="s1"><a href="#">首页</a></li>
        <li class="s1"><a href="#">我的收藏</a></li>
        <li class="s1"><a href="#">我的赞</a></li>
        <li><a href="#">热门博客</a></li>
        <li><a href="#">热门视频</a></li>
        <li><a href="#">最新博客</a></li>
    </ul>
</div>
<div id="d">
    <section class="add">
        <header>
            <h3>添加博客</h3>
        </header>
        <form action="${pageContext.request.contextPath}/post/add" method="post" enctype="multipart/form-data">
            <input id="fileInput" type="file" name="cover" accept="image/*">
            <label class="g1">
                <input name="title" placeholder="标题">
                <input name="author" placeholder="作者">
                <button>发表博客</button>
            </label>
            <div class="g2">
                <textarea name="content" placeholder="内容"></textarea>
                <img class="previewImg" src="${pageContext.request.contextPath}/img/mm.jpg" title="图片" alt="图片">
            </div>
        </form>
    </section>
    <section class="posts">
        <c:forEach items="${posts}" var="post">
            <article>
                <div>
                    <header>
                        <a Target="_blank" href="${pageContext.request.contextPath}/post?id=${post.id}">${post.title}</a>
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

