<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>我的博客</title>
    <style>
        section {
            margin: 0 auto;
            width: 600px;
        }
        article {
            margin-bottom: 1em;
            padding: 1em;
            box-shadow: 0 0 3px #999;
        }
        article > header {
            font-weight: bold;
            border-bottom: 1px dotted #999999;
        }
        article > footer {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>
    <header>
        <h3>我的博客</h3>
    </header>

    <section class="posts">
        <c:forEach items="${posts}" var="post">
            <article>
                <header><a href="${pageContext.request.contextPath}/post?id=${post.id}">${post.title}</a></header>
                <div>
                    <p>
                        ${post.content}
                    </p>
                </div>
                <footer>
                    <p>${post.author}</p>
                    <p>${post.created}</p>
                </footer>
            </article>
        </c:forEach>
    </section>

    <section class="add">
        <header>
            <h3>添加博客</h3>
        </header>
        <form action="${pageContext.request.contextPath}/post/add" method="post">
            <input name="author" placeholder="作者">
            <input name="title" placeholder="标题">
            <input name="content" placeholder="内容">
            <button>发表博客</button>
        </form>
    </section>

</body>
</html>
