
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

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("adminUsername") == null) {
			resp.sendRedirect(req.getContextPath() + "/adminLogin.jsp");
			return;
		}

		String sql = "SELECT COUNT(*) AS total, " + "SUM(CASE WHEN type = 'Bike' THEN 1 ELSE 0 END) AS bikes, "
				+ "SUM(CASE WHEN type = 'Car' THEN 1 ELSE 0 END) AS cars " + "FROM vehicles";

		try (Connection con = ConnectionFactory.getCon();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			if (rs.next()) {
				req.setAttribute("totalVehicles", rs.getInt("total"));
				req.setAttribute("totalBikes", rs.getInt("bikes"));
				req.setAttribute("totalCars", rs.getInt("cars"));
			}

			req.setAttribute("adminUsername", session.getAttribute("adminUsername"));

			req.getRequestDispatcher("/adminDashboard.jsp").forward(req, resp);

		} catch (Exception e) {
			throw new ServletException("Unable to load admin dashboard.", e);
		}
	}
}
