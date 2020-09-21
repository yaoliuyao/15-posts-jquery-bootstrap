package com.nfit.yaoliusan.myblog.web;


import com.nfit.yaoliusan.myblog.bean.Comment;
import com.nfit.yaoliusan.myblog.bean.Post;
import com.nfit.yaoliusan.myblog.dao.CommentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/comment/add")
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
            // 返回页面:
            // resp.sendRedirect();
            // req.getRequestDispatcher().forward();
            resp.sendRedirect(req.getContextPath() + "/post?id=" + postId);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", e.getLocalizedMessage());
            req.getRequestDispatcher("/jsp/error.jsp").forward(req, resp);
        }
    }
}
