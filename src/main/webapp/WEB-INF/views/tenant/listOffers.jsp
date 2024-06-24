
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.kd.immoplus.dto.RentalUnitDTO" %>

<div class="page-header">
    <h1 class="page-title">Offres de location</h1>
</div>
<div id="offersContainer"></div>

<script>
    function loadRentalOffers() {
        $.ajax({
            url: "tenant?action=getOffers",
            type: "GET",
            success: function(data) {
                var offersHTML = "<div class='row'>";
                data.forEach(function(offer) {
                    offersHTML += "<div class='col-md-4 mb-4'>" +
                        "<div class='card'>" +
                        "<img src='" + offer.building.imgPath + "' class='card-img-top' alt='Image de l\\'immeuble'>" +
                        "<div class='card-body'>" +
                        "<h5 class='card-title'>" + offer.rentalUnit.description + "</h5>" +
                        "<p class='card-text'><strong>Adresse:</strong> " + offer.building.address + "</p>" +
                        "<p class='card-text'><strong>Nombre d'étages:</strong> " + offer.building.floorNumber + "</p>" +
                        "<p class='card-text'><strong>Numéro d'unité:</strong> " + offer.rentalUnit.unitNumber + "</p>" +
                        "<p class='card-text'><strong>Nombre de pièces:</strong> " + offer.rentalUnit.numberOfRooms + "</p>" +
                        "<p class='card-text'><strong>Surface:</strong> " + offer.rentalUnit.area + " m²</p>" +
                        "<p class='card-text'><strong>Loyer mensuel:</strong> <span class='float-right'>" + offer.rentalUnit.monthlyRent + " €</span></p>" +
                        "<p class='card-text'><strong>Équipements:</strong></p>" +
                        "<ul class='list-inline'>";
                    offer.amenities.forEach(function(amenity) {
                        offersHTML += "<li class='list-inline-item'><i class='" + amenity.icon + "'></i> " + amenity.name + "</li>";
                    });
                    offersHTML += "</ul>" +
                        "<button class='btn btn-primary' onclick='showRequestModal(" + offer.rentalUnit.id + ")'>Faire une demande</button>" +
                        "</div>" +
                        "</div>" +
                        "</div>";
                });
                offersHTML += "</div>"; // Fermer la rangée de Bootstrap
                $('#offersContainer').html(offersHTML);
            },
            error: function() {
                alert('Erreur lors du chargement des offres');
            }
        });
    }
    function showRequestModal(rentalUnitId) {
        $('#submitRequestModal').modal('show');
        $('#rentalUnitId').val(rentalUnitId);
    }

    function submitRentRequest(event) {
        event.preventDefault();

        var formData = {
            rentalUnitId: $('#rentalUnitId').val(),
            expectedStartDate: $('#expectedStartDate').val(),
            monthsNumber: $('#monthsNumber').val(),
            personsNumber: $('#personsNumber').val()
        };

        $.ajax({
            type: 'POST',
            url: 'tenant?action=submitRequest',
            data: JSON.stringify(formData),
            contentType: 'application/json',
            success: function(response) {
                $('#submitRequestModal').modal('hide');
                Swal.fire('Succès', 'Votre demande a été soumise avec succès', 'success');
            },
            error: function() {
                Swal.fire('Erreur', "Erreur lors de la soumission de la demande", 'error');
            }
        });
    }

    $(document).ready(function() {
        loadRentalOffers();
        $('#submitRequestForm').on('submit', submitRentRequest);

    });
</script>

<!-- Modal pour soumettre une demande -->
<div class="modal fade" id="submitRequestModal" tabindex="-1" aria-labelledby="submitRequestModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="submitRequestModalLabel">Soumettre une demande de location</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="submitRequestForm">
                    <input type="hidden" id="rentalUnitId" name="rentalUnitId">
                    <div class="mb-3">
                        <label for="expectedStartDate" class="form-label">Date prévue de début</label>
                        <input type="date" class="form-control" id="expectedStartDate" name="expectedStartDate" required>
                    </div>
                    <div class="mb-3">
                        <label for="monthsNumber" class="form-label">Nombre de mois</label>
                        <input type="number" class="form-control" id="monthsNumber" name="monthsNumber" required>
                    </div>
                    <div class="mb-3">
                        <label for="personsNumber" class="form-label">Nombre de personnes</label>
                        <input type="number" class="form-control" id="personsNumber" name="personsNumber" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Soumettre la demande</button>
                </form>
            </div>
        </div>
    </div>
</div>