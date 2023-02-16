<%-- 
    Document   : register
    Created on : Feb 2, 2023, 1:25:51 PM
    Author     : Beyond Nguyen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="ftco-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 text-center mb-5">
                <a href="<c:url value="/" />"><img src="<c:url value="/assets/img/logo.png" />" alt=""/></a>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-12 col-lg-10">
                <div class="wrap d-md-flex">
                    <div
                        class="text-wrap p-4 p-lg-5 text-center d-flex align-items-center order-md-last"
                        >
                        <div class="text w-100">
                            <h2>Welcome to signup</h2>
                            <p class="text-white">Already have an account?</p>
                            <a href="<c:url value="/user/login.do" />" class="btn btn-white btn-outline-white"
                               >Sign In</a
                            >
                        </div>
                    </div>
                    <div class="login-wrap p-4 p-lg-5">
                        <div class="d-flex">
                            <div class="w-100">
                                <h3 class="mb-4">Sign Up</h3>
                            </div>

                        </div>
                        <form action="#" class="signin-form">
                            <div class="form-group mb-3">
                                <label class="label" for="name">Username</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    placeholder="Username"
                                    required
                                    />
                            </div>
                            <div class="form-group mb-3">
                                <label class="label" for="password">Password</label>
                                <input
                                    type="password"
                                    class="form-control"
                                    placeholder="Password"
                                    required
                                    />
                            </div>
                            <div class="form-group">
                                <button
                                    type="submit"
                                    class="form-control btn btn-primary submit px-3"
                                    >
                                    Sign Up
                                </button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
