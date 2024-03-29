package controllers;

import dao.AccountFacade;
import dao.CustomerFacade;
import dao.EmployeeFacade;
import dao.OrderFacade;
import entity.Account;
import entity.Customer;
import entity.Employee;
import entity.FullOrder;
import entity.Toast;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Beyond Nguyen
 */
@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
@MultipartConfig
public class ProfileController extends HttpServlet {

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

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");
        String id = Integer.toString(acc.getId());
        AccountFacade af = new AccountFacade();
        CustomerFacade cf = new CustomerFacade();
        EmployeeFacade ef = new EmployeeFacade();
        switch (action) {
            case "info":
                try {
                    if (acc.getRole().equals("ROLE_CUSTOMER")) {
                        Customer cus;
                        cus = cf.read(id);
                        request.setAttribute("cus", cus);
                    } else {
                        Employee emp = ef.read(id);
                        request.setAttribute("emp", emp);
                    }

                    request.getRequestDispatcher("/WEB-INF/layouts/main.jsp").forward(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            case "updateInfo": {
                try {

                    HashMap<String, String> map = new HashMap<>();
                    for (Part part : request.getParts()) {
                        String partName = part.getName();
                        if (!partName.equals("avatar")) {
                            String partValue = convertISToString(part.getInputStream());
                            
                            if (partName.equals("email")) {
                                if (af.checkAccountExist(partValue) != null) {
                                    Toast toast = new Toast("Existing email!", "failed");
                                    request.setAttribute("toast", toast);
                                    request.getRequestDispatcher("/profile/info.do").forward(request, response);
                                }
                            }
                            
                            map.put(partName, partValue);
                        } else {
                            if (part.getContentType().startsWith("image/")) {
                                String newFileName = "avatar-" + id + ".jpg";
                                String savePath = getServletContext().getRealPath("/assets/img/account/" + File.separator + newFileName);
                                savePath = savePath.replace("\\build", "");
                                part.write(savePath);
                            }
                        }
                    }

                    af.updateNonSecurityInfo(id, map.get("username"), map.get("phone"), map.get("email"), map.get("address"), true);
                    cf.update(id, cf.read(id).getCategory(), map.get("deliveryAddress"));
                    session.setAttribute("acc", af.getAnAccount(id));
                    
                    Toast toast = new Toast("Updated!", "success");
                    request.setAttribute("toast", toast);
                    request.getRequestDispatcher("/profile/info.do").forward(request, response);
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            break;
            case "security":
                request.getRequestDispatcher("/WEB-INF/layouts/main.jsp").forward(request, response);
                break;
            case "updatePass":
                try {
                    Toast toast = null;
                    String password = request.getParameter("password");
                    String newPassword = request.getParameter("newPassword");
                    String confirmPassword = request.getParameter("confirmPassword");

                    if (!acc.getPass().equals(af.hash(password))) {
                        toast = new Toast("Current password does not correct!", "failed");
                    } else if (!newPassword.equals(confirmPassword)) {
                        toast = new Toast("Confirmation is differ from new password", "failed");
                    } else {
                        af.updateSecurityInfo(newPassword, id);
                        toast = new Toast("Changed password successfully", "success");
                    }

                    request.setAttribute("toast", toast);
                    request.getRequestDispatcher("/profile/security.do").forward(request, response);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;
            case "orders":
                try {
                    OrderFacade of = new OrderFacade();
                    List<FullOrder> list = of.selectFullOrders(acc.getId());
                    request.setAttribute("list", list);
                    request.getRequestDispatcher("/WEB-INF/layouts/main.jsp").forward(request, response);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;
            default:
                //Show error page
                request.setAttribute("controller", "error");
                request.setAttribute("action", "error404");
                request.getRequestDispatcher("/WEB-INF/layouts/fullscreen.jsp").forward(request, response);

        }
    }

    public String convertISToString(InputStream is) throws IOException {
        int bufferSize = 1024;
        char[] buffer = new char[bufferSize];
        StringBuilder out = new StringBuilder();
        Reader in = new InputStreamReader(is, StandardCharsets.UTF_8);
        for (int numRead; (numRead = in.read(buffer, 0, buffer.length)) > 0;) {
            out.append(buffer, 0, numRead);
        }
        return out.toString();
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
