
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MotoVerse - Admin Login</title>

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
	width: 100%;
	padding: 22px 7%;
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #292a30;
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
	font-size: 14px;
	transition: color 0.2s;
}

.nav-link:hover {
	color: #ff4d36;
}

.main-content {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 40px 16px;
}

.login-card {
	width: 100%;
	max-width: 420px;
	background: #191a1f;
	border: 1px solid #303137;
	border-radius: 14px;
	padding: 36px;
	box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
}

.icon {
	width: 54px;
	height: 54px;
	display: flex;
	justify-content: center;
	align-items: center;
	background: rgba(255, 77, 54, 0.12);
	border: 1px solid rgba(255, 77, 54, 0.3);
	border-radius: 12px;
	font-size: 25px;
	margin-bottom: 22px;
}

h1 {
	font-size: 28px;
	margin-bottom: 10px;
}

h1 span {
	color: #ff4d36;
}

.subtitle {
	color: #aaa;
	font-size: 14px;
	line-height: 1.6;
	margin-bottom: 28px;
}

.form-group {
	margin-bottom: 20px;
}

label {
	display: block;
	margin-bottom: 9px;
	font-size: 14px;
	font-weight: bold;
	color: #e5e5e5;
}

input {
	width: 100%;
	padding: 13px 14px;
	background: #101114;
	color: #fff;
	border: 1px solid #393a42;
	border-radius: 7px;
	font-size: 14px;
	outline: none;
}

input:focus {
	border-color: #ff4d36;
	box-shadow: 0 0 0 2px rgba(255, 77, 54, 0.12);
}

.error-message {
	background: rgba(255, 77, 54, 0.1);
	border: 1px solid rgba(255, 77, 54, 0.4);
	color: #ff8172;
	padding: 12px;
	margin-bottom: 22px;
	border-radius: 7px;
	font-size: 13px;
	line-height: 1.5;
}

.login-button {
	width: 100%;
	padding: 13px;
	background: #ff4d36;
	color: white;
	border: none;
	border-radius: 7px;
	font-size: 15px;
	font-weight: bold;
	cursor: pointer;
	transition: background 0.2s, transform 0.2s;
}

.login-button:hover {
	background: #e63c27;
	transform: translateY(-1px);
}

.back-link {
	display: block;
	text-align: center;
	color: #bbb;
	font-size: 13px;
	text-decoration: none;
	margin-top: 22px;
}

.back-link:hover {
	color: #ff4d36;
}

.footer {
	padding: 20px 12px;
	text-align: center;
	color: #777;
	font-size: 12px;
	border-top: 1px solid #292a30;
}

@media ( max-width : 480px) {
	.navbar {
		padding: 18px 5%;
	}
	.login-card {
		padding: 26px 22px;
	}
	h1 {
		font-size: 25px;
	}
}
</style>
</head>

<body>

	<nav class="navbar">
		<a class="logo" href="<%=request.getContextPath()%>/index.jsp">
			MotoVerse </a> <a class="nav-link"
			href="<%=request.getContextPath()%>/vehicles"> ← Back to
			Vehicles </a>
	</nav>

	<main class="main-content">
		<section class="login-card">

			<div class="icon" aria-hidden="true">🔐</div>

			<h1>
				Admin <span>Login</span>
			</h1>

			<p class="subtitle">Sign in to manage the MotoVerse vehicle
				collection.</p>

			<%
			if ("1".equals(request.getParameter("error"))) {
			%>
			<div class="error-message" role="alert">Invalid username or
				password. Please try again.</div>
			<%
			}
			%>

			<form action="<%=request.getContextPath()%>/adminLogin"
				method="post">

				<div class="form-group">
					<label for="username">Username</label> <input type="text"
						id="username" name="username" placeholder="Enter your username"
						autocomplete="username" required>
				</div>

				<div class="form-group">
					<label for="password">Password</label> <input type="password"
						id="password" name="password" placeholder="Enter your password"
						autocomplete="current-password" required>
				</div>

				<button type="submit" class="login-button">Sign In</button>

			</form>

			<a class="back-link" href="<%=request.getContextPath()%>/vehicles">
				Explore Vehicles </a>

		</section>
	</main>

	<footer class="footer"> © 2026 MotoVerse — Smart Vehicle
		Explorer </footer>

</body>
</html>
