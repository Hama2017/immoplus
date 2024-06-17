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
                            <a class="side-menu__item has-link" data-bs-toggle="slide" href="index.html">
                                <i class="side-menu__icon fe fe-home"></i>
                                <span class="side-menu__label">Dashboard A</span>
                            </a>
                        </li>
                        <li class="slide">
                            <a class="side-menu__item" data-bs-toggle="slide" href="javascript:void(0)">
                                <i class="side-menu__icon fe fe-slack"></i>
                                <span class="side-menu__label">Utilisateurs</span>
                                <i class="angle fe fe-chevron-right"></i>
                            </a>
                        </li>
                        <li class="slide">
                            <a class="side-menu__item" data-bs-toggle="slide" href="javascript:void(0)">
                                <i class="side-menu__icon fe fe-slack"></i>
                                <span class="side-menu__label">Rapports</span>
                                <i class="angle fe fe-chevron-right"></i>
                            </a>
                        </li>
                        <li class="slide">
                            <a class="side-menu__item" data-bs-toggle="slide" href="javascript:void(0)">
                                <i class="side-menu__icon fe fe-slack"></i>
                                <span class="side-menu__label">Configurations</span>
                                <i class="angle fe fe-chevron-right"></i>
                            </a>
                        </li>
                    </c:when>
                    <c:when test="${sessionScope.user.role == 'tenant'}">
                        <li class="slide">
                        <a class="side-menu__item has-link" data-bs-toggle="slide" href="index.html">
                            <i class="side-menu__icon fe fe-home"></i>
                            <span class="side-menu__label">Dashboard T</span>
                        </a>
                    </li>
                        <li class="slide">
                            <a class="side-menu__item" data-bs-toggle="slide" href="javascript:void(0)">
                                <i class="side-menu__icon fe fe-slack"></i>
                                <span class="side-menu__label">Utilisateurs</span>
                                <i class="angle fe fe-chevron-right"></i>
                            </a>
                        </li>
                        <li class="slide">
                            <a class="side-menu__item" data-bs-toggle="slide" href="javascript:void(0)">
                                <i class="side-menu__icon fe fe-slack"></i>
                                <span class="side-menu__label">Rapports</span>
                                <i class="angle fe fe-chevron-right"></i>
                            </a>
                        </li>
                        <li class="slide">
                            <a class="side-menu__item" data-bs-toggle="slide" href="javascript:void(0)">
                                <i class="side-menu__icon fe fe-slack"></i>
                                <span class="side-menu__label">Configurations</span>
                                <i class="angle fe fe-chevron-right"></i>
                            </a>
                        </li>
                    </c:when>
                    <c:when test="${sessionScope.user.role == 'owner'}">
                        <!-- Contenu pour le proprietaire -->
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
