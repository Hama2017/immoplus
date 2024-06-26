<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="sn.kd.immoplus.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // Redirect to login page or show an error message
        return;
    }
%>
<input type="hidden" id="currentUserId" value="<%= user.getId() %>">
<div class="page-header">
    <h1 class="page-title">Gestion Contrats</h1>
</div>
<div class="row row-sm">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <button class="btn btn-primary float-end" data-bs-toggle="modal" data-bs-target="#addContractModal">Ajouter Contrat</button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="contractsTable" class="table table-bordered text-nowrap">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Locataire</th>
                            <th>Appartement</th>
                            <th>Date de début</th>
                            <th>Date de fin</th>
                            <th>Montant</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Les contrats seront chargés ici par AJAX -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Ajouter Contrat -->
<div class="modal fade" id="addContractModal" tabindex="-1" aria-labelledby="addContractModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addContractModalLabel">Ajouter Contrat</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addContractForm">
                    <div class="mb-3">
                        <label for="tenantSelect" class="form-label">Demande / Locataire</label>
                        <select class="form-select" id="tenantSelect" name="requestId" required>
                            <!-- Les locataires seront chargés ici par AJAX -->
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="startDate" class="form-label">Date de début</label>
                        <input type="date" class="form-control" id="startDate" name="startDate" required>
                    </div>
                    <div class="mb-3">
                        <label for="endDate" class="form-label">Date de fin</label>
                        <input type="date" class="form-control" id="endDate" name="endDate" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Ajouter</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        // Charger les contrats existants
        function loadContracts() {
            $.ajax({
                url: 'owner?action=getContracts',
                method: 'GET',
                success: function (contracts) {
                    var tbody = $('#contractsTable tbody');
                    tbody.empty();
                    contracts.forEach(function (contract) {
                        console.log(contract)

                        var row = "<tr>" +
                            "<td>C" + contract.rentalContract.id + "</td>" +
                            "<td>" + contract.tenant.firstName +" "+ contract.tenant.lastName + "</td>" +
                            "<td>" + contract.rentalUnit.description + "</td>" +
                            "<td>" + contract.rentalContract.startDate + "</td>" +
                            "<td>" + contract.rentalContract.endDate + "</td>" +
                            "<td>" + contract.rentalContract.amount + "</td>" +
                            "<td>" + contract.rentalContract.status + "</td>";
                        if (contract.rentalContract.status === "Validée") {
                            row += "<td><button class='btn btn-danger btn-sm terminate-btn' data-id='" + contract.rentalContract.id + "'>Résilier</button></td>";
                        }
                        row += +"</tr>";


                        tbody.append(row);
                    });
                },
                error: function () {
                    Swal.fire('Erreur', 'Erreur lors du chargement des contrats', 'error');
                }
            });
        }

        // Charger les locataires pour le formulaire d'ajout de contrat
        function loadTenants() {
            $.ajax({
                url: 'owner?action=getAcceptedTenants',
                method: 'GET',
                success: function (tenants) {
                    console.log(tenants)
                    var tenantSelect = $('#tenantSelect');
                    tenantSelect.empty();
                    tenantSelect.append('<option value="">Sélectionner un locataire</option>');
                    tenants.forEach(function (tenant) {
                        var option = "<option value='" + tenant.rentRequest.id + "'>DL" + tenant.rentRequest.id + " - " + tenant.user.firstName + " " + tenant.user.lastName + "/APP-" + tenant.rentalUnit.unitNumber + " </option>";
                        tenantSelect.append(option);
                    });
                },
                error: function () {
                    Swal.fire('Erreur', 'Erreur lors du chargement des locataires', 'error');
                }
            });
        }

        // Ajouter un contrat
        $('#addContractForm').on('submit', function (e) {
            e.preventDefault();

            // Validation des dates
            var startDate = $('#startDate').val();
            var endDate = $('#endDate').val();
            if (new Date(startDate) > new Date(endDate)) {
                Swal.fire('Erreur', 'La date de début ne peut pas être postérieure à la date de fin.', 'error');
                return;
            }

            // Validation du sélecteur de contrat
            var tenantSelect = $('#tenantSelect').val();
            if (!tenantSelect) {
                Swal.fire('Erreur', 'Il n\'y a pas de demande valide.', 'error');
                return;
            }

            var formData = $(this).serialize();
            $.ajax({
                url: 'owner?action=addContract',
                method: 'POST',
                data: formData,
                success: function () {
                    $('#addContractModal').modal('hide');
                    Swal.fire('Succès', 'Contrat ajouté avec succès', 'success');
                    loadContracts();
                },
                error: function () {
                    Swal.fire('Erreur', "Erreur lors de l'ajout du contrat", 'error');
                }
            });
        });

        $('#contractsTable tbody').on('click', '.terminate-btn', function() {
            var contractId = $(this).data('id');
            Swal.fire({
                title: 'Êtes-vous sûr?',
                text: "Vous ne pourrez pas revenir en arrière!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Oui, résilier!',
                cancelButtonText: 'Annuler'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: 'owner?action=terminateContract',
                        type: 'POST',
                        data: { contractId: contractId },
                        success: function(response) {
                            Swal.fire(
                                'Résilié!',
                                'Le contrat a été résilié.',
                                'success'
                            );
                            loadContracts();
                        },
                        error: function() {
                            Swal.fire(
                                'Erreur!',
                                'Erreur lors de la résiliation du contrat.',
                                'error'
                            );
                        }
                    });
                }
            });
        });

        // Charger les données initiales
        loadContracts();
        loadTenants();
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
