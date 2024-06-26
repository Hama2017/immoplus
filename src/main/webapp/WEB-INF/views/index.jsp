<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.kd.immoplus.model.User" %>

<%
    User user = (User) session.getAttribute("user");
%>
<!doctype html>
<html lang="en" dir="ltr">

<head>
    <!-- META DATA -->
    <meta charset="UTF-8">
    <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- FAVICON -->
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/images/brand/immoplus_favicon.png">

    <!-- TITLE -->
    <title> IMMO PLUS</title>

    <!-- BOOTSTRAP CSS -->
    <link id="style" href="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- STYLE CSS -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet">

    <!-- Plugins CSS -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/plugins.css" rel="stylesheet">

    <!--- FONT-ICONS CSS -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/icons.css" rel="stylesheet">

    <!-- INTERNAL Switcher css -->
    <link href="${pageContext.request.contextPath}/resources/assets/switcher/css/switcher.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/switcher/demo.css" rel="stylesheet">

    <!-- SweetAlert CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

</head>

<body class="app ltr landing-page horizontal">

<!-- GLOBAL-LOADER -->
<div id="global-loader">
    <img src="${pageContext.request.contextPath}/resources/assets/images/loader.svg" class="loader-img" alt="Loader">
</div>
<!-- /GLOBAL-LOADER -->

<!-- PAGE -->
<div class="page">
    <div class="page-main">

        <!-- app-Header -->
        <div class="hor-header header">
            <div class="container main-container">
                <div class="d-flex">
                    <a aria-label="Hide Sidebar" class="app-sidebar__toggle" data-bs-toggle="sidebar"
                       href="javascript:void(0)"></a>
                    <!-- sidebar-toggle-->
                    <a class="logo-horizontal " href="index.html">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/brand/immoplus_logo_transparent_crop_blanc.png" class="header-brand-img desktop-logo" alt="logo">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/brand/immoplus_logo_transparent_crop_blanc" class="header-brand-img light-logo1"
                             alt="logo">
                    </a>
                    <!-- LOGO -->
                    <div class="d-flex order-lg-2 ms-auto header-right-icons">
                        <button class="navbar-toggler navresponsive-toggler d-lg-none ms-auto" type="button"
                                data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent-4"
                                aria-controls="navbarSupportedContent-4" aria-expanded="false"
                                aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon fe fe-more-vertical"></span>
                        </button>
                        <div class="navbar navbar-collapse responsive-navbar p-0">
                            <div class="collapse navbar-collapse bg-white px-0" id="navbarSupportedContent-4">
                                <!-- SEARCH -->
                                <div class="header-nav-right p-5">
                                    <c:choose>
                                        <c:when test="${not empty user}">
                                            <c:choose>
                                                <c:when test="${user.role == 'locataire'}">
                                                    <a href="tenant?action=dashboard" class="btn ripple btn-min w-sm btn-secondary me-2 my-auto">Retour au Dashboard</a>
                                                </c:when>
                                                <c:when test="${user.role == 'proprietaire'}">
                                                    <a href="owner?action=listRequestRent" class="btn ripple btn-min w-sm btn-secondary me-2 my-auto">Retour au Dashboard</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <!-- Contenu pour les autres rôles -->
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="user?action=register" class="btn ripple btn-min w-sm btn-secondary me-2 my-auto">Inscription</a>
                                            <a href="user?action=login" class="btn ripple btn-min w-sm btn-white me-2 my-auto">Connexion</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /app-Header -->

        <div class="landing-top-header overflow-hidden">
            <div class="top sticky">
                <!--APP-SIDEBAR-->
                <div class="app-sidebar__overlay" data-bs-toggle="sidebar"></div>
                <div class="app-sidebar bg-primary horizontal-main">
                    <div class="container">
                        <div class="row">
                            <div class="main-sidemenu navbar px-0">
                                <a class="navbar-brand ps-0 d-none d-lg-block" href="/index">
                                    <img alt="" class="logo-2" src="${pageContext.request.contextPath}/resources/assets/images/brand/immoplus_logo_transparent_crop_blanc.png" style="width: 125px;margin-top: -10px;">
                                    <img src="${pageContext.request.contextPath}/resources/assets/images/brand/immoplus_logo_transparent_crop_blanc.png" class="logo-3" alt="logo" style="width: 125px;margin-top: -10px;">
                                </a>
                                <div class="header-nav-right d-none d-lg-flex">
                                    <c:choose>
                                        <c:when test="${not empty user}">
                                            <c:choose>
                                                <c:when test="${user.role == 'locataire'}">
                                                    <a href="tenant?action=listRequestRent" class="btn ripple btn-min w-sm btn-secondary me-2 my-auto">Retour au Dashboard</a>
                                                </c:when>
                                                <c:when test="${user.role == 'proprietaire'}">
                                                    <a href="owner?action=listRequestRent" class="btn ripple btn-min w-sm btn-secondary me-2 my-auto">Retour au Dashboard</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <!-- Contenu pour les autres rôles -->
                                                </c:otherwise>
                                            </c:choose>                                        </c:when>
                                        <c:otherwise>
                                            <a href="user?action=register" class="btn ripple btn-min w-sm btn-secondary me-2 my-auto">Inscription</a>
                                            <a href="user?action=login" class="btn ripple btn-min w-sm btn-white me-2 my-auto">Connexion</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--/APP-SIDEBAR-->
            </div>
            <div class="demo-screen-headline main-demo main-demo-1 spacing-top overflow-hidden reveal" id="home" style="background-color: #8fd2f4;">
                <div class="container px-sm-0">
                    <div class="row">
                        <div class="col-xl-6 col-lg-6 mb-5 pb-5 animation-zidex pos-relative">
                            <h4 class="fw-semibold mt-7">Gérez Votre Immobilier</h4>
                            <h1 class="text-start fw-bold">Nous vous aidons à réaliser votre projet immobilier avec Immo Plus</h1>
                            <h6 class="pb-3">
                                Immo Plus - Utilisez cette plateforme pour concevoir et gérer des projets immobiliers étonnants
                                qui impressionneront vos clients ou utilisateurs. Pour créer un bon et bien structuré projet immobilier,
                                vous devez commencer par les bonnes bases souvent complique et couteux mais en utilisant Immo Plus,
                                vous avez déjà une solution clé en main.
                            </h6>
                        </div>
                        <div class="col-xl-6 col-lg-6 my-auto">
                            <img src="${pageContext.request.contextPath}/resources/assets/images/brand/img.png" alt="Immo Plus">
                        </div>
                    </div>
                </div>
            </div>
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
    </div>

    <!-- FOOTER OPEN -->
    <div class="demo-footer">
        <div class="container">
            <div class="row">
                <div class="card">
                    <div class="card-body">
                        <footer class="main-footer px-0 pb-0 text-center">
                            <div class="row ">
                                <div class="col-md-12 col-sm-12">
                                    Copyright © <span id="year"></span> <a href="javascript:void(0)">Immo Plus</a>.
                                    Designed with <span class="fa fa-heart text-danger"></span> by <a
                                        href="javascript:void(0)"> HBS </a> All rights reserved.
                                </div>
                            </div>
                        </footer>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- FOOTER CLOSED -->
