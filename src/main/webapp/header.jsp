<%@ page import="com.mycompany.forum.NewServletListener" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.forum.DatabaseConnection" %><%--
  Created by IntelliJ IDEA.
  User: skuch
  Date: 26.11.2021
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<head>
    <head>
        <link rel="stylesheet" href="index.css">
        <link rel="stylesheet" href="header.css">
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

        <!-- jQuery library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <!-- Popper JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

        <!-- Latest compiled JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
</head>
<div class="Header">
    <div class="header2 <%if(request.getAttribute("agent").equals("chrome")){%>bg-success-gradiant"<%}else{%>"style="background: linear-gradient(to right, #ff0000 0%, #00ff00 100%);"<%}%>>
        <div class="">
            <!-- Header 1 code -->
            <nav class="navbar navbar-expand-lg h2-nav"> <a class="navbar-brand" href="/Forum">PWSZ Forum</a> <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#header2" aria-controls="header2" aria-expanded="false" aria-label="Toggle navigation"> <span class="icon-menu"></span> </button>
                <div class="collapse navbar-collapse hover-dropdown" id="header2">
                    <ul class="navbar-nav">
                        <li class="nav-item active"><a class="nav-link" href="/Forum">Home</a></li>
                    </ul>
                    <%
                        Connection cont = DatabaseConnection.initializeDatabase();
                        String querycntposts  = "SELECT COUNT(Posts.Post_ID) as 'Postcnt' from Posts;";
                        PreparedStatement pp = cont.prepareStatement(querycntposts);
                        ResultSet postscnt = pp.executeQuery();
                        postscnt.next();
                        Integer cntpost = postscnt.getInt("Postcnt");

                        String qr  = "SELECT COUNT(Relies.Reply_ID) as 'replycnt' from Relies;";
                        PreparedStatement psr = cont.prepareStatement(qr);
                        ResultSet rsr = psr.executeQuery();
                        rsr.next();
                        Integer cntrep = rsr.getInt("replycnt");
                    %>
                    <ul class="navbar-nav ml-auto">
                        <%int sessions;%>
                        <li class="nav-item"><a class="nav-link" href="">All posts:<%=cntpost%></a></li>
                        <li class="nav-item"><a class="nav-link" href="">All replies:<%=cntrep%></a></li>
                        <li class="nav-item"><a class="nav-link" href="">Logged users: <%= sessions = NewServletListener.getActiveSessions() %></a></li>
                        <%
                            //allow access only if session exists
                            String user = (String) session.getAttribute("user");
                            String userName = "";
                            String userID = "";
                            String sessionID = null;
                            Cookie[] cookies = request.getCookies();
                            if(cookies !=null){
                                for(Cookie cookie : cookies){
                                    if(cookie.getName().equals("user")) userName = cookie.getValue();
                                    if(cookie.getName().equals("userID")) userID = cookie.getValue();
                                    if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
                                }
                            }
                            if(userName == ""){
                        %>

                        <li class="nav-item active"><a class="nav-link" href="login.jsp">Login</a></li>
                        <li class="nav-item"><a class="btn rounded-pill btn-dark py-2 px-4" href="register.jsp">Sign up</a></li>

                        <li class="nav-item">
                        <%}else{%>
                        <li class="nav-item active"><a class="nav-link" href="userPanel.jsp">
                        <%out.write("Hello "+userName);%>
                    </a></li>
                        <li class="nav-item">
                            <form action="LogoutServlet" method="post">
                                <input type="submit" class="btn rounded-pill btn-dark py-2 px-4" value="Logout" >
                            </form>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </nav> <!-- End Header 1 code -->
        </div>
    </div>
</div>
