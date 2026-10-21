
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Explore bikes and cars, discover specifications, and compare vehicles with MotoVerse.">

<title>MotoVerse | Explore Your Drive</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css?v=9">
</head>
<body>

	<%
	String contextPath = request.getContextPath();

	boolean isAdmin = session.getAttribute("adminUsername") != null;
	String adminUsername = isAdmin ? (String) session.getAttribute("adminUsername") : "";

	boolean isUser = session.getAttribute("userId") != null;
	String userName = isUser ? (String) session.getAttribute("userName") : "";
	%>

	<nav class="navbar" aria-label="Main navigation">
		<a class="logo" href="<%=contextPath%>/index.jsp"> Moto<span>Verse</span>
		</a>

		<div class="nav-links">
			<a href="<%=contextPath%>/index.jsp">Home</a> <a
				href="<%=contextPath%>/vehicles">Explore Vehicles</a> <a
				href="<%=contextPath%>/vehicles?type=Bike">Bikes</a> <a
				href="<%=contextPath%>/vehicles?type=Car">Cars</a>

			<%
			if (isAdmin) {
			%>

			<a href="<%=contextPath%>/adminDashboard">Dashboard</a> <span
				class="admin-status"> <%=adminUsername.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;")
		.replace("'", "&#39;")%> · Admin
			</span> <a class="logout-nav" href="<%=contextPath%>/logout"> Logout </a>

			<%
			} else if (isUser) {
			%>

			<a href="<%=contextPath%>/wishlist">♡ My Wishlist</a> <span
				class="admin-status"> Welcome, <%=userName.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'",
		"&#39;")%>
			</span> <a class="logout-nav" href="<%=contextPath%>/logout"> Logout </a> <a
				href="<%=contextPath%>/adminLogin.jsp">Admin</a>

			<%
			} else {
			%>

			<a href="<%=contextPath%>/login.jsp">Login</a> <a
				href="<%=contextPath%>/register.jsp">Register</a> <a
				href="<%=contextPath%>/adminLogin.jsp">Admin</a>

			<%
			}
			%>
		</div>
	</nav>

	<main>
		<section class="hero">
			<div class="hero-content">
				<p class="eyebrow">YOUR JOURNEY STARTS HERE</p>

				<h1>
					Find Your Next<br> <span>Ride</span>
				</h1>

				<p class="hero-description">Explore bikes and cars, discover
					their specifications, and compare your favourite vehicles in one
					place.</p>

				<div class="hero-buttons">
					<a class="btn btn-primary" href="<%=contextPath%>/vehicles">
						Explore Vehicles </a> <a class="btn btn-outline"
						href="<%=contextPath%>/vehicles?type=Bike"> Explore Bikes </a>
				</div>
			</div>
		</section>

		<section class="categories">
			<div class="section-heading">
				<p class="eyebrow">EXPLORE YOUR OPTIONS</p>
				<h2>Choose Your Ride</h2>
				<p>From everyday commutes to weekend adventures.</p>
			</div>

			<div class="category-grid">
				<a class="category-card bike-card"
					href="<%=contextPath%>/vehicles?type=Bike"
					aria-label="Explore motorcycles">
					<div class="category-content">
						<p>BUILT FOR THE OPEN ROAD</p>
						<h3>Motorcycles</h3>
						<span>Explore Bikes →</span>
					</div>
				</a> <a class="category-card car-card"
					href="<%=contextPath%>/vehicles?type=Car" aria-label="Explore cars">
					<div class="category-content">
						<p>COMFORT MEETS PERFORMANCE</p>
						<h3>Cars</h3>
						<span>Explore Cars →</span>
					</div>
				</a>
			</div>
		</section>

		<section class="features">
			<div>
				<h3>Explore</h3>
				<p>Browse vehicles and their specifications.</p>
			</div>

			<div>
				<h3>Discover</h3>
				<p>Search by brand, name, and vehicle type.</p>
			</div>

			<div>
				<h3>Compare</h3>
				<p>Compare two vehicles side by side.</p>
			</div>
		</section>
	</main>

	<footer>
		<a class="logo" href="<%=contextPath%>/index.jsp"> Moto<span>Verse</span>
		</a>

		<p>Discover your next ride.</p>
		<p>© 2026 MotoVerse — Smart Vehicle Explorer</p>
	</footer>

</body>
</html>
