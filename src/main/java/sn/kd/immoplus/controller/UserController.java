package sn.kd.immoplus.controller;

import com.google.gson.Gson;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import sn.kd.immoplus.model.Notification;
import sn.kd.immoplus.model.User;
import sn.kd.immoplus.service.NotificationService;
import sn.kd.immoplus.service.NotificationServiceImpl;
import sn.kd.immoplus.service.UserService;
import sn.kd.immoplus.service.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

@WebServlet("/user")
public class UserController extends HttpServlet {

    private UserService userService = new UserServiceImpl();
    private NotificationService notificationService = new NotificationServiceImpl();


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
            request.getRequestDispatcher("/WEB-INF/views/edit-profil.jsp").forward(request, response);
        } else if (action.equals("getUsers")) {
            List<User> users = userService.findAll();
            String jsonUsers = new Gson().toJson(users);
            response.setContentType("application/json");
            response.getWriter().write(jsonUsers);
        } else if (action.equals("findUserById")) {
            int userId = Integer.parseInt(request.getParameter("id"));
            User user = userService.findById(userId);
            String jsonUser = new Gson().toJson(user);
            response.setContentType("application/json");
            response.getWriter().write(jsonUser);
        } else if (action.equals("editUser")) {
            int userId = Integer.parseInt(request.getParameter("id"));
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            int status = request.getParameter("status") != null ? Integer.parseInt(request.getParameter("status")) : 0;
            System.out.println("userId: " + userId);
            System.out.println("firstName: " + firstName);
            System.out.println("status: " + status);


            User user = userService.findById(userId);
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setAddress(address);
            user.setPhoneNumber(phoneNumber);
            user.setEmail(email);
            user.setRole(role);
            user.setStatus(status);

            userService.update(user);

            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson("success"));
        } else if (action.equals("edit-profil")) {
            request.setAttribute("action", "edit-profil");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        } else if (action.equals("logout")) {
            HttpSession session = request.getSession();
            session.invalidate();
            request.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(request, response);
        } else if (action.equals("listNotifications")) {
            User user = (User) request.getSession().getAttribute("user");
            request.setAttribute("user", user);
            request.setAttribute("action", "listNotifications");

            if (request.getParameter("idNotification") != null) {
                int notificationId = Integer.parseInt(request.getParameter("idNotification"));
                notificationService.markAsRead(notificationId);
            }

            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        } else if ("getNotifications".equals(action)) {
            int userId = ((User) request.getSession().getAttribute("user")).getId();
            List<Notification> notifications = notificationService.getNotificationsByUserId(userId);
            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(notifications));
        } else if ("viewedNotification".equals(action)) {
            int notificationId = Integer.parseInt(request.getParameter("idNotification"));
            notificationService.markAsRead(notificationId);
            response.sendRedirect("user?action=listNotifications");
        } else if ("deleteNotification".equals(action)) {
            int notificationId = Integer.parseInt(request.getParameter("idNotification"));
            Notification notification = notificationService.findById(notificationId);
            notificationService.deleteNotification(notification);
            response.sendRedirect("user?action=listNotifications");
        } else if ("deleteAllNotificationUser".equals(action)) {
            int userId = ((User) request.getSession().getAttribute("user")).getId();
            notificationService.deleteAllNotificationsByUserId(userId);
            response.sendRedirect("user?action=listNotifications");
        } else if ("getUnreadNotificationsCount".equals(action)) {
            int userId = ((User) request.getSession().getAttribute("user")).getId();
            int unreadCount = notificationService.getUnreadNotificationsCount(userId);
            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(unreadCount));
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
            user.setRole("locataire");
            user.setStatus(1);

            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy");
            LocalDate localDate = LocalDate.now();

            user.setDateCreated(dtf.format(localDate));


            // Vérifier si l'email existe déjà
            if (userService.emailExists(email)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"error\": true, \"message\": \"Cet email est déjà utilisé pour un compte.\"}");
                out.flush();
                return;
            }


            // Vérifier si le numero existe déjà
            if (userService.phoneNumberExists(phoneNumber)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"error\": true, \"message\": \"Numero de telephone est déjà utilisé pour un compte.\"}");
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
                out.print("{\"success\": true, \"message\": \"" + role + "\"}");
                out.flush();

            } else {
                // Login failed
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            }

        } else  if (action.equals("editUser")) {
            int userId = Integer.parseInt(request.getParameter("id"));
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            int status = Integer.parseInt(request.getParameter("status"));

            User user = userService.findById(userId);
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setAddress(address);
            user.setPhoneNumber(phoneNumber);
            user.setEmail(email);
            user.setRole(role);
            user.setStatus(status);

            userService.update(user);

            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson("success"));
        }else if ("updatePassword".equals(action)) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"message\": \"Utilisateur non connecté.\"}");
                return;
            }

            if (!BCrypt.checkpw(currentPassword, user.getPassword())) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"message\": \"Le mot de passe actuel est incorrect.\"}");
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"message\": \"Les mots de passe ne correspondent pas.\"}");
                return;
            }

            // Hash the new password
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

            // Update password in the database
            boolean updateResult = userService.updatePassword(Math.toIntExact(user.getId()), hashedPassword);

            if (updateResult) {
                response.getWriter().write("{\"message\": \"success\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"message\": \"Échec de la mise à jour du mot de passe.\"}");
            }
        } else if ("updateProfil".equals(action)) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"message\": \"Utilisateur non connecté.\"}");
                return;
            }

            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");


            boolean updateResult = userService.updateProfile(Math.toIntExact(user.getId()), firstName, lastName, email, phoneNumber, address);


            if (updateResult) {
                user = userService.findById(user.getId());
                session.setAttribute("user", user);
                response.getWriter().write("{\"message\": \"success\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"message\": \"Failed to update profile.\"}");
            }
        }


    }


//    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String action = request.getParameter("action");
//        if (action.equals("editUser")) {
//            long userId = Integer.parseInt(request.getParameter("id"));
//            String firstName = request.getParameter("firstName");
//            String lastName = request.getParameter("lastName");
//            String address = request.getParameter("address");
//            String phoneNumber = request.getParameter("phoneNumber");
//            String email = request.getParameter("email");
//            String role = request.getParameter("role");
//            int status = request.getParameter("status") != null ? Integer.parseInt(request.getParameter("status")) : 0;
//            System.out.println("userId: " + userId);
//            System.out.println("firstName: " + firstName);
//            System.out.println("status: " + status);
//
//
//            User user = userService.findById(userId);
//            user.setFirstName(firstName);
//            user.setLastName(lastName);
//            user.setAddress(address);
//            user.setPhoneNumber(phoneNumber);
//            user.setEmail(email);
//            user.setRole(role);
//            user.setStatus(status);
//
//            userService.update(user);
//
//            response.setContentType("application/json");
//            response.getWriter().write(new Gson().toJson("success"));
//        }
//    }


    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("deleteUser")) {
            try {
                int userId = Integer.parseInt(request.getParameter("id"));
                User user = userService.findById(userId);
                if (user != null) {
                    userService.delete(user);
                    response.setContentType("application/json");
                    response.getWriter().write(new Gson().toJson("success"));
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND); // Utilisateur non trouvé
                }
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Mauvaise requête
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Erreur interne du serveur
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Action non prise en charge
        }
    }

}



