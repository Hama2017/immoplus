package sn.kd.immoplus.service;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
import sn.kd.immoplus.model.Payment;
import sn.kd.immoplus.model.RentRequest;
import sn.kd.immoplus.model.User;
import java.io.ByteArrayOutputStream;

public class PdfService {

    public byte[] generateReceipt(Payment payment, User tenant, User owner, RentRequest rentRequest) {
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            Document document = new Document();
            PdfWriter.getInstance(document, baos);
            document.open();

            // Ajouter un logo
            String logoPath = "http://localhost:8080/immoplus_war_exploded/resources/assets/images/brand/immoplus_logo_transparent_crop.png";
            Image logo = Image.getInstance(logoPath);
            logo.scaleAbsolute(100, 50);
            document.add(logo);

            // Ajouter le titre
            Paragraph title = new Paragraph("Reçu de Paiement", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20));
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(20);
            document.add(title);

            // Ajouter les informations du propriétaire
            document.add(new Paragraph("Informations du Propriétaire", FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
            document.add(new Paragraph("Nom: " + owner.getFirstName() + " " + owner.getLastName()));
            document.add(new Paragraph("Email: " + owner.getEmail()));
            document.add(new Paragraph("Téléphone: " + owner.getPhoneNumber()));
            document.add(Chunk.NEWLINE);

            // Ajouter les informations du locataire
            document.add(new Paragraph("Informations du Locataire", FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
            document.add(new Paragraph("Nom: " + tenant.getFirstName() + " " + tenant.getLastName()));
            document.add(new Paragraph("Email: " + tenant.getEmail()));
            document.add(new Paragraph("Téléphone: " + tenant.getPhoneNumber()));
            document.add(Chunk.NEWLINE);

            // Ajouter les détails du paiement
            document.add(new Paragraph("Détails du Paiement", FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
            document.add(new Paragraph("Date de Paiement: " + payment.getPaidDate()));
            document.add(new Paragraph("Montant: " + payment.getAmount() + " €"));
            document.add(new Paragraph("Statut: " + payment.getStatus()));
            document.add(Chunk.NEWLINE);

            // Ajouter les informations de la demande de location
            document.add(new Paragraph("Informations de la Demande de Location", FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
            document.add(new Paragraph("Date de Début Prévue: " + rentRequest.getExpectedStartDate()));
            document.add(new Paragraph("Nombre de Mois: " + rentRequest.getMonthsNumber()));
            document.add(new Paragraph("Nombre de Personnes: " + rentRequest.getPersonsNumber()));

            document.close();
            return baos.toByteArray();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


}
