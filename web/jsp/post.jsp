<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${post.title}</title>
</head>
<body>

<section class="post">
    <header>
        <h3>${post.title}</h3>
    </header>
    <div>
        <p>
            ${post.content}
        </p>
    </div>
</section>

<section class="comments">
    <c:forEach items="${comments}" var="comment" varStatus="s">
        <%-- 渲染评论列表 --%>
        <div>
            TOP${s.count}：${comment.author}
        </div>
        <div>
            <p>
                ${comment.content}
            </p>
        </div>
        <div id="time">
            <span id="timeP">
                ${comment.created}
            </span>
        </div>
    </c:forEach>
</section>

<section class="comment_form">
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
</body>
</html>
