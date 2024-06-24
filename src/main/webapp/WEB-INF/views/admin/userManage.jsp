<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="sn.kd.immoplus.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // Redirect to login page or show an error message
    }
%>
<input type="hidden" id="currentUserId" value="<%= user.getId() %>">
<div class="page-header">
    <h1 class="page-title">Gestion Utilisateurs</h1>
</div>
<div class="row row-sm">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Utilisateurs</h3>
            </div>
            <div class="card-body">
                <button id="addUserButton" class="btn btn-primary mb-3">
                    <i class="fe fe-plus"></i> Ajouter Utilisateur
                </button>
                <div class="table-responsive">
                    <table id="usersListTable" class="table border text-nowrap text-md-nowrap table-hover mb-0">
                        <thead>
                        <tr>
                            <th>Prenom</th>
                            <th>Nom</th>
                            <th>Adresse</th>
                            <th>Numero Telephone</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody id="usersListTableBody"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Ajouter Utilisateur -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addUserModalLabel">Ajouter Utilisateur</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addUserForm">
                    <div class="mb-3">
                        <label for="firstName" class="form-label">Prénom</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" required>
                    </div>
                    <div class="mb-3">
                        <label for="lastName" class="form-label">Nom</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" required>
                    </div>
                    <div class="mb-3">
                        <label for="address" class="form-label">Adresse</label>
                        <input type="text" class="form-control" id="address" name="address" required>
                    </div>
                    <div class="mb-3">
                        <label for="phoneNumber" class="form-label">Numéro de Téléphone</label>
                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Mot de passe</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>

                    <div class="mb-3">
                        <label for="role" class="form-label">Rôle</label>
                        <select class="form-select" id="role" name="role" required>
                            <option value="admin">Admin</option>
                            <option value="proprietaire" selected>Proprietaire</option>
                            <option value="locataire">Locataire</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="status" class="form-label">Statut</label>
                        <select class="form-select" id="status" name="status" required>
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Ajouter</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Modifier Utilisateur -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editUserModalLabel">Modifier Utilisateur</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editUserForm">
                    <input type="hidden" id="editUserId" name="id">
                    <div class="mb-3">
                        <label for="editFirstName" class="form-label">Prénom</label>
                        <input type="text" class="form-control" id="editFirstName" name="firstName" required>
                    </div>
                    <div class="mb-3">
                        <label for="editLastName" class="form-label">Nom</label>
                        <input type="text" class="form-control" id="editLastName" name="lastName" required>
                    </div>
                    <div class="mb-3">
                        <label for="editAddress" class="form-label">Adresse</label>
                        <input type="text" class="form-control" id="editAddress" name="address" required>
                    </div>
                    <div class="mb-3">
                        <label for="editPhoneNumber" class="form-label">Numéro de Téléphone</label>
                        <input type="text" class="form-control" id="editPhoneNumber" name="phoneNumber" required>
                    </div>
                    <div class="mb-3">
                        <label for="editEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="editEmail" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="editRole" class="form-label">Rôle</label>
                        <select class="form-select" id="editRole" name="role" required>
                            <option value="admin">Admin</option>
                            <option value="proprietaire">Proprietaire</option>
                            <option value="locataire">Locataire</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="editStatus" class="form-label">Statut</label>
                        <select class="form-select" id="editStatus" name="status" required>
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Modifier</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Supprimer Utilisateur -->
<div class="modal fade" id="deleteUserModal" tabindex="-1" aria-labelledby="deleteUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteUserModalLabel">Supprimer Utilisateur</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Êtes-vous sûr de vouloir supprimer cet utilisateur ?</p>
                <form id="deleteUserForm">
                    <input type="hidden" id="deleteUserId" name="id">
                    <button type="submit" class="btn btn-danger">Supprimer</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        const usersTable = $('#usersListTable').DataTable({
            ajax: {
                url: 'user?action=getUsers',
                dataSrc: ''
            },
            columns: [
                {data: 'firstName'},
                {data: 'lastName'},
                {data: 'address'},
                {data: 'phoneNumber'},
                {data: 'email'},
                {data: 'role'},
                {
                    data: 'status',
                    render: function (data) {
                        return data === 1 ? 'Active' : 'Inactive';
                    }
                },
                {
                    data: null,
                    render: function (data) {
                        return `
                            <button class="btn btn-primary btn-sm edit-btn">Modifier</button>
                            <button class="btn btn-danger btn-sm delete-btn">Supprimer</button>
                        `;
                    }
                }
            ]
        });

        var currentUserId = $('#currentUserId').val(); // ID de l'utilisateur connecté

        $('#usersListTable').on('draw.dt', function() {
            $('#usersListTableBody tr').each(function() {
                var data = usersTable.row(this).data();

                if (data.id == currentUserId) {
                    $(this).remove();
                } else {
                    $(this).find('.edit-btn').attr('data-id', data.id);
                    $(this).find('.delete-btn').attr('data-id', data.id);
                }
            });
        });


        $('#addUserButton').on('click', function () {
            $('#addUserModal').modal('show');
        });

        $('#addUserForm').on('submit', function (e) {
            e.preventDefault();
            const formData = $(this).serialize();
            $.post('user?action=register', formData, function () {
                $('#addUserModal').modal('hide');
                usersTable.ajax.reload();
                Swal.fire('Succès', 'Utilisateur ajouté avec succès', 'success');
            }).fail(function () {
                Swal.fire('Erreur', "Erreur lors de l'ajout de l'utilisateur", 'error');
            });
        });

        $('#usersListTableBody').on('click', '.edit-btn', function () {
            const userId = $(this).data('id');
            let url = "user?action=findUserById&id="+userId
            $.get(url, function (data) {
                $('#editUserId').val(data.id);
                $('#editFirstName').val(data.firstName);
                $('#editLastName').val(data.lastName);
                $('#editAddress').val(data.address);
                $('#editPhoneNumber').val(data.phoneNumber);
                $('#editEmail').val(data.email);
                $('#editRole').val(data.role);
                $('#editStatus').val(data.status);
                $('#editUserModal').modal('show');
            });
        });

        $('#editUserForm').on('submit', function (e) {
            e.preventDefault();
            const formData = $(this).serialize();
            const userId = parseInt($('#editUserId').val());
            let url = "user?action=editUser&id="+userId

            $.ajax({
                url: url,
                method: 'GET',
                data: formData,
                success: function () {
                    $('#editUserModal').modal('hide');
                    usersTable.ajax.reload();
                    Swal.fire('Succès', 'Utilisateur modifié avec succès', 'success');
                },
                error: function () {
                    Swal.fire('Erreur', "Erreur lors de la modification de l'utilisateur", 'error');
                }
            });
        });

        $('#usersListTableBody').on('click', '.delete-btn', function () {
            const userId =  $(this).data('id');
            $('#deleteUserId').val(userId);
            $('#deleteUserModal').modal('show');
        });

        $('#deleteUserForm').on('submit', function (e) {
            e.preventDefault();
            let userId = parseInt($('#deleteUserId').val());
            let url = "user?action=deleteUser&id="+userId;
            fetch(url, {
                method: 'DELETE'
            })
                .then(response => {
                    if (response.ok) {
                        $('#deleteUserModal').modal('hide');
                        usersTable.ajax.reload();
                        Swal.fire('Succès', 'Utilisateur supprimé avec succès', 'success');
                    } else {
                        Swal.fire('Erreur', "Erreur lors de la suppression de l'utilisateur", 'error');
                    }
                })
                .catch(error => {
                    Swal.fire('Erreur', "Erreur lors de la suppression de l'utilisateur", 'error');
                });
        });


    });
</script>