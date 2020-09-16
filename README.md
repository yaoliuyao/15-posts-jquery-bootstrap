# Posts

## 基本要求

- 根据之前的需求分析，填充未完成的代码
- 让业务在 Tomcat 中能够 **正常** 运行
- 使用 [Apache DBUtils](https://mvnrepository.com/search?q=dbutils) 来处理数据库

## 业务简介

- 首页能显示 Post 的列表
- 首页的底部有一个 form 表单，通过它可以发布新的 Post
- 点击 Post 可以进行详情页面
- 在 Post 详情页面的下面，可以查看评论
- 在评论的最后，有一个 form 表单，可以用来发表新的评论

## 问题

- DBUtils 该怎么去使用？
- DataSource 不需要管，直接使用 Connection
    ```
      Connection conn = getConnection(); // 成本太高
      conn.close();
    ```
## 接下来的任务

#### 为新增博客，添加图片上传功能
#### 将整个项目使用 ajax 进行重构
#### 使用 jQuery 将整个项目进行重构
#### 使用 bootstrap 将所有样式进行重构
#### 增加分页等其他功能