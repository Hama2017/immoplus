<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="sn.kd.immoplus.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index"); // Redirect to the login page
        return; //
    }

%>

<html>

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
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css"/>
    <!-- Plugins CSS -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/plugins.css" rel="stylesheet">

    <!--- FONT-ICONS CSS -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/icons.css" rel="stylesheet">

    <!-- INTERNAL Switcher css -->
    <link href="${pageContext.request.contextPath}/resources/assets/switcher/css/switcher.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/switcher/demo.css" rel="stylesheet">

    <!-- SweetAlert CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <!-- SweetAlert JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body class="app sidebar-mini ltr light-mode">


<!-- GLOBAL-LOADER -->

<!-- /GLOBAL-LOADER -->

<!-- PAGE -->
<div class="page">
    <div class="page-main">

        <!-- app-Header -->
        <div class="app-header header sticky">
            <div class="container-fluid main-container">
                <div class="d-flex">
                    <a aria-label="Hide Sidebar" class="app-sidebar__toggle" data-bs-toggle="sidebar" href="javascript:void(0)"></a>
                    <!-- sidebar-toggle-->
                    <a class="logo-horizontal " href="index">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/brand/logo-white.png" class="header-brand-img desktop-logo" alt="logo">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/brand/logo-dark.png" class="header-brand-img light-logo1"
                             alt="logo">
                    </a>
                    <!-- LOGO -->
                    <div class="d-flex order-lg-2 ms-auto header-right-icons">
                        <!-- SEARCH -->
                        <button class="navbar-toggler navresponsive-toggler d-lg-none ms-auto" type="button"
                                data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent-4"
                                aria-controls="navbarSupportedContent-4" aria-expanded="false"
                                aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon fe fe-more-vertical"></span>
                        </button>
                        <div class="navbar navbar-collapse responsive-navbar p-0">
                            <div class="collapse navbar-collapse" id="navbarSupportedContent-4">
                                <div class="d-flex order-lg-2">
                                    <div class="dropdown d-lg-none d-flex">
                                        <a href="javascript:void(0)" class="nav-link icon" data-bs-toggle="dropdown">
                                            <i class="fe fe-search"></i>
                                        </a>
                                        <div class="dropdown-menu header-search dropdown-menu-start">
                                            <div class="input-group w-100 p-2">
                                                <input type="text" class="form-control" placeholder="Search....">
                                                <div class="input-group-text btn btn-primary">
                                                    <i class="fa fa-search" aria-hidden="true"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="dropdown  d-flex notifications">
                                        <a href="index" class="btn btn-outline-primary">Accueil</a>
                                    </div>


                                    <!-- Notifications Dropdown -->
                                    <div class="dropdown  d-flex notifications">
                                        <a class="nav-link icon" data-bs-toggle="dropdown" aria-expanded="true">
                                            <i class="fe fe-bell"></i>
                                            <div id="notifUnReadCount">

                                            </div>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-end dropdown-menu-arrow" data-bs-popper="static">
                                            <div class="drop-heading border-bottom">
                                                <div class="d-flex">
                                                    <h6 class="mt-1 mb-0 fs-16 fw-semibold text-dark">Notifications</h6>
                                                </div>
                                            </div>
                                            <div class="notifications-menu ps" id="notificationsList">
                                                <!-- Notifications will be loaded here via AJAX -->
                                            </div>
                                            <div class="dropdown-divider m-0"></div>
                                            <a href="user?action=listNotifications" class="dropdown-item text-center p-3 text-muted">Tout les notifications</a>
                                        </div>
                                    </div>

                                    <!-- SIDE-MENU -->
                                    <div class="dropdown d-flex profile-1">
                                        <a href="javascript:void(0)" data-bs-toggle="dropdown" class="nav-link leading-none d-flex">
                                            <img src="${pageContext.request.contextPath}/resources/assets/images/brand/photo-avatar-profil.png"
                                                 class="avatar  profile-user brround cover-image">
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                            <div class="drop-heading">
                                                <div class="text-center">
                                                    <h5 class="text-dark mb-0 fs-14 fw-semibold"><%= user.getFirstName() + " " + user.getLastName() %></h5>
                                                    <small class="text-muted"><%= user.getRole() %></small>
                                                </div>
                                            </div>
                                            <div class="dropdown-divider m-0"></div>
                                            <a class="dropdown-item" href="user?action=edit-profil">
                                                <i class="dropdown-icon fe fe-user"></i> Profile
                                            </a>


                                            <a class="dropdown-item" href="user?action=logout">
                                                <i class="dropdown-icon fe fe-log-out"></i> Deconnexion
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /app-Header -->

        <!--APP-SIDEBAR-->
        <div class="sticky">
            <div class="app-sidebar__overlay" data-bs-toggle="sidebar"></div>
            <div class="app-sidebar">
                <div class="side-header">
                    <a class="header-brand1" style="padding: 20px;" href="index.html">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/brand/immoplus_logo_transparent_crop.png" class="header-brand-img desktop-logo" alt="logo">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/brand/immoplus_logo_transparent_crop.png" class="header-brand-img toggle-logo"
                             alt="logo">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/brand/immoplus_favicon.png" class="header-brand-img light-logo" alt="logo" style="max-width: 100px;
  margin-left: -14px;">
                        <img src="${pageContext.request.contextPath}/resources/assets/images/brand/immoplus_logo_transparent_crop.png" class="header-brand-img light-logo1"
                             alt="logo" style="width: 160px;">
                    </a>
                    <!-- LOGO -->
                </div>
                <%@ include file="/WEB-INF/views/menuLayout.jsp" %>
            </div>
        </div>
        <!--/APP-SIDEBAR-->

        <!--app-content open-->
        <div class="main-content app-content mt-0">
            <div class="side-app">

                <!-- CONTAINER -->
                <div class="main-container container-fluid">

                    <!-- Dynamic content inclusion -->
                    <c:choose>
                        <c:when test="${not empty controllerName && not empty action}">
                            <jsp:include page="/WEB-INF/views/${controllerName}/${action}.jsp" />
                        </c:when>
                        <c:otherwise>
                            <p>No content available</p>
                        </c:otherwise>
                    </c:choose>

                    <!-- ROWS-->




                    <!-- ROWS -->
                </div>
                <!-- CONTAINER END -->
            </div>
        </div>
        <!--app-content close-->

    </div>


