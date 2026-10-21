
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.motoverse.model.Vehicle"%>

<%
Vehicle vehicle = (Vehicle) request.getAttribute("vehicle");
String contextPath = request.getContextPath();

if (vehicle == null) {
	response.sendRedirect(contextPath + "/vehicles");
	return;
}

String imageUrl = vehicle.getImageUrl();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MotoVerse | Vehicle Details</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">

<style>
.details-page {
	width: 92%;
	max-width: 1150px;
	margin: 0 auto;
	padding: 45px 0 60px;
	color: #f5f5f5;
}

.back-link {
	display: inline-block;
	margin-bottom: 25px;
	color: #ff727b;
	text-decoration: none;
}

.back-link:hover {
	text-decoration: underline;
}

.details-card {
	display: grid;
	grid-template-columns: 1.1fr 1fr;
	gap: 35px;
	padding: 28px;
	background: linear-gradient(145deg, #202020, #151515);
	border: 1px solid #303030;
	border-radius: 16px;
}

.details-image {
	width: 100%;
	height: 420px;
	object-fit: contain;
	background: #252525;
	border-radius: 12px;
}

.details-type {
	display: inline-block;
	padding: 6px 12px;
	color: #ff727b;
	background: rgba(230, 57, 70, .13);
	border: 1px solid rgba(230, 57, 70, .3);
	border-radius: 20px;
	font-size: .85rem;
}

.details-info h1 {
	margin: 18px 0;
	font-size: clamp(1.8rem, 4vw, 2.6rem);
	overflow-wrap: anywhere;
}

.details-price {
	margin: 20px 0;
	color: #ff5964;
	font-size: 2rem;
	font-weight: 700;
}

.specifications {
	margin-top: 25px;
	border-top: 1px solid #383838;
}

.spec-row {
	display: flex;
	justify-content: space-between;
	gap: 15px;
	padding: 16px 0;
	border-bottom: 1px solid #383838;
}

.spec-row span:first-child {
	color: #aaa;
}

.spec-row span:last-child {
	text-align: right;
	overflow-wrap: anywhere;
}

@media ( max-width : 750px) {
	.details-card {
		grid-template-columns: 1fr;
		padding: 18px;
	}
	.details-image {
		height: 280px;
	}
	.details-page {
		width: 94%;
		padding-top: 28px;
	}
}
</style>
</head>

<body>

	<nav class="navbar">
		<div class="nav-container">
			<a href="<%=contextPath%>/index.jsp" class="logo">MotoVerse</a>
			<div class="nav-links">
				<a href="<%=contextPath%>/index.jsp">Home</a> <a
					href="<%=contextPath%>/vehicles">Vehicles</a>
			</div>
		</div>
	</nav>

	<main class="details-page">

		<a class="back-link" href="<%=contextPath%>/vehicles"> &larr; Back
			to Vehicles </a>

		<section class="details-card">

			<div>
				<%
				if (imageUrl != null && !imageUrl.trim().isEmpty()) {
				%>
				<img class="details-image" src="<%=imageUrl.trim()%>"
					alt="Vehicle image" onerror="this.style.display='none';">
				<%
				} else {
				%>
				<div class="details-image"
					style="display: flex; align-items: center; justify-content: center; color: #999;">
					Image unavailable</div>
				<%
				}
				%>
			</div>

			<div class="details-info">

				<span class="details-type"> <%=vehicle.getType() == null ? "Vehicle" : vehicle.getType()%>
				</span>

				<h1>
					<%=vehicle.getBrand() == null ? "" : vehicle.getBrand()%>
					<%=vehicle.getName() == null ? "" : vehicle.getName()%>
				</h1>

				<p class="details-price">
					₹<%=String.format("%,.2f", vehicle.getPrice())%>
				</p>

				<h2>Specifications</h2>

				<div class="specifications">

					<div class="spec-row">
						<span>Brand</span> <span><%=vehicle.getBrand() == null ? "Not specified" : vehicle.getBrand()%></span>
					</div>

					<div class="spec-row">
						<span>Model</span> <span><%=vehicle.getName() == null ? "Not specified" : vehicle.getName()%></span>
					</div>

					<div class="spec-row">
						<span>Vehicle Type</span> <span><%=vehicle.getType() == null ? "Not specified" : vehicle.getType()%></span>
					</div>

					<div class="spec-row">
						<span>Engine Capacity</span> <span><%=vehicle.getEngineCc()%>
							cc</span>
					</div>

					<div class="spec-row">
						<span>Mileage</span> <span><%=vehicle.getMileage()%></span>
					</div>

					<div class="spec-row">
						<span>Fuel Type</span> <span><%=vehicle.getFuelType() == null ? "Not specified" : vehicle.getFuelType()%></span>
					</div>

				</div>
			</div>

		</section>

	</main>

	<footer>
		<p style="text-align: center; padding: 24px; color: #999;">&copy;
			2026 MotoVerse. All rights reserved.</p>
	</footer>

</body>
</html>
