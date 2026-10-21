<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.motoverse.model.Vehicle"%>

<%!private String safe(String value) {
		if (value == null)
			return "";

		return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;")
				.replace("'", "&#39;");
	}%>

<%
List<Vehicle> vehiclesToCompare = (List<Vehicle>) request.getAttribute("vehiclesToCompare");

String contextPath = request.getContextPath();

boolean validComparison = vehiclesToCompare != null && vehiclesToCompare.size() == 2;

Vehicle v1 = validComparison ? vehiclesToCompare.get(0) : null;
Vehicle v2 = validComparison ? vehiclesToCompare.get(1) : null;

String name1 = "";
String name2 = "";

boolean samePrice = false;
boolean sameMileage = false;

String verdictTitle = "";
String verdictMessage = "";
String verdictWinner = "";
String verdictClass = "";

if (validComparison) {
	String brand1 = v1.getBrand() == null ? "" : v1.getBrand().trim();
	String model1 = v1.getName() == null ? "" : v1.getName().trim();

	String brand2 = v2.getBrand() == null ? "" : v2.getBrand().trim();
	String model2 = v2.getName() == null ? "" : v2.getName().trim();

	name1 = (brand1 + " " + model1).trim();
	name2 = (brand2 + " " + model2).trim();

	if (name1.isEmpty())
		name1 = "Vehicle 1";
	if (name2.isEmpty())
		name2 = "Vehicle 2";

	samePrice = Double.compare(v1.getPrice(), v2.getPrice()) == 0;
	sameMileage = Double.compare(v1.getMileage(), v2.getMileage()) == 0;

	boolean v1AtLeastAsGood = v1.getPrice() <= v2.getPrice() && v1.getMileage() >= v2.getMileage();

	boolean v2AtLeastAsGood = v2.getPrice() <= v1.getPrice() && v2.getMileage() >= v1.getMileage();

	if (samePrice && sameMileage) {
		verdictTitle = "It's a tie!";

		verdictMessage = "Both vehicles have the same price and mileage. "
		+ "Consider engine capacity, fuel type, maintenance costs, " + "comfort and your needs.";

		verdictWinner = "No clear winner";
		verdictClass = "tie";

	} else if (v1AtLeastAsGood && !v2AtLeastAsGood) {
		verdictTitle = name1 + " offers better value";

		verdictMessage = name1 + " costs no more and offers at least as much mileage " + "as " + name2
		+ ", based on price and mileage.";

		verdictWinner = "Better value: " + name1;

	} else if (v2AtLeastAsGood && !v1AtLeastAsGood) {
		verdictTitle = name2 + " offers better value";

		verdictMessage = name2 + " costs no more and offers at least as much mileage " + "as " + name1
		+ ", based on price and mileage.";

		verdictWinner = "Better value: " + name2;

	} else if (samePrice) {
		verdictTitle = "Both vehicles have their advantages";

		verdictMessage = (v1.getMileage() > v2.getMileage() ? name1 : name2)
		+ " offers better mileage at the same price.";

		verdictWinner = "Compare your priorities";
		verdictClass = "tradeoff";

	} else if (sameMileage) {
		verdictTitle = "Both vehicles offer the same mileage";

		verdictMessage = (v1.getPrice() < v2.getPrice() ? name1 : name2) + " has the lower purchase price.";

		verdictWinner = "Lower price at equal mileage";
		verdictClass = "tradeoff";

	} else {
		verdictTitle = "It depends on your priorities";

		if (v1.getPrice() < v2.getPrice()) {
	verdictMessage = name1 + " costs less, while " + name2 + " offers better mileage. Decide whether purchase "
			+ "price or fuel efficiency matters more to you.";
		} else {
	verdictMessage = name2 + " costs less, while " + name1 + " offers better mileage. Decide whether purchase "
			+ "price or fuel efficiency matters more to you.";
		}

		verdictWinner = "Price vs. mileage trade-off";
		verdictClass = "tradeoff";
	}
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>MotoVerse | Vehicle Comparison</title>

<style>
:root {
	--background: #101114;
	--surface: #1a1b20;
	--border: #303139;
	--text: #f5f5f7;
	--muted: #a4a5af;
	--accent: #ff4d36;
	--green: #2ecc71;
	--red: #ff7868;
	--yellow: #f1c40f;
}

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: Arial, Helvetica, sans-serif;
	background: var(--background);
	color: var(--text);
	min-height: 100vh;
	line-height: 1.6;
}

.navbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 20px;
	padding: 20px 7%;
	background: #111216;
	border-bottom: 1px solid var(--border);
}

.logo {
	color: var(--text);
	font-size: 25px;
	font-weight: 800;
	text-decoration: none;
}

.logo span {
	color: var(--accent);
}

.nav-links {
	display: flex;
	flex-wrap: wrap;
	gap: 22px;
}

.nav-links a {
	color: var(--text);
	text-decoration: none;
	font-size: 14px;
}

.nav-links a:hover {
	color: var(--accent);
}

.page-header {
	padding: 55px 7% 35px;
	background: #15161b;
	border-bottom: 1px solid var(--border);
}

.eyebrow {
	color: var(--accent);
	font-size: 12px;
	font-weight: 700;
	letter-spacing: 2px;
	margin-bottom: 10px;
}

.page-header h1 {
	font-size: clamp(30px, 5vw, 46px);
	line-height: 1.2;
	margin-bottom: 12px;
}

.page-header h1 span {
	color: var(--accent);
}

.page-header p:last-child {
	color: var(--muted);
}

.page-content {
	padding: 35px 7% 65px;
}

.comparison-card {
	background: var(--surface);
	border: 1px solid var(--border);
	border-radius: 12px;
	padding: 25px;
	overflow: hidden;
}

.comparison-title {
	font-size: 21px;
	margin-bottom: 10px;
}

.legend {
	font-size: 13px;
	color: var(--muted);
	margin-bottom: 18px;
}

.table-wrapper {
	width: 100%;
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 620px;
}

th, td {
	padding: 16px 18px;
	text-align: left;
	border-bottom: 1px solid var(--border);
	vertical-align: middle;
}

thead th {
	background: #222329;
	font-size: 14px;
}

thead th:first-child {
	color: var(--muted);
	width: 22%;
}

thead th:not(:first-child) {
	color: var(--accent);
}

tbody td:first-child {
	color: var(--muted);
	font-weight: 600;
}

tbody td:not(:first-child) {
	font-weight: 600;
}

tbody tr:last-child td {
	border-bottom: none;
}

tbody tr:hover {
	background: #222329;
}

.better-value {
	background: rgba(46, 204, 113, 0.13);
	color: var(--green) !important;
	font-weight: 800 !important;
}

.worse-value {
	background: rgba(255, 77, 54, 0.08);
	color: var(--red) !important;
}

.equal-value {
	color: var(--text);
}

.price {
	font-size: 17px;
}

.winner-badge {
	display: inline-block;
	margin: 4px 0 0 5px;
	padding: 3px 7px;
	border-radius: 4px;
	background: rgba(46, 204, 113, 0.16);
	color: var(--green);
	font-size: 10px;
	font-weight: 800;
	white-space: nowrap;
}

.vehicle-image {
	display: block;
	width: 100%;
	max-width: 220px;
	height: 130px;
	object-fit: cover;
	border-radius: 8px;
	background: #292a31;
}

.no-image {
	width: 100%;
	max-width: 220px;
	height: 100px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #25262d;
	border: 1px dashed #454650;
	border-radius: 8px;
	color: #a4a5af;
	font-size: 12px;
}

