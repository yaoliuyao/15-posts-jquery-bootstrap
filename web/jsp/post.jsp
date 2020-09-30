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
        .comment > header {
            display: flex;
            justify-content: space-between;
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
                <a href="" class="like-it">点赞 (<span class="num">${post.likes}</span>)</a>
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
                    result += "<header>" +
                        "<span>" +comments[i].author + "</span>" +
                        "<i class='del' onclick='doDelComment(" + comments[i].id + ")'>删除</i></header>";
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

    // 删除评论

    function doDelComment(id) {
        if (window.confirm("你是不是要删除 id 为 " + id + " 的评论?")) {
            var xmlHttpRequest = new XMLHttpRequest();
            xmlHttpRequest.open("GET", "${pageContext.request.contextPath}/comment/del?id=" + id);
            xmlHttpRequest.onload = function (ev) {
                var res = this.responseText;
                if (this.responseText === "-1") {
                    alert("删除失败");
                } else {
                    alert("删除成功");
                    loadComments(${post.id});
                }
            };
            xmlHttpRequest.send(null);
        }
    }

    // 点赞

    document.querySelector(".like-it").addEventListener('click', (ev) => {
        ev.preventDefault(); // 禁止原先的跳转功能
        var xmlHttpRequest = new XMLHttpRequest();
        xmlHttpRequest.open("GET", "${pageContext.request.contextPath}/post/like?id=${post.id}");
        xmlHttpRequest.onload = function () {
            if (this.responseText !== "-1") {
                var node = document.querySelector(".like-it .num");
                node.innerText = parseInt(node.innerText) + 1;
            }
        }
        xmlHttpRequest.send(null);
    });
</script>

</body>
</html>
