
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
if (session.getAttribute("adminUsername") == null) {
	response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
	return;
}

String adminUsername = (String) session.getAttribute("adminUsername");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MotoVerse - Admin Dashboard</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: Arial, sans-serif;
	background: #101114;
	color: #f5f5f5;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.navbar {
	padding: 20px 7%;
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 15px;
	flex-wrap: wrap;
	border-bottom: 1px solid #292a30;
	background: #15161a;
}

.logo {
	color: #ff4d36;
	font-size: 26px;
	font-weight: bold;
	text-decoration: none;
}

.nav-links {
	display: flex;
	align-items: center;
	gap: 24px;
}

.nav-links a {
	color: #ddd;
	text-decoration: none;
	font-size: 14px;
	transition: color 0.2s;
}

.nav-links a:hover {
	color: #ff4d36;
}

.logout-link {
	border: 1px solid #45464e;
	padding: 9px 14px;
	border-radius: 6px;
}

.main-content {
	width: 100%;
	max-width: 1100px;
	margin: 0 auto;
	padding: 48px 24px;
	flex: 1;
}

.welcome-section {
	padding: 32px;
	background: linear-gradient(120deg, #24252b, #191a1f);
	border: 1px solid #35363e;
	border-radius: 14px;
	margin-bottom: 36px;
}

.eyebrow {
	color: #ff4d36;
	font-size: 12px;
	font-weight: bold;
	letter-spacing: 2px;
	text-transform: uppercase;
	margin-bottom: 14px;
}

h1 {
	font-size: 32px;
	line-height: 1.3;
	margin-bottom: 12px;
}

h1 span {
	color: #ff4d36;
}

.welcome-text {
	color: #aaa;
	line-height: 1.7;
	font-size: 14px;
}

.section-heading {
	font-size: 21px;
	margin-bottom: 8px;
}

.section-description {
	color: #999;
	font-size: 14px;
	margin-bottom: 22px;
	line-height: 1.6;
}

.dashboard-grid {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 22px;
}

.dashboard-card {
	background: #191a1f;
	border: 1px solid #303137;
	border-radius: 12px;
	padding: 26px;
	transition: transform 0.2s, border-color 0.2s;
}

.dashboard-card:hover {
	transform: translateY(-3px);
	border-color: #ff4d36;
}

.card-icon {
	width: 48px;
	height: 48px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: rgba(255, 77, 54, 0.12);
	border-radius: 10px;
	font-size: 23px;
	margin-bottom: 20px;
}

.dashboard-card h3 {
	font-size: 18px;
	margin-bottom: 10px;
}

.dashboard-card p {
	color: #aaa;
	font-size: 14px;
	line-height: 1.7;
	margin-bottom: 22px;
}

.btn {
	display: inline-block;
	text-decoration: none;
	padding: 11px 16px;
	border-radius: 7px;
	font-size: 14px;
	font-weight: bold;
	transition: background 0.2s;
}

.btn-primary {
	background: #ff4d36;
	color: white;
}

.btn-primary:hover {
	background: #e63c27;
}

.btn-secondary {
	background: #292a30;
	border: 1px solid #414149;
	color: #eee;
}

.btn-secondary:hover {
	background: #35363e;
}

.footer {
	padding: 20px 12px;
	text-align: center;
	color: #777;
	font-size: 12px;
	border-top: 1px solid #292a30;
}

@media ( max-width : 600px) {
	.navbar {
		padding: 18px 5%;
	}
	.nav-links {
		gap: 14px;
		flex-wrap: wrap;
	}
	.main-content {
		padding: 30px 16px;
	}
	.welcome-section {
		padding: 24px 20px;
	}
	h1 {
		font-size: 26px;
	}
	.dashboard-grid {
		grid-template-columns: 1fr;
	}
	.dashboard-card {
		padding: 22px;
	}
}
</style>
</head>

<body>

	<nav class="navbar">
		<a class="logo" href="<%=request.getContextPath()%>/index.jsp">
			MotoVerse </a>

		<div class="nav-links">
			<a href="<%=request.getContextPath()%>/vehicles"> Vehicles </a> <a
				href="<%=request.getContextPath()%>/addVehicle.jsp"> Add
				Vehicle </a> <a class="logout-link"
				href="<%=request.getContextPath()%>/logout"> Logout </a>
		</div>
	</nav>

	<main class="main-content">

		<section class="welcome-section">
			<p class="eyebrow">Administration</p>

			<h1>
				Welcome back, <span><%=adminUsername%></span>!
			</h1>

			<p class="welcome-text">You're successfully logged in. Manage the
				MotoVerse vehicle collection and keep vehicle information up to
				date.</p>
		</section>

		<section>
			<h2 class="section-heading">Dashboard Overview</h2>

			<p class="section-description">Choose an action to manage your
				vehicle collection.</p>

			<div class="dashboard-grid">

				<article class="dashboard-card">
					<div class="card-icon" aria-hidden="true">🏍️</div>

					<h3>Manage Vehicles</h3>

					<p>View the available bikes and cars, search the collection,
						and edit or delete existing entries.</p>

					<a class="btn btn-secondary"
						href="<%=request.getContextPath()%>/vehicles"> View Vehicles
						→ </a>
				</article>

				<article class="dashboard-card">
					<div class="card-icon" aria-hidden="true">➕</div>

					<h3>Add New Vehicle</h3>

					<p>Add a bike or car with its brand, specifications, price,
						mileage, fuel type, and image URL.</p>

					<a class="btn btn-primary"
						href="<%=request.getContextPath()%>/addVehicle.jsp"> Add
						Vehicle → </a>
				</article>

			</div>
		</section>

	</main>

	<footer class="footer"> © 2026 MotoVerse — Smart Vehicle
		Explorer </footer>

</body>
</html>
