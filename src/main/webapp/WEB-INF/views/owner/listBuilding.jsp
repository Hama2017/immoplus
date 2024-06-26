<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="sn.kd.immoplus.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // Redirect to login page or show an error message
    }
%>
<input type="hidden" id="currentUserId" value="<%= user.getId() %>">
<div class="page-header">
    <h1 class="page-title">Gestion Immeubles</h1>
</div>
<div class="row row-sm">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Immeubles</h3>
            </div>
            <div class="card-body">
                <button id="addBuildingButton" class="btn btn-primary mb-3">
                    <i class="fe fe-plus"></i> Ajouter Immeuble
                </button>
                <div class="table-responsive">
                    <table id="buildingsTable" class="table border text-nowrap text-md-nowrap table-hover mb-0">
                        <thead>
                        <tr>
                            <th>Adresse</th>
                            <th>Description</th>
                            <th>Nombre d'étages</th>
                            <th>Image</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody id="buildingsTableBody"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Ajouter Immeuble -->
<div class="modal fade" id="addBuildingModal" tabindex="-1" aria-labelledby="addBuildingModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addBuildingModalLabel">Ajouter Immeuble</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addBuildingForm" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="address" class="form-label">Adresse</label>
                        <input type="text" class="form-control" id="address" name="address" required>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" name="description" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="floorNumber" class="form-label">Nombre d'étages</label>
                        <input type="number" class="form-control" id="floorNumber" name="floorNumber" required>
                    </div>
                    <div class="mb-3">
                        <label for="imgPath" class="form-label">Image</label>
                        <input type="file" class="form-control" id="imgPath" name="imgPath" accept="image/*" required>
                    </div>
                    <div class="mb-3">
                        <label for="amenitiesCheckboxes" class="form-label">Équipements</label>
                        <div id="amenitiesCheckboxes">
                            <!-- Dynamically generate checkboxes here -->
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Ajouter</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Modifier Immeuble -->
<div class="modal fade" id="editBuildingModal" tabindex="-1" aria-labelledby="editBuildingModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editBuildingModalLabel">Modifier Immeuble</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editBuildingForm" enctype="multipart/form-data">
                    <input type="hidden" id="editBuildingId" name="buildingId">
                    <div class="mb-3">
                        <label for="editAddress" class="form-label">Adresse</label>
                        <input type="text" class="form-control" id="editAddress" name="address" required>
                    </div>
                    <div class="mb-3">
                        <label for="editDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="editDescription" name="description" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="editFloorNumber" class="form-label">Nombre d'étages</label>
                        <input type="number" class="form-control" id="editFloorNumber" name="floorNumber" required>
                    </div>
                    <div class="mb-3">
                        <label for="editImgPath" class="form-label">Image</label>
                        <input type="file" class="form-control" id="editImgPath" name="imgPath" accept="image/*">
                    </div>
                    <div class="mb-3">
                        <label for="editAmenitiesCheckboxes" class="form-label">Équipements</label>
                        <div id="editAmenitiesCheckboxes">
                            <!-- Dynamically generate checkboxes here -->
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Modifier</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        const buildingsTable = $('#buildingsTable').DataTable({
            ajax: {
                url: 'owner?action=getBuildings',
                dataSrc: ''
            },
            columns: [
                {data: 'address'},
                {data: 'description'},
                {data: 'floorNumber'},
                {
                    data: 'imgPath',
                    render: function (data) {
                        return "<img src='/immoplus_war_exploded/"+data+"'"+"alt='Image' style='width: 100px; height: auto;'>";
                    }
                },
                {
                    data: null,
                    render: function (data) {
                        return "<button class='btn btn-primary btn-sm edit-btn' data-id='"+data.id+"'>Modifier</button><button class='btn btn-danger btn-sm delete-btn' style='margin-left: 10px;'  data-id='"+data.id+"'>Supprimer</button>";
                    }
                }
            ]
        });

        // Fetch amenities and populate the checkboxes
        function fetchAmenities() {
            $.ajax({
                type: 'GET',
                url: 'owner?action=getAmenities',
                success: function(data) {
                    var checkboxes = '';
                    data.forEach(function(amenity) {
                        checkboxes += '<div class="form-check">' +
                            '<input class="form-check-input" type="checkbox" name="amenities" value="' + amenity.id + '" id="amenity' + amenity.id + '">' +
                            '<label class="form-check-label" for="amenity' + amenity.id + '">' + amenity.name + '</label>' +
                            '</div>';
                    });
                    $('#amenitiesCheckboxes').html(checkboxes);
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

        fetchAmenities();

        $('#addBuildingButton').on('click', function () {
            $('#addBuildingModal').modal('show');
        });

        $('#addBuildingForm').on('submit', function (e) {
            e.preventDefault();
            if (!validateBuildingForm('#addBuildingForm')) {
                return;
            }
            var formData = new FormData(this);

            $.ajax({
                type: 'POST',
                url: 'owner?action=addBuilding',
                data: formData,
                processData: false,
                contentType: false,
                success: function () {
                    buildingsTable.ajax.reload();
                    $('#addBuildingModal').modal('hide');
                    Swal.fire('Succès', 'Immeuble ajouté avec succès', 'success');
                },
                error: function () {
                    Swal.fire('Erreur', "Erreur lors de l'ajout de l'immeuble", 'error');
                }
            });
        });

        // Bouton pour ouvrir le modal d'édition
        $('#buildingsTable').on('click', '.edit-btn', function () {
            var buildingId = $(this).data('id');
            $.ajax({
                type: 'GET',
                url: 'owner?action=getBuildingDetails',
                data: {buildingId: buildingId},
                success: function (data) {
                    $('#editBuildingId').val(data.building.id);
                    $('#editAddress').val(data.building.address);
                    $('#editDescription').val(data.building.description);
                    $('#editFloorNumber').val(data.building.floorNumber);
                    $('#editAmenitiesCheckboxes').empty();
                    data.amenities.forEach(function (amenity) {
                        var isChecked = data.buildingAmenities.includes(amenity.id) ? 'checked' : '';
                        $('#editAmenitiesCheckboxes').append(
                            '<div class="form-check">' +
                            '<input class="form-check-input" type="checkbox" name="amenities" value="' + amenity.id + '" id="editAmenity' + amenity.id + '" ' + isChecked + '>' +
                            '<label class="form-check-label" for="editAmenity' + amenity.id + '">' + amenity.name + '</label>' +
                            '</div>'
                        );
                    });
                    $('#editBuildingModal').modal('show');
                },
                error: function () {
                    Swal.fire('Erreur', "Erreur lors de la récupération des détails de l'immeuble", 'error');
                }
            });
        });

        // Formulaire de modification
        $('#editBuildingForm').on('submit', function (e) {
            e.preventDefault();
            if (!validateBuildingForm('#editBuildingForm')) {
                return;
            }
            var formData = new FormData(this);
            formData.append('userId', $('#currentUserId').val());
            $.ajax({
                type: 'POST',
                url: 'owner?action=updateBuilding',
                data: formData,
                processData: false,
                contentType: false,
                success: function () {
                    buildingsTable.ajax.reload();
                    $('#editBuildingModal').modal('hide');
                    Swal.fire('Succès', 'Immeuble modifié avec succès', 'success');
                },
                error: function () {
                    Swal.fire('Erreur', "Erreur lors de la modification de l'immeuble", 'error');
                }
            });
        });

        // Bouton pour ouvrir le modal de suppression
        $('#buildingsTable').on('click', '.delete-btn', function () {
            var buildingId = $(this).data('id');
            Swal.fire({
                title: 'Êtes-vous sûr?',
                text: 'Vous ne pourrez pas revenir en arrière! Tous les appartements associés seront également supprimés.',
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
                        url: 'owner?action=deleteBuilding',
                        data: { buildingId: buildingId },
                        success: function () {
                            buildingsTable.ajax.reload();
                            Swal.fire(
                                'Supprimé!',
                                'L\'immeuble et tous les appartements associés ont été supprimés.',
                                'success'
                            );
                        },
                        error: function () {
                            Swal.fire('Erreur', "Erreur lors de la suppression de l'immeuble", 'error');
                        }
                    });
                }
            });
        });

        function validateBuildingForm(formSelector) {
            let isValid = true;
            const form = $(formSelector);

            form.find('input, textarea').each(function () {
                if (!$(this).val()) {
                    isValid = false;
                    Swal.fire('Erreur', 'Tous les champs doivent être remplis.', 'error');
                    return false;  // break the loop
                }

                const value = parseInt($(this).val());
                if ($(this).attr('type') === 'number' && value < 0) {
                    isValid = false;
                    Swal.fire('Erreur', 'Les valeurs numériques doivent être positives.', 'error');
                    return false;  // break the loop
                }
            });

            return isValid;
        }
    });
</script>
