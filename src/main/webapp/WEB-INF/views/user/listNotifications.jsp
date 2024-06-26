<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="sn.kd.immoplus.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // Redirect to login page or show an error message
        return;
    }
%>
<div class="page-header">
    <h1 class="page-title">Notifications</h1>
</div>

<div class="container">
    <ul class="notification" id="notificationsContainer">
        <!-- Notifications will be loaded here via AJAX -->
    </ul>
</div>

<%--<a class="btn btn-icon btn-danger" href="user?action=deleteAllNotificationUser">Tout supprimer <i class="fe fe-trash"></i> </a>--%>

<script>
    $(document).ready(function() {
        function loadNotifications() {
            $.ajax({
                url: 'user?action=getNotifications',
                method: 'GET',
                success: function(data) {
                    var notificationsHTML = '';
                    data.forEach(function(notification) {
                        notificationsHTML +=
                            '<li>' +
                            '<div class="notification-time">' +
                            '<span class="date">Date</span>' +
                            '<span class="time">' + notification.dateCreated + '</span>' +
                            '</div>' +
                            '<div class="notification-body">' +
                            '<div class="media mt-0">' +
                            '<div class="media-body ms-3 d-flex">' +
                            '<div class="">' +
                            '<p class="fs-15 text-dark fw-bold mb-0">' + notification.title +
                            (notification.status == 0 ? ' <span class="badge bg-warning ms-3 px-2 pb-1 mb-1">Nouveau</span>' : '') +
                            '</p>' +
                            '<div class="mb-0 fs-13 text-dark">' + notification.content + '</div>' +
                            '</div>' +
                            '<div class="notify-time mt-3">' +
                            (notification.status == 0 ?  '<a class="btn btn-icon btn-success" href="user?action=viewedNotification&idNotification=' + notification.id + '"><i class="fe fe-check"></i></a>' : '')+
                            '<a class="btn btn-icon btn-danger" href="user?action=deleteNotification&idNotification=' + notification.id + '"><i class="fe fe-trash"></i></a>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</li>';
                    });
                    $('#notificationsContainer').html(notificationsHTML);
                }
            });
        }

        loadNotifications();
    });
</script>
