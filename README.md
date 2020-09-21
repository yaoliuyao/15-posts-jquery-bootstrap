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

## 问题反馈
#### DBUtils 该怎么去使用？

看代码，看示例。

#### DataSource 是啥?

暂时不需要管，直接使用 Connection。

```
  Connection conn = getConnection(); // 成本太高
  conn.close();
```

#### 如何排查数据库连接问题

基本步骤:
1. 数据库服务有没有正常开启  1433
2. 确定使用 smss 能不能正常连接上 sa/sa
3. jdbc 驱动是否有问题
4. 连接字符串有没有问题

无法连接 1433 端口的问题:
- 怀疑问题:
  1. 数据库服务是否正常开启
  2. 设置相应端口
- 确定端口是否正常监听
  + 打开 `cmd` 窗口
  + 查看所有连接: `netstat -ano`
  + 查看所有监听的连接: `netstat -ano | findstr "LISTE"`
  + 查看所有 143 开始的端口: `netstat -ano | findstr 143`
  
#### 如何渲染评论

comment
- id
- created 

-------------

热门评论:
- `select top 5 * from comment where ? order by clicks;`

历史评论:
- `select * from comment where ? order by id desc;`
- `select top 10 * from comment where ? order by created desc;`

## 接下来的任务
#### 为新增博客，添加图片上传功能
#### 将整个项目使用 ajax 进行重构
#### 使用 jQuery 将整个项目进行重构
#### 使用 bootstrap 将所有样式进行重构
#### 增加分页等其他功能
#### MVVM: Vue.js/ReactJS.js/AngularJS
