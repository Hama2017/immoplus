<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="sn.kd.immoplus.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // Redirect to login page or show an error message
    }
%>
<input type="hidden" id="currentUserId" value="<%= user.getId() %>">
    <!-- PAGE-HEADER -->
    <div class="page-header">
        <h1 class="page-title">Dashboard Admin</h1>
    </div>
    <!-- PAGE-HEADER END -->

    <!-- ROW-1 -->
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xl-12">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-12 col-xl-3">
                    <div class="card overflow-hidden">
                        <div class="card-body">
                            <div class="d-flex">
                                <div class="mt-2">
                                    <h6 class="">Total Users</h6>
                                    <h2 class="mb-0 number-font">44,278</h2>
                                </div>
                                <div class="ms-auto">
                                    <div class="chart-wrapper mt-1">
                                        <canvas id="saleschart" class="h-8 w-9 chart-dropshadow" style="display: block; box-sizing: border-box; height: 64px; width: 96px;" width="192" height="128"></canvas>
                                    </div>
                                </div>
                            </div>
                            <span class="text-muted fs-12"><span class="text-secondary"><i class="fe fe-arrow-up-circle  text-secondary"></i> 5%</span>
                                                    Last week</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-12 col-xl-3">
                    <div class="card overflow-hidden">
                        <div class="card-body">
                            <div class="d-flex">
                                <div class="mt-2">
                                    <h6 class="">Total Profit</h6>
                                    <h2 class="mb-0 number-font">67,987</h2>
                                </div>
                                <div class="ms-auto">
                                    <div class="chart-wrapper mt-1">
                                        <canvas id="leadschart" class="h-8 w-9 chart-dropshadow" style="display: block; box-sizing: border-box; height: 64px; width: 96px;" width="192" height="128"></canvas>
                                    </div>
                                </div>
                            </div>
                            <span class="text-muted fs-12"><span class="text-pink"><i class="fe fe-arrow-down-circle text-pink"></i> 0.75%</span>
                                                    Last 6 days</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-12 col-xl-3">
                    <div class="card overflow-hidden">
                        <div class="card-body">
                            <div class="d-flex">
                                <div class="mt-2">
                                    <h6 class="">Total Expenses</h6>
                                    <h2 class="mb-0 number-font">$76,965</h2>
                                </div>
                                <div class="ms-auto">
                                    <div class="chart-wrapper mt-1">
                                        <canvas id="profitchart" class="h-8 w-9 chart-dropshadow" style="display: block; box-sizing: border-box; height: 64px; width: 96px;" width="192" height="128"></canvas>
                                    </div>
                                </div>
                            </div>
                            <span class="text-muted fs-12"><span class="text-green"><i class="fe fe-arrow-up-circle text-green"></i> 0.9%</span>
                                                    Last 9 days</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-12 col-xl-3">
                    <div class="card overflow-hidden">
                        <div class="card-body">
                            <div class="d-flex">
                                <div class="mt-2">
                                    <h6 class="">Total Cost</h6>
                                    <h2 class="mb-0 number-font">$59,765</h2>
                                </div>
                                <div class="ms-auto">
                                    <div class="chart-wrapper mt-1">
                                        <canvas id="costchart" class="h-8 w-9 chart-dropshadow" style="display: block; box-sizing: border-box; height: 64px; width: 96px;" width="192" height="128"></canvas>
                                    </div>
                                </div>
                            </div>
                            <span class="text-muted fs-12"><span class="text-warning"><i class="fe fe-arrow-up-circle text-warning"></i> 0.6%</span>
                                                    Last year</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ROW-1 END -->

    <!-- ROW-2 -->
    <div class="row">
        <div class="col">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Sales Analytics</h3>
                </div>
                <div class="card-body">
                    <div class="d-flex mx-auto text-center justify-content-center mb-4">
                        <div class="d-flex text-center justify-content-center me-3"><span class="dot-label bg-primary my-auto"></span>Total Sales</div>
                        <div class="d-flex text-center justify-content-center"><span class="dot-label bg-secondary my-auto"></span>Total Orders</div>
                    </div>
                    <div class="chartjs-wrapper-demo">
                        <canvas id="transactions" class="chart-dropshadow" height="660" style="display: block; box-sizing: border-box; height: 330px; width: 1037.5px;" width="2075"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ROW-2 END -->

