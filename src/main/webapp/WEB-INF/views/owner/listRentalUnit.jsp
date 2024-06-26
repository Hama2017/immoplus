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
    <h1 class="page-title">Gestion Appartements</h1>
</div>
<div class="row row-sm">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <button id="addApartmentButton" class="btn btn-primary float-end">Ajouter Appartement</button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="apartmentsListTable" class="table border text-nowrap text-md-nowrap table-hover mb-0">
                        <thead>
                        <tr>
                            <th>Numéro</th>
                            <th>Description</th>
                            <th>Niveau</th>
                            <th>Nombre de pièces</th>
                            <th>Surface</th>
                            <th>Loyer mensuel</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody id="apartmentsListTableBody"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Ajouter Appartement -->
<div class="modal fade" id="addApartmentModal" tabindex="-1" aria-labelledby="addApartmentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addApartmentModalLabel">Ajouter Appartement</h5>
            </div>
            <div class="modal-body">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

                <form id="addApartmentForm">
                    <div class="mb-3">
                        <label for="buildingSelect" class="form-label">Immeuble</label>
                        <select class="form-select" id="buildingSelect" name="buildingId" required>
                            <!-- Options will be populated dynamically -->
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="unitNumber" class="form-label">Numéro d'unité</label>
                        <input type="text" class="form-control" id="unitNumber" name="unitNumber" required>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" name="description" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="floorLevel" class="form-label">Niveau</label>
                        <input type="number" class="form-control" id="floorLevel" name="floorLevel" required>
                    </div>
                    <div class="mb-3">
                        <label for="numberOfRooms" class="form-label">Nombre de pièces</label>
                        <input type="number" class="form-control" id="numberOfRooms" name="numberOfRooms" required>
                    </div>
                    <div class="mb-3">
                        <label for="area" class="form-label">Surface (m²)</label>
                        <input type="number" class="form-control" id="area" name="area" required>
                    </div>
                    <div class="mb-3">
                        <label for="monthlyRent" class="form-label">Loyer mensuel</label>
                        <input type="number" class="form-control" id="monthlyRent" name="monthlyRent" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Ajouter</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Modifier Appartement -->
