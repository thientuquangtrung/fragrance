/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.AccountFacade;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Beyond Nguyen
 */
@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

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
        System.out.println(AccountFacade.isLogin(request));
        if (AccountFacade.isLogin(request) != 0) {
            if (AccountFacade.isLogin(request) != 3) {
                switch (action) {
                    case "dashboard":
                        request.getRequestDispatcher("/WEB-INF/layouts/admin.jsp").forward(request, response);
                        break;
                    case "product":
                        request.getRequestDispatcher("/WEB-INF/layouts/admin.jsp").forward(request, response);
                        break;
                    case "category":
                        if (AccountFacade.isLogin(request) == 1) {
                            request.getRequestDispatcher("/WEB-INF/layouts/admin.jsp").forward(request, response);
                        } else {
                            response.sendRedirect(request.getContextPath() + "/admin/dashboard.do");
                        }
                        break;
                    case "revenue":
                        if (AccountFacade.isLogin(request) == 1) {
                            request.getRequestDispatcher("/WEB-INF/layouts/admin.jsp").forward(request, response);
                        } else {
                            response.sendRedirect(request.getContextPath() + "/admin/dashboard.do");
                        }
                        break;
                    default:
                        request.setAttribute("controller", "error");
                        request.setAttribute("action", "error404");
                        request.getRequestDispatcher("/WEB-INF/layouts/fullscreen.jsp").forward(request, response);
                }
            } else{
                response.sendRedirect(request.getContextPath() + "/home/index.do");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/account/login.do");
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
