<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.motoverse.model.Vehicle"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Explore, filter, and compare bikes and cars on MotoVerse.">
<title>MotoVerse | Explore Vehicles</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css?v=10">

<style>
/* VEHICLES PAGE */
.vehicle-page {
	width: 100%;
	max-width: 1550px;
	margin: 0 auto;
	padding: 38px 24px 60px;
	color: #f5f5f5;
}

.vehicle-heading {
	margin-bottom: 30px;
}

.vehicle-heading h1 {
	font-size: clamp(2rem, 4vw, 3rem);
	margin-bottom: 10px;
	letter-spacing: -1px;
}

.vehicle-heading h1 span {
	color: #ff4d36;
}

.vehicle-heading p {
	color: #a4a6af;
	font-size: 1.05rem;
}

/* NAVIGATION */
.navbar {
	position: sticky;
	top: 0;
	z-index: 100;
	width: 100%;
	padding: 15px 5%;
	background: rgba(16, 17, 20, 0.96);
	border-bottom: 1px solid #303137;
	box-shadow: 0 6px 24px rgba(0, 0, 0, 0.2);
	backdrop-filter: blur(14px);
	-webkit-backdrop-filter: blur(14px);
}

.nav-container {
	width: 100%;
	max-width: 1550px;
	margin: 0 auto;
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 24px;
}

.navbar .logo {
	color: #f5f5f5;
	font-size: 27px;
	font-weight: 800;
	letter-spacing: -1px;
	text-decoration: none;
	white-space: nowrap;
}

.navbar .logo span {
	color: #ff4d36;
}

.nav-links {
	display: flex;
	align-items: center;
	justify-content: flex-end;
	flex-wrap: wrap;
	gap: 6px;
}

.nav-links a {
	position: relative;
	display: inline-block;
	padding: 9px 12px;
	border-radius: 7px;
	color: #d5d5da;
	font-size: 14px;
	font-weight: 500;
	text-decoration: none;
	white-space: nowrap;
	transition: color 0.2s ease, background 0.2s ease;
}

.nav-links a:hover {
	color: #fff;
	background: #25262c;
}

.nav-links a.active {
	color: #ff6957;
	background: rgba(255, 77, 54, 0.12);
	font-weight: 700;
}

.nav-links a.active::after {
	content: "";
	position: absolute;
	bottom: 3px;
	left: 12px;
	right: 12px;
	height: 2px;
	border-radius: 2px;
	background: #ff4d36;
}

.admin-status {
	padding: 5px 9px;
	border: 1px solid rgba(80, 200, 120, 0.3);
	border-radius: 6px;
	background: rgba(80, 200, 120, 0.1);
	color: #8ee0a1;
	font-size: 12px;
	font-weight: 700;
	white-space: nowrap;
}

.nav-links a.logout-nav {
	color: #ff8172;
	border: 1px solid rgba(255, 77, 54, 0.4);
}

.nav-links a.logout-nav:hover {
	color: #fff;
	background: #ff4d36;
}

