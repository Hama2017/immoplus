package sn.kd.immoplus.controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sn.kd.immoplus.model.User;
import sn.kd.immoplus.service.UserService;
import sn.kd.immoplus.service.UserServiceImpl;

import java.io.IOException;

@WebServlet("/owner")
public class OwnerController extends HttpServlet {

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
            // Afficher le formulaire d'inscription
            request.setAttribute("action", "dashboard");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        }
        //     else if (action.equals("login")) {
//            // Afficher le formulaire de connexion
//            request.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(request, response);
//        } else if (action.equals("profile")) {
//            // Afficher le profil du locataire
//            User user = (User) request.getSession().getAttribute("user");
//            request.setAttribute("user", user);
//            request.getRequestDispatcher("/WEB-INF/views/edit-profil.jsp").forward(request, response);
//        }
    }



}
