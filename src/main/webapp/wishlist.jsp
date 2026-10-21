<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List,com.motoverse.model.Vehicle"%>

<%
String contextPath = request.getContextPath();

if (session.getAttribute("userId") == null) {
	response.sendRedirect(contextPath + "/login.jsp");
	return;
}

String userName = (String) session.getAttribute("userName");
List<Vehicle> wishlist = (List<Vehicle>) request.getAttribute("wishlist");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Wishlist | MotoVerse</title>
<link rel="stylesheet" href="<%=contextPath%>/css/style.css?v=10">

<style>
body {
	margin: 0;
	background: #0b0f14;
	color: #f1f5f9;
	font-family: Arial, sans-serif;
}

.wishlist-container {
	width: min(1100px, 92%);
	margin: 55px auto;
}

.wishlist-heading {
	margin-bottom: 8px;
	font-size: 32px;
}

.wishlist-subtitle {
	color: #94a3b8;
	margin-bottom: 30px;
}

.wishlist-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 24px;
}

.wishlist-card {
	overflow: hidden;
	border: 1px solid #263241;
	border-radius: 14px;
	background: #121923;
}

.wishlist-card img {
	display: block;
	width: 100%;
	height: 190px;
	object-fit: cover;
	background: #1e293b;
}

.wishlist-details {
	padding: 18px;
}

.wishlist-details h3 {
	margin: 0 0 8px;
}

.wishlist-details p {
	color: #aab7c7;
	margin: 7px 0;
}

.wishlist-price {
	color: #38bdf8 !important;
	font-size: 20px;
	font-weight: bold;
}

.wishlist-actions {
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
	margin-top: 18px;
}

.wishlist-actions a, .wishlist-actions button, .empty-wishlist a {
	padding: 10px 14px;
	border: 0;
	border-radius: 7px;
	text-decoration: none;
	font-weight: bold;
	cursor: pointer;
	font-size: 14px;
}

.details-button {
	background: #2563eb;
	color: white;
}

.remove-button {
	background: #7f1d1d;
	color: white;
}

.empty-wishlist {
	padding: 35px 20px;
	border: 1px solid #263241;
	border-radius: 12px;
	text-align: center;
	background: #121923;
}

.empty-wishlist p {
	color: #94a3b8;
}

.empty-wishlist a {
	display: inline-block;
	margin-top: 12px;
	background: #2563eb;
	color: white;
}
</style>
</head>

<body>

	<main class="wishlist-container">
		<h1 class="wishlist-heading">My Wishlist ♡</h1>
		<p class="wishlist-subtitle">
			Your saved vehicles,
			<%=userName == null ? "rider"
		: userName.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;")%>.
		</p>

		<%
		if (wishlist == null || wishlist.isEmpty()) {
		%>
		<div class="empty-wishlist">
			<h2>Your wishlist is empty</h2>
			<p>Explore MotoVerse and save vehicles you like.</p>
			<a href="<%=contextPath%>/vehicles">Explore Vehicles</a>
		</div>
		<%
		} else {
		%>

		<div class="wishlist-grid">
			<%
			for (Vehicle vehicle : wishlist) {
			%>
			<article class="wishlist-card">

				<%
				if (vehicle.getImageUrl() != null && !vehicle.getImageUrl().trim().isEmpty()) {
				%>
				<img
					src="<%=vehicle.getImageUrl().replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;")%>"
					alt="Vehicle image" onerror="this.style.display='none';">
				<%
				} else {
				%>
				<img src="<%=contextPath%>/images/vehicle-placeholder.png"
					alt="Vehicle image" onerror="this.style.display='none';">
				<%
				}
				%>

				<div class="wishlist-details">
					<h3><%=vehicle.getBrand()%>
						<%=vehicle.getName()%></h3>

					<p>
						Type:
						<%=vehicle.getType()%></p>
					<p>
						Fuel:
						<%=vehicle.getFuelType()%></p>
					<p class="wishlist-price">
						₹
						<%=String.format("%,.0f", vehicle.getPrice())%>
					</p>

					<div class="wishlist-actions">
						<a class="details-button"
							href="<%=contextPath%>/vehicleDetails?id=<%=vehicle.getId()%>">
							View Details </a>

						<form action="<%=contextPath%>/wishlist" method="post"
							onsubmit="return confirm('Remove this vehicle from your wishlist?');">
							<input type="hidden" name="action" value="remove"> <input
								type="hidden" name="vehicleId" value="<%=vehicle.getId()%>">
							<button class="remove-button" type="submit">Remove ♡</button>
						</form>
					</div>
				</div>
			</article>
			<%
			}
			%>
		</div>

		<%
		}
		%>
	</main>

</body>
</html>
