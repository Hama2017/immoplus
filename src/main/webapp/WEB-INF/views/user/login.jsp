<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en" dir="ltr">

<head>

    <!-- META DATA -->
    <meta charset="UTF-8">
    <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- FAVICON -->
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/images/brand/favicon.ico">

    <!-- TITLE -->
    <title>IMMO PLUS</title>

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
    <!-- SweetAlert JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body class="app sidebar-mini ltr login-img" style=" background: rgb(2,0,36);
background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%); ">

<!-- BACKGROUND-IMAGE -->
<div class="">

    <!-- GLOABAL LOADER -->
    <div id="global-loader">
        <img src="${pageContext.request.contextPath}/resources/assets/images/loader.svg" class="loader-img" alt="Loader">
    </div>
    <!-- /GLOABAL LOADER -->

    <!-- PAGE -->
    <div class="page">
        <div class="">
            <!-- Theme-Layout -->

            <!-- CONTAINER OPEN -->
            <div class="col col-login mx-auto mt-7">
                <div class="text-center">
                    <a href="index.html"><img src="${pageContext.request.contextPath}/resources/assets/images/brand/immoplus_logo_transparent_crop_blanc.png" class="header-brand-img m-0" style="    width: 312px;
    margin-bottom: 20px !important;" alt=""></a>
                </div>
            </div>
            <div class="container-login100">
                <div class="wrap-login100 p-6">
                    <form id="loginForm" action="user?action=login" method="post" class="login100-form validate-form">
        <span class="login100-form-title">
            Connexion
        </span>



                        <div class="wrap-input100 validate-input input-group" data-bs-validate="Un email valide est requis : ex@abc.xyz">
                            <a href="javascript:void(0)" class="input-group-text bg-white text-muted">
                                <i class="zmdi zmdi-email" aria-hidden="true"></i>
                            </a>
                            <input class="input100 border-start-0 ms-0 form-control" type="email" name="email" placeholder="Email" required>
                        </div>

                        <div class="wrap-input100 validate-input input-group" id="Password-toggle">
                            <a href="javascript:void(0)" class="input-group-text bg-white text-muted">
                                <i class="zmdi zmdi-eye" aria-hidden="true"></i>
                            </a>
                            <input class="input100 border-start-0 ms-0 form-control" type="password" name="password" placeholder="Mot de passe" required>
                        </div>


                        <div class="container-login100-form-btn">
                            <button type="submit" class="login100-form-btn btn-primary">
                                Connexion
                            </button>
                        </div>

                        <div class="text-center pt-3">
                            <p class="text-dark mb-0 d-inline-flex">Vous n'avez pas un compte ?<a href="user?action=register" class="text-primary ms-1">Creer un compte</a></p>
                        </div>
                    </form>
                </div>

            </div>
            <!-- CONTAINER CLOSED -->
        </div>
    </div>
    <!-- END PAGE -->

</div>
<!-- BACKGROUND-IMAGE CLOSED -->

<!-- JQUERY JS -->
<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>

<!-- BOOTSTRAP JS -->
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/plugins/bootstrap/js/bootstrap.min.js"></script>

<!-- SHOW PASSWORD JS -->
<script src="${pageContext.request.contextPath}/resources/assets/js/show-password.min.js"></script>

<!-- Perfect SCROLLBAR JS-->
<script src="${pageContext.request.contextPath}/resources/assets/plugins/p-scroll/perfect-scrollbar.js"></script>

<!-- Color Theme js -->
<script src="${pageContext.request.contextPath}/resources/assets/js/themeColors.js"></script>

<!-- CUSTOM JS -->
<script src="${pageContext.request.contextPath}/resources/assets/js/custom.js"></script>

<!-- Custom-switcher -->
<script src="${pageContext.request.contextPath}/resources/assets/js/custom-swicher.js"></script>

<!-- Switcher js -->
<script src="${pageContext.request.contextPath}/resources/assets/switcher/js/switcher.js"></script>

<script>
    $(document).ready(function() {
        $('#loginForm').on('submit', function(event) {
            event.preventDefault();

            $.ajax({
                type: 'POST',
                url: 'user?action=login',
                data: $(this).serialize(),
                success: function(response) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Connexion réussie',
                        showConfirmButton: false,
                        timer: 2000
                    }).then(() => {
                        let role = response.message;
                        switch (role) {
                            case "locataire":
                                window.location="tenant?action=dashboard";
                                break;
                            case "admin":
                                window.location="admin?action=dashboard";
                                break;
                            case "proprietaire":
                                window.location="owner?action=dashboard";
                                break;
                        }
                    });
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Erreur',
                        text: 'Échec de la connexion. Veuillez vérifier vos informations.',
                        confirmButtonColor:"#0092dd",

                    });
                }
            });
        });
    });
</script>



</body>

</html>