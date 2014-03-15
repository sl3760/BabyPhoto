package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.S3;
import model.RDS;

public class DeleteServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String fileName = request.getParameter("fileName");
		String user_id=fileName.split("&")[0];
		String image_name=fileName.split("&")[1];
		
		String file = user_id + "/" + image_name;
		//delete object from S3 
		S3 s3 = new S3();
		s3.deleteObject(file);
		
		//delete object from RDS
		RDS rds = new RDS();
		rds.deleteObject(user_id,image_name);
		rds.close();
		
		response.sendRedirect("me.jsp");
	}
}
