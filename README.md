# Posts (异步请求, AJAX)

## 什么是 AJAX

Asynchronous Javascript And XML，异步的 JS 和 XML。

## 为什么要有 AJAX

传统上，网页进行交互:
- a 超链接 + form 表单
- http 请求，基于 request/response，刷新页面
- 每次请求结束，会刷新整个页面。这种行为有可能会打断当前页面的浏览状态 (看视频)
- 每次加载页面，会要么看不见，要么全看见，页面的卡顿感非常严重

所以，就出现了很多的技术解决上述的 **用户体验** 的问题:
- iframe 方案
- IE 上面的一些私有方案
- 最后，胜出并成为标准的是 AJAX

所以，AJAX 就是为了解决:
- 让页面能够逐步、分次加载
- 让请求能够局部刷新页面，防止页面状态被打断

## 基本的使用步骤

```js
// 发送异步请求
document.querySelector(".comment-form button").addEventListener('click', () => {
    // 拿到我们要发送的内容
    var pinglun = document.querySelector(".comment-form input").value;

    // 创建一个异步请求的对象
    var xhr = new XMLHttpRequest();
    // 设置使用 Post 方法进行提交，并且设置请求的 url
    xhr.open("POST", "${pageContext.request.contextPath}/ajax/video");
    // 设置发送数据的格式为 aaa=1&bbb=2 的格式
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    // 注册事件 (委托浏览器在请求结束的时候触发这个逻辑)
    xhr.onload = function (e) {
        document.querySelector(".comments")
            .insertAdjacentHTML("afterbegin", this.responseText);
        document.querySelector(".comment-form input").value = "";
    };
    // 开始发送请求！
    xhr.send("pinglun=" + pinglun);
});
```

## [例] 实现分步加载的核心代码

页面端:
```html
<section class="comments">
    <img class="loading" src="${pageContext.request.contextPath}/img/loading.svg">
</section>
```

使用 JS 的方式填充内容:
```js
function loadComments(postid) {
    // 创建
    var xhr = new XMLHttpRequest();
    // 设置
    xhr.open("GET", "/comments?" + "postid=" + postid);
    xhr.onload = function (e) {
        document.querySelector(".comments").innerHTML = this.responseText;
    };
    // 发送
    xhr.send(null);
}

loadComments(${post.id});
```

后台的逻辑，一如既往:
```java
@WebServlet("/comments")
public class CommentListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int postid = Integer.parseInt(req.getParameter("postid"));
        try {
            CommentDAO commentDAO = new CommentDAO();
            List<Comment> comments = commentDAO.getCommentsByPostId(postid);
            req.setAttribute("comments", comments);
            // req.setAttribute("comments", new CommentDAO().getCommentsByPostId(postid));
            req.getRequestDispatcher("/jsp/comments.jsp").forward(req, resp);
        } catch (Exception e) {
            PrintWriter writer = resp.getWriter();
            writer.write("<div class='error'>Load failed.</div>");
        }
    }
}
```

## 接下来的任务
#### 使用 jQuery 将整个项目进行重构
#### 使用 bootstrap 将所有样式进行重构
#### 增加分页等其他功能
#### MVVM: Vue.js/ReactJS.js/AngularJS
