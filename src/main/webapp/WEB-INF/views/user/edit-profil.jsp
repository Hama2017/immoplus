<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="sn.kd.immoplus.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // Redirect to login page or show an error message
    }
%>
<div class="page-header">
    <h1 class="page-title">Paramètres du Profil</h1>
</div>
<div class="row">

    <div class="col-xl-4">
        <div class="card">
            <div class="card-header">
                <div class="card-title">Modifier le mot de passe</div>
            </div>
            <form id="editPasswordForm">
                <div class="card-body">
                    <div class="form-group">
                        <label class="form-label">Mot de passe actuel</label>
                        <div class="wrap-input100 validate-input input-group" id="Password-toggle">
                            <a href="javascript:void(0)" class="input-group-text bg-white text-muted">
                                <i class="zmdi zmdi-eye text-muted" aria-hidden="true"></i>
                            </a>
                            <input class="input100 form-control" type="password" id="currentPassword" placeholder="Mot de passe actuel" autocomplete="current-password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Nouveau mot de passe</label>
                        <div class="wrap-input100 validate-input input-group" id="Password-toggle1">
                            <a href="javascript:void(0)" class="input-group-text bg-white text-muted">
                                <i class="zmdi zmdi-eye text-muted" aria-hidden="true"></i>
                            </a>
                            <input class="input100 form-control" type="password" id="newPassword" placeholder="Nouveau mot de passe" autocomplete="new-password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Confirmer le mot de passe</label>
                        <div class="wrap-input100 validate-input input-group" id="Password-toggle2">
                            <a href="javascript:void(0)" class="input-group-text bg-white text-muted">
                                <i class="zmdi zmdi-eye text-muted" aria-hidden="true"></i>
                            </a>
                            <input class="input100 form-control" type="password" id="confirmPassword" placeholder="Confirmer le mot de passe" autocomplete="new-password">
                        </div>
                    </div>
                </div>
                <div class="card-footer text-end">
                    <a href="javascript:void(0)" class="btn btn-primary" id="updatePasswordBtn">Mettre à jour</a>
                </div>
            </form>
        </div>
    </div>

    <div class="col-xl-8">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Modifier le profil</h3>
            </div>
            <div class="card-body">
                <form id="editProfileForm">
                    <input type="hidden" id="userId" value="<%= user.getId() %>">
                    <div class="row">
                        <div class="col-lg-6 col-md-12">
                            <div class="form-group">
                                <label for="firstName">Prénom</label>
                                <input type="text" class="form-control" id="firstName" placeholder="Prénom" value="<%= user.getFirstName() %>">
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-12">
                            <div class="form-group">
                                <label for="lastName">Nom</label>
                                <input type="text" class="form-control" id="lastName" placeholder="Nom" value="<%= user.getLastName() %>">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email">Adresse email</label>
                        <input type="email" class="form-control" id="email" placeholder="Adresse email" value="<%= user.getEmail() %>">
                    </div>
                    <div class="form-group">
                        <label for="phoneNumber">Numéro de contact</label>
                        <input type="text" class="form-control" id="phoneNumber" placeholder="Numéro de contact" value="<%= user.getPhoneNumber() %>">
                    </div>
                    <div class="form-group">
                        <label for="address">Adresse</label>
                        <input type="text" class="form-control" id="address" placeholder="Adresse" value="<%= user.getAddress() %>">
                    </div>
                </form>
            </div>
            <div class="card-footer text-end">
                <button type="button" class="btn btn-primary my-1" id="saveProfileBtn">Enregistrer</button>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {

        $('#updatePasswordBtn').click(function() {
            const passwordData = {
                action: "updatePassword",
                currentPassword: $('#currentPassword').val(),
                newPassword: $('#newPassword').val(),
                confirmPassword: $('#confirmPassword').val()
            };

            $.ajax({
                type: 'POST',
                url: 'user?action=updatePassword',
                data: passwordData,
                dataType: 'json',
                success: function(response) {
                    if (response.message === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Succès',
                            text: 'Mot de passe mis à jour avec succès.'
                        }).then((result) => {
                            $('#currentPassword').val('');
                            $('#newPassword').val('');
                            $('#confirmPassword').val('');
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Erreur',
                            text: response.message
                        });
                    }
                },
                error: function(xhr) {
                    let errorMessage = 'Une erreur est survenue.';
                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        errorMessage = xhr.responseJSON.message;
                    }
                    Swal.fire({
                        icon: 'error',
                        title: 'Erreur',
                        text: errorMessage
                    });
                }
            });
        });



        $('#saveProfileBtn').click(function() {
            const profileData = {
                action: "updateProfile",
                userId: $('#userId').val(),
                firstName: $('#firstName').val(),
                lastName: $('#lastName').val(),
                email: $('#email').val(),
                phoneNumber: $('#phoneNumber').val(),
                address: $('#address').val()
            };

            $.ajax({
                type: 'POST',
                url: 'user?action=updateProfil',
                data: profileData,
                dataType: 'json',
                success: function(response) {
                    if (response.message === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Succès',
                            text: 'Profil mis à jour avec succès.'
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Erreur',
                            text: 'Échec de la mise à jour du profil.'
                        });
                    }
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Erreur',
                        text: 'Une erreur est survenue.'
                    });
                }
            });
        });

    });
</script>