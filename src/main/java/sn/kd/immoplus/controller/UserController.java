package sn.kd.immoplus.controller;

import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import sn.kd.immoplus.model.User;
import sn.kd.immoplus.service.UserService;
import sn.kd.immoplus.service.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

@WebServlet("/user")
public class UserController extends HttpServlet {

    private UserService userService = new UserServiceImpl();


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String uri = request.getRequestURI();
        String[] parts = uri.split("/");
        String controllerName = parts[parts.length - 1];
        request.setAttribute("controllerName", controllerName);

        if (action == null) {
            // Afficher la page d'accueil du locataire
            request.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(request, response);
        } else if (action.equals("register")) {
            // Afficher le formulaire d'inscription
            request.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(request, response);
        } else if (action.equals("login")) {
            // Afficher le formulaire de connexion
            request.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(request, response);
        } else if (action.equals("profile")) {
            // Afficher le profil du locataire
            User user = (User) request.getSession().getAttribute("user");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("register")) {

            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            User user = new User();
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setPassword(hashedPassword);  // Set the hashed password            user.setAddress(address);
            user.setPhoneNumber(phoneNumber);
            user.setAddress(address);
            user.setRole("tenant");
            user.setStatus(1);
            user.setDateCreated(new Date());


            // Vérifier si l'email existe déjà
            if (userService.emailExists(email)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"error\": true, \"message\": \"Cet email est déjà utilisé pour un compte.\"}");
                out.flush();
                return;
            }

            userService.save(user);

            // Envoyer une réponse JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"success\": true, \"message\": \"User registered successfully\"}");
            out.flush();
        } else if (action.equals("login")) {

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User user = userService.findByEmail(email);  // Assurez-vous que cette méthode existe dans votre UserService

            if (user != null && BCrypt.checkpw(password, user.getPassword())) {
                // Login successful
                // Set user information in session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Redirect based on user role
                String role = user.getRole();

                // Send success response
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_OK);
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"success\": true, \"message\": \""+role+"\"}");
                out.flush();

            } else {
                // Login failed
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            }

        }
    }

}
