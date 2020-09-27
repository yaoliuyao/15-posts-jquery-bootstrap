<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${post.title}</title>
    <style>
        h3 {
            position: sticky;
            top: 0;
            background: white;
            padding: 10px 3em;
        }
        h3 a {
            text-decoration: none;
            color: green;
        }

        .main {
            width: 75vw;
            margin: 1em auto;
        }

        .post {
            display: flex;
        }
        .post img {
            width: 80px;
            height: 80px;
            margin-right: 1em;
            border: 3px solid gray;
        }
        .post footer {
            display: flex;
            justify-content: flex-end;
        }
        .post footer a {
            text-decoration: none;
            padding: 6px 12px;
        }

        .comments {
            margin-top: 2em;
            margin-bottom: 2em;
        }
        .comment {
            margin-bottom: 1em;
            padding: 1em;
            box-shadow: 0 0 3px grey;
        }
        .comment header, .comment footer {
            color: #999999;
        }

        label {
            display: flex;
            width: 300px;
            margin-bottom: 1em;
        }
        label > span {
            flex: 0 0 100px;
        }
        label > input, label > textarea {
            width: 100%;
        }
    </style>
</head>
<body>

<h3><a href="${pageContext.request.contextPath}/posts">${post.title}</a></h3>

<div class="main">
    <section class="post">
        <div>
            <img src="${pageContext.request.contextPath}/img/mm.jpg" alt="头像" title="头像">
        </div>
        <div>
            <div>
                ${post.content}
            </div>
            <footer>
                <a href="">回复</a>
                <a href="">点赞</a>
                <a href="">举报</a>
                <a href="">分享</a>
            </footer>
        </div>
    </section>

    <section class="comments">
        <c:forEach items="${comments}" var="comment" varStatus="s">
            <div class="comment">
                <header>
                    第 ${s.count} 楼：${comment.author}
                </header>
                <p>
                    ${comment.content}
                </p>
                <footer id="time">
                    ${comment.created}
                </footer>
            </div>
        </c:forEach>
    </section>

    <section class="comment-form">
        <form method="post" action="${pageContext.request.contextPath}/comment/add">
            <input type="hidden" name="postid" value="${post.id}">
            <label>
                <span>姓名</span>
                <input name="author">
            </label>
            <label>
                <span>评论内容</span>
                <textarea name="content"></textarea>
            </label>
            <div>
                <button>提交评论</button>
            </div>
        </form>
    </section>
</div>
</body>
</html>
