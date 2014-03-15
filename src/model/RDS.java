package model;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.ClasspathPropertiesFileCredentialsProvider;
import com.amazonaws.services.rds.AmazonRDSClient;

public class RDS {
	private AWSCredentialsProvider credentialsProvider;
	private AmazonRDSClient rds;
	Connection conn;
	Statement st;

	public RDS() {
		try {
			credentialsProvider = new ClasspathPropertiesFileCredentialsProvider();
			rds = new AmazonRDSClient(credentialsProvider);
           
			Class.forName("com.mysql.jdbc.Driver");
			// connect to RDS
			String dbName = "babyphotodb";
			String userName = "";
			String password = "";
			String hostname = "babyphoto.cbm0g79rz9sb.us-east-1.rds.amazonaws.com";
			String port = "3306";
			String jdbcUrl = "jdbc:mysql://" + hostname + ":" + port + "/"
					+ dbName + "?user=" + userName + "&password=" + password;
			conn = DriverManager.getConnection(jdbcUrl);
			st = conn.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	}

	   
	    public void add(String user_id, String image_name, String description){
	    	Date date = new Date();
			String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
			int com_num = 0;
	        String comment = "";
	        System.out.println("RDS description: "+ description);
	        String sql = "insert into babyphoto (user_id, image_name, time, com_num, comment, description) values ('" + user_id + "','" 
	            + image_name +"','" + time + "','" + com_num + "','" + comment +"','"+description+ "')";
			try
			{
				st = conn.createStatement();
				st.executeUpdate(sql);
			}catch(Exception e)
			{
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
	    }
	    
	    public ArrayList<Asset> getObject(ArrayList<String> ids) throws InterruptedException {
	        ArrayList<Asset> assets = new ArrayList<Asset>();
	        for(String id : ids) {
	            String sql = "select * from babyphoto where user_id='" + id + "' order by time DESC";
	            try {
	                st = conn.createStatement();
	                ResultSet rs = st.executeQuery(sql);
	                while (rs.next()) {
	                    String name = rs.getObject("user_id").toString();
	                    String image = rs.getObject("image_name").toString();
	                    String time = rs.getObject("time").toString();
	                    int com_num = rs.getInt("com_num");
	                    String comment = rs.getObject("comment").toString();  
	                    String description = rs.getObject("description").toString();
	                    assets.add(new Asset(name, image, time, com_num, comment, description));
	                }   
	            } catch (Exception e) {
	                e.printStackTrace();
	                System.out.println(e.getMessage());
	                return assets;
	            }
	        }
	        return assets;
	    }

	    public void updateImage(String user_id, String image_name, String comment) {
	        String sql = "select com_num, comment from babyphoto where user_id='" + user_id + "' and image_name='" + image_name + "'";
	        try {
	            st = conn.createStatement();
	            ResultSet resultset = st.executeQuery(sql);
	            resultset.next();
	            int com_num = resultset.getInt("com_num") + 1;
	            comment = resultset.getString("comment") + "#" + comment;
	            String insql = "update babyphoto set com_num=" + com_num + ",comment=" + comment + " where user_id='" + user_id + "' and image_name='" + image_name + "'";
	            st.executeUpdate(insql);
	        } catch (Exception e) {
	            e.printStackTrace();
	            System.out.println(e.getMessage());
	        }
	    }
	    
	    public void close()
		{
			try {
				st.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
		}
	    
	    public void deleteObject(String user_id, String image_name) {
	        String sql = "delete from babyphoto where user_id ='" + user_id + "' and image_name='" + image_name + "'";
	        try {
	            st = conn.createStatement();
	            st.executeUpdate(sql);
	        } catch (Exception e) {
	            e.printStackTrace();
	            System.out.println(e.getMessage());
	        }
	    }
	    
	    public Asset getImage(String user_id, String img_name) throws InterruptedException {
            Asset asset = null;
            String sql = "select * from babyphoto where user_id ='" + user_id + "' and image_name='" + img_name + "'";;
            try {
                st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()) {
                    String name = rs.getObject("user_id").toString();
                    String image = rs.getObject("image_name").toString();
                    String time = rs.getObject("time").toString();
                    int com_num = rs.getInt("com_num");
                    String comment = rs.getObject("comment").toString();  
                    String description = rs.getObject("description").toString();
                    asset = new Asset(name, image, time, com_num, comment, description);
                }   
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
                return null;
            }
            return asset;
	    }
	

}
