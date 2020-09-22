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
            margin-left: 300px;

        }

        #s {
            float: left;
            width: 180px;
            height: 530px;
            background: #eeeeee;
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

        section {
            margin: 0 auto;
            width: 600px;

        }

        article {
            margin-bottom: 1em;
            padding: 1em;
            box-shadow: 0 0 3px #999;
            background-color: white;
            border-radius: 10px;
        }

        #z {
            font-size: 20px;
            color: black;
            font-weight: bold;
            text-decoration: none;
        }

        #z:hover {
            color: red;
        }

        span {
            font-size: 12px;
            color: gray;
        }

        #z2 {
            font-size: 10px;
            color: gray;
        }
    </style>
</head>
<body>
<div id="a">
    <div class="a1">

    </div>
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
        <li><a href="#">好友圈</a></li>
        <li><a href="#">特别关注</a></li>
        <li><a href="#">专属博客</a></li>
        <li><a href="#">群博客</a></li>
    </ul>
</div>
<div id="d">
    <section class="add">
        <header>
            <h3>添加博客</h3>
        </header>
        <form action="${pageContext.request.contextPath}/post/add" method="post">
            <div>
                <input name="author" placeholder="作者">
                <input name="title" placeholder="标题">
            </div>
            <div>
                <textarea name="content" placeholder="内容">
                </textarea>
            </div>
            <div>
                <button>发表博客</button>
            </div>
        </form>
    </section>
    <section class="posts">
        <c:forEach items="${posts}" var="post">
            <article>
                <a Target="_blank" href="${pageContext.request.contextPath}/post?id=${post.id}" id="z">${post.title}</a>
                <p id="z2"><span>来自${post.author}</span> <br>${post.created} </p>
                <p id="z3"> ${post.content} </p>
            </article>
        </c:forEach>
    </section>
</div>
</body>
</html>

