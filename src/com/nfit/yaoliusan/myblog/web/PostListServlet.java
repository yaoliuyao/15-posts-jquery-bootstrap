package com.nfit.yaoliusan.myblog.web;


import com.google.gson.Gson;
import com.nfit.yaoliusan.myblog.bean.Post;
import com.nfit.yaoliusan.myblog.dao.PostDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/posts")
public class PostListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PostDAO dao = new PostDAO();
        try {
            List<Post> posts = dao.getAllPosts();
            PrintWriter writer = resp.getWriter();
            String json = new Gson().toJson(posts);
            writer.write(json);
        } catch (Exception e) {
            PrintWriter writer = resp.getWriter();
            writer.write(1);
        }
    }
}