</div>

    <!-- FOOTER -->
    <footer class="footer">
        <div class="container">
            <div class="row align-items-center flex-row-reverse">
                <div class="col-md-12 col-sm-12 text-center">
                    Copyright © <span id="year"></span> <a href="javascript:void(0)">IMMO PLUS</a> All rights reserved.
                </div>
            </div>
        </div>
    </footer>
    <!-- FOOTER END -->


    <!-- BACK-TO-TOP -->
    <a href="#top" id="back-to-top"><i class="fa fa-angle-up"></i></a>

    <!-- JQUERY JS -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>


    <!-- BOOTSTRAP JS -->
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap/js/bootstrap.min.js"></script>

    <!-- TypeHead js -->
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap5-typehead/autocomplete.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/typehead.js"></script>

    <!-- FORM WIZARD JS-->
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/formwizard/jquery.smartWizard.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/formwizard/fromwizard.js"></script>

    <!-- INTERNAl Jquery.steps js -->
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/jquery-steps/jquery.steps.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/parsleyjs/parsley.min.js"></script>

    <!-- Perfect SCROLLBAR JS-->
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/p-scroll/perfect-scrollbar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/p-scroll/pscroll.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/p-scroll/pscroll-1.js"></script>

    <!-- INTERNAL Accordion-Wizard-Form js-->
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/accordion-Wizard-Form/jquery.accordion-wizard.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/form-wizard.js"></script>

    <!-- FILE UPLOADES JS -->
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/fileuploads/js/fileupload.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/fileuploads/js/file-upload.js"></script>

    <!-- INTERNAL File-Uploads Js-->
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/fancyuploder/jquery.ui.widget.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/fancyuploder/jquery.fileupload.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/fancyuploder/jquery.iframe-transport.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/fancyuploder/jquery.fancy-fileupload.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/fancyuploder/fancy-uploader.js"></script>

    <!-- SIDE-MENU JS -->
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/sidemenu/sidemenu.js"></script>

    <!-- SIDEBAR JS -->
    <script src="${pageContext.request.contextPath}/resources/assets/plugins/sidebar/sidebar.js"></script>

    <!-- Color Theme js -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/themeColors.js"></script>

    <!-- Sticky js -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/sticky.js"></script>

    <!-- CUSTOM JS -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/custom.js"></script>

    <!-- Custom-switcher -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/custom-swicher.js"></script>

    <!-- Switcher js -->
    <script src="${pageContext.request.contextPath}/resources/assets/switcher/js/switcher.js"></script>


<script>$(document).ready(function() {
    function loadNotifications() {
        $.ajax({
            url: 'user?action=getNotifications',
            method: 'GET',
            success: function(data) {
                var notificationsHTML = '';
                data.forEach(function(notification) {
                    notificationsHTML +=
                        '<a class="dropdown-item d-flex" href="user?action=listNotifications&idNotification=' + notification.id + '">' +
                        '<div class="me-3 notifyimg bg-secondary brround box-shadow-secondary">' +
                        '<i class="fe fe-message-circle"></i>' +
                        '</div>' +
                        '<div class="mt-1 wd-80p">' +
                        '<h5 class="notification-label mb-1">' + notification.title + '</h5>' +
                        '<span class="notification-subtext">' + notification.dateCreated + '</span>' +
                        '</div>' +
                        '</a>';
                });
                $('#notificationsList').html(notificationsHTML);
            }
        });
    }

    loadNotifications();

    function loadUnreadNotificationsCount() {
        $.ajax({
            url: 'user?action=getUnreadNotificationsCount',
            type: 'GET',
            success: function(data) {
                var count = data;
                var notifUnReadCount = $('#notifUnReadCount');
                console.log(count)
                console.log(notifUnReadCount)
                console.log(data)
                if (count > 0) {
                    notifUnReadCount.html(
                        '<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">' + (count > 20 ? '20+' : count) + '</span>'
                    );
                } else {
                    notifUnReadCount.empty();
                }
            },
            error: function() {
                console.log('Erreur lors de la récupération du compteur de notifications non lues');
            }
        });
    }

    // Charger le compteur de notifications non lues à l'initialisation
    loadUnreadNotificationsCount();

    // Charger le compteur toutes les 30 secondes
    setInterval(loadUnreadNotificationsCount, 30000);


});
</script>

</body>

</html>