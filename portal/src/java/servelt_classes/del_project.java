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
public class del_project extends HttpServlet {

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

            String delete_project_id = request.getParameter("delete_project_id");

            Connection con = mysqlconnection.connectionsql.connect();
            try {
                String strdel = "DELETE FROM project WHERE sno='" + delete_project_id + "' ";
                PreparedStatement ps_del = con.prepareStatement(strdel);
                ps_del.execute();


                String strdelmeta = "DELETE FROM project_meta WHERE project_id='" + delete_project_id + "' ";
                PreparedStatement psmeta_del = con.prepareStatement(strdelmeta);
                psmeta_del.execute();

            } catch (Exception e) {

            }


            String nextJSP = "/exist_project.jsp";
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
            dispatcher.forward(request, response);




            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet del_project</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet del_project at " + request.getContextPath() + "</h1>");
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