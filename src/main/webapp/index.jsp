<%@ page import="java.sql.Connection" %>
<%@ page import="com.mycompany.forum.DatabaseConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter" %>
<html>

<%@ include file="/header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<body>
<div class="container-fluid mt-100">
	<div class="d-flex flex-wrap justify-content-between">
		<%
			if(userName != ""){
		%>
		<div> <a href="newPost.jsp"> <button type="button" class="btn btn-shadow btn-wide btn-primary"> <span class="btn-icon-wrapper pr-2 opacity-7"> <i class="fa fa-plus fa-w-20"></i> </span> New thread </button></a> </div>
		<%}%>
		<form>
			<div class="input-group mb-3">
				<input type="text" class="form-control" placeholder="Search..." aria-label="Recipient's username" aria-describedby="basic-addon2">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="button">Search</button>
				</div>
			</div>
		</form>
	</div>
	<section>
<div style="display: flex;flex-direction: row;">

	<div style="display: flex;flex-direction: column;width: 19%;" class="left">
		<div class="card mb-3">
			<div class="card-header pl-0 pr-0">
				<div class="row no-gutters w-100 align-items-center">
					<div class="col ml-3">Newest Topics</div>
				</div>
			</div>
			<%
				Connection con = DatabaseConnection.initializeDatabase();

				String queryn  = "SELECT Post_ID,Posts.Post_Title,Users.Username,Posts.Date,Posts.Post,Users.User_ID from Posts INNER join Users on Posts.Author_ID = Users.User_ID order by Posts.Date DESC;";
				PreparedStatement psn = con.prepareStatement(queryn);
				ResultSet rsn = psn.executeQuery();

				for(int i = 0; i < 3; i++){
					if(rsn.isLast())
						break;
					rsn.next();
					String postIDn = rsn.getString("Post_ID");
					String tytuln = rsn.getString("Post_Title");
					String DataN =  rsn.getString("Date");
			%>
			<div class="card-body py-3">
				<div class="row no-gutters align-items-center">
					<div class="col"> <a href="/Forum/post.jsp?post=<%=postIDn%>" class="text-big" data-abc="true"> <%=tytuln %></a>
						<div class="text-muted small mt-1">Started: <%=DataN%></div>
					</div>

				</div>
			</div>
			<% } %>
			<hr class="m-0">
		</div>
	</div>


		<div style="width: 80%; margin-left: 1%;" class="main">
			<div class="card mb-3">
				<div class="card-header pl-0 pr-0">
					<div class="row no-gutters w-100 align-items-center">
						<div class="col ml-3">Topics</div>
						<div class="col-4 text-muted">
							<div class="row no-gutters align-items-center">
								<div class="col-4">Replies</div>
								<div class="col-8">Author</div>
							</div>
						</div>
					</div>
				</div>
				<%

					PrintWriter posts = response.getWriter();

					String query  = "SELECT Post_ID,Posts.Post_Title,Users.Username,Posts.Date,Posts.Post,Users.User_ID,(SELECT COUNT(Relies.Reply_ID) FROM Relies where Posts.Post_ID = Post_ID) as 'repi' from Posts INNER join Users on Posts.Author_ID = Users.User_ID order by Posts.Date DESC;";
					PreparedStatement ps = con.prepareStatement(query);
					ResultSet rs = ps.executeQuery();

					Integer init=Integer.parseInt(application.getInitParameter("posts"));
					for(int i = 0; i < init; i++){
						if(rs.isLast())
							break;
						rs.next();
						String postID = rs.getString("Post_ID");
						String tytul = rs.getString("Post_Title");
						String Username = rs.getString("Username");
						String User_ID = rs.getString("User_ID");
						String Date = rs.getString("Date");
						Integer repi =  rs.getInt("repi");
				%>
				<div class="card-body py-3">
					<div class="row no-gutters align-items-center">
						<div class="col"> <a href="/Forum/post.jsp?post=<%=postID%>" class="text-big" data-abc="true"> <%=tytul %></a>
							<div class="text-muted small mt-1">Started: <%=Date%></div>
						</div>
						<div class="d-none d-md-block col-4">
							<div class="row no-gutters align-items-center">
								<div class="col-4"><%=repi%></div>
								<div class="media col-8 align-items-center">
									<div class="media-body flex-truncate ml-2">
										<div class="line-height-1 text-truncate"><%=Username%></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<% } %>
				<hr class="m-0">
			</div>
		</div>
	<div>
	</section>
</div>
<%@ include file="/footer.jsp" %>
</body>
</html>