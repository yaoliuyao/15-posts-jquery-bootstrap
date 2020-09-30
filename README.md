# Posts (异步请求, AJAX)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Posts (异步请求, AJAX)](#posts-异步请求-ajax)
    - [什么是 AJAX](#什么是-ajax)
    - [为什么要有 AJAX](#为什么要有-ajax)
    - [基本的使用步骤](#基本的使用步骤)
    - [[例] 实现分步加载的核心代码](#例-实现分步加载的核心代码)
    - [[例] 实现刷新局部页面的核心代码](#例-实现刷新局部页面的核心代码)
    - [[例] 将 loadComments 进行重构，直接返回 JSON 数据](#例-将-loadcomments-进行重构直接返回-json-数据)
    - [[例] 将博客上传更改为 Ajax 方式 (文件的上传)](#例-将博客上传更改为-ajax-方式-文件的上传)
    - [[例] 删除跟点赞](#例-删除跟点赞)
    - [当前小结: AJAX 相关的 API](#当前小结-ajax-相关的-api)
    - [JSON 简介](#json-简介)
    - [接下来的任务](#接下来的任务)
        - [使用 jQuery 将整个项目进行重构](#使用-jquery-将整个项目进行重构)
        - [使用 bootstrap 将所有样式进行重构](#使用-bootstrap-将所有样式进行重构)
        - [增加分页等其他功能](#增加分页等其他功能)
        - [MVVM: Vue.js/ReactJS.js/AngularJS](#mvvm-vuejsreactjsjsangularjs)

<!-- markdown-toc end -->


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
    xhr.open("GET", "${pageContext.request.contextPath}/comments?" + "postid=" + postid);
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

## [例] 实现刷新局部页面的核心代码

页面端，可以不需要 form 标签:
```html
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
```

使用 JS 进行异步提交，并只刷新评论区域:
```js
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
```

后台代码做相应修改 (注意，这里忽略了异常处理):
```java
public class CommentAddServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String postId = req.getParameter("postid");
        String author = req.getParameter("author");
        String content = req.getParameter("content");
        try {
            Post post = new Post();
            post.setId(Long.parseLong(postId));
            new CommentDAO().addComment(new Comment(content, author, post));
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("添加评论出错");
        }
    }
}
```

## [例] 将 loadComments 进行重构，直接返回 JSON 数据

前端:
```js
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
```

后台:
```java
@WebServlet("/comments")
public class CommentListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int postid = Integer.parseInt(req.getParameter("postid"));
        try {
            CommentDAO commentDAO = new CommentDAO();
            List<Comment> comments = commentDAO.getCommentsByPostId(postid);
            PrintWriter writer = resp.getWriter();
            writer.write(new Gson().toJson(comments));
        } catch (Exception e) {
            PrintWriter writer = resp.getWriter();
            writer.write("<div class='error'>Load failed.</div>");
        }
    }
}
```
## [例] 将博客上传更改为 Ajax 方式 (文件的上传)

前端:
```js
document.querySelector("button.submit-post").addEventListener('click', () => {
    var fileInput = document.querySelector(".form .file-input");
    var title = document.querySelector(".form .title");
    var author = document.querySelector(".form .author");
    var content = document.querySelector(".form .cont");

    // 组装数据
    var formData = new FormData();
    formData.append("cover", fileInput.files[0]); // type=file
    formData.append("title", title.value);
    formData.append("author", author.value);
    formData.append("content", content.value);

    // 发送请求
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "${pageContext.request.contextPath}/post/add");
    xhr.onload = function (ev) {
        var id = this.responseText;
        if (id === "-1") {
            alert("添加失败!");
        } else {
            alert("添加成功！");
            window.location.href="${pageContext.request.contextPath}/post?id=" + id;
        }
    };
    xhr.send(formData);

    // 清理工作
    fileInput.value = "";
    content.value = "";
    title.value = "";
    author.value = "";
});
```

后台:
```java
@WebServlet("/post/add")
@MultipartConfig
public class PostAddServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String author = req.getParameter("author");
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        Part cover = req.getPart("cover");
        try {
            // 将图片保存，并获取其路径名
            String coverPath = "/img/" + System.currentTimeMillis() + "-" + cover.getSubmittedFileName();
            cover.write(getServletContext().getRealPath("/") + coverPath);

            // 所有信息入库
            PostDAO postDAO = new PostDAO();
            Post post = postDAO.addPost(new Post(title, content, author, coverPath));

            // 跳转到详情页面更合理
            resp.getWriter().print(post.getId());
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().print("-1");
        }
    }
}
```

## [例] 删除跟点赞

请查看代码。

## 当前小结: AJAX 相关的 API

XmlHttpRequest:
```js
// 符合标准的语法
var xhr = new XmlHttpRequest();

// 旧的，兼容性的创建写法。因此出现了 jQuery 等框架
var xhr=new xhr();
function xhr(){
    if(window.XMLHttpRequest) {
       return window.XMLHttpRequest()
    } else if (window.ActiveXObject) {
       try {
         return new ActiveObject("Microsoft.XMLHTTP")
       } catch(e) {
           try {
             return new ActiveObject("Msxml2.XMLHTTP")
           } catch(e) {
           }
       }
  }
}

```

属性:
- `xhr.status/statusText` 返回码/返回描述。20X 表示成功，404 页面没找到，500 表示服务端异常
- `xhr.responseType='json'`
- `xhr.response` 返回的内容。返回的类型跟 responseType 匹配的
- `xhr.responseText/responseXML` responseText 返回的就是原始的字符串
- `xhr.readyState` 返回的是当前 xhr 请求的进度
- `xhr.timeout=10` 设置超时的时间
- `xhr.withCredentials` 后面再学，跨域

方法:
- `xhr.open(METHOD, URL, 是否要进行异步请求)` 打开一个[异步]请求的连接
- `xhr.send(data|null)` 发送数据
- `xhr.abort()` 将当前的异步请求停掉
- `xhr.getResponseHeader()/setResponseHeader()` 获取或者设置请求的头部

事件:
- `onreadystatechange` 每次请求的状态发生变化的时候触发
- `onload/onerror/ontimeout` 请求结束的各种状态
- `onloadstart/onloadend` 注意 onloadend 和 onload
- `onprogress/xhr.upload.ongprogress` 下载、上传的进度条

注意一点:
- 如果服务器返回的是 404 的结果，那么 onload/status==404
- onerror 捕获的是请求本身出问题了，比如说网络中断

下面两种写法是等价的:
```js
xhr.onreadystatechange = function (e) {
   if (this.readyState === 4) { // 4 表示请求结束
       document.querySelector(".comments").innerHTML = this.responseText;
   }
}

xhr.onload = function(e) {
   document.querySelector(".comments").innerHTML = this.responseText;
}
```

## JSON 简介

JavaScript Object Notation。

将 Java 对象跟 Json 字符串进行互相转换的 jar 包:
- jackson
- fastjson
- gson (`String 字符串 = new Gson().toJSON(对象)`)

在浏览器端，将 JSON 字符串跟 JS 对象进行互相转换的 API:
- `JSON.parse(字符串)` 将字符串转换为对象
- `JSON.stringify(对象)` 将对象转换为字符串

## 接下来的任务
### 使用 jQuery 将整个项目进行重构
### 使用 bootstrap 将所有样式进行重构
### 增加分页等其他功能
### MVVM: Vue.js/ReactJS.js/AngularJS
