package sn.kd.immoplus.controller;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.kd.immoplus.dto.RentRequestDTO;
import sn.kd.immoplus.model.*;
import sn.kd.immoplus.service.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

import java.util.stream.Collectors;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 15    // 15 MB
)
@WebServlet("/owner")

public class OwnerController extends HttpServlet {

    private static final Gson gson = new Gson();

    private UserService userService = new UserServiceImpl();
    private BuildingService buildingService = new BuildingServiceImpl();
    private AmenityService amenityService = new AmenityServiceImpl();
    private RentalUnitService rentalUnitService = new RentalUnitServiceImpl();
    private RentRequestService rentRequestService = new RentRequestServiceImpl();
    private RentalContractService rentalContractService = new RentalContractServiceImpl();
    private PaymentService paymentService = new PaymentServiceImpl();
    BuildingAmenityService buildingAmenityService = new BuildingAmenityServiceImpl();




    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String uri = request.getRequestURI();
        String[] parts = uri.split("/");
        String controllerName = parts[parts.length - 1];
        request.setAttribute("controllerName", controllerName);

        if ("dashboard".equals(action)) {
            request.setAttribute("action", "dashboard");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        } else if ("listBuilding".equals(action)) {
            request.setAttribute("action", "listBuilding");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        } else if ("listRentalUnit".equals(action)) {
            request.setAttribute("action", "listRentalUnit");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        }else if ("listPayment".equals(action)) {
            request.setAttribute("action", "listPayment");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        } else if ("getBuildings".equals(action)) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            List<Building> buildings = buildingService.getByUserId(user.getId());
            System.out.println(buildings);
            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(buildings));
        } else if ("getAmenities".equals(action)) {
            List<Amenity> amenities = amenityService.findAll();
            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(amenities));
            System.out.println(amenities);
        } else if ("getBuildingAmenities".equals(action)) {
            int buildingId = Integer.parseInt(request.getParameter("buildingId"));
            List<BuildingAmenity> buildingAmenities = buildingAmenityService.getBuildingAmenities(buildingId);

            // Crée une nouvelle liste d'Amenity
            List<Amenity> listAmenities = new ArrayList<>();

            // Boucle sur la liste de BuildingAmenity
            for (BuildingAmenity buildingAmenity : buildingAmenities) {
                // Utilise le service Amenity pour obtenir l'Amenity correspondant à l'ID
                Amenity amenity = amenityService.findById(buildingAmenity.getAmenityId());
                // Ajoute l'Amenity à la liste
                listAmenities.add(amenity);
            }

            // Convertit la liste d'Amenity en JSON et l'envoie en réponse
            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(listAmenities));
        } else if ("getBuildingDetails".equals(action)) {
            int buildingId = Integer.parseInt(request.getParameter("buildingId"));
            Building building = buildingService.findById(buildingId);
            List<BuildingAmenity> buildingAmenities = buildingAmenityService.getBuildingAmenities(buildingId);
            List<Amenity> amenities = amenityService.findAll();

            List<Integer> amenityIds = buildingAmenities.stream()
                    .map(BuildingAmenity::getAmenityId)
                    .collect(Collectors.toList());

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("building", building);
            responseData.put("buildingAmenities", amenityIds);
            responseData.put("amenities", amenities);

            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(responseData));
        }else if ("getApartments".equals(action)) {

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }
            int userId = user.getId();
            List<RentalUnit> apartments = rentalUnitService.findByUserId(userId);

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.write(new Gson().toJson(apartments));
            out.close();



        }else if ("findApartmentById".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            RentalUnit apartment = rentalUnitService.findById(id);

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.write(new Gson().toJson(apartment));
            out.close();

        }else if ("listRequestRent".equals(action)) {
            request.setAttribute("action", "listRequestRent");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        }else if ("getRequests".equals(action)) {
            User user = (User) request.getSession().getAttribute("user");
            List<RentRequest> rentRequests = rentRequestService.findByOwnerId(user.getId());
            List<RentRequestDTO> rentRequestDTOs = convertToDTOs(rentRequests);
            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(rentRequestDTOs));
        }else if ("listRentalContract".equals(action)) {
            request.setAttribute("action", "listRentalContract");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        }else if ("getContracts".equals(action)) {
            User user = (User) request.getSession().getAttribute("user");
            List<RentalContract> contracts = rentalContractService.findByUserId(user.getId());
            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(contracts));
        }else if ("getAcceptedTenants".equals(action)) {
            User user = (User) request.getSession().getAttribute("user");
            List<RentRequest> acceptedRequests = rentRequestService.findAcceptedRequests(user.getId());

            List<RentRequestDTO> rentRequestDTOs = acceptedRequests.stream()
                    .map(req -> {
                        RentalUnit rentalUnit = rentalUnitService.findById(req.getRentalUnitId());
                        Building building = buildingService.findById(rentalUnit.getBuildingId());
                        User tenant = userService.findById(req.getUserId());
                        return new RentRequestDTO(req, rentalUnit, building, tenant);
                    })
                    .collect(Collectors.toList());

            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(rentRequestDTOs));
        }else if ("getContractsByUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            List<RentalContract> contracts = rentalContractService.findByUserId(userId);
            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(contracts));
        }else if ("getPaymentsByContract".equals(action)) {
            int contractId = Integer.parseInt(request.getParameter("contractId"));
            List<Payment> payments = paymentService.findByContractId(contractId);
            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(payments));
        }else {
            // Action par défaut si aucune correspondance trouvée
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action non reconnue");
        }


    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

            if (action.equals("addBuilding")) {
                // Récupérer les données du formulaire
                String address = request.getParameter("address");
                String description = request.getParameter("description");
                int floorNumber = Integer.parseInt(request.getParameter("floorNumber"));
                int userId = ((User) request.getSession().getAttribute("user")).getId();

                // Récupérer le fichier image envoyé
                Part filePart = request.getPart("imgPath");
                String fileName = filePart.getSubmittedFileName();
                InputStream fileContent = filePart.getInputStream();

                // Chemin d'accès à src/main/webapp/resources/images
                String uploadPath = getServletContext().getRealPath("/resources/images/") + File.separator + fileName;

                // Enregistrer le fichier image sur le serveur
                File file = new File(uploadPath);
                file.getParentFile().mkdirs(); // Créez les répertoires parents si nécessaire
                Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);

                // Créer une instance de Building avec les données
                Building building = new Building();
                building.setAddress(address);
                building.setDescription(description);
                building.setFloorNumber(floorNumber);
                building.setImgPath("resources/images/" + fileName); // Enregistrer le chemin relatif vers le fichier image
                building.setUserId(userId);

                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDate localDate = LocalDate.now();
                building.setDateCreated(dtf.format(localDate));

                // Appeler le service pour enregistrer le bâtiment dans la base de données
                buildingService.save(building);

                // Enregistrer les équipements sélectionnés pour le bâtiment
                String[] amenities = request.getParameterValues("amenities");
                if (amenities != null) {
                    for (String amenityId : amenities) {
                        BuildingAmenity buildingAmenity = new BuildingAmenity();
                        buildingAmenity.setBuildingId(building.getId());
                        buildingAmenity.setAmenityId(Integer.parseInt(amenityId));
                        buildingAmenityService.save(buildingAmenity);
                    }
                }

                // Envoyer une réponse JSON de succès
                response.setContentType("application/json");
                response.getWriter().write(new Gson().toJson("success"));
            }
            else if (action.equals("updateBuilding")) {

                int buildingId = Integer.parseInt(request.getParameter("buildingId"));
                String address = request.getParameter("address");
                String description = request.getParameter("description");
                int floorNumber = Integer.parseInt(request.getParameter("floorNumber"));
                Part filePart = request.getPart("imgPath");

                Building building = buildingService.findById(buildingId);
                building.setAddress(address);
                building.setDescription(description);
                building.setFloorNumber(floorNumber);

                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = filePart.getSubmittedFileName();
                    InputStream fileContent = filePart.getInputStream();
                    String uploadPath = getServletContext().getRealPath("/resources/images/") + File.separator + fileName;
                    File file = new File(uploadPath);
                    file.getParentFile().mkdirs(); // Créez les répertoires parents si nécessaire
                    Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    building.setImgPath("resources/images/" + fileName);
                }

                buildingService.update(building);

                // Mettre à jour les équipements
                String[] amenities = request.getParameterValues("amenities");
                buildingAmenityService.deleteByBuildingId(buildingId);
                if (amenities != null) {
                    for (String amenityId : amenities) {
                        BuildingAmenity buildingAmenity = new BuildingAmenity();
                        buildingAmenity.setBuildingId(building.getId());
                        buildingAmenity.setAmenityId(Integer.parseInt(amenityId));
                        buildingAmenityService.save(buildingAmenity);
                    }
                }

                response.setContentType("application/json");
                response.getWriter().write(new Gson().toJson("success"));
            }
            else if (action.equals("deleteBuilding")) {
                int buildingId = Integer.parseInt(request.getParameter("buildingId"));
                buildingService.deleteBuildingAndUnits(buildingId);
                response.getWriter().write(new Gson().toJson("Building and associated units deleted successfully!"));
                ;
            }else if ("addApartment".equals(action)) {

                String unitNumber = request.getParameter("unitNumber");
                String description = request.getParameter("description");
                int floorLevel = Integer.parseInt(request.getParameter("floorLevel"));
                int numberOfRooms = Integer.parseInt(request.getParameter("numberOfRooms"));
                int area = Integer.parseInt(request.getParameter("area"));
                int monthlyRent = Integer.parseInt(request.getParameter("monthlyRent"));
                int buildingId = Integer.parseInt(request.getParameter("buildingId"));

                RentalUnit rentalUnit = new RentalUnit();
                rentalUnit.setUnitNumber(unitNumber);
                rentalUnit.setDescription(description);
                rentalUnit.setFloorLevel(floorLevel);
                rentalUnit.setNumberOfRooms(numberOfRooms);
                rentalUnit.setArea(area);
                rentalUnit.setMonthlyRent(monthlyRent);
                rentalUnit.setBuildingId(buildingId);
                rentalUnit.setDateCreated(java.time.LocalDate.now().toString());

                rentalUnitService.save(rentalUnit);

                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.write(new Gson().toJson("success"));
                out.close();

            }else if ("updateApartment".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                String unitNumber = request.getParameter("unitNumber");
                String description = request.getParameter("description");
                int floorLevel = Integer.parseInt(request.getParameter("floorLevel"));
                int numberOfRooms = Integer.parseInt(request.getParameter("numberOfRooms"));
                int area = Integer.parseInt(request.getParameter("area"));
                int monthlyRent = Integer.parseInt(request.getParameter("monthlyRent"));
                int buildingId = Integer.parseInt(request.getParameter("buildingId"));

                RentalUnit rentalUnit = rentalUnitService.findById(id);

                if (rentalUnit != null) {
                    rentalUnit.setUnitNumber(unitNumber);
                    rentalUnit.setDescription(description);
                    rentalUnit.setFloorLevel(floorLevel);
                    rentalUnit.setNumberOfRooms(numberOfRooms);
                    rentalUnit.setArea(area);
                    rentalUnit.setMonthlyRent(monthlyRent);
                    rentalUnit.setBuildingId(buildingId);
                    rentalUnitService.update(rentalUnit);

                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    out.write(new Gson().toJson("success"));
                    out.close();
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    out.write(new Gson().toJson("Apartment not found"));
                    out.close();
                }

            }else if ("deleteApartment".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));

                rentalUnitService.delete(id);

                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.write(new Gson().toJson("success"));
                out.close();

            } else if ("updateRequestStatus".equals(action)) {
            int requestId = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            rentRequestService.updateStatus(requestId, status);
            response.getWriter().write("success");
        } else if ("addContract".equals(action)) {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");





                RentRequest rentRequest = rentRequestService.findById(requestId);
            RentalUnit rentalUnit = rentalUnitService.findById(rentRequest.getRentalUnitId());

            int userId = rentRequest.getUserId();
            int rentalUnitId = rentalUnit.getId();
            int monthsNumber = getMonthsDifference(startDate, endDate);
            int amount = monthsNumber * rentalUnit.getMonthlyRent();

            RentalContract contract = new RentalContract();
            contract.setUserId(userId);
            contract.setRentalUnitId(rentalUnitId);
            contract.setStartDate(startDate);
            contract.setEndDate(endDate);
            contract.setAmount(amount);
            contract.setStatus("Validée");

            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy");
            contract.setDateCreated(dtf.format(LocalDate.now()));

            rentalContractService.save(contract);

            // Set RentRequest status to 'Contract'
            rentRequest.setStatus("Contrat");
            rentRequestService.update(rentRequest);



                LocalDate start = LocalDate.parse(startDate);
                LocalDate end = LocalDate.parse(endDate);


                int months = (int) ChronoUnit.MONTHS.between(start, end) + 1;

                paymentService.createPaymentsForContract(contract.getId(), startDate, months, rentalUnit.getMonthlyRent());



                response.setContentType("application/json");
                response.getWriter().write(new Gson().toJson("success"));
        }else if ("terminateContract".equals(action)) {
                int contractId = Integer.parseInt(request.getParameter("contractId"));
                RentalContract contract = rentalContractService.findById(contractId);

                if (contract != null) {
                    int rentalUnitId = contract.getRentalUnitId();

                    // Supprimer les paiements liés
                    paymentService.deleteByRentalContractId(contractId);

                    // Supprimer la demande de location liée
                    rentRequestService.deleteByRentalUnitId(rentalUnitId);

                    // Supprimer le contrat
                    rentalContractService.delete(contractId);

                    response.setContentType("application/json");
                    response.getWriter().write(new Gson().toJson("success"));
                } else {
                    response.setContentType("application/json");
                    response.getWriter().write(new Gson().toJson("error"));
                }
            }else if ("payPayment".equals(action)) {
                int paymentId = Integer.parseInt(request.getParameter("paymentId"));
                paymentService.payPayment(paymentId);
                response.setContentType("text/plain");
                response.getWriter().write("Payment updated successfully");
            }

    }


    private List<RentRequestDTO> convertToDTOs(List<RentRequest> rentRequests) {
        return rentRequests.stream().map(this::convertToDTO).collect(Collectors.toList());
    }

    private RentRequestDTO convertToDTO(RentRequest rentRequest) {
        User tenant = userService.findById(rentRequest.getUserId());
        RentalUnit rentalUnit = rentalUnitService.findById(rentRequest.getRentalUnitId());
        Building building = buildingService.findById(rentalUnit.getBuildingId());
        return new RentRequestDTO(rentRequest, rentalUnit, building, tenant);
    }

    private int getMonthsDifference(String startDate, String endDate) {
        LocalDate start = LocalDate.parse(startDate);
        LocalDate end = LocalDate.parse(endDate);
        return end.getYear() * 12 + end.getMonthValue() - (start.getYear() * 12 + start.getMonthValue());
    }

}
