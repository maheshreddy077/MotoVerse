
package com.motoverse.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.motoverse.util.ConnectionFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String username = req.getParameter("username");
		String password = req.getParameter("password");

		String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";

		try (Connection con = ConnectionFactory.getCon();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, username);
			ps.setString(2, password);

			try (ResultSet rs = ps.executeQuery()) {

				if (rs.next()) {
					HttpSession session = req.getSession();
					session.setAttribute("adminUsername", username);
					resp.sendRedirect(req.getContextPath() + "/adminDashboard");
				} else {
					resp.sendRedirect(req.getContextPath() + "/adminLogin.jsp?error=1");
				}
			}

		} catch (Exception e) {
			throw new ServletException("Admin login failed.", e);
		}
	}
}
