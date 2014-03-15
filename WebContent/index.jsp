<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.amazonaws.*"%>
<%@ page import="com.amazonaws.auth.*"%>
<%@ page import="com.amazonaws.services.ec2.*"%>
<%@ page import="com.amazonaws.services.ec2.model.*"%>
<%@ page import="com.amazonaws.services.s3.*"%>
<%@ page import="com.amazonaws.services.s3.model.*"%>
<%@ page import="com.amazonaws.services.dynamodbv2.*"%>
<%@ page import="com.amazonaws.services.dynamodbv2.model.*"%>

<!DOCTYPE html>
<html>
<head>
<meta meta http-equiv="content-type" content="text/html; charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<title>Login</title>

 <!-- Bootstrap core CSS -->
    <link href="styles/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="styles/navbar-static-top.css" rel="stylesheet">
    
</head>
<body>
	<div id="fb-root"></div>
	<script>
  window.fbAsyncInit = function() {
    // init the FB JS SDK
    FB.init({
      appId      : '243414265815342',                        // App ID from the app dashboard
      status     : true,                                 // Check Facebook Login status
      cookie     : true, // enable cookies to allow the server to access the session
      xfbml      : true                                  // Look for social plugins on the page
    });

    // Additional initialization code such as adding Event Listeners goes here
  

   FB.Event.subscribe('auth.authResponseChange', function(response) {
    
    if (response.status === 'connected') {    
       login();
     
    } else if (response.status === 'not_authorized') {   
       FB.login(function(response){});
        
    } else {
       FB.login(function(response){});
    }
  });
  };

  // Load the SDK asynchronously
  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "https://connect.facebook.net/en_US/all.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
  
  
   function login() { 
	    var form = document.createElement("form");
	    form.setAttribute("method", "post");
	    form.setAttribute("action", "./main.jsp");
	    
	    FB.api('/me/friends', function(response) {
	    	   var friends = response.data;
	    	   var params = "";
	    	   for (var i = 0; i < friends.length; i++) {
	    		   params += friends[i].name + "," + friends[i].id + ";";
	    	   }    

	   	       var hidden = document.createElement("input");
	           hidden.setAttribute("type", "hidden");
	           hidden.setAttribute("name", "friends");
	           hidden.setAttribute("value", params);
	   	       form.appendChild(hidden);
	   	        	  
	    });
	    
	    FB.api('/me', function(response) {
	    	   var hidden = document.createElement("input");
	           hidden.setAttribute("type", "hidden");
	           hidden.setAttribute("name", "me");
	           var param = response.name + "," + response.id;
	           hidden.setAttribute("value", param); 
	           form.appendChild(hidden);
	           document.body.appendChild(form);
		       form.submit();
	    });
	        
  }
  
</script>

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
          <ul class="nav navbar-nav navbar-right">            
            <li>
            <div class="fb-login-button" size="large" data-max-rows="1" data-show-faces="false"></div>
            </li>        
          </ul>
          
        </div><!--/.nav-collapse -->
      </div>
    </div>
     <div class="container">
      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
         <img src="./images/baby1.jpg" alt="baby" class="img-rounded">
       </div>
      
    </div>
<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="styles/bootstrap.min.js"></script>
</body>
</html>
