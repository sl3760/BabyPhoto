<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
   String[] friends=session.getAttribute("friends").toString().split(";"); 
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
      </br>
      </br>
      </br>
     <div class="container">
      <div class="jumbotron">
         <div class="row">
         <% 
            String[] friend_info;
            String friend_name;
            String friend_id;
            for(int i=0; i<friends.length-1;i=i+2){
                friend_info=friends[i].split(",");
                friend_name=friend_info[0];
                friend_id=friend_info[1];
                out.println("<div class=\"col-md-6\">");
                out.println("<img src=\"http://graph.facebook.com/"+friend_id+"/picture\" class=\"img-rounded\">");
                out.println("<a href=\"./friend.jsp?friend_id="+friend_id+"&friend_name="+friend_name+"\">");
                out.println(friend_name);
                out.println("</a>");
                out.println("</div>");              
                friend_info=friends[i+1].split(",");
                friend_name=friend_info[0];
                friend_id=friend_info[1];
                out.println("<div class=\"col-md-6\">");
                out.println("<img src=\"http://graph.facebook.com/"+friend_id+"/picture\" class=\"img-rounded\">");
                out.println("<a href=\"./friend.jsp?friend_id="+friend_id+"&friend_name="+friend_name+"\">");
                out.println(friend_name);
                out.println("</a>");
                out.println("</div>");
                out.println("<br />");
                out.println("<br />");
            }
         %>

         </div>
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