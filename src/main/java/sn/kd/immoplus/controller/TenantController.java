package sn.kd.immoplus.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sn.kd.immoplus.dto.RentRequestDTO;
import sn.kd.immoplus.dto.RentalUnitDTO;
import sn.kd.immoplus.model.*;
import sn.kd.immoplus.service.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/tenant")
public class TenantController extends HttpServlet {

    private final RentalUnitService rentalUnitService = new RentalUnitServiceImpl();
    private final BuildingService buildingService = new BuildingServiceImpl();
    private final BuildingAmenityService buildingAmenityService = new BuildingAmenityServiceImpl();
    private final RentRequestService rentRequestService = new RentRequestServiceImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String uri = request.getRequestURI();
        String[] parts = uri.split("/");
        String controllerName = parts[parts.length - 1];
        request.setAttribute("controllerName", controllerName);

        if ("getOffers".equals(action)) {
            List<RentalUnit> rentalUnits = rentalUnitService.findAll();
            List<RentalUnitDTO> rentalUnitDTOs = convertToDTOs(rentalUnits);
            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(rentalUnitDTOs));
        }else if ("listOffers".equals(action)) {
            request.setAttribute("action", "listOffers");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        }else if ("listRequestRent".equals(action)) {
            request.setAttribute("action", "listRequestRent");
            request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
        } else if ("getRentRequests".equals(action)) {
            User user = (User) request.getSession().getAttribute("user");
            List<RentRequest> rentRequests = rentRequestService.findByUserId(user.getId());
            List<RentRequestDTO> rentRequestDTOs = convertToDTOsRentRequest(rentRequests);
            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(rentRequestDTOs));
        }
    }



    private RentRequestDTO convertToDTORentRequest(RentRequest rentRequest) {
        RentalUnit rentalUnit = rentalUnitService.findById(rentRequest.getRentalUnitId());
        Building building = buildingService.findById(rentalUnit.getBuildingId());
        return new RentRequestDTO(rentRequest, rentalUnit, building);
    }


    private List<RentRequestDTO> convertToDTOsRentRequest(List<RentRequest> rentRequests) {
        return rentRequests.stream().map(this::convertToDTORentRequest).collect(Collectors.toList());
    }





    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("submitRequest".equals(action)) {
            StringBuilder jsonStringBuilder = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    jsonStringBuilder.append(line);
                }
            }

            String jsonString = jsonStringBuilder.toString();
            Gson gson = new Gson();
            RentRequest rentRequest = gson.fromJson(jsonString, RentRequest.class);

            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"message\": \"User not logged in.\"}");
                return;
            }

            rentRequest.setUserId(user.getId());
            rentRequest.setStatus("En attente");

            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy");
            LocalDate localDate = LocalDate.now();
            rentRequest.setDateCreated(dtf.format(localDate));

            rentRequestService.save(rentRequest);

            response.setContentType("application/json");
            response.getWriter().write("{\"message\": \"Request submitted successfully.\"}");

        }
    }

    private List<RentalUnitDTO> convertToDTOs(List<RentalUnit> rentalUnits) {
        return rentalUnits.stream().map(this::convertToDTO).collect(Collectors.toList());
    }

    private RentalUnitDTO convertToDTO(RentalUnit rentalUnit) {
        Building building = buildingService.findById(rentalUnit.getBuildingId());
        List<Amenity> amenities = buildingAmenityService.findAmenitiesByBuildingId(building.getId());
        return new RentalUnitDTO(rentalUnit, building, amenities);
    }
}
