package servlets;
import java.io.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.MultipartConfig;

import model.S3;
import model.RDS;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.*;
@MultipartConfig(location = "", fileSizeThreshold = 1024*1024, maxFileSize = 1024*1024*1024*5, maxRequestSize = 1024*1024*1024*5)
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean error=false;
        try {
        	S3 s3 = new S3();
		    RDS rds = new RDS();
		    String fileName="",file="",description="";
		    File fileData = null;
        	String me_id = request.getSession().getAttribute("me_id").toString();
			List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
			for (FileItem item : items) {
	            if (item.isFormField()) {
	                description = item.getString();
	            } else {
                    fileName = item.getName();
                    fileData = new File(fileName);
                    item.write(fileData);
                    file = me_id + "/" + fileName;                  
	            }
	            
	        }
			 if (s3.existName(fileName)) {
                 error = true;
             }
             s3.add(file, fileData);
             rds.add(me_id, fileName, description);
             rds.close();
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	    if(error)
	    	response.sendRedirect("error.jsp");
	    else
		    response.sendRedirect("index.jsp");
	}
	
}
