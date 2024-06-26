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
                <div class="legend mt-1 mb-5">
                    <span class="badge bg-success">Validé</span>
                    <span class="badge bg-warning">En attente</span>
                    <span class="badge bg-danger">Refusé</span>
                    <span class="badge bg-primary">Contrat signé</span>
                </div>
                <table id="requestsTable" class="table table-bordered">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Immeuble</th>
                        <th>Appartement</th>
                        <th>Date de début prévue</th>
                        <th>Nombre de mois prévue</th>
                        <th>Statut</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Contenu généré dynamiquement par AJAX -->
                    </tbody>
                </table>

            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        loadRentRequests();

        function loadRentRequests() {
            $.ajax({
                url: "tenant?action=getRentRequests",
                type: "GET",
                success: function(data) {

                    console.log(data)
                    var tableBody = $("#requestsTable tbody");
                    tableBody.empty();
                    data.forEach(function(request) {

                        console.log(request)
                        var statusClass = '';
                        switch (request.rentRequest.status) {
                            case 'Validée':
                                statusClass = 'bg-success';
                                break;
                            case 'En attente':
                                statusClass = 'bg-warning';
                                break;
                            case 'Refusé':
                                statusClass = 'bg-danger';
                                break;
                            case 'Contrat':
                                statusClass = 'bg-primary';
                                break;
                        }
                        var row = "<tr>" +
                            "<td>DL" + request.rentRequest.id + "</td>" +
                            "<td>" + request.building.description + "</td>" +
                            "<td>" + request.rentalUnit.unitNumber + "</td>" +
                            "<td>" + request.rentRequest.expectedStartDate + "</td>" +
                            "<td>" + request.rentRequest.personsNumber + "</td>" +
                            "<td><span class='badge " + statusClass + "'>" + request.rentRequest.status + "</span></td>" +
                            "</tr>";
                        tableBody.append(row);
                    });
                },
                error: function() {
                    alert('Erreur lors du chargement des demandes de location');
                }
            });
        }
    });
</script>
