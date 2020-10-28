# Posts (jQuery + ajax)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Posts (jQuery + ajax)](#posts-jquery--ajax)
    - [jQuery](#jquery)
    - [Bootstrap](#bootstrap)
    - [接下来的任务](#接下来的任务)
        - [增加分页等其他功能](#增加分页等其他功能)
        - [MVVM: Vue.js/ReactJS.js/AngularJS](#mvvm-vuejsreactjsjsangularjs)

<!-- markdown-toc end -->

## 首先，对页面进行设计

## 其次，使用 bootstrap 完成页面布局

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我的博客</title>
    <!-- 提供基本的样式、布局、组件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">

    <!-- 提供额外的，跟交互有关的组件功能，弹出层、tab 页切换 -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <style>
        .wrapper {
            margin-top: 80px;
        }
        .hot-tags, .hot-posts {
            border: 1px solid grey;
            height: 100px;
            padding: 1em;
            margin-top: 1em;
            margin-bottom: 2em;
        }
        .others {
            margin-top: 1em;
            padding-top: 2em;
            min-height: 80px;
            background: #eeeeee;
        }
        .posts {
            padding-right: 2em;
        }
        .post-header {
            display: flex;
            align-items: center;
        }
        .post-header img {
            width: 100%;
        }
        .post {
            margin-bottom: 2em;
            padding-bottom: 2em;
            border-bottom: 1px solid #eee;
        }
        .post-footer {
            margin-top: 1em;
        }
        #addPostModal img {
            width: 100%;
        }
    </style>
</head>
<body>

<section>
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">My Private Blog</a>
        </div>

        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">分类 <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="http://baidu.com">学习</a></li>
                        <li><a href="#">娱乐</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#">未知</a></li>
                        <li><a href="#">琐事</a></li>
                    </ul>
                </li>
                <li><a href="#">标签</a></li>
                <li><a href="#">关于我们</a></li>
            </ul>
            <form class="navbar-form navbar-left" role="search">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Search">
                </div>
                <button type="submit" class="btn btn-default">搜索</button>
            </form>
            <ul class="nav navbar-nav navbar-right" style="padding-right: 1em">
                <li>
                    <a href="#">用户管理</a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="#" data-target="#addPostModal" data-toggle="modal">添加博客</a>
                </li>
            </ul>
        </div>
    </nav>
</section>
<section class="container wrapper">
    <div class="row">
        <div class="col-md-9 main">
            <div class="posts">
                <div class="post">
                    <div class="post-header row">
                        <div class="col-md-8">
                            <h3>特朗普说，他一定能当选</h3>
                            <p>
                                对特朗普来说，就没有不坏的规矩，所有正常的规则、规矩，他只要看着不太顺眼，立刻就像个破坏王一样砸烂。 刚刚，特朗普在联合国大会上又坏了一个规矩，他竟然为了一己私利，利用联合国的讲台，罔顾事实地编造谎言抹黑指责中国，这种行为可以说low到爆了！ 据媒体报道，在第75届联大一般性辩论会上，特朗普当着全世界多国领导人和国际组织的面，罔顾常识和事实，竟然直接称新冠病毒为“中国病毒”，甚至在讲话中用了很大篇幅在多个层面攻击中国，譬如抗疫、网络安全、生态、乃至海洋捕捞等等，时间长达7分钟。
                            </p>
                        </div>
                        <div class="col-md-4">
                            <img src="../img/mm2.jpg" class="img-thumbnail">
                        </div>
                    </div>
                    <div class="post-footer row">
                        <div class="col-md-1 post-author">张三</div>
                        <div class="col-md-3 post-time">发布于 <i>2001-10-23</i></div>
                        <div class="col-md-4"></div>
                        <div class="col-md-4">
                            <span class="post-like">点赞 (<i>10</i>) </span>
                            <span class="post-comment">评论 (<i>17</i>) </span>
                            <span class="post-share">分享 (<i>20</i>) </span>
                        </div>
                    </div>
                </div>
                <div class="post">
                    <div class="post-header row">
                        <div class="col-md-8">
                            <h3>特朗普说，他一定能当选</h3>
                            <p>
                                对特朗普来说，就没有不坏的规矩，所有正常的规则、规矩，他只要看着不太顺眼，立刻就像个破坏王一样砸烂。 刚刚，特朗普在联合国大会上又坏了一个规矩，他竟然为了一己私利，利用联合国的讲台，罔顾事实地编造谎言抹黑指责中国，这种行为可以说low到爆了！ 据媒体报道，在第75届联大一般性辩论会上，特朗普当着全世界多国领导人和国际组织的面，罔顾常识和事实，竟然直接称新冠病毒为“中国病毒”，甚至在讲话中用了很大篇幅在多个层面攻击中国，譬如抗疫、网络安全、生态、乃至海洋捕捞等等，时间长达7分钟。
                            </p>
                        </div>
                        <div class="col-md-4">
                            <img src="../img/mm2.jpg">
                        </div>
                    </div>
                    <div class="post-footer row">
                        <div class="col-md-1 post-author">张三</div>
                        <div class="col-md-3 post-time">发布于 <i>2001-10-23</i></div>
                        <div class="col-md-4"></div>
                        <div class="col-md-4">
                            <span class="post-like">点赞 (<i>10</i>) </span>
                            <span class="post-comment">评论 (<i>17</i>) </span>
                            <span class="post-share">分享 (<i>20</i>) </span>
                        </div>
                    </div>
                </div>
                <div class="post">
                    <div class="post-header row">
                        <div class="col-md-8">
                            <h3>特朗普说，他一定能当选</h3>
                            <p>
                                对特朗普来说，就没有不坏的规矩，所有正常的规则、规矩，他只要看着不太顺眼，立刻就像个破坏王一样砸烂。 刚刚，特朗普在联合国大会上又坏了一个规矩，他竟然为了一己私利，利用联合国的讲台，罔顾事实地编造谎言抹黑指责中国，这种行为可以说low到爆了！ 据媒体报道，在第75届联大一般性辩论会上，特朗普当着全世界多国领导人和国际组织的面，罔顾常识和事实，竟然直接称新冠病毒为“中国病毒”，甚至在讲话中用了很大篇幅在多个层面攻击中国，譬如抗疫、网络安全、生态、乃至海洋捕捞等等，时间长达7分钟。
                            </p>
                        </div>
                        <div class="col-md-4">
                            <img src="../img/mm2.jpg">
                        </div>
                    </div>
                    <div class="post-footer row">
                        <div class="col-md-1 post-author">张三</div>
                        <div class="col-md-3 post-time">发布于 <i>2001-10-23</i></div>
                        <div class="col-md-4"></div>
                        <div class="col-md-4">
                            <span class="post-like">点赞 (<i>10</i>) </span>
                            <span class="post-comment">评论 (<i>17</i>) </span>
                            <span class="post-share">分享 (<i>20</i>) </span>
                        </div>
                    </div>
                </div>
                <div class="post">
                    <div class="post-header row">
                        <div class="col-md-8">
                            <h3>特朗普说，他一定能当选</h3>
                            <p>
                                对特朗普来说，就没有不坏的规矩，所有正常的规则、规矩，他只要看着不太顺眼，立刻就像个破坏王一样砸烂。 刚刚，特朗普在联合国大会上又坏了一个规矩，他竟然为了一己私利，利用联合国的讲台，罔顾事实地编造谎言抹黑指责中国，这种行为可以说low到爆了！ 据媒体报道，在第75届联大一般性辩论会上，特朗普当着全世界多国领导人和国际组织的面，罔顾常识和事实，竟然直接称新冠病毒为“中国病毒”，甚至在讲话中用了很大篇幅在多个层面攻击中国，譬如抗疫、网络安全、生态、乃至海洋捕捞等等，时间长达7分钟。
                            </p>
                        </div>
                        <div class="col-md-4">
                            <img src="../img/mm2.jpg">
                        </div>
                    </div>
                    <div class="post-footer row">
                        <div class="col-md-1 post-author">张三</div>
                        <div class="col-md-3 post-time">发布于 <i>2001-10-23</i></div>
                        <div class="col-md-4"></div>
                        <div class="col-md-4">
                            <span class="post-like">点赞 (<i>10</i>) </span>
                            <span class="post-comment">评论 (<i>17</i>) </span>
                            <span class="post-share">分享 (<i>20</i>) </span>
                        </div>
                    </div>
                </div>
                <div class="post">
                    <div class="post-header row">
                        <div class="col-md-8">
                            <h3>特朗普说，他一定能当选</h3>
                            <p>
                                对特朗普来说，就没有不坏的规矩，所有正常的规则、规矩，他只要看着不太顺眼，立刻就像个破坏王一样砸烂。 刚刚，特朗普在联合国大会上又坏了一个规矩，他竟然为了一己私利，利用联合国的讲台，罔顾事实地编造谎言抹黑指责中国，这种行为可以说low到爆了！ 据媒体报道，在第75届联大一般性辩论会上，特朗普当着全世界多国领导人和国际组织的面，罔顾常识和事实，竟然直接称新冠病毒为“中国病毒”，甚至在讲话中用了很大篇幅在多个层面攻击中国，譬如抗疫、网络安全、生态、乃至海洋捕捞等等，时间长达7分钟。
                            </p>
                        </div>
                        <div class="col-md-4">
                            <img src="../img/mm2.jpg">
                        </div>
                    </div>
                    <div class="post-footer row">
                        <div class="col-md-1 post-author">张三</div>
                        <div class="col-md-3 post-time">发布于 <i>2001-10-23</i></div>
                        <div class="col-md-4"></div>
                        <div class="col-md-4">
                            <span class="post-like">点赞 (<i>10</i>) </span>
                            <span class="post-comment">评论 (<i>17</i>) </span>
                            <span class="post-share">分享 (<i>20</i>) </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 aside">
            <div class="hot-tags">
                热门标签
            </div>
            <div class="hot-posts">
                点击排行
            </div>
        </div>
    </div>
</section>
<section class="others">
    <p class="text-center">
        版权所有: 南方 IT 学院 163 班
    </p>
</section>

<div class="modal fade" id="addPostModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加博客</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-8">
                        <form>
                            <div class="form-group">
                                <label for="post-title">标题</label>
                                <input type="text" class="form-control" id="post-title" placeholder="请输入标题">
                            </div>
                            <div class="form-group">
                                <label for="post-content">内容</label>
                                <textarea class="form-control" id="post-content" placeholder="请输入内容"></textarea>
                            </div>
                            <div class="form-group" style="display: none">
                                <input type="file" id="post-cover">
                            </div>
                        </form>
                    </div>
                    <div class="col-md-4">
                        <img src="../img/mm.jpg">
                        <p>
                            请点击选择图片
                        </p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
```


## jQuery

$.xxx;

## Bootstrap

class="col-md-3"

## 接下来的任务
### 增加分页等其他功能
### MVVM: Vue.js/ReactJS.js/AngularJS
