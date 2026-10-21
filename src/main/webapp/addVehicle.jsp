
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (session.getAttribute("adminUsername") == null) {
	response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MotoVerse - Add Vehicle</title>

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
	padding: 30px 16px;
}

.navbar {
	max-width: 1100px;
	margin: 0 auto 35px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 15px;
	flex-wrap: wrap;
}

.logo {
	color: #ff4d36;
	font-size: 26px;
	font-weight: bold;
	text-decoration: none;
}

.nav-link {
	color: #ddd;
	text-decoration: none;
	margin-left: 20px;
	font-size: 14px;
}

.nav-link:hover {
	color: #ff4d36;
}

.container {
	max-width: 720px;
	margin: 0 auto;
	background: #191a1f;
	padding: 32px;
	border: 1px solid #303137;
	border-radius: 14px;
	box-shadow: 0 12px 35px rgba(0, 0, 0, 0.25);
}

.heading {
	margin-bottom: 8px;
	font-size: 28px;
}

.heading span {
	color: #ff4d36;
}

.subtitle {
	color: #aaa;
	margin-bottom: 28px;
	font-size: 14px;
	line-height: 1.5;
}

.form-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.form-group {
	display: flex;
	flex-direction: column;
	gap: 9px;
}

.full-width {
	grid-column: 1/-1;
}

label {
	font-size: 14px;
	color: #e5e5e5;
	font-weight: 600;
}

input, select {
	width: 100%;
	padding: 12px 13px;
	background: #101114;
	color: #fff;
	border: 1px solid #393a42;
	border-radius: 7px;
	font-size: 14px;
	outline: none;
}

input:focus, select:focus {
	border-color: #ff4d36;
	box-shadow: 0 0 0 2px rgba(255, 77, 54, 0.12);
}

select option {
	background: #191a1f;
}

.hint {
	color: #999;
	font-size: 12px;
	line-height: 1.5;
}

.actions {
	display: flex;
	gap: 12px;
	flex-wrap: wrap;
	margin-top: 28px;
}

.btn {
	display: inline-block;
	padding: 12px 20px;
	border-radius: 7px;
	border: none;
	text-decoration: none;
	text-align: center;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
	transition: 0.2s;
}

.btn-primary {
	background: #ff4d36;
	color: #fff;
}

.btn-primary:hover {
	background: #e63c27;
	transform: translateY(-1px);
}

.btn-secondary {
	background: #292a30;
	color: #eee;
	border: 1px solid #414149;
}

.btn-secondary:hover {
	background: #35363e;
}

.footer {
	text-align: center;
	color: #777;
	font-size: 12px;
	margin-top: 35px;
}

@media ( max-width : 600px) {
	.container {
		padding: 22px 18px;
	}
	.form-grid {
		grid-template-columns: 1fr;
	}
	.full-width {
		grid-column: auto;
	}
	.heading {
		font-size: 24px;
	}
	.nav-link {
		margin-left: 10px;
	}
	.btn {
		flex: 1;
	}
}
</style>
</head>

<body>

	<nav class="navbar">
		<a class="logo" href="<%=request.getContextPath()%>/index.jsp">MotoVerse</a>

		<div>
			<a class="nav-link" href="<%=request.getContextPath()%>/vehicles">Vehicles</a>

			<a class="nav-link"
				href="<%=request.getContextPath()%>/adminDashboard.jsp">Dashboard</a>

			<a class="nav-link" href="<%=request.getContextPath()%>/logout">Logout</a>
		</div>
	</nav>

	<main class="container">
		<h1 class="heading">
			Add New <span>Vehicle</span>
		</h1>
		<p class="subtitle">Add a bike or car to the MotoVerse collection.
			Enter accurate specifications to help users compare vehicles.</p>

		<form action="<%=request.getContextPath()%>/addVehicle"
			method="post">

			<div class="form-grid">

				<div class="form-group">
					<label for="brand">Brand</label> <input type="text" id="brand"
						name="brand" placeholder="e.g. Honda" required maxlength="100">
				</div>

				<div class="form-group">
					<label for="name">Vehicle Name</label> <input type="text" id="name"
						name="name" placeholder="e.g. SP 125" required maxlength="150">
				</div>

				<div class="form-group">
					<label for="type">Vehicle Type</label> <select id="type"
						name="type" required>
						<option value="Bike">Bike</option>
						<option value="Car">Car</option>
					</select>
				</div>

				<div class="form-group">
					<label for="fuelType">Fuel Type</label> <input type="text"
						id="fuelType" name="fuelType" placeholder="e.g. Petrol or Diesel"
						required maxlength="50">
				</div>

				<div class="form-group">
					<label for="price">Price (₹)</label> <input type="number"
						id="price" name="price" placeholder="e.g. 180000" min="0.01"
						step="0.01" required>
				</div>

				<div class="form-group">
					<label for="mileage">Mileage (km/l)</label> <input type="number"
						id="mileage" name="mileage" placeholder="e.g. 40" min="0.01"
						step="0.01" required>
				</div>

				<div class="form-group">
					<label for="engineCc">Engine Capacity (CC)</label> <input
						type="number" id="engineCc" name="engineCc" placeholder="e.g. 125"
						min="1" step="1" required>
				</div>

				<div class="form-group full-width">
					<label for="imageUrl">Vehicle Image URL (Optional)</label> <input
						type="url" id="imageUrl" name="imageUrl"
						placeholder="https://example.com/vehicle.jpg">
					<p class="hint">Paste a direct image URL beginning with
						https://. Leave blank if you do not have an image.</p>
				</div>

			</div>

			<div class="actions">
				<button type="submit" class="btn btn-primary">+ Add Vehicle
				</button>

				<a class="btn btn-secondary"
					href="<%=request.getContextPath()%>/vehicles"> View Vehicles
				</a>
			</div>

		</form>
	</main>

	<footer class="footer"> © 2026 MotoVerse — Smart Vehicle
		Explorer </footer>

</body>
</html>
