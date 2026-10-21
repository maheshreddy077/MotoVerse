
package com.motoverse.controller;

import java.io.IOException;
import java.util.List;

import com.motoverse.dao.WishlistDao;
import com.motoverse.model.Vehicle;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

	private final WishlistDao wishlistDao = new WishlistDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("userId") == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		int userId = (Integer) session.getAttribute("userId");

		try {
			List<Vehicle> wishlist = wishlistDao.getWishlist(userId);
			req.setAttribute("wishlist", wishlist);
			req.getRequestDispatcher("/wishlist.jsp").forward(req, resp);

		} catch (RuntimeException e) {
			getServletContext().log("Unable to load wishlist.", e);
			resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load your wishlist.");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("userId") == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		int userId = (Integer) session.getAttribute("userId");
		String action = req.getParameter("action");
		String vehicleIdValue = req.getParameter("vehicleId");

		try {
			int vehicleId = Integer.parseInt(vehicleIdValue);

			if (vehicleId <= 0) {
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid vehicle ID.");
				return;
			}

			if ("add".equals(action)) {
				wishlistDao.addToWishlist(userId, vehicleId);
			} else if ("remove".equals(action)) {
				wishlistDao.removeFromWishlist(userId, vehicleId);
			} else {
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid wishlist action.");
				return;
			}

			resp.sendRedirect(req.getContextPath() + "/wishlist");

		} catch (NumberFormatException e) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid vehicle ID.");
		} catch (RuntimeException e) {
			getServletContext().log("Unable to update wishlist.", e);
			resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to update your wishlist.");
		}
	}
}
