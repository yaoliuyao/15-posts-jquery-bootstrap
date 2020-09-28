<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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