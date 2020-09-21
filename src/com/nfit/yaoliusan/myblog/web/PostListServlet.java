package com.nfit.yaoliusan.myblog.web;


import com.nfit.yaoliusan.myblog.bean.Post;
import com.nfit.yaoliusan.myblog.dao.PostDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/posts")
public class PostListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PostDAO dao = new PostDAO();
        try {
            List<Post> posts = dao.getAllPosts();
            req.setAttribute("posts", posts);
            req.getRequestDispatcher("/jsp/posts.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace(); // 这个纯粹打印，不是真正的异常处理
            req.setAttribute("error", e.getLocalizedMessage());
            req.getRequestDispatcher("/jsp/error.jsp").forward(req, resp);
        }
    }
}
