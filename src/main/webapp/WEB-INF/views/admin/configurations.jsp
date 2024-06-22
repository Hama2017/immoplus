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
    <h1 class="page-title">Configurations</h1>
</div>

<div class="row">
    <div class="col-xl-6">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Configuration des fichiers</h3>
            </div>
            <div class="card-body">
                <form id="fileConfigForm">
                    <div class="form-group">
                        <label for="allowedFileTypes">Types de fichiers autorisés</label>
                        <input type="text" class="form-control" id="allowedFileTypes" placeholder="Ex: pdf,jpg,png">
                    </div>
                    <div class="form-group">
                        <label for="maxFileSize">Taille maximale du fichier (en MB)</label>
                        <input type="number" class="form-control" id="maxFileSize" placeholder="Ex: 10">
                    </div>
                </form>
            </div>
            <div class="card-footer text-end">
                <button type="button" class="btn btn-primary my-1" id="updateFileConfigBtn">Mettre à jour</button>
            </div>
        </div>
    </div>
    <!-- Column for Adding and Managing Amenities -->
    <div class="col-xl-6">
        <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3 class="card-title">Gestion des Équipements de l'Immeuble</h3>
                    <button type="button" class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#addAmenityModal">Ajouter Équipement</button>
                </div>
            <div class="card-body">
                <table class="table table-bordered" id="amenitiesTable">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Icone</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Rows will be populated by AJAX -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Add Amenity Modal -->
<div class="modal fade" id="addAmenityModal" tabindex="-1" aria-labelledby="addAmenityModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addAmenityModalLabel">Ajouter Équipement</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addAmenityForm">
                    <div class="form-group">
                        <label for="amenityName">Nom</label>
                        <input type="text" class="form-control" id="amenityName" required>
                    </div>
                    <div class="form-group">
                        <label for="amenityIcon">Icone</label>
                        <input type="text" class="form-control" id="amenityIcon" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Fermer</button>
                <button type="button" class="btn btn-primary" id="saveAmenityBtn">Enregistrer</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Amenity Modal -->
<div class="modal fade" id="editAmenityModal" tabindex="-1" aria-labelledby="editAmenityModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editAmenityModalLabel">Modifier Équipement</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editAmenityForm">
                    <input type="hidden" id="editAmenityId">
                    <div class="form-group">
                        <label for="editAmenityName">Nom</label>
                        <input type="text" class="form-control" id="editAmenityName" required>
                    </div>
                    <div class="form-group">
                        <label for="editAmenityIcon">Icone</label>
                        <input type="text" class="form-control" id="editAmenityIcon" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
                <button type="button" class="btn btn-primary" id="updateAmenityBtn">Mettre à jour</button>
            </div>
        </div>
    </div>
</div>

</div>

