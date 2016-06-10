/*
    * To change this license header, choose License Headers in Project Properties.
    * To change this template file, choose Tools | Templates
    * and open the template in the editor.
    */

package servelt_classes;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
    *
    * @author Swarn Avinash Kumar
    */
public class remove_doc extends HttpServlet {

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

            String project_meta_id = request.getParameter("project_meta_id");
            String project_id = request.getParameter("project_id");

            Connection con = mysqlconnection.connectionsql.connect();
            try {
                String strdel = "DELETE FROM project_meta WHERE meta_id='" + project_meta_id + "' ";
                PreparedStatement ps_del = con.prepareStatement(strdel);
                ps_del.execute();
            } catch (Exception e) {

            }

            request.setAttribute("edit_project_id", project_id);
            String nextJSP = "/edit_project.jsp";
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
            dispatcher.forward(request, response);
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet remove_doc</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet remove_doc at " + request.getContextPath() + "</h1>");
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