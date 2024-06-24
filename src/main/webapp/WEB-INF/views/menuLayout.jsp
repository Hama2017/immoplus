<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="main-sidemenu">
    <div class="slide-left disabled" id="slide-left">
        <svg xmlns="http://www.w3.org/2000/svg" fill="#7b8191" width="24" height="24" viewBox="0 0 24 24">
            <path d="M13.293 6.293L7.586 12l5.707 5.707-1.414 1.414L10.414 12l-4.293-4.293z" />
        </svg>
    </div>
    <ul class="side-menu">

        <c:choose>
            <c:when test="${not empty sessionScope.user}">

                <c:choose>
                    <c:when test="${sessionScope.user.role == 'admin'}">
                        <li class="slide">
                            <a class="side-menu__item has-link" data-bs-toggle="slide" href="admin?action=dashboard">
                                <i class="side-menu__icon fe fe-home"></i>
                                <span class="side-menu__label">Dashboard</span>
                            </a>
                        </li>
                        <li class="slide">
                            <a class="side-menu__item" data-bs-toggle="slide" href="admin?action=userManage">
                                <i class="side-menu__icon fe fe-users"></i>
                                <span class="side-menu__label">Utilisateurs</span>
                                <i class="angle fe fe-chevron-right"></i>
                            </a>
                        </li>
                        <li class="slide">
                            <a class="side-menu__item" data-bs-toggle="slide" href="admin?action=rapports">
                                <i class="side-menu__icon fe fe-file"></i>
                                <span class="side-menu__label">Rapports</span>
                                <i class="angle fe fe-chevron-right"></i>
                            </a>
                        </li>
                        <li class="slide">
                            <a class="side-menu__item" data-bs-toggle="slide" href="admin?action=configurations">
                                <i class="side-menu__icon fe fe-settings"></i>
                                <span class="side-menu__label">Configurations</span>
                                <i class="angle fe fe-chevron-right"></i>
                            </a>
                        </li>
                    </c:when>
                    <c:when test="${sessionScope.user.role == 'proprietaire'}">
                        <li class="slide">
                        <a class="side-menu__item has-link" data-bs-toggle="slide" href="owner?action=dashboard">
                            <i class="side-menu__icon fe fe-home"></i>
                            <span class="side-menu__label">Dashboard</span>
                        </a>
                    </li>
                        <li class="slide">
                            <a class="side-menu__item" data-bs-toggle="slide" href="owner?action=listBuilding">
                                <i class="side-menu__icon fe fe-slack"></i>
                                <span class="side-menu__label">Immeubles</span>
                                <i class="angle fe fe-chevron-right"></i>
                            </a>
                        </li>
                        <li class="slide">
                            <a class="side-menu__item" data-bs-toggle="slide" href="owner?action=listRentalUnit">
                                <i class="side-menu__icon fe fe-slack"></i>
                                <span class="side-menu__label">Appartements</span>
                                <i class="angle fe fe-chevron-right"></i>
                            </a>
                        </li>
                        <li class="slide">
                            <a class="side-menu__item" data-bs-toggle="slide" href="javascript:void(0)">
                                <i class="side-menu__icon fe fe-slack"></i>
                                <span class="side-menu__label">Locations</span>
                                <i class="angle fe fe-chevron-right"></i>
                            </a>
                            <ul class="slide-menu open">
                                <li class="panel sidetab-menu">
                                    <div class="panel-body tabs-menu-body p-0 border-0">
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="side13" role="tabpanel">
                                                <ul class="sidemenu-list">
                                                    <li><a href="owner?action=listRequestRent" class="slide-item">Demandes</a></li>
                                                    <li><a href="owner?action=listRentalContract" class="slide-item">Contrats</a></li>
                                                    <li><a href="owner?action=listPayment" class="slide-item">Paiements</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </c:when>
                    <c:when test="${sessionScope.user.role == 'locataire'}">
                        <li class="slide">
                            <a class="side-menu__item has-link" data-bs-toggle="slide" href="tenant?action=listOffers">
                                <i class="side-menu__icon fe fe-home"></i>
                                <span class="side-menu__label">Offres</span>
                            </a>
                        </li>
                        <li class="slide">
                            <a class="side-menu__item" data-bs-toggle="slide" href="tenant?action=listRequestRent">
                                <i class="side-menu__icon fe fe-users"></i>
                                <span class="side-menu__label">Demandes</span>
                                <i class="angle fe fe-chevron-right"></i>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <!-- Contenu pour les autres rôles -->
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <!-- Contenu lorsque la session est nulle -->
            </c:otherwise>
        </c:choose>



    </ul>
    <div class="slide-right" id="slide-right">
        <svg xmlns="http://www.w3.org/2000/svg" fill="#7b8191" width="24" height="24" viewBox="0 0 24 24">
            <path d="M10.707 17.707L16.414 12l-5.707-5.707-1.414 1.414L13.586 12l-4.293 4.293z" />
        </svg>
    </div>
</div>
