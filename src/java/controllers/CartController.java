/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.AccountFacade;
import dao.CartFacade;
import dao.ProductFacade;
import entity.Account;
import entity.Cart;
import entity.Item;
import entity.Product;
import entity.Toast;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Beyond Nguyen
 */
@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String id = request.getParameter("id");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        //Lay gio tu session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            //Neu chua co cart thi tao cart moi
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        ProductFacade pf = new ProductFacade();
        Product product = pf.read(id);
        Item item = new Item(product, quantity);

        //Add item vao cart
        cart.add(item);

        PrintWriter out = response.getWriter();
        out.print(cart.cartLength());
        out.flush();
        out.close();
    }

    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        //Lay gio tu session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        Enumeration<String> names = request.getParameterNames();
        while (names.hasMoreElements()) {
            String name = names.nextElement();
            if (name.startsWith("newQuantity_")) {
                int quantity = Integer.parseInt(request.getParameter(name));
                String id = name.substring(12);

                //update item vao cart
                cart.update(Integer.parseInt(id), quantity);
            }
        }
        //Quay ve home page
        response.sendRedirect(request.getContextPath() + "/cart/index.do");
    }

    protected void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String id = request.getParameter("idneedtodelete");
        //Lay gio tu session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        //Add item vao cart
        cart.delete(Integer.parseInt(id));
        //Quay ve home page
        response.sendRedirect(request.getContextPath() + "/cart/index.do");
    }

    protected void clearCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        cart.empty();
        session.setAttribute("cart", cart);
        //Quay ve home page
        response.sendRedirect(request.getContextPath() + "/cart/index.do");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String controller = (String) request.getAttribute("controller");
        String action = (String) request.getAttribute("action");

        switch (action) {
            case "index":
                request.getRequestDispatcher("/WEB-INF/layouts/main.jsp").forward(request, response);
                break;
            case "add":
                try {
                    add(request, response);
                } catch (IOException | SQLException | ServletException ex) { //in thong báo loi chi tiet cho developer
                    //in thong báo loi chi tiet cho developer
                    request.setAttribute("message", ex.getMessage());
                    request.getRequestDispatcher("/WEB-INF/layouts/main.jsp").forward(request, response);
                }
                break;
            case "checkout":
                request.getRequestDispatcher("/WEB-INF/layouts/main.jsp").forward(request, response);
                break;
            case "order":
                try {
                    AccountFacade af = new AccountFacade();
                    int customerId = 0;

                    String newAccount = request.getParameter("newAccount");
                    if (newAccount == null) {
                        HttpSession session = request.getSession();
                        if (session.getAttribute("acc") != null) {
                            Account acc = (Account) session.getAttribute("acc");
                            customerId = acc.getId();
                        } else {
                            Toast toast = new Toast("You must login before checking out", "info");
                            request.setAttribute("toast", toast);
                            request.getRequestDispatcher("/cart/checkout.do").forward(request, response);
                        }
                    } else if (newAccount.equalsIgnoreCase("true")) {
                        String name = request.getParameter("name");
                        String address = request.getParameter("address");
                        String phone = request.getParameter("phone");
                        String email = request.getParameter("email");

                        if (af.checkAccountExist(email) != null) {
                            Toast toast = new Toast("The email has existed already! Please try again.", "failed");
                            request.setAttribute("toast", toast);
                            request.getRequestDispatcher("/cart/checkout.do").forward(request, response);
                        }
                        
                        Account newAcc = new Account(0, name, address, phone, email, "1", true, "ROLL_CUSTOMER");
                        customerId = af.signup(newAcc);
                    }
//                    At this line, you have customer id already, save product order to database here
                    String noteOfDetailHeader = request.getParameter("noteOfDetailHeader");
                    HttpSession session = request.getSession();
                    Cart cart = (Cart) session.getAttribute("cart");
                    CartFacade cartFacade = new CartFacade();
                    cartFacade.addOrder(customerId, noteOfDetailHeader, cart);
                    cart.empty();
                    session.setAttribute("cart", cart);
                    session.setAttribute("acc", af.getAnAccount((Integer.toString(customerId))));
                    
                    Toast toast = new Toast("Order confirmed! Thank you <3", "success");
                    request.setAttribute("toast", toast);
                    request.getRequestDispatcher("/home/index.do").forward(request, response);
                } catch (IOException | SQLException | NoSuchAlgorithmException ex) {
                    request.setAttribute("message", ex.getMessage());
                    request.getRequestDispatcher("/WEB-INF/layouts/main.jsp").forward(request, response);
                }
                break;
            case "update":
                try {
                    update(request, response);
                } catch (IOException | SQLException | ServletException ex) { //in thong báo loi chi tiet cho developer
                    //in thong báo loi chi tiet cho developer
                    request.setAttribute("message", ex.getMessage());
                    request.getRequestDispatcher("/WEB-INF/layouts/main.jsp").forward(request, response);
                }
                break;
            case "delete":
                try {
                    delete(request, response);
                } catch (IOException | SQLException | ServletException ex) { //in thong báo loi chi tiet cho developer
                    //in thong báo loi chi tiet cho developer
                    request.setAttribute("message", ex.getMessage());
                    request.getRequestDispatcher("/WEB-INF/layouts/main.jsp").forward(request, response);
                }
                break;
            case "clearCart":
                try {
                    clearCart(request, response);
                } catch (IOException | SQLException | ServletException ex) { //in thong báo loi chi tiet cho developer
                    //in thong báo loi chi tiet cho developer
                    request.setAttribute("message", ex.getMessage());
                    request.getRequestDispatcher("/WEB-INF/layouts/main.jsp").forward(request, response);
                }
                break;
            default:
                request.setAttribute("controller", "error");
                request.setAttribute("action", "error404");
                request.getRequestDispatcher("/WEB-INF/layouts/fullscreen.jsp").forward(request, response);
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
