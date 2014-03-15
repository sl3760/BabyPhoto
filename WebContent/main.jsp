<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="java.lang.*" %>
<%@page import="com.amazonaws.services.s3.model.*" %>
<%@page import="com.amazonaws.services.s3.*" %>
<%@page import="model.*" %>
<%@page import="servlets.*" %>
<%@page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/images/youtube.jpg">

    <title>BabyPhoto</title>
   
    <!-- Bootstrap core CSS -->
    <link href="styles/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="styles/navbar-static-top.css" rel="stylesheet">
  </head>
  
  <body>
   
    <%
    String me = request.getParameter("me");
    String friends =request.getParameter("friends");
    if(me != null && friends != null) {
      session.setAttribute("friends", friends);
      session.setAttribute("me", me);
      String[] meinfo = me.split(",");
      session.setAttribute("me_name", meinfo[0]);
      session.setAttribute("me_id", meinfo[1]);
    } else {
      me = session.getAttribute("me").toString();
      friends = session.getAttribute("friends").toString();
    }

    String me_name=session.getAttribute("me_name").toString();
    String me_id=session.getAttribute("me_id").toString();
    ArrayList<String> names = new ArrayList<String>();
    ArrayList<String> ids = new ArrayList<String>();
    %>
            
    <!-- Static navbar -->
    <div class="navbar navbar-inverse navbar-fixed-top" role="banner">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="./index.jsp"">BabyBooth</a>
        </div>
        <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
          <ul class="nav navbar-nav">
            <li><a href="./main.jsp">Home</a></li>
            <li><a href="./friends.jsp">Friends</a></li> 
            <li><a href="./upload.jsp">Upload</a></li>         
          </ul>
         <ul class="nav navbar-nav navbar-right">            
            <li>
            <img src="http://graph.facebook.com/<%=me_id%>/picture" alt="me" class="img-rounded">
            </li> 
            <li class="active">
            <a href="./me.jsp"><%=me_name%></a>
            </li> 
            <li>
              <button type="button" class="btn btn-primary"  onclick="Logout();" />Logout</button>
            </li>      
          </ul>
          
        </div><!--/.nav-collapse -->
      </div>
    </div>


    <div class="container">
      <div class="jumbotron">
        <h1>Welcome to BabyPhoto</h1> 
        <br /> 
        <%    
           String[] name_id = friends.split(";");
           for(String str : name_id) {
               String[] tmp = str.split(",");
               names.add(tmp[0]);
               ids.add(tmp[1]);
           }
     
           RDS rds = new RDS();
           String[] id_map = friends.split(";");
           ArrayList<Asset> assets = rds.getObject(ids);
           String base = "http://s3.amazonaws.com/babyshop/";
           for(Asset asset : assets) {
        	  out.println("<div class=\"jumbotron\">");
        	  String tmp_name = "";
        	  for(String item : id_map) {
        		  String[] tmp = item.split(",");
        		  if(tmp[1].equals(asset.name)) {
        			  tmp_name = tmp[0];
        			  break;
        		  }
        	  }
        	  out.println("<div class=\"row\">");
              out.println("<div class=\"col-md-12\">");
        	  out.println("<em>"+tmp_name+"</em>");
        	  out.println("</div>");
              out.println("</div>");
              String file = base + asset.name + "/" + asset.image;
              out.println("<a href=\"./item.jsp?user_id="+asset.name+"&user_name="+tmp_name + "&img_id="+asset.image+"\">" + "<img src=" + file + " width=400 height=300 class=img-rounded><br>" + "</a>");
              //out.println("<img border=1 src=" + file + " width=800 height=600 class=img-rounded></ br>");
              out.println("<div class=\"row\">");
              out.println("<div class=\"col-md-9\">");
              out.println(asset.description);
              out.println("</div>");
              out.println("<div class=\"col-md-3\">");
              out.println("<div class=\"fb-like\" data-href=\"http://127.0.0.1:8080/BabyPhoto/main.jsp?"+asset.name+"&"+asset.image+"\" data-layout=\"button_count\" data-action=\"like\" data-show-faces=\"false\" data-share=\"false\"></div>");
              out.println("</div>");
              out.println("</div>");
              out.println("<div class=\"row\">");
              out.println("<div class=\"col-md-12\">");
              out.println("<em>Uploaded at "+asset.time+"</em>");
              out.println("</div>");
              out.println("</div>");
              out.println("<div class=\"fb-comments\" data-href=\"http://1.testforsocialgames.appspot.com?"+asset.name+"&"+asset.image+"\" data-numposts=\"5\" data-colorscheme=\"light\"></div>");
              out.println("</div>"); 
           }   
     %>  
        
      </div>
    </div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="styles/bootstrap.min.js"></script>
    <script src="styles/logout.js"></script>
   
  </body>
</html>