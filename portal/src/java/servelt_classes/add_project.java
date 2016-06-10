/*
    * To change this license header, choose License Headers in Project Properties.
    * To change this template file, choose Tools | Templates
    * and open the template in the editor.
    */

package servelt_classes;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
/**
    *
    * @author Swarn Avinash Kumar
    */
//@WebServlet("/upload")
//@MultipartConfig
public class add_project extends HttpServlet {
    private static final long serialVersionUID = 1 L;
    // location to store file uploaded
    private static final String UPLOAD_DIRECTORY = "file_upload";
    // upload settings
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3; // 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

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

            String project_name = "";
            String project_detail = "";
            String email_ids = "";
            String last_in_id = "";


            // checks if the request actually contains upload file
            if (!ServletFileUpload.isMultipartContent(request)) {
                // if not, we stop here
                PrintWriter writer = response.getWriter();
                writer.println("Error: Form must has enctype=multipart/form-data.");

                String nextJSP = "/new_project.jsp";
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
                dispatcher.forward(request, response);
                writer.flush();
                return;
            }
            DiskFileItemFactory factory = new DiskFileItemFactory();
            // sets memory threshold - beyond which files are stored in disk
            factory.setSizeThreshold(MEMORY_THRESHOLD);
            // sets temporary location to store files
            factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

            ServletFileUpload upload = new ServletFileUpload(factory);

            // sets maximum size of upload file
            upload.setFileSizeMax(MAX_FILE_SIZE);

            // sets maximum size of request (include file + form data)
            upload.setSizeMax(MAX_REQUEST_SIZE);

            // constructs the directory path to store upload file
            // this path is relative to application's directory
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;

            // creates the directory if it does not exist
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            try {

                List < FileItem > formItems = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                //List<FileItem> formItems = upload.parseRequest( request);
                String fileName1 = "";
                if (formItems != null && formItems.size() > 0) {
                    out.println("11212");
                    for (FileItem item: formItems) {
                        // processes only fields that are not form fields
                        if (!item.isFormField()) {
                            String fileName = new File(item.getName()).getName();
                            fileName1 += fileName + "NNNNXXXTTT";
                            String filePath = uploadPath + File.separator + fileName;
                            File storeFile = new File(filePath);
                            // saves the file on disk
                            item.write(storeFile);
                        } else {
                            String fieldName = item.getFieldName();
                            if (fieldName.equalsIgnoreCase("project_name")) {
                                project_name = item.getString();
                            }
                            if (fieldName.equalsIgnoreCase("project_detail")) {
                                project_detail = item.getString();
                            }
                            if (fieldName.equalsIgnoreCase("email_ids")) {
                                email_ids = item.getString();
                            }

                        }
                    }
                }

                Connection con = mysqlconnection.connectionsql.connect();
                try {
                    String user = "";
                    HttpSession session = request.getSession();
                    user = session.getAttribute("username").toString();
                    String str = "insert into project (project_name, project_detail,created_by ,total_view) values ( '" + project_name + "' , '" + project_detail + "', '" + user + "','" + '0' + "')";
                    PreparedStatement ps = con.prepareStatement(str);
                    Boolean b = ps.execute();
                    out.println("BOOLEAN" + b);
                    if (b == false) {
                        String lastr = "SELECT sno FROM project ORDER BY sno DESC limit 1";
                        PreparedStatement ps1 = con.prepareStatement(lastr);
                        ResultSet st = ps1.executeQuery();

                        while (st.next()) {
                            last_in_id = st.getString("sno");
                        }

                        String[] tokens = fileName1.split("NNNNXXXTTT");
                        for (int iii = 0; iii < tokens.length; iii++) {
                            String pmeta = "insert into project_meta (project_id, meta_key,meta_value ) values ( '" + last_in_id + "' , '" + "project_doc" + "', '" + tokens[iii] + "')";
                            PreparedStatement ps23 = con.prepareStatement(pmeta);
                            Boolean b23 = ps23.execute();

                        }

                        String[] token_em = email_ids.split(",");
                        for (int iii = 0; iii < token_em.length; iii++) {
                            String pmeta = "insert into project_meta (project_id, meta_key,meta_value ) values ( '" + last_in_id + "' , '" + "peoject_emails" + "', '" + token_em[iii] + "')";
                            PreparedStatement ps23 = con.prepareStatement(pmeta);
                            Boolean b23 = ps23.execute();

                        }


                        request.setAttribute("commit", "done");
                        String nextJSP = "/new_project.jsp";
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
                        dispatcher.forward(request, response);


                    }

                } catch (Exception e) {}


            } catch (Exception ex) {
                out.println(ex.getMessage());
            }

            request.setAttribute("commit", "not_done");
            String nextJSP = "/new_project.jsp";
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
            dispatcher.forward(request, response);

            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet add_project</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet add_project at " + request.getContextPath() + project_name + "llssaa   " + last_in_id + "</h1>");
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