/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import com.google.gson.Gson;
import dao.AccountFacade;
import dao.CustomerFacade;
import entity.Account;
import entity.Customer;
import entity.CustomerProfile;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Beyond Nguyen
 */
@WebServlet(name = "CustomerController", urlPatterns = {"/admin/customer"})
public class CustomerController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String controller = (String) request.getAttribute("controller");
        String action = (String) request.getAttribute("action");

        AccountFacade af = new AccountFacade();
        CustomerFacade cf = new CustomerFacade();
        if (AccountFacade.isLogin(request) == 1) {
            switch (action) {
                case "list": {
                    try {
                        //Processing code here

                        List<Account> accList = af.selectCustomerAccounts();
                        List<Customer> cusList = cf.selectAll();
                        
                        List<CustomerProfile> list = new ArrayList();
                        for (int i = 0; i < accList.size(); ++i) {
                            list.add(new CustomerProfile(accList.get(i), cusList.get(i)));
                        }

                        int page = 0;
                        if (request.getParameter("page") == null) {
                            page = 1;
                        } else {
                            page = Integer.parseInt(request.getParameter("page"));
                        }

                        int numOfPages = (int) Math.ceil(list.size() / 9.0);
                        if (page < numOfPages) {
                            list = list.subList(9 * (page - 1), 9 * page);
                        } else {
                            list = list.subList(9 * (page - 1), list.size());
                        }

                        request.setAttribute("numOfPages", numOfPages);
                        request.setAttribute("currentPage", page);
                        request.setAttribute("activeTab", "customer");
                        request.setAttribute("list", list);
                        request.getRequestDispatcher("/WEB-INF/layouts/admin.jsp").forward(request, response);
                    } catch (SQLException ex) {
                        Logger.getLogger(CustomerController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                break;

                case "create":
                    try {
                        String name = request.getParameter("name");
                        String phone = request.getParameter("phone");
                        String email = request.getParameter("email");
                        String category = request.getParameter("category");
                        String address = request.getParameter("address");
                        String deliveryAddress = request.getParameter("deliveryAddress");
                        
                        int id = af.createCustomerAccount(name, phone, email, address);
                        cf.create(id, category, deliveryAddress);

                        response.sendRedirect(request.getContextPath() + "/admin/customer/list.do");
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }

                    break;

                case "read":
                    try {
                        String id = request.getParameter("id");

                        Account acc = af.getAnAccount(id);
                        Customer cus = cf.read(id);

                        Gson gson = new Gson();
                        PrintWriter out = response.getWriter();
                        out.print(gson.toJson(acc));
                        out.print("***");
                        out.print(gson.toJson(cus));
                        out.flush();
                        out.close();
                    } catch (SQLException ex) {
                        Logger.getLogger(AdminController.class.getName()).log(Level.SEVERE, null, ex);
                    }

                    break;
                case "update": {
                    try {
                        String id = request.getParameter("id");
                        String name = request.getParameter("name");
                        String phone = request.getParameter("phone");
                        String email = request.getParameter("email");
                        String category = request.getParameter("category");
                        String address = request.getParameter("address");
                        String deliveryAddress = request.getParameter("deliveryAddress");

                        af.updateNonSecurityInfo(id, name, phone, email, address, true);
                        cf.update(id, category, deliveryAddress);

                        response.sendRedirect(request.getContextPath() + "/admin/customer/list.do");
                    } catch (SQLException ex) {
                        Logger.getLogger(CustomerController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                break;

                case "delete":
                    try {
                        String id = request.getParameter("id");
                        af.delete(id);
                        response.sendRedirect(request.getContextPath() + "/admin/customer/list.do");
                    } catch (SQLException ex) {
                        Logger.getLogger(AdminController.class.getName()).log(Level.SEVERE, null, ex);
                    }

                    break;
                default:
                    //Show error page
                    request.setAttribute("controller", "error");
                    request.setAttribute("action", "error404");
                    request.getRequestDispatcher("/WEB-INF/layouts/fullscreen.jsp").forward(request, response);

            }
        } else {
            response.sendRedirect(request.getContextPath() + "/home/index.do");
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
