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
    <h1 class="page-title">Gestion Paiements</h1>
</div>

<div class="row row-sm">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Sélectionner un contrat</h3>
                <select id="contractSelect" class="form-select">
                    <option value="">Sélectionner un contrat</option>
                </select>
                <button id="loadPaymentsBtn" class="btn btn-primary">Charger paiements</button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="paymentsTable" class="table border text-nowrap text-md-nowrap table-hover mb-0">
                        <thead>
                        <tr>
                            <th>Date de paiement</th>
                            <th>Montant</th>
                            <th>Status</th>
                            <th>Date de paiement effective</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody id="paymentsTableBody"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        // Load contracts on page load
        loadContracts();

        function loadContracts() {
            const userId = $('#currentUserId').val();
            $.ajax({
                url: "owner?action=getContractsByUser",
                type: "GET",
                data: { userId: userId },
                success: function(contracts) {
                    contracts.forEach(function(contract) {
                        $('#contractSelect').append("<option value='" + contract.id + "'>Contract ID: " + contract.id + "</option>");
                    });
                },
                error: function() {
                    alert('Erreur lors du chargement des contrats');
                }
            });
        }

        // Load payments on button click
        $('#loadPaymentsBtn').click(function () {
            const contractId = $('#contractSelect').val();
            if (contractId) {
                loadPayments(contractId);
            } else {
                alert('Veuillez sélectionner un contrat');
            }
        });

        function loadPayments(contractId) {
            $.ajax({
                url: 'owner?action=getPaymentsByContract&contractId=' + contractId,
                type: 'GET',
                success: function(data) {
                    var paymentsHTML = '';
                    data.forEach(function(payment) {
                        paymentsHTML += '<tr>' +
                            '<td>' + payment.paymentDate + '</td>' +
                            '<td>' + payment.amount + ' €</td>' +
                            '<td>' + payment.status + '</td>' +
                            '<td>';
                        if (payment.paidDate == null) {
                            paymentsHTML += '<button class="btn btn-success pay-btn" data-id="' + payment.id + '">Payer</button>';
                        } else {
                            paymentsHTML += '<button class="btn btn-info download-receipt-btn" data-id="' + payment.id + '">Télécharger Reçu</button>';
                        }
                        paymentsHTML += '</td>' +
                            '</tr>';
                    });
                    $('#paymentsTableBody').html(paymentsHTML);
                },
                error: function() {
                    alert('Erreur lors du chargement des paiements');
                }
            });
        }

        $('#paymentsTableBody').on('click', '.download-receipt-btn', function() {
            var paymentId = $(this).data('id');
            window.location.href = 'pdf?action=downloadReceipt&paymentId=' + paymentId;
        });

        // Handle payment
        $('#paymentsTableBody').on('click', '.pay-btn', function () {
            const paymentId = $(this).data('id');
            Swal.fire({
                title: 'Êtes-vous sûr?',
                text: "Vous ne pourrez pas revenir en arrière!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Oui, payer!',
                cancelButtonText: 'Annuler'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: "owner?action=payPayment",
                        type: "POST",
                        data: { paymentId: paymentId },
                        success: function () {
                            Swal.fire('Payé!', 'Le paiement a été effectué.', 'success');
                            const contractId = $('#contractSelect').val();
                            loadPayments(contractId);
                        },
                        error: function () {
                            Swal.fire('Erreur', "Erreur lors du paiement.", 'error');
                        }
                    });
                }
            });
        });
    });
</script>
