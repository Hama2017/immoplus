package sn.kd.immoplus.controller;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sn.kd.immoplus.model.Amenity;
import sn.kd.immoplus.model.Setting;
import sn.kd.immoplus.model.User;
import sn.kd.immoplus.service.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/admin")
public class AdminController extends HttpServlet {

    private UserService userService = new UserServiceImpl();
    private AmenityService amenityService = new AmenityServiceImpl();
    private SettingService settingService = new SettingServiceImpl();
    private Gson gson = new Gson();

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
        } else if (action.equals("updateFileConfig")) {



            String allowedFileTypes = request.getParameter("allowedFileTypes");
            String maxFileSizeStr = request.getParameter("maxFileSize");

            if (allowedFileTypes == null || allowedFileTypes.isEmpty() || maxFileSizeStr == null || maxFileSizeStr.isEmpty()) {

                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"error\": true, \"message\": \"Valeurs d'entrée invalides..\"}");
                out.flush();
                return;
            }

            int maxFileSize;
            try {
                maxFileSize = Integer.parseInt(maxFileSizeStr);
            } catch (NumberFormatException e) {

                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"error\": true, \"message\": \"Valeur de la taille de fichier invalide.\"}");
                out.flush();
                return;
            }

            boolean updateResult = settingService.updateFileConfig(allowedFileTypes, maxFileSize);

            if (updateResult) {
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_OK);
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"success\": true, \"message\": \"Configurations enregistrées avec succès.\"}");
                out.flush();
            } else {
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print("{\"message\": \"Une erreur est survenue lors de la mise à jour de la configuration.\"}");
                out.flush();
            }


        } else if ("getCurrentSettings".equals(action)) {
            Setting setting = settingService.findById(1); // assuming the ID of the setting is 1
            String jsonResponse = gson.toJson(setting);
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse);
        }else if ("getAmenities".equals(action)) {
            List<Amenity> amenities = amenityService.findAll();
            Gson gson = new Gson();
            String json = gson.toJson(amenities);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        }else if ("updateAmenity".equals(action)) {
                // Récupérer les données du formulaire
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String icon = request.getParameter("icon");

                // Récupérer l'équipement à mettre à jour
                Amenity existingAmenity = amenityService.findById(id);
                if (existingAmenity != null) {
                    // Mettre à jour les données de l'équipement
                    existingAmenity.setName(name);
                    existingAmenity.setIcon(icon);

                    // Mettre à jour l'équipement dans la base de données
                    amenityService.update(existingAmenity);

                    // Retourner une réponse de succès
                    Gson gson = new Gson();
                    String jsonResponse = gson.toJson("success");
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(jsonResponse);
                } else {
                    // Gérer le cas où l'équipement n'est pas trouvé
                    // Retourner une réponse d'erreur
                    Gson gson = new Gson();
                    String jsonResponse = gson.toJson("error");
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(jsonResponse);
                }

        }else if ("getAmenityById".equals(action)) {
            String amenityIdStr = request.getParameter("id");
            if (amenityIdStr != null) {
                try {
                    int amenityId = Integer.parseInt(amenityIdStr);
                    AmenityService amenityService = new AmenityServiceImpl();
                    Amenity amenity = amenityService.findById(amenityId); // Supposons que vous avez une méthode findById dans votre service
                    if (amenity != null) {
                        Gson gson = new Gson();
                        String json = gson.toJson(amenity);
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        response.getWriter().write(json);
                        return;
                    }
                } catch (NumberFormatException e) {
                    // Log the exception or handle it as needed
                }
            }
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // ID invalide ou non fourni
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND); // Action non prise en charge
        }
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("addAmenity".equals(action)) {
            // Récupérer les données du formulaire
            String name = request.getParameter("name");
            String icon = request.getParameter("icon");

            // Créer un nouvel objet Amenity
            Amenity newAmenity = new Amenity();
            newAmenity.setName(name);
            newAmenity.setIcon(icon);

            // Ajouter l'équipement à la base de données
            amenityService.save(newAmenity);

            // Retourner une réponse de succès
            Gson gson = new Gson();
            String jsonResponse = gson.toJson("success");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);
        }else if ("deleteAmenity".equals(action)) {
            // Récupérer l'ID de l'équipement à supprimer
            int id = Integer.parseInt(request.getParameter("id"));

            // Supprimer l'équipement de la base de données
            Amenity existingAmenity = amenityService.findById(id);
            if (existingAmenity != null) {
                amenityService.delete(existingAmenity);

                // Retourner une réponse de succès
                Gson gson = new Gson();
                String jsonResponse = gson.toJson("success");
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jsonResponse);
            } else {
                // Gérer le cas où l'équipement n'est pas trouvé
                // Retourner une réponse d'erreur
                Gson gson = new Gson();
                String jsonResponse = gson.toJson("error");
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jsonResponse);
            }
        } else {
            // Autres traitements ou gestion des erreurs
        }
    }



}
