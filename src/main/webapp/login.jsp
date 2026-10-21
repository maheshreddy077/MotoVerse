
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login | MotoVerse</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css?v=10">

<style>
.auth-page {
	min-height: 80vh;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 40px 18px;
}

.auth-card {
	width: 100%;
	max-width: 440px;
	padding: 32px;
	background: #1c1d22;
	border: 1px solid #303137;
	border-radius: 15px;
	color: #f5f5f5;
	box-shadow: 0 12px 35px rgba(0, 0, 0, 0.25);
}

.auth-card h1 {
	margin: 0 0 8px;
	font-size: 30px;
}

.auth-card h1 span {
	color: #ff4d36;
}

.auth-subtitle {
	color: #a4a6af;
	margin-bottom: 25px;
	line-height: 1.6;
}

.auth-form label {
	display: block;
	margin: 16px 0 7px;
	font-size: 14px;
	color: #ddd;
}

.auth-form input {
	box-sizing: border-box;
	width: 100%;
	padding: 13px;
	border: 1px solid #41424b;
	border-radius: 8px;
	background: #111216;
	color: #fff;
	font: inherit;
}

.auth-form input:focus {
	outline: none;
	border-color: #ff4d36;
	box-shadow: 0 0 0 3px rgba(255, 77, 54, 0.12);
}

.auth-button {
	width: 100%;
	margin-top: 24px;
	padding: 13px;
	border: none;
	border-radius: 8px;
	background: #ff4d36;
	color: white;
	font-size: 15px;
	font-weight: 700;
	cursor: pointer;
}

.auth-button:hover {
	background: #e63c27;
}

.auth-message {
	padding: 12px;
	margin: 15px 0;
	border-radius: 7px;
	font-size: 14px;
	line-height: 1.5;
}

.auth-error {
	background: #421f20;
	border: 1px solid #823b3c;
	color: #ffaaa4;
}

.auth-success {
	background: #153d2b;
	border: 1px solid #28784c;
	color: #9af0bd;
}

.auth-footer {
	margin-top: 22px;
	text-align: center;
	color: #a4a6af;
	font-size: 14px;
}

.auth-footer a {
	color: #ff6957;
	text-decoration: none;
	font-weight: 700;
}

.auth-footer a:hover {
	text-decoration: underline;
}

@media ( max-width : 480px) {
	.auth-card {
		padding: 24px 20px;
	}
}
</style>
</head>
<body>

	<%
	String contextPath = request.getContextPath();
	%>

	<nav class="navbar" aria-label="Main navigation">
		<a class="logo" href="<%=contextPath%>/index.jsp"> Moto<span>Verse</span>
		</a>

		<div class="nav-links">
			<a href="<%=contextPath%>/index.jsp">Home</a> <a
				href="<%=contextPath%>/vehicles">Explore Vehicles</a> <a
				href="<%=contextPath%>/register.jsp">Register</a>
		</div>
	</nav>

	<main class="auth-page">
		<section class="auth-card">
			<h1>
				Welcome <span>Back</span>
			</h1>

			<p class="auth-subtitle">Log in to access your MotoVerse account
				and saved vehicles.</p>

			<%
			if (request.getAttribute("errorMessage") != null) {
			%>
			<div class="auth-message auth-error" role="alert">
				<%=request.getAttribute("errorMessage")%>
			</div>
			<%
			}
			%>

			<%
			if (request.getAttribute("successMessage") != null) {
			%>
			<div class="auth-message auth-success" role="status">
				<%=request.getAttribute("successMessage")%>
			</div>
			<%
			}
			%>

			<form class="auth-form" action="<%=contextPath%>/login" method="post">

				<label for="email">Email Address</label> <input type="email"
					id="email" name="email" placeholder="you@example.com"
					autocomplete="email" required> <label for="password">Password</label>
				<input type="password" id="password" name="password"
					placeholder="Enter your password" autocomplete="current-password"
					required>

				<button class="auth-button" type="submit">Login</button>
			</form>

			<div class="auth-footer">
				Don't have an account? <a href="<%=contextPath%>/register.jsp">Create
					Account</a>
			</div>
		</section>
	</main>

	<footer class="vehicle-footer"> © 2026 MotoVerse — Smart
		Vehicle Explorer </footer>

</body>
</html>
