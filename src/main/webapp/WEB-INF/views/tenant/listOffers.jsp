
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.kd.immoplus.model.User" %>

<%
    User user = (User) session.getAttribute("user");
%>


<div class="page-header">
    <h1 class="page-title">Offres de location</h1>
</div>

<!--app-content open-->
<div class="main-content mt-0">
    <div class="side-app">
        <div class="main-container">
            <div class="container">
                <!-- Section Heading -->
                <div class="row mb-3 mt-7">
                    <h2 class="text-center fw-semibold mb-7">Appartement Disponibles</h2>
                </div>

                <!-- Filters Section -->
                <div class="row mb-7">
                    <div class="col-md-3">
                        <label for="priceMinFilter" class="form-label">Prix Minimum (FCFA)</label>
                        <input type="number" id="priceMinFilter" class="form-control">
                    </div>
                    <div class="col-md-3">
                        <label for="priceMaxFilter" class="form-label">Prix Maximum (FCFA)</label>
                        <input type="number" id="priceMaxFilter" class="form-control">
                    </div>
                    <div class="col-md-3">
                        <label for="amenityFilter" class="form-label">Équipements</label>
                        <select id="amenityFilter" class="form-select">
                            <!-- Options will be loaded here via AJAX -->
                        </select>
                    </div>
                    <div class="col-md-3 d-flex align-items-end">
                        <button id="filterButton" class="btn btn-primary w-100">Filtrer</button>
                    </div>
                </div>

                <!-- Apartments Cards Section -->
                <div class="row" id="apartmentsContainer">
                    <!-- Les cartes d'appartements seront chargées ici -->
                </div>
            </div>
        </div>

        <!-- Modal Faire une demande -->
        <div class="modal fade" id="requestModal" tabindex="-1" aria-labelledby="requestModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="requestModalLabel">Faire une demande</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="requestForm">
                            <div class="mb-3">
                                <label for="expectedStartDate" class="form-label">Date d'entrée prévue</label>
                                <input type="date" class="form-control" id="expectedStartDate" name="expectedStartDate" required>
                            </div>
                            <div class="mb-3">
                                <label for="personsNumber" class="form-label">Nombre de personnes</label>
                                <input type="number" class="form-control" id="personsNumber" name="personsNumber" required>
                            </div>
                            <div class="mb-3">
                                <label for="monthsNumber" class="form-label">Nombre de mois</label>
                                <input type="number" class="form-control" id="monthsNumber" name="monthsNumber" required>
                            </div>
                            <input type="hidden" id="rentalUnitId" name="rentalUnitId">
                            <button type="submit" class="btn btn-primary">Soumettre</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<!--app-content closed-->


