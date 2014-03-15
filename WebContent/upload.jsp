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
  String me_name=session.getAttribute("me_name").toString();
  String me_id=session.getAttribute("me_id").toString();
	 ArrayList<String> me_asset=new ArrayList<String>();
	 me_asset.add(me_id);
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
        <p>You can upload baby photos.</p>          
        <form action="UploadServlet" method="post" enctype="multipart/form-data" >
        <input type="file" class="btn btn-primary" id="uploadfilename" name="filename" size="30" />
        <br />
        <p>You can describe your baby photos:</p>
        <textarea name="description" id="description" class="form-control" rows="3">
        </textarea>
        <br />
        <br />
        <input type="submit" class="btn btn-success" value="Submit" />
        </form>
       
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