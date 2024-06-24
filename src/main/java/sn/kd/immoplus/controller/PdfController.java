package sn.kd.immoplus.controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sn.kd.immoplus.model.Payment;
import sn.kd.immoplus.model.RentRequest;
import sn.kd.immoplus.model.RentalContract;
import sn.kd.immoplus.model.User;
import sn.kd.immoplus.service.*;

import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/pdf")
public class PdfController extends HttpServlet {

    private PaymentService paymentService = new PaymentServiceImpl();
    private UserService userService = new UserServiceImpl();
    private RentRequestService rentRequestService = new RentRequestServiceImpl();
    private RentalContractService rentalcontractService = new RentalContractServiceImpl();
    private PdfService pdfService = new PdfService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("downloadReceipt".equals(action)) {
            HttpSession session = request.getSession();

            int paymentId = Integer.parseInt(request.getParameter("paymentId"));
            Payment payment = paymentService.findById(paymentId);
            RentalContract rentalContract = rentalcontractService.findById(payment.getRentalContractId());
            User tenant = userService.findById(rentalContract.getUserId());
            RentRequest rentRequest = rentRequestService.findByUserId(tenant.getId()).get(0);
            User owner =((User) session.getAttribute("user"));

            byte[] pdfBytes = pdfService.generateReceipt(payment, tenant, owner, rentRequest);

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=recu_paiement.pdf");
            response.setContentLength(pdfBytes.length);

            try (OutputStream out = response.getOutputStream()) {
                out.write(pdfBytes);
            }
        }
    }
}