<script>
    $(document).ready(function () {
        // Charger les équipements
        function loadAmenities() {
            $.ajax({
                url: "tenant?action=getAmenities",
                type: "GET",
                success: function (data) {
                    var amenitySelect = $("#amenityFilter");
                    amenitySelect.empty();
                    amenitySelect.append("<option value=''>Tous</option>");
                    console.log(data)
                    data.forEach(function (amenity) {
                        amenitySelect.append("<option value='" + amenity.id + "'>" + amenity.name + "</option>");
                    });
                },
                error: function () {
                    alert('Erreur lors du chargement des équipements');
                }
            });
        }

        // Charger les appartements
        function loadApartments(filters = {}) {
            $.ajax({
                url: "tenant?action=getOffers",
                type: "GET",
                data: filters,
                success: function (data) {
                    var apartmentsHTML = "";
                    data.forEach(function (apartment) {
                        apartmentsHTML += "<div class='col-md-4 mb-4'>" +
                            "<div class='card shadow-sm'>" +
                            "<img src='" + apartment.building.imgPath + "' class='card-img-top' alt='Image de l\\'immeuble' style='height: 200px; object-fit: cover;'>" +
                            "<div class='card-body'>" +
                            "<h5 class='card-title'>" + apartment.rentalUnit.description + "</h5>" +
                            "<p class='card-text'><strong>Adresse:</strong> " + apartment.building.address + "</p>" +
                            "<p class='card-text'><strong>Niveau de l'Etage:</strong> " + apartment.rentalUnit.floorLevel + "iem</p>" +
                            "<div class='d-flex justify-content-between'>" +
                            "<p class='card-text'><strong>Numéro d'unité:</strong> " + apartment.rentalUnit.unitNumber + "</p>" +
                            "<p class='card-text'><strong>Nombre de pièces:</strong> " + apartment.rentalUnit.numberOfRooms + "</p>" +
                            "</div>" +
                            "<div class='d-flex justify-content-between'>" +
                            "<p class='card-text'><strong>Surface:</strong> " + apartment.rentalUnit.area + " m²</p>" +
                            "<p class='card-text border border-primary text-primary p-1 bg-light'><strong>Loyer mensuel:</strong> " + apartment.rentalUnit.monthlyRent + " FCFA</p>" +
                            "</div>" +
                            "<p class='card-text'><strong>Équipements:</strong></p>" +
                            "<ul class='list-group list-group-flush'>";
                        apartment.amenities.forEach(function (amenity) {
                            apartmentsHTML += "<li class='list-group-item'><i class='" + amenity.icon + "'></i> " + amenity.name + "</li>";
                        });
                        apartmentsHTML += "</ul>" +
                            "<button class='btn btn-primary mt-3' onclick='checkAndShowRequestModal(" + apartment.rentalUnit.id + ")'>Faire une demande</button>" +
                            "</div>" +
                            "</div>" +
                            "</div>";
                    });
                    $('#apartmentsContainer').html(apartmentsHTML);
                },
                error: function () {
                    alert('Erreur lors du chargement des appartements');
                }
            });
        }

        // Charger les équipements lors du chargement de la page
        loadAmenities();

        // Charger les appartements lors du chargement de la page
        loadApartments();

        // Filtrer les appartements
        $('#filterButton').on('click', function () {
            var filters = {
                priceMin: $('#priceMinFilter').val(),
                priceMax: $('#priceMaxFilter').val(),
                amenity: $('#amenityFilter').val()
            };
            loadApartments(filters);
        });

        // Vérifier et afficher le modal pour faire une demande
        window.checkAndShowRequestModal = function (rentalUnitId) {
            <% if (user == null) { %>
            Swal.fire('Erreur', 'Veuillez créer un compte et vous connecter pour faire une demande', 'error');
            <% } else { %>
            $.ajax({
                url: "tenant?action=checkRequest&rentalUnitId=" + rentalUnitId,
                type: "GET",
                success: function (response) {
                    if (response.hasRequested) {
                        Swal.fire('Erreur', 'Vous avez déjà fait une demande pour cet appartement.', 'error');
                    } else {
                        $('#rentalUnitId').val(rentalUnitId);
                        $('#requestModal').modal('show');
                    }
                },
                error: function () {
                    Swal.fire('Erreur', 'Erreur lors de la vérification de la demande.', 'error');
                }
            });
            <% } %>
        };

        // Soumettre la demande
        $('#requestForm').on('submit', function (e) {
            e.preventDefault();
            var formData = {
                expectedStartDate: $('#expectedStartDate').val(),
                personsNumber: $('#personsNumber').val(),
                monthsNumber: $('#monthsNumber').val(),
                rentalUnitId: $('#rentalUnitId').val()
            };

            $.ajax({
                url: "tenant?action=submitRequest",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(formData),
                success: function () {
                    $('#requestModal').modal('hide');
                    Swal.fire('Succès', 'Demande soumise avec succès', 'success');
                },
                error: function () {
                    Swal.fire('Erreur', "Erreur lors de la soumission de la demande", 'error');
                }
            });
        });
    });
</script>

<style>
    .card {
        transition: transform 0.2s ease-in-out;
    }

    .card:hover {
        transform: translateY(-10px);
    }

    .card-body {
        padding: 20px;
    }

    .card-title {
        font-size: 1.25rem;
        font-weight: bold;
        margin-bottom: 15px;
    }

    .card-text {
        margin-bottom: 10px;
    }

    .card-img-top {
        height: 200px;
        object-fit: cover;
    }

    .border-primary {
        border-width: 2px;
    }

    div:where(.swal2-container) button:where(.swal2-styled).swal2-confirm {
        border: 0;
        border-radius: .25em;
        background: initial;
        background-color: initial;
        background-color: #0092dd;
        color: #fff;
        font-size: 1em;
    }
</style>