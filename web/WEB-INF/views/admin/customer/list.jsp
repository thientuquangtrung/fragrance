<%-- 
Document   : customer
Created on : Feb 24, 2023, 6:55:30 AM
Author     : Beyond Nguyen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid p-lg-5">
    <div class="table-responsive">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6">
                        <h2>Manage <b>Customer</b></h2>
                    </div>
                    <div class="col-sm-6">
                        <a href="#addCustomerModal" class="btn btn-success" data-toggle="modal"><i class="material-icons fa fa-plus-circle"></i> <span>Add New Customer</span></a>

                    </div>
                </div>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Category</th>
                        <th>Delivery</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="profile" items="${list}">
                        <tr>
                            <td>${profile.customer.id}</td>
                            <td>${profile.account.user}</td>
                            <td>${profile.account.email}</td>
                            <td>${profile.account.phone}</td>
                            <td>${profile.customer.category}</td>
                            <td class="line-clamp">${profile.customer.deliveryAddress}</td>
                            <td>${profile.account.enabled}</td>
                            <td>
                                <a href="#editCustomerModal" onclick="handleEditCate(${profile.customer.id})" class="edit" data-toggle="modal"><i class="material-icons fa fa-pencil" data-toggle="tooltip" title="Edit"></i></a>
                                <a href="#deleteCustomerModal" onclick="handleDeleteCate(${profile.customer.id})" class="delete ${profile.account.enabled == true ? "" : "disabled"}" data-toggle="modal"><i class="material-icons fa fa-trash" data-toggle="tooltip" title="Delete"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="clearfix">
                <ul class="pagination">
                    <li class="page-item ${currentPage == 1 ? "disabled" : ""}"><a href="<c:url value="/admin/orders/list.do?page=${currentPage - 1}" />"  class="page-link">Previous</a></li>
                        <c:forEach var="page" begin="1" end="${numOfPages}">
                        <li class="page-item ${currentPage == page ? "active" : ""}"><a href="<c:url value="/admin/customer/list.do?page=${page}" />" class="page-link">${page}</a></li>
                        </c:forEach>
                    <li class="page-item ${currentPage == numOfPages ? "disabled" : ""}"><a href="<c:url value="/admin/orders/list.do?page=${currentPage + 1}" />" class="page-link">Next</a></li>
                </ul>
            </div>
        </div>
    </div>        
</div>

<!-- Add Modal HTML -->
<div id="addCustomerModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="<c:url value="/admin/customer/create.do" />">
                <div class="modal-header">						
                    <h4 class="modal-title">Add customer</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text"  name="name" class="form-control" required>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label>Phone</label>
                            <input type="text" name="phone" class="form-control" required>
                        </div>
                        <div class="form-group col">
                            <label>Email</label>
                            <input type="text" name="email" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Category</label>
                        <input type="text" name="category" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Address</label>
                        <input type="text" name="address" class="form-control" required>
                    </div>  
                    <div class="form-group">
                        <label>Delivery Address</label>
                        <input type="text" name="deliveryAddress" class="form-control" required>
                    </div>  
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                    <input type="submit" class="btn btn-success" value="Add">
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Modal HTML -->
<div id="editCustomerModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="<c:url value="/admin/customer/update.do" />">
                <div class="modal-header">						
                    <h4 class="modal-title">Edit Product</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group col">
                            <label>Id</label>
                            <input style="pointer-events: none" type="text" name="id" class="form-control" required>
                        </div>
                        <div class="form-group col">
                            <label>Category</label>
                            <input type="text" name="category" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text"  name="name" class="form-control" required>
                    </div>
                    <div class="row">
                        <div class="form-group col">
                            <label>Phone</label>
                            <input type="text" name="phone" class="form-control" required>
                        </div>
                        <div class="form-group col">
                            <label>Email</label>
                            <input type="text" name="email" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Address</label>
                        <input type="text" name="address" class="form-control" required>
                    </div>  
                    <div class="form-group">
                        <label>Delivery Address</label>
                        <input type="text" name="deliveryAddress" class="form-control" required>
                    </div>  
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                    <input type="submit" class="btn btn-info" value="Update">
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete Modal HTML -->
<div id="deleteCustomerModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="<c:url value="/admin/customer/delete.do" />">
                <div class="modal-header">						
                    <h4 class="modal-title">Delete Employee</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">					
                    <p>Are you sure you want to delete these Records?</p>
                    <p class="text-warning"><small>This action cannot be undone.</small></p>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                    <input type="hidden" name="id" value="delete">
                    <button type="submit" class="btn btn-danger" >Delete</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    const handleEditCate = (id, email) => {
        const url = "<c:url value="/admin/customer/read.do?&id=" />" + id;
        $.ajax({
            type: 'GET',
            url: url,
            success: function (data) {

                const list = data.split('***');
                const account = JSON.parse(list[0]);
                const customer = JSON.parse(list[1]);
                const profile = {...customer, ...account}

                document.querySelector('#editCustomerModal input[name=id]').value = profile.id;
                document.querySelector('#editCustomerModal input[name=category]').value = profile.category;
                document.querySelector('#editCustomerModal input[name=name]').value = profile.user;
                document.querySelector('#editCustomerModal input[name=phone]').value = profile.phone;
                document.querySelector('#editCustomerModal input[name=email]').value = profile.email;
                document.querySelector('#editCustomerModal input[name=address]').value = profile.address;
                document.querySelector('#editCustomerModal input[name=deliveryAddress]').value = profile.deliveryAddress;
            }
        });
    };

    const handleDeleteCate = (id) => {
        document.querySelector('#deleteCustomerModal input[name=id]').value = id;
    };
</script>