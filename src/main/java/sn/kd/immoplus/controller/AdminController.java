package sn.kd.immoplus.controller;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sn.kd.immoplus.model.User;
import sn.kd.immoplus.service.UserService;
import sn.kd.immoplus.service.UserServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminController extends HttpServlet {

    private UserService userService = new UserServiceImpl();


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String uri = request.getRequestURI();
        String[] parts = uri.split("/");
        String controllerName = parts[parts.length - 1];
        request.setAttribute("controllerName", controllerName);
        if (action == null) {
        }
        else if (action.equals("dashboard")) {
            request.setAttribute("action", "dashboard");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        }
        else if (action.equals("userManage")) {
            request.setAttribute("action", "userManage");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        }else if (action.equals("rapports")) {
            request.setAttribute("action", "rapports");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        }else if (action.equals("configurations")) {
            request.setAttribute("action", "configurations");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        }
        else if (action.equals("getUsers")) {
            List<User> users = userService.findAll();
            String jsonUsers = new Gson().toJson(users);
            response.setContentType("application/json");
            response.getWriter().write(jsonUsers);
        }
    }



}
