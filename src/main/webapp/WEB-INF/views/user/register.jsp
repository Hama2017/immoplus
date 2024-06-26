<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <a href="index"><img src="${pageContext.request.contextPath}/resources/assets/images/brand/immoplus_logo_transparent_crop_blanc.png" class="header-brand-img m-0" style="    width: 312px;
    margin-bottom: 20px !important;" alt=""></a>
                </div>
            </div>
            <div class="container-login100">
                <div class="wrap-login100 p-6">
                    <form id="registerForm" action="user?action=register" method="post" class="login100-form validate-form">
        <span class="login100-form-title">
            Inscription
        </span>

                        <div class="wrap-input100 validate-input input-group" data-bs-validate="Un prénom valide est requis">
                            <a href="javascript:void(0)" class="input-group-text bg-white text-muted">
                                <i class="mdi mdi-account" aria-hidden="true"></i>
                            </a>
                            <input class="input100 border-start-0 ms-0 form-control" type="text" name="firstName" placeholder="Prénom" required>
                        </div>

                        <div class="wrap-input100 validate-input input-group" data-bs-validate="Un nom valide est requis">
                            <a href="javascript:void(0)" class="input-group-text bg-white text-muted">
                                <i class="mdi mdi-account" aria-hidden="true"></i>
                            </a>
                            <input class="input100 border-start-0 ms-0 form-control" type="text" name="lastName" placeholder="Nom" required>
                        </div>

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

                        <div class="wrap-input100 validate-input input-group" data-bs-validate="Une adresse valide est requise">
                            <a href="javascript:void(0)" class="input-group-text bg-white text-muted">
                                <i class="mdi mdi-home" aria-hidden="true"></i>
                            </a>
                            <input class="input100 border-start-0 ms-0 form-control" type="text" name="address" placeholder="Adresse" required>
                        </div>

                        <div class="wrap-input100 validate-input input-group" data-bs-validate="Un numéro de téléphone valide est requis">
                            <a href="javascript:void(0)" class="input-group-text bg-white text-muted">
                                <i class="mdi mdi-phone" aria-hidden="true"></i>
                            </a>
                            <input class="input100 border-start-0 ms-0 form-control" type="text" name="phoneNumber" placeholder="Numéro de téléphone" required>
                        </div>

                        <label class="custom-control custom-checkbox mt-4">
                            <input type="checkbox" class="custom-control-input" required>
                            <span class="custom-control-label">Accepter les <a href="terms.html">conditions et la politique</a></span>
                        </label>

                        <div class="container-login100-form-btn">
                            <button type="submit" class="login100-form-btn btn-primary">
                                S'inscrire
                            </button>
                        </div>

                        <div class="text-center pt-3">
                            <p class="text-dark mb-0 d-inline-flex">Vous avez déjà un compte ?<a href="user?action=login" class="text-primary ms-1">Se connecter</a></p>
                        </div>
                        <div class="text-center pt-3">
                            <p class="text-dark mb-0 d-inline-flex">Revenir a l'accueil<a href="index" class="text-primary ms-1">Accueil</a></p>
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
        // Fonction pour vérifier si un numéro de téléphone est valide
        function isValidPhoneNumber(phoneNumber) {
            var phoneRegex = /^[0-9]{9}$/;
            return phoneRegex.test(phoneNumber);
        }

        $("#registerForm").submit(function(event) {
            event.preventDefault();

            // Récupérer les valeurs des champs
            var firstName = $("input[name='firstName']").val();
            var lastName = $("input[name='lastName']").val();
            var email = $("input[name='email']").val();
            var password = $("input[name='password']").val();
            var address = $("input[name='address']").val();
            var phoneNumber = $("input[name='phoneNumber']").val();
            var termsAccepted = $("input[type='checkbox']").is(":checked");

            // Valider les champs
            if (!firstName) {
                Swal.fire("Erreur", "Le prénom est requis", "error");
                return;
            }
            if (!lastName) {
                Swal.fire("Erreur", "Le nom est requis", "error");
                return;
            }
            if (!email) {
                Swal.fire("Erreur", "L'email est requis", "error");
                return;
            }
            if (!password) {
                Swal.fire("Erreur", "Le mot de passe est requis", "error");
                return;
            }
            if (!address) {
                Swal.fire("Erreur", "L'adresse est requise", "error");
                return;
            }
            if (!phoneNumber) {
                Swal.fire("Erreur", "Le numéro de téléphone est requis", "error");
                return;
            }
            if (!isValidPhoneNumber(phoneNumber)) {
                Swal.fire("Erreur", "Le numéro de téléphone doit contenir exactement 9 chiffres", "error");
                return;
            }
            if (!termsAccepted) {
                Swal.fire("Erreur", "Vous devez accepter les termes et conditions", "error");
                return;
            }

            var formData = $(this).serialize();

            $.ajax({
                type: "POST",
                url: "user?action=register",
                data: formData,
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            title: "Inscription réussie",
                            text: "Votre compte a été créé avec succès!",
                            icon: "success",
                            showConfirmButton: false,
                            timer: 2000
                        }).then(() => {
                            window.location = "user?action=login";
                        });
                    } else if (response.error) {
                        Swal.fire({
                            title: "Erreur d'inscription",
                            text: response.message,
                            icon: "error",
                            confirmButtonText: "OK",
                            confirmButtonColor: "#0092dd",
                        });
                    } else {
                        Swal.fire({
                            title: "Erreur d'inscription",
                            text: response.message,
                            icon: "error",
                            confirmButtonColor: "#0092dd",
                            confirmButtonText: "OK"
                        });
                    }
                }
            });
        });
    });
</script>


<style>

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