/* SEARCH AND FILTERS */
.vehicle-search {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 12px;
	margin-bottom: 28px;
	padding: 20px;
	background: linear-gradient(145deg, #1c1d22, #16171b);
	border: 1px solid #303137;
	border-radius: 14px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
}

.vehicle-search input, .vehicle-search select {
	flex: 1 1 165px;
	min-width: 0;
	width: 100%;
	padding: 13px 14px;
	border: 1px solid #3c3d45;
	border-radius: 8px;
	background: #111216;
	color: #f5f5f5;
	font: inherit;
	font-size: 14px;
	outline: none;
	transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.vehicle-search input::placeholder {
	color: #898b94;
}

.vehicle-search input:focus, .vehicle-search select:focus {
	border-color: #ff4d36;
	box-shadow: 0 0 0 3px rgba(255, 77, 54, 0.12);
}

.vehicle-search select {
	cursor: pointer;
}

.vehicle-search button, .compare-button {
	padding: 13px 20px;
	border: 1px solid transparent;
	border-radius: 8px;
	background: #ff4d36;
	color: #fff;
	font: inherit;
	font-size: 14px;
	font-weight: 700;
	cursor: pointer;
	transition: background 0.2s ease, transform 0.2s ease;
}

.vehicle-search button:hover, .compare-button:hover:not(:disabled) {
	background: #e63c27;
	transform: translateY(-1px);
}

.clear-filters {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 12px 16px;
	border: 1px solid #41424b;
	border-radius: 8px;
	color: #ddd;
	text-decoration: none;
	font-size: 14px;
	transition: background 0.2s ease, border-color 0.2s ease;
}

.clear-filters:hover {
	background: #292a30;
	border-color: #ff4d36;
}

/* MESSAGES */
.vehicle-message {
	padding: 13px 16px;
	margin-bottom: 20px;
	border-radius: 8px;
	font-size: 14px;
	line-height: 1.6;
}

.vehicle-message.success {
	background: #153d2b;
	color: #9af0bd;
	border: 1px solid #28784c;
}

.vehicle-message.error {
	background: #421f20;
	color: #ffaaa4;
	border: 1px solid #823b3c;
}

/* COMPARISON TOOLBAR */
.compare-toolbar {
	display: flex;
	align-items: center;
	justify-content: space-between;
	flex-wrap: wrap;
	gap: 14px;
	margin: 0 0 24px;
	padding: 17px 20px;
	background: #1b1c21;
	border: 1px solid #303137;
	border-radius: 12px;
}

.compare-toolbar p {
	margin: 0;
	color: #ddd;
	line-height: 1.7;
}

.compare-count {
	display: inline-block;
	margin-left: 5px;
	color: #ff7969;
	font-weight: 700;
}

.compare-button:disabled {
	background: #45464e;
	color: #b8b8bd;
	cursor: not-allowed;
	opacity: 0.8;
}

/* VEHICLE CARDS */
.vehicle-grid {
	display: grid;
	grid-template-columns: repeat(3, minmax(0, 1fr));
	align-items: stretch;
	gap: 26px;
}

.vehicle-card {
	display: flex;
	flex-direction: column;
	min-width: 0;
	padding: 17px;
	overflow: hidden;
	background: linear-gradient(145deg, #202127, #15161a);
	border: 1px solid #303137;
	border-radius: 15px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.18);
	transition: transform 0.25s ease, border-color 0.25s ease;
}

.vehicle-card:hover {
	transform: translateY(-4px);
	border-color: #ff4d36;
}

.vehicle-image {
	display: block;
	width: 100%;
	height: 235px;
	margin-bottom: 18px;
	border-radius: 10px;
	background: #25262c;
	object-fit: contain;
}

.image-placeholder {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 100%;
	height: 235px;
	margin-bottom: 18px;
	border-radius: 10px;
	background: #25262c;
	color: #999;
}

.vehicle-type {
	display: inline-block;
	align-self: flex-start;
	padding: 5px 11px;
	background: rgba(255, 77, 54, 0.12);
	color: #ff8172;
	border: 1px solid rgba(255, 77, 54, 0.3);
	border-radius: 20px;
	font-size: 12px;
	font-weight: 700;
}

.vehicle-card h2 {
	margin: 14px 0 12px;
	font-size: 1.3rem;
	line-height: 1.4;
	overflow-wrap: anywhere;
}

.vehicle-details {
	display: grid;
	gap: 11px;
	margin: 14px 0;
	padding: 15px 0;
	border-top: 1px solid #303137;
	border-bottom: 1px solid #303137;
}

.vehicle-details p {
	margin: 0;
	color: #bfc0c7;
	font-size: 14px;
	line-height: 1.6;
}

.vehicle-details strong {
	color: #f5f5f5;
}

.vehicle-price {
	margin: 14px 0 5px;
	color: #ff6957;
	font-size: 1.45rem;
	font-weight: 800;
}

/* CARD ACTION BUTTONS */
.view-details-button {
	display: block;
	width: 100%;
	box-sizing: border-box;
	margin-top: 12px;
	padding: 12px 14px;
	border: 1px solid transparent;
	border-radius: 8px;
	background: #ff4d36;
	color: #fff;
	font-family: inherit;
	font-size: 14px;
	font-weight: 700;
	text-align: center;
	text-decoration: none;
	cursor: pointer;
	transition: background 0.2s ease, border-color 0.2s ease;
}

.view-details-button:hover {
	background: #e63c27;
}

.view-details-button.secondary {
	background: #292a30;
	border-color: #41424b;
}

.view-details-button.secondary:hover {
	background: #35363e;
}

.view-details-button.delete-button {
	background: #292a30;
	border-color: #803c3c;
	color: #ff9990;
}

.view-details-button.delete-button:hover {
	background: #652b2b;
	color: #fff;
}

/* WISHLIST BUTTON */
.wishlist-button {
	background: #292a30;
	border-color: #80304b;
	color: #ff8aab;
}

.wishlist-button:hover {
	background: #652b42;
	color: #fff;
}

.compare-option {
	display: flex;
	align-items: center;
	gap: 9px;
	margin-top: auto;
	padding-top: 17px;
	color: #d5d5da;
	font-size: 14px;
	cursor: pointer;
}

.compare-option input {
	width: 18px;
	height: 18px;
	accent-color: #ff4d36;
	cursor: pointer;
}

.empty-message {
	grid-column: 1/-1;
	padding: 40px 20px;
	background: #191a1f;
	border: 1px solid #303137;
	border-radius: 12px;
	color: #b5b6bd;
	text-align: center;
	line-height: 1.7;
}

/* FOOTER */
.vehicle-footer {
	padding: 24px 16px;
	border-top: 1px solid #303137;
	background: #0d0e11;
	color: #858791;
	text-align: center;
	font-size: 13px;
}

/* RESPONSIVE LAYOUT */
@media ( max-width : 1100px) {
	.vehicle-grid {
		grid-template-columns: repeat(2, minmax(0, 1fr));
		gap: 20px;
	}
	.vehicle-search {
		gap: 10px;
	}
}

@media ( max-width : 850px) {
	.navbar {
		padding: 14px 5%;
	}
	.nav-container {
		flex-direction: column;
		align-items: flex-start;
		gap: 12px;
	}
	.nav-links {
		width: 100%;
		justify-content: flex-start;
		gap: 4px;
	}
	.nav-links a {
		padding: 8px 10px;
	}
	.vehicle-page {
		padding: 30px 20px 45px;
	}
}

@media ( max-width : 600px) {
	.vehicle-page {
		padding: 25px 15px 35px;
	}
	.vehicle-grid {
		grid-template-columns: 1fr;
		gap: 18px;
	}
	.vehicle-search {
		padding: 14px;
	}
	.vehicle-search input, .vehicle-search select, .vehicle-search button,
		.clear-filters {
		flex: 1 1 100%;
		width: 100%;
		box-sizing: border-box;
	}
	.vehicle-image, .image-placeholder {
		height: 225px;
	}
	.compare-toolbar {
		align-items: stretch;
		padding: 15px;
	}
	.compare-button {
		width: 100%;
	}
	.vehicle-card {
		padding: 14px;
	}
}

@media ( max-width : 420px) {
	.navbar {
		padding: 13px 4%;
	}
	.navbar .logo {
		font-size: 25px;
	}
	.nav-links {
		gap: 2px;
	}
	.nav-links a {
		padding: 8px 7px;
		font-size: 12px;
	}
	.admin-status {
		font-size: 11px;
	}
	.vehicle-heading h1 {
		font-size: 2rem;
	}
}

@media ( prefers-reduced-motion : reduce) {
	.vehicle-card, .nav-links a, .view-details-button, .vehicle-search button
		{
		transition: none;
	}
	.vehicle-card:hover {
		transform: none;
	}
}
</style>
</head>

<body>

	<%
	String contextPath = request.getContextPath();

	List<Vehicle> vehicles = (List<Vehicle>) request.getAttribute("vehicles");

	String keyword = (String) request.getAttribute("keyword");
	String selectedType = (String) request.getAttribute("selectedType");
	String selectedFuel = (String) request.getAttribute("selectedFuel");
	String selectedSort = (String) request.getAttribute("selectedSort");

	if (keyword == null)
		keyword = "";
	if (selectedType == null)
		selectedType = "";
	if (selectedFuel == null)
		selectedFuel = "";
	if (selectedSort == null)
		selectedSort = "name";

	boolean isAdmin = session.getAttribute("adminUsername") != null;
	boolean isUser = session.getAttribute("userId") != null;

	String userName = isUser ? (String) session.getAttribute("userName") : "";
	%>

	<!-- NAVIGATION -->
	<nav class="navbar" aria-label="Main navigation">
		<div class="nav-container">

			<a href="<%=contextPath%>/index.jsp" class="logo"> Moto<span>Verse</span>
			</a>

			<div class="nav-links">

				<a href="<%=contextPath%>/index.jsp">Home</a> <a
					href="<%=contextPath%>/vehicles"
					class="<%=selectedType.isEmpty() ? "active" : ""%>"
					<%=selectedType.isEmpty() ? "aria-current=\"page\"" : ""%>>
					Explore </a> <a href="<%=contextPath%>/vehicles?type=Bike"
					class="<%="Bike".equalsIgnoreCase(selectedType) ? "active" : ""%>"
					<%="Bike".equalsIgnoreCase(selectedType) ? "aria-current=\"page\"" : ""%>>
					Bikes </a> <a href="<%=contextPath%>/vehicles?type=Car"
					class="<%="Car".equalsIgnoreCase(selectedType) ? "active" : ""%>"
					<%="Car".equalsIgnoreCase(selectedType) ? "aria-current=\"page\"" : ""%>>
					Cars </a>

				<%
				if (isAdmin) {
				%>
				<a href="<%=contextPath%>/adminDashboard">Dashboard</a> <span
					class="admin-status">● Admin</span> <a
					href="<%=contextPath%>/logout" class="logout-nav">Logout</a>

				<%
				} else if (isUser) {
				%>
				<a href="<%=contextPath%>/wishlist">♡ Wishlist</a> <span>Welcome,
					<%=userName == null ? "User" : userName%></span> <a
					href="<%=contextPath%>/logout" class="logout-nav">Logout</a> <a
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
		</div>
	</nav>

	<main class="vehicle-page">

		<!-- PAGE HEADING -->
		<section class="vehicle-heading">
			<h1>
				Explore <span>Vehicles</span>
			</h1>
			<p>Find your next ride with MotoVerse.</p>
		</section>

		<!-- SUCCESS AND ERROR MESSAGES -->
		<%
		String vehicleMessage = (String) session.getAttribute("vehicleMessage");

		String vehicleMessageType = (String) session.getAttribute("vehicleMessageType");

		if (vehicleMessage != null) {
			session.removeAttribute("vehicleMessage");
			session.removeAttribute("vehicleMessageType");

			String messageClass = "error".equalsIgnoreCase(vehicleMessageType) ? "error" : "success";
		%>
		<div class="vehicle-message <%=messageClass%>" role="status">
			<%=vehicleMessage%>
		</div>
		<%
		}
		%>

		<!-- SEARCH AND FILTERS -->
		<form class="vehicle-search" action="<%=contextPath%>/vehicles"
			method="get">

			<input type="text" name="keyword" placeholder="Search brand or model"
				aria-label="Search by brand or model" value="<%=keyword%>">

			<select name="type" aria-label="Vehicle type">
				<option value="" <%=selectedType.isEmpty() ? "selected" : ""%>>
					All Vehicle Types</option>

				<option value="Bike"
					<%="Bike".equalsIgnoreCase(selectedType) ? "selected" : ""%>>
					Bikes</option>

				<option value="Car"
					<%="Car".equalsIgnoreCase(selectedType) ? "selected" : ""%>>
					Cars</option>
			</select> <select name="fuelType" aria-label="Fuel type">
				<option value="" <%=selectedFuel.isEmpty() ? "selected" : ""%>>
					All Fuel Types</option>

				<option value="Petrol"
					<%="Petrol".equalsIgnoreCase(selectedFuel) ? "selected" : ""%>>
					Petrol</option>

				<option value="Diesel"
					<%="Diesel".equalsIgnoreCase(selectedFuel) ? "selected" : ""%>>
					Diesel</option>

				<option value="Electric"
					<%="Electric".equalsIgnoreCase(selectedFuel) ? "selected" : ""%>>
					Electric</option>

				<option value="Hybrid"
					<%="Hybrid".equalsIgnoreCase(selectedFuel) ? "selected" : ""%>>
					Hybrid</option>
			</select> <input type="number" name="minPrice" placeholder="Minimum price"
				aria-label="Minimum price" min="0" step="0.01"
				value="<%=request.getAttribute("minPrice") != null ? request.getAttribute("minPrice") : ""%>">

			<input type="number" name="maxPrice" placeholder="Maximum price"
				aria-label="Maximum price" min="0" step="0.01"
				value="<%=request.getAttribute("maxPrice") != null ? request.getAttribute("maxPrice") : ""%>">

			<select name="sortBy" aria-label="Sort vehicles">
				<option value="name"
					<%="name".equals(selectedSort) ? "selected" : ""%>>Name:
					A–Z</option>

				<option value="priceAsc"
					<%="priceAsc".equals(selectedSort) ? "selected" : ""%>>
					Price: Low to High</option>

				<option value="priceDesc"
					<%="priceDesc".equals(selectedSort) ? "selected" : ""%>>
					Price: High to Low</option>

				<option value="mileageDesc"
					<%="mileageDesc".equals(selectedSort) ? "selected" : ""%>>
					Mileage: High to Low</option>
			</select>

			<button type="submit">Apply Filters</button>

			<a class="clear-filters" href="<%=contextPath%>/vehicles"> Clear
				Filters </a>
		</form>

		<%-- Separate delete forms stay outside the comparison form. --%>
		<%
		if (isAdmin && vehicles != null) {
			for (Vehicle vehicle : vehicles) {
		%>
		<form id="deleteVehicleForm<%=vehicle.getId()%>"
			action="<%=contextPath%>/deleteVehicle" method="post"
			onsubmit="return confirm('Are you sure you want to delete this vehicle?');">

			<input type="hidden" name="id" value="<%=vehicle.getId()%>">
		</form>
		<%
		}
		}
		%>

		<%-- Wishlist forms also stay outside the comparison form. --%>
		<%
		if (isUser && !isAdmin && vehicles != null) {
			for (Vehicle vehicle : vehicles) {
		%>
		<form id="addWishlistForm<%=vehicle.getId()%>"
			action="<%=contextPath%>/wishlist" method="post"
			style="display: none;">

			<input type="hidden" name="action" value="add"> <input
				type="hidden" name="vehicleId" value="<%=vehicle.getId()%>">
		</form>
		<%
		}
		}
		%>

		<!-- VEHICLE COMPARISON FORM -->
		<form id="compareForm" action="<%=contextPath%>/compareVehicles"
			method="get">

			<div class="compare-toolbar">
				<p>
					Select exactly two vehicles to compare. <span class="compare-count"
						id="compareCount"> 0 / 2 selected </span>
				</p>

				<button class="compare-button" id="compareButton" type="submit"
					disabled>Compare Vehicles</button>
			</div>

			<!-- VEHICLE CARDS -->
			<section class="vehicle-grid">

				<%
				if (vehicles != null && !vehicles.isEmpty()) {
					for (Vehicle vehicle : vehicles) {
						String imageUrl = vehicle.getImageUrl();
				%>

				<article class="vehicle-card">

					<%
					if (imageUrl != null && !imageUrl.trim().isEmpty()) {
					%>
					<img class="vehicle-image" src="<%=imageUrl.trim()%>"
						alt="<%=vehicle.getBrand() == null ? "" : vehicle.getBrand()%> <%=vehicle.getName() == null ? "" : vehicle.getName()%>"
						loading="lazy" onerror="this.style.display='none';">
					<%
					} else {
					%>
					<div class="image-placeholder">Image unavailable</div>
					<%
					}
					%>

					<span class="vehicle-type"> <%=vehicle.getType() == null ? "Vehicle" : vehicle.getType()%>
					</span>

					<h2>
						<%=vehicle.getBrand() == null ? "" : vehicle.getBrand()%>
						<%=vehicle.getName() == null ? "" : vehicle.getName()%>
					</h2>

					<div class="vehicle-details">
						<p>
							<strong>Engine:</strong>
							<%=vehicle.getEngineCc()%>
							cc
						</p>

						<p>
							<strong>Mileage:</strong>
							<%=vehicle.getMileage()%>
						</p>

						<p>
							<strong>Fuel:</strong>
							<%=vehicle.getFuelType() == null ? "Not specified" : vehicle.getFuelType()%>
						</p>
					</div>

					<p class="vehicle-price">
						₹<%=String.format("%,.2f", vehicle.getPrice())%>
					</p>

					<a class="view-details-button"
						href="<%=contextPath%>/vehicleDetails?id=<%=vehicle.getId()%>">
						View Details </a>

					<%-- WISHLIST BUTTON --%>
					<%
					if (isUser && !isAdmin) {
					%>
					<button type="submit" form="addWishlistForm<%=vehicle.getId()%>"
						class="view-details-button wishlist-button">♡ Add to
						Wishlist</button>
					<%
					}
					%>

					<%-- ADMIN ACTIONS --%>
					<%
					if (isAdmin) {
					%>
					<a class="view-details-button secondary"
						href="<%=contextPath%>/editVehicle?id=<%=vehicle.getId()%>">
						Edit Vehicle </a>

					<button type="submit" form="deleteVehicleForm<%=vehicle.getId()%>"
						class="view-details-button delete-button">Delete Vehicle
					</button>
					<%
					}
					%>

					<!-- COMPARE CHECKBOX -->
					<label class="compare-option"> <input type="checkbox"
						name="compareId" value="<%=vehicle.getId()%>"
						data-type="<%=vehicle.getType() == null ? "" : vehicle.getType()%>">
						Select to compare
					</label>

				</article>

				<%
				}
				} else {
				%>
				<p class="empty-message">No vehicles found. Try changing your
					search or filters.</p>
				<%
				}
				%>

			</section>
		</form>
	</main>

	<footer class="vehicle-footer"> © 2026 MotoVerse — Smart
		Vehicle Explorer </footer>

	<script>
(function () {
    const form = document.getElementById("compareForm");

    const checkboxes = Array.from(
        form.querySelectorAll('input[name="compareId"]')
    );

    const count = document.getElementById("compareCount");
    const button = document.getElementById("compareButton");

    function updateCompareSelection() {
        const selected = checkboxes.filter(box => box.checked);

        count.textContent = selected.length + " / 2 selected";
        button.disabled = selected.length !== 2;
    }

    checkboxes.forEach(function (checkbox) {
        checkbox.addEventListener("change", function () {
            const selected = checkboxes.filter(box => box.checked);

            if (selected.length > 2) {
                checkbox.checked = false;
                alert("Please select only two vehicles.");
                updateCompareSelection();
                return;
            }

            if (selected.length === 2) {
                const firstType =
                    (selected[0].dataset.type || "").trim().toLowerCase();

                const secondType =
                    (selected[1].dataset.type || "").trim().toLowerCase();

                if (firstType !== secondType) {
                    checkbox.checked = false;
                    alert("Please compare two bikes or two cars.");
                }
            }

            updateCompareSelection();
        });
    });

    form.addEventListener("submit", function (event) {
        const selected = checkboxes.filter(box => box.checked);

        if (selected.length !== 2) {
            event.preventDefault();
            alert("Please select exactly two vehicles.");
            return;
        }

        const firstType =
            (selected[0].dataset.type || "").trim().toLowerCase();

        const secondType =
            (selected[1].dataset.type || "").trim().toLowerCase();

        if (firstType !== secondType) {
            event.preventDefault();
            alert("Please compare two bikes or two cars.");
        }
    });

    updateCompareSelection();
})();
</script>

</body>
</html>