.verdict-card {
	margin-top: 28px;
	padding: 24px;
	border: 1px solid var(--border);
	border-left: 4px solid var(--green);
	border-radius: 12px;
	background: linear-gradient(135deg, #1a1b20, #202129);
}

.verdict-card.tradeoff {
	border-left-color: var(--yellow);
}

.verdict-card.tie {
	border-left-color: #8e9aaf;
}

.verdict-label {
	color: var(--green);
	font-size: 11px;
	font-weight: 800;
	letter-spacing: 2px;
	margin-bottom: 8px;
}

.verdict-card.tradeoff .verdict-label {
	color: var(--yellow);
}

.verdict-card.tie .verdict-label {
	color: #b8c0ce;
}

.verdict-card h3 {
	font-size: 23px;
	margin-bottom: 10px;
	overflow-wrap: anywhere;
}

.verdict-card p {
	color: var(--muted);
	line-height: 1.7;
}

.verdict-winner {
	display: inline-block;
	margin-top: 16px;
	padding: 8px 12px;
	border-radius: 6px;
	background: rgba(46, 204, 113, 0.13);
	color: var(--green);
	font-size: 13px;
	font-weight: 800;
}

.verdict-card.tradeoff .verdict-winner, .verdict-card.tie .verdict-winner
	{
	background: rgba(255, 255, 255, 0.06);
	color: var(--text);
}

.actions {
	display: flex;
	flex-wrap: wrap;
	gap: 12px;
	margin-top: 25px;
}

.button {
	display: inline-block;
	padding: 12px 20px;
	border-radius: 6px;
	text-decoration: none;
	font-weight: 700;
	font-size: 14px;
	transition: 0.2s ease;
}

.primary-button {
	background: var(--accent);
	color: white;
	border: 1px solid var(--accent);
}

.primary-button:hover {
	background: #e83e29;
}

.secondary-button {
	color: var(--text);
	border: 1px solid var(--border);
}

.secondary-button:hover {
	border-color: var(--accent);
	color: var(--accent);
}

.empty-state {
	padding: 35px 20px;
	text-align: center;
	background: var(--surface);
	border: 1px solid var(--border);
	border-radius: 10px;
}

.empty-state p {
	color: var(--muted);
	margin: 10px 0 20px;
}

.site-footer {
	background: #111216;
	border-top: 1px solid var(--border);
	padding: 25px 7%;
	text-align: center;
	color: var(--muted);
	font-size: 13px;
}

.site-footer .logo {
	display: inline-block;
	margin-bottom: 8px;
}

@media ( max-width : 650px) {
	.navbar {
		align-items: flex-start;
		flex-direction: column;
	}
	.nav-links {
		gap: 14px;
	}
	.page-header {
		padding: 35px 5%;
	}
	.page-content {
		padding: 25px 5% 45px;
	}
	.comparison-card {
		padding: 15px;
	}
	th, td {
		padding: 13px 12px;
	}
	.verdict-card {
		padding: 18px;
	}
	.verdict-card h3 {
		font-size: 20px;
	}
}
</style>
</head>

<body>

	<nav class="navbar">
		<a class="logo" href="<%=contextPath%>/index.jsp"> Moto<span>Verse</span>
		</a>

		<div class="nav-links">
			<a href="<%=contextPath%>/index.jsp">Home</a> <a
				href="<%=contextPath%>/vehicles">Vehicles</a> <a
				href="<%=contextPath%>/vehicles?type=Bike">Bikes</a> <a
				href="<%=contextPath%>/vehicles?type=Car">Cars</a>
		</div>
	</nav>

	<header class="page-header">
		<p class="eyebrow">MAKE THE RIGHT CHOICE</p>

		<h1>
			Compare <span>Vehicles.</span>
		</h1>

		<p>Compare specifications side by side and find your next ride.</p>
	</header>

	<main class="page-content">

		<%
		if (validComparison) {
		%>

		<section class="comparison-card">

			<h2 class="comparison-title">Vehicle Specifications</h2>

			<p class="legend">
				<span style="color: #2ecc71">● Green</span> = Better value for price
				or mileage &nbsp;&nbsp; <span style="color: #ff7868">● Red</span> =
				Less favorable value
			</p>

			<div class="table-wrapper">

				<table>
					<thead>
						<tr>
							<th>Specification</th>
							<th><%=safe(name1)%></th>
							<th><%=safe(name2)%></th>
						</tr>
					</thead>

					<tbody>

						<tr>
							<td>Vehicle Image</td>

							<td>
								<%
								if (v1.getImageUrl() != null && !v1.getImageUrl().trim().isEmpty()) {
								%> <img class="vehicle-image"
								src="<%=safe(v1.getImageUrl().trim())%>" alt="<%=safe(name1)%>"
								onerror="this.style.display='none';
                         this.nextElementSibling.style.display='flex';">

								<div class="no-image" style="display: none">Image
									unavailable</div> <%
 } else {
 %>

								<div class="no-image">No image provided</div> <%
 }
 %>
							</td>

							<td>
								<%
								if (v2.getImageUrl() != null && !v2.getImageUrl().trim().isEmpty()) {
								%> <img class="vehicle-image"
								src="<%=safe(v2.getImageUrl().trim())%>" alt="<%=safe(name2)%>"
								onerror="this.style.display='none';
                         this.nextElementSibling.style.display='flex';">

								<div class="no-image" style="display: none">Image
									unavailable</div> <%
 } else {
 %>

								<div class="no-image">No image provided</div> <%
 }
 %>
							</td>
						</tr>

						<!-- Brand -->
						<tr>
							<td>Brand</td>
							<td><%=safe(v1.getBrand())%></td>
							<td><%=safe(v2.getBrand())%></td>
						</tr>

						<!-- Vehicle name -->
						<tr>
							<td>Vehicle Name</td>
							<td><%=safe(v1.getName())%></td>
							<td><%=safe(v2.getName())%></td>
						</tr>

						<!-- Vehicle type -->
						<tr>
							<td>Vehicle Type</td>
							<td><%=safe(v1.getType())%></td>
							<td><%=safe(v2.getType())%></td>
						</tr>

						<!-- Price -->
						<tr>
							<td>Price</td>

							<td
								class="<%=v1.getPrice() < v2.getPrice() ? "better-value"
		: (v1.getPrice() > v2.getPrice() ? "worse-value" : "equal-value")%>">

								<span class="price"> ₹<%=String.format("%,.0f", v1.getPrice())%>
							</span> <%
 if (v1.getPrice() < v2.getPrice()) {
 %> <span class="winner-badge">LOWER PRICE</span> <%
 } else if (samePrice) {
 %> <span class="winner-badge">EQUAL</span> <%
 }
 %>
							</td>

							<td
								class="<%=v2.getPrice() < v1.getPrice() ? "better-value"
		: (v2.getPrice() > v1.getPrice() ? "worse-value" : "equal-value")%>">

								<span class="price"> ₹<%=String.format("%,.0f", v2.getPrice())%>
							</span> <%
 if (v2.getPrice() < v1.getPrice()) {
 %> <span class="winner-badge">LOWER PRICE</span> <%
 } else if (samePrice) {
 %> <span class="winner-badge">EQUAL</span> <%
 }
 %>
							</td>
						</tr>

						<!-- Mileage -->
						<tr>
							<td>Mileage (km/l)</td>

							<td
								class="<%=v1.getMileage() > v2.getMileage() ? "better-value"
		: (v1.getMileage() < v2.getMileage() ? "worse-value" : "equal-value")%>">

								<%=String.format("%.1f", v1.getMileage())%> <%
 if (v1.getMileage() > v2.getMileage()) {
 %> <span class="winner-badge">BETTER</span> <%
 } else if (sameMileage) {
 %> <span class="winner-badge">EQUAL</span> <%
 }
 %>
							</td>

							<td
								class="<%=v2.getMileage() > v1.getMileage() ? "better-value"
		: (v2.getMileage() < v1.getMileage() ? "worse-value" : "equal-value")%>">

								<%=String.format("%.1f", v2.getMileage())%> <%
 if (v2.getMileage() > v1.getMileage()) {
 %> <span class="winner-badge">BETTER</span> <%
 } else if (sameMileage) {
 %> <span class="winner-badge">EQUAL</span> <%
 }
 %>
							</td>
						</tr>

						<!-- Engine capacity -->
						<tr>
							<td>Engine Capacity</td>
							<td><%=v1.getEngineCc()%> cc</td>
							<td><%=v2.getEngineCc()%> cc</td>
						</tr>

						<!-- Fuel type -->
						<tr>
							<td>Fuel Type</td>
							<td><%=safe(v1.getFuelType())%></td>
							<td><%=safe(v2.getFuelType())%></td>
						</tr>

					</tbody>
				</table>

			</div>

			<!-- Smart Verdict -->
			<div class="verdict-card <%=verdictClass%>">

				<div class="verdict-label">MOTOVERSE SMART VERDICT</div>

				<h3><%=safe(verdictTitle)%></h3>

				<p><%=safe(verdictMessage)%></p>

				<div class="verdict-winner">
					<%=safe(verdictWinner)%>
				</div>

			</div>

			<div class="actions">

				<a class="button primary-button" href="<%=contextPath%>/vehicles">
					Compare Other Vehicles </a> <a class="button secondary-button"
					href="<%=contextPath%>/index.jsp"> Back to Home </a>

			</div>

		</section>

		<%
		} else {
		%>

		<section class="empty-state">

			<h2>Unable to Compare Vehicles</h2>

			<p>Please select exactly two vehicles from the vehicle listing.</p>

			<a class="button primary-button" href="<%=contextPath%>/vehicles">
				Explore Vehicles </a>

		</section>

		<%
		}
		%>

	</main>

	<footer class="site-footer">

		<a class="logo" href="<%=contextPath%>/index.jsp"> Moto<span>Verse</span>
		</a>

		<p>Discover your next ride.</p>
		<p>© 2026 MotoVerse</p>

	</footer>

</body>
</html>