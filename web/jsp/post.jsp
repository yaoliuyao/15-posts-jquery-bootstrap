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
            width: 75vw;
            margin: 0 auto;
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

        .comments > .loading {
            display: block;
            width: 90px;
            margin: 0 auto;
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
        <img class="loading" src="${pageContext.request.contextPath}/img/loading.svg">
    </section>

    <section class="comment-form">
        <label>
            <span>姓名</span>
            <input class="author" name="author">
        </label>
        <label>
            <span>评论内容</span>
            <textarea class="cont" name="content"></textarea>
        </label>
        <div>
            <button>提交评论</button>
        </div>
    </section>
</div>

<script>
    // 加载列表

    function loadComments(postid) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "${pageContext.request.contextPath}/comments?" + "postid=" + postid);
        xhr.onload = function (e) {
            if (this.status === 200) {
                var comments = JSON.parse(this.responseText);
                console.log(comments);
                var result = "";
                for (var i = 0; i < comments.length; i++) {
                    result += "<div class='comment'>";
                    result += "<header>" +comments[i].author + "</header>";
                    result += "<p>" +comments[i].content + "</p>";
                    result += "</div>";
                }
                document.querySelector(".comments").innerHTML = result;
            } else {
                document.querySelector(".comments").innerHTML = "<p>加载失败</p>";
            }
        };
        xhr.send(null);
    }

    loadComments(${post.id});

    // 提交评论

    function submitComment() {
        var author = document.querySelector(".comment-form .author");
        var content = document.querySelector(".comment-form .cont");

        // 将需要的数据封装到 FormData 对象
        var formData = new FormData();
        formData.append("postid", ${post.id});
        formData.append("author", author.value);
        formData.append("content", content.value);

        // 发送请求
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "${pageContext.request.contextPath}/comment/add");
        xhr.onload = function () {
            loadComments(${post.id});
            window.scrollTo(0, 0);
            author.value = "";
            content.value = "";
        }
        xhr.send(formData);
    }

    document.querySelector(".comment-form button").addEventListener('click', submitComment);
</script>

</body>
</html>