<script>
    $('#updateFileConfigBtn').click(function() {
        var allowedFileTypes = $('#allowedFileTypes').val();
        var maxFileSize = $('#maxFileSize').val();

        // Validation
        if (allowedFileTypes.trim() === '' || maxFileSize.trim() === '') {
            Swal.fire({
                icon: 'error',
                title: 'Erreur',
                text: 'Veuillez remplir tous les champs'
            });
            return;
        }

        if (!/^\d+$/.test(maxFileSize)) {
            Swal.fire({
                icon: 'error',
                title: 'Erreur',
                text: 'La taille maximale doit être un nombre entier'
            });
            return;
        }

        if (!/^(\.\w+\s*,\s*)*(\.\w+)$/.test(allowedFileTypes)) {
            Swal.fire({
                icon: 'error',
                title: 'Erreur',
                text: 'Les types de fichiers autorisés doivent être au format ".nomextension, .nomextension, ..."'
            });
            return;
        }

        // AJAX request
        $.ajax({
            type: 'GET',
            url: 'admin?action=updateFileConfig',
            data: {
                allowedFileTypes: allowedFileTypes,
                maxFileSize: maxFileSize
            },
            success: function(response) {
                Swal.fire({
                    icon: 'success',
                    title: 'Succès',
                    text: 'Configuration mise à jour avec succès'
                });
            },
            error: function(response) {
                Swal.fire({
                    icon: 'error',
                    title: 'Erreur',
                    text: response.message
                });
            }
        });
    });

    // Fetch current settings and populate the form
    $.ajax({
        type: 'GET',
        url: 'admin?action=getCurrentSettings',
        success: function(data) {
            $('#allowedFileTypes').val(data.allowedFileTypes);
            $('#maxFileSize').val(data.maxFileSize);
        },
        error: function() {
            Swal.fire({
                icon: 'error',
                title: 'Erreur',
                text: 'Une erreur est survenue lors de la récupération des paramètres actuels'
            });
        }
    });






    // Fetch amenities and populate the table
    function fetchAmenities() {
        $.ajax({
            type: 'GET',
            url: 'admin?action=getAmenities',
            success: function(data) {
                var tableBody = $('#amenitiesTable tbody');
                tableBody.empty();
                data.forEach(function(amenity) {
                    var row = '<tr>' +
                        '<td>' + amenity.id + '</td>' +
                        '<td>' + amenity.name + '</td>' +
                        '<td>'+ amenity.icon + ' <i class="' + amenity.icon + '"></i></td>' +
                        '<td>' +
                        '<button type="button" class="btn btn-warning btn-sm editAmenityBtn" data-id="' + amenity.id + '">Modifier</button> ' +
                        '<button type="button" class="btn btn-danger btn-sm deleteAmenityBtn" data-id="' + amenity.id + '">Supprimer</button>' +
                        '</td>' +
                        '</tr>';

                    tableBody.append(row);
                });
            },
            error: function() {
                Swal.fire({
                    icon: 'error',
                    title: 'Erreur',
                    text: 'Une erreur est survenue lors de la récupération des équipements'
                });
            }
        });
    }
    // Call fetchAmenities on page load
    fetchAmenities();

    // Handle add amenity
    $('#saveAmenityBtn').click(function() {
        var name = $('#amenityName').val();
        var icon = $('#amenityIcon').val();

        if (name.trim() === '' || icon.trim() === '') {
            Swal.fire({
                icon: 'error',
                title: 'Erreur',
                text: 'Veuillez remplir tous les champs'
            });
            return;
        }

        $.ajax({
            type: 'POST',
            url: 'admin?action=addAmenity',
            data: {
                name: name,
                icon: icon
            },
            success: function() {
                fetchAmenities();
                $('#amenityName').val('');
                $('#amenityIcon').val('');
                $('#addAmenityModal').modal('hide');
                Swal.fire({
                    icon: 'success',
                    title: 'Succès',
                    text: 'Équipement ajouté avec succès'
                });
            },
            error: function() {
                Swal.fire({
                    icon: 'error',
                    title: 'Erreur',
                    text: 'Une erreur est survenue lors de l\'ajout de l\'équipement'
                });
            }
        });
    });



    // Handle update amenity
    $('#updateAmenityBtn').click(function() {
        var id = $('#editAmenityId').val();
        var name = $('#editAmenityName').val();
        var icon = $('#editAmenityIcon').val();

        if (name.trim() === '' || icon.trim() === '') {
            Swal.fire({
                icon: 'error',
                title: 'Erreur',
                text: 'Veuillez remplir tous les champs'
            });
            return;
        }

        $.ajax({
            type: 'GET',
            url: 'admin?action=updateAmenity',
            data: {
                id: id,
                name: name,
                icon: icon
            },
            success: function() {
                fetchAmenities();
                $('#editAmenityModal').modal('hide');
                Swal.fire({
                    icon: 'success',
                    title: 'Succès',
                    text: 'Équipement mis à jour avec succès'
                });
            },
            error: function() {
                Swal.fire({
                    icon: 'error',
                    title: 'Erreur',
                    text: 'Une erreur est survenue lors de la mise à jour de l\'équipement'
                });
            }
        });
    });

    // Handle delete amenity
    $('#amenitiesTable').on('click', '.deleteAmenityBtn', function() {
        var amenityId = $(this).data('id');
        Swal.fire({
            title: 'Êtes-vous sûr?',
            text: 'Vous ne pourrez pas revenir en arrière!',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Oui, supprimer!',
            cancelButtonText: 'Annuler'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'POST',
                    url: 'admin?action=deleteAmenity',
                    data: {
                        id: amenityId
                    },
                    success: function() {
                        fetchAmenities();
                        Swal.fire(
                            'Supprimé!',
                            'L\'équipement a été supprimé.',
                            'success'
                        );
                    },
                    error: function() {
                        Swal.fire({
                            icon: 'error',
                            title: 'Erreur',
                            text: 'Une erreur est survenue lors de la suppression de l\'équipement'
                        });
                    }
                });
            }
        });
    });

    // Ouvrir le modal d'édition lorsqu'on clique sur le bouton "Modifier"
    $('#amenitiesTable').on('click', '.editAmenityBtn', function() {
        var amenityId = $(this).data('id');
        // Récupérer les données de l'équipement à modifier et les afficher dans le modal d'édition
        $.ajax({
            type: 'GET',
            url: 'admin?action=getAmenityById',
            data: {
                id: amenityId
            },
            success: function(data) {
                $('#editAmenityId').val(data.id);
                $('#editAmenityName').val(data.name);
                $('#editAmenityIcon').val(data.icon);
                $('#editAmenityModal').modal('show'); // Ouvrir le modal d'édition
            },
            error: function() {
                Swal.fire({
                    icon: 'error',
                    title: 'Erreur',
                    text: 'Une erreur est survenue lors de la récupération des données de l\'équipement'
                });
            }
        });
    });



</script>