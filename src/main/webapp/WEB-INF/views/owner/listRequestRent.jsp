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
    <h1 class="page-title">Gestion Demandes</h1>
</div>

<div class="row row-sm">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Demandes location</h3>
            </div>
            <div class="card-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom du Locataire</th>
                        <th>Appartement</th>
                        <th>Date de début prévue</th>
                        <th>Nombre de mois</th>
                        <th>Nombre de personnes</th>
                        <th>Statut</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody id="requestsTableBody">
                    </tbody>
                </table>
                <div class="mt-3">
                    <span class="badge bg-success">Validée</span>
                    <span class="badge bg-warning text-dark">En attente</span>
                    <span class="badge bg-danger">Refusée</span>
                    <span class="badge bg-primary">Contrat signé</span>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        loadRequests();

        function loadRequests() {
            $.ajax({
                url: "owner?action=getRequests",
                type: "GET",
                success: function(data) {
                    var requestsHTML = "";
                    data.forEach(function(request) {
                        requestsHTML += "<tr>" +
                            "<td>" + request.rentRequest.id + "</td>" +
                            "<td>" + request.user.firstName +" "+ request.user.lastName + "</td>" +
                            "<td>" + request.rentalUnit.description + "</td>" +
                            "<td>" + request.rentRequest.expectedStartDate + "</td>" +
                            "<td>" + request.rentRequest.monthsNumber + "</td>" +
                            "<td>" + request.rentRequest.personsNumber + "</td>" +
                            "<td>" + getStatusBadge(request.rentRequest.status) + "</td>";

                        if (request.rentRequest.status === "En attente") {
                            requestsHTML += "<td>" +
                                "<button class='btn btn-success btn-sm' onclick='updateRequestStatus(" + request.rentRequest.id + ", \"Validée\")'>Accepter</button> " +
                                "<button class='btn btn-danger btn-sm' onclick='updateRequestStatus(" + request.rentRequest.id + ", \"Refusée\")'>Refuser</button>" +
                                "</td>";
                        } else {
                            requestsHTML += "<td></td>";
                        }

                        requestsHTML += "</tr>";
                    });
                    $('#requestsTableBody').html(requestsHTML);
                },
                error: function() {
                    Swal.fire('Erreur', "Erreur lors du chargement des demandes", 'error');
                }
            });
        }

        function getStatusBadge(status) {
            switch (status) {
                case "Validée":
                    return "<span class='badge bg-success'>" + status + "</span>";
                case "En attente":
                    return "<span class='badge bg-warning text-dark'>" + status + "</span>";
                case "Refusée":
                    return "<span class='badge bg-danger'>" + status + "</span>";
                case "Contrat signé":
                    return "<span class='badge bg-primary'>" + status + "</span>";
                default:
                    return status;
            }
        }

        window.updateRequestStatus = function(requestId, newStatus) {
            Swal.fire({
                title: 'Êtes-vous sûr?',
                text: "Vous ne pourrez pas revenir en arrière!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Oui, changer le statut!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: "owner?action=updateRequestStatus",
                        type: "POST",
                        data: {
                            id: requestId,
                            status: newStatus
                        },
                        success: function() {
                            loadRequests();
                            Swal.fire('Succès', 'Statut de la demande mis à jour avec succès', 'success');
                        },
                        error: function() {
                            Swal.fire('Erreur', "Erreur lors de la mise à jour du statut de la demande", 'error');
                        }
                    });
                }
            });
        }
    });
</script>
