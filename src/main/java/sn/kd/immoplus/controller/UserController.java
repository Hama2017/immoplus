package sn.kd.immoplus.controller;

import sn.kd.immoplus.model.User;
import sn.kd.immoplus.service.UserService;
import sn.kd.immoplus.service.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/user")
public class UserController extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = userService.findAll();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/WEB-INF/views/user.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        User user = new User();
        user.setFirstName(name);
        userService.save(user);
        resp.sendRedirect(req.getContextPath() + "/user");
    }
}
