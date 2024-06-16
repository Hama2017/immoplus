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