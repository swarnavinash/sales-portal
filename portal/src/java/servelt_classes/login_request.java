/*
    * To change this license header, choose License Headers in Project Properties.
    * To change this template file, choose Tools | Templates
    * and open the template in the editor.
    */

package servelt_classes;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
    *
    * @author Swarn Avinash Kumar
    */
public class login_request extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {

            String user_name = request.getParameter("user_name");
            String password = request.getParameter("password");
            String enpass = "";
            try {
                MessageDigest md = MessageDigest.getInstance("MD5");
                byte[] passBytes = password.getBytes();
                md.reset();
                byte[] digested = md.digest(passBytes);
                StringBuffer sb = new StringBuffer();
                for (int i = 0; i < digested.length; i++) {
                    sb.append(Integer.toHexString(0xff & digested[i]));
                }
                enpass = sb.toString();
            } catch (NoSuchAlgorithmException ex) {
                out.println(ex.getMessage());
            }


            try {
                Connection con = mysqlconnection.connectionsql.connect();
                String str = "select * from user where user_name='" + user_name + "' AND password='" + enpass + "'";
                PreparedStatement ps = con.prepareStatement(str);
                ResultSet st = ps.executeQuery();

                while (st.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("username", user_name);
                    session.setAttribute("user_type", st.getString(5));
                    session.setAttribute("user_email", st.getString(4));
                    //   setting session to expiry in 5 mins
                    session.setMaxInactiveInterval(3000 * 60);

                    if (st.getInt(5) == 0) {

                        request.setAttribute("login", "done");
                        String nextJSP = "/event-manager.jsp";
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
                        dispatcher.forward(request, response);
                    } else {
                        request.setAttribute("login", "done");
                        String nextJSP = "/buyer.jsp";
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
                        dispatcher.forward(request, response);
                    }
                }

            } catch (Exception e) {
                out.println(e.getMessage());
            }

            request.setAttribute("login", "not_done");
            String nextJSP = "/index.jsp";
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
            dispatcher.forward(request, response);

            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet login_request</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet login_request at " + request.getContextPath() + user_name + "ppp " + enpass + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        } // </editor-fold>

}