<div class="modal fade" id="editApartmentModal" tabindex="-1" aria-labelledby="editApartmentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editApartmentModalLabel">Modifier Appartement</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editApartmentForm">
                    <input type="hidden" id="editApartmentId" name="id">
                    <div class="mb-3">
                        <label for="editBuildingSelect" class="form-label">Immeuble</label>
                        <select class="form-select" id="editBuildingSelect" name="buildingId" required>
                            <!-- Options will be populated dynamically -->
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="editUnitNumber" class="form-label">Numéro d'unité</label>
                        <input type="text" class="form-control" id="editUnitNumber" name="unitNumber" required>
                    </div>
                    <div class="mb-3">
                        <label for="editDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="editDescription" name="description" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="editFloorLevel" class="form-label">Niveau</label>
                        <input type="number" class="form-control" id="editFloorLevel" name="floorLevel" required>
                    </div>
                    <div class="mb-3">
                        <label for="editNumberOfRooms" class="form-label">Nombre de pièces</label>
                        <input type="number" class="form-control" id="editNumberOfRooms" name="numberOfRooms" required>
                    </div>
                    <div class="mb-3">
                        <label for="editArea" class="form-label">Surface (m²)</label>
                        <input type="number" class="form-control" id="editArea" name="area" required>
                    </div>
                    <div class="mb-3">
                        <label for="editMonthlyRent" class="form-label">Loyer mensuel</label>
                        <input type="number" class="form-control" id="editMonthlyRent" name="monthlyRent" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Modifier</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        const apartmentsTable = $('#apartmentsListTable').DataTable({
            ajax: {
                url: 'owner?action=getApartments',
                dataSrc: ''
            },
            columns: [
                {data: 'unitNumber'},
                {data: 'description'},
                {data: 'floorLevel'},
                {data: 'numberOfRooms'},
                {data: 'area'},
                {data: 'monthlyRent'},
                {
                    data: null,
                    render: function (data) {
                        return "<button class='btn btn-primary btn-sm edit-btn' data-id='"+data.id+"'>Modifier</button><button class='btn btn-danger btn-sm delete-btn' style='margin-left: 10px;'  data-id='"+data.id+"'>Supprimer</button>";
                        ;
                    }
                }
            ]
        });

        $('#addApartmentButton').on('click', function () {
            $('#addApartmentModal').modal('show');
            fetchBuildings('#buildingSelect');
        });

        $('#addApartmentForm').on('submit', function (e) {
            e.preventDefault();
            if (!validateApartmentForm('#addApartmentForm')) {
                return;
            }
            var formData = $(this).serialize();
            $.post('owner?action=addApartment', formData, function () {
                apartmentsTable.ajax.reload();
                $('#addApartmentModal').modal('hide');
                Swal.fire('Succès', 'Appartement ajouté avec succès', 'success');
            }).fail(function () {
                Swal.fire('Erreur', "Erreur lors de l'ajout de l'appartement", 'error');
            });
        });

        $('#apartmentsListTableBody').on('click', '.edit-btn', function () {
            const apartmentId = $(this).data('id');
            $.get("owner?action=findApartmentById&id="+apartmentId+"", function (data) {
                $('#editApartmentId').val(data.id);
                $('#editBuildingSelect').val(data.buildingId);
                $('#editUnitNumber').val(data.unitNumber);
                $('#editDescription').val(data.description);
                $('#editFloorLevel').val(data.floorLevel);
                $('#editNumberOfRooms').val(data.numberOfRooms);
                $('#editArea').val(data.area);
                $('#editMonthlyRent').val(data.monthlyRent);
                $('#editApartmentModal').modal('show');
                fetchBuildings('#editBuildingSelect', data.buildingId);
            });
        });

        $('#editApartmentForm').on('submit', function (e) {
            e.preventDefault();
            if (!validateApartmentForm('#editApartmentForm')) {
                return;
            }
            var formData = $(this).serialize();
            const apartmentId = $('#editApartmentId').val();
            $.ajax({
                url: "owner?action=updateApartment&id="+apartmentId,
                type: 'POST',
                data: formData,
                success: function () {
                    apartmentsTable.ajax.reload();
                    $('#editApartmentModal').modal('hide');
                    Swal.fire('Succès', 'Appartement modifié avec succès', 'success');
                },
                error: function () {
                    Swal.fire('Erreur', "Erreur lors de la modification de l'appartement", 'error');
                }
            });
        });

        $('#apartmentsListTableBody').on('click', '.delete-btn', function () {
            const apartmentId = $(this).data('id');
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
                        url: "owner?action=deleteApartment&id="+apartmentId,
                        type: 'POST',
                        success: function () {
                            apartmentsTable.ajax.reload();
                            Swal.fire('Supprimé!', "L'appartement a été supprimé.", 'success');
                        },
                        error: function () {
                            Swal.fire('Erreur', "Erreur lors de la suppression de l'appartement", 'error');
                        }
                    });
                }
            });
        });

        function fetchBuildings(selector, selectedId = null) {
            $.get('owner?action=getBuildings', function (data) {
                var options = '<option value="">Sélectionner un immeuble</option>';
                data.forEach(function (building) {
                    options += '<option value="' + building.id + '"' + (selectedId == building.id ? ' selected' : '') + '>' + building.address + '</option>';
                });
                $(selector).html(options);
            });
        }

        function validateApartmentForm(formSelector) {
            let isValid = true;
            const form = $(formSelector);

            form.find('input, textarea, select').each(function () {
                if (!$(this).val()) {
                    isValid = false;
                    Swal.fire('Erreur', 'Tous les champs doivent être remplis.', 'error');
                    return false;  // break the loop
                }

                const value = parseInt($(this).val());
                if ($(this).attr('type') === 'number' && value < 0) {
                    isValid = false;
                    Swal.fire('Erreur', 'Les valeurs doivent être positives.', 'error');
                    return false;  // break the loop
                }
            });

            return isValid;
        }
    });
</script>