</div>

<!-- BACK-TO-TOP -->
<a href="#top" id="back-to-top"><i class="fa fa-angle-up"></i></a>

<!-- JQUERY JS -->
<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>

<!-- BOOTSTRAP JS -->
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap/js/bootstrap.min.js"></script>

<!-- COUNTERS JS-->
<script src="${pageContext.request.contextPath}/resources/assets/plugins/counters/counterup.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/counters/waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/counters/counters-1.js"></script>

<!-- Perfect SCROLLBAR JS-->
<script src="${pageContext.request.contextPath}/resources/assets/plugins/owl-carousel/owl.carousel.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/company-slider/slider.js"></script>

<!-- Star Rating Js-->
<script src="${pageContext.request.contextPath}/resources/assets/plugins/rating/jquery-rate-picker.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/rating/rating-picker.js"></script>

<!-- Star Rating-1 Js-->
<script src="${pageContext.request.contextPath}/resources/assets/plugins/ratings-2/jquery.star-rating.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/ratings-2/star-rating.js"></script>

<!-- Sticky js -->
<script src="${pageContext.request.contextPath}/resources/assets/js/sticky.js"></script>

<!-- SweetAlert JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- CUSTOM JS -->
<script src="${pageContext.request.contextPath}/resources/assets/js/landing.js"></script>

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
                    console.log(data)
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
</body>

</html>
