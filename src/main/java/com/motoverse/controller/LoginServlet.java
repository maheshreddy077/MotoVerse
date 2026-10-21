
package com.motoverse.controller;

import java.io.IOException;

import com.motoverse.dao.UserDao;
import com.motoverse.model.User;
import com.motoverse.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	private final UserDao userDao = new UserDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.getRequestDispatcher("/login.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String email = req.getParameter("email");
		String password = req.getParameter("password");

		if (email == null || email.trim().isEmpty() || password == null || password.isEmpty()) {

			req.setAttribute("errorMessage", "Enter your email and password.");
			req.getRequestDispatcher("/login.jsp").forward(req, resp);
			return;
		}

		try {
			User user = userDao.getUserByEmail(email.trim());

			if (user == null || !PasswordUtil.verifyPassword(password, user.getPassword())) {

				req.setAttribute("errorMessage", "Invalid email or password.");
				req.getRequestDispatcher("/login.jsp").forward(req, resp);
				return;
			}

			// Avoid carrying an existing admin or stale user session forward.
			HttpSession oldSession = req.getSession(false);
			if (oldSession != null) {
				oldSession.invalidate();
			}

			HttpSession session = req.getSession(true);
			session.setAttribute("userId", user.getId());
			session.setAttribute("userName", user.getName());

			resp.sendRedirect(req.getContextPath() + "/index.jsp");

		} catch (RuntimeException e) {
			getServletContext().log("User login failed.", e);
			req.setAttribute("errorMessage", "Login could not be completed. Please try again.");
			req.getRequestDispatcher("/login.jsp").forward(req, resp);
		}
	}
}
