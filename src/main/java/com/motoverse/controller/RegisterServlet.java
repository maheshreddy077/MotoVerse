
package com.motoverse.controller;

import java.io.IOException;
import java.util.regex.Pattern;

import com.motoverse.dao.UserDao;
import com.motoverse.model.User;
import com.motoverse.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

	private final UserDao userDao = new UserDao();

	private static final Pattern EMAIL_PATTERN = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.getRequestDispatcher("/register.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("password");

		name = name == null ? "" : name.trim();
		email = email == null ? "" : email.trim().toLowerCase();

		if (name.isEmpty() || name.length() > 100 || email.isEmpty() || email.length() > 150
				|| !EMAIL_PATTERN.matcher(email).matches() || password == null || password.length() < 8
				|| password.length() > 128) {

			req.setAttribute("errorMessage", "Enter a valid name and email. Password must be 8–128 characters.");
			req.getRequestDispatcher("/register.jsp").forward(req, resp);
			return;
		}

		try {
			String hashedPassword = PasswordUtil.hashPassword(password);

			User user = new User(name, email, hashedPassword);
			boolean registered = userDao.registerUser(user);

			if (registered) {
				req.setAttribute("successMessage", "Registration successful. Please log in.");
				req.getRequestDispatcher("/login.jsp").forward(req, resp);
			} else {
				req.setAttribute("errorMessage", "That email is already registered.");
				req.getRequestDispatcher("/register.jsp").forward(req, resp);
			}

		} catch (RuntimeException e) {
			getServletContext().log("User registration failed.", e);
			req.setAttribute("errorMessage", "Registration could not be completed. Please try again.");
			req.getRequestDispatcher("/register.jsp").forward(req, resp);
		}
	}
}
