
package com.motoverse.controller;

import java.io.IOException;

import com.motoverse.dao.VehicleDao;
import com.motoverse.dao.VehicleDaoImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/deleteVehicle")
public class DeleteVehicleServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("adminUsername") == null) {
			resp.sendRedirect(req.getContextPath() + "/adminLogin.jsp");
			return;
		}

		String idParam = req.getParameter("id");

		if (idParam == null || !idParam.matches("\\d+")) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid vehicle ID");
			return;
		}

		int id;

		try {
			id = Integer.parseInt(idParam);

			if (id <= 0) {
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid vehicle ID");
				return;
			}
		} catch (NumberFormatException e) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid vehicle ID");
			return;
		}

		VehicleDao dao = new VehicleDaoImpl();

		try {
			dao.deleteVehicle(id);

			session.setAttribute("vehicleMessage", "Vehicle deleted successfully.");
			session.setAttribute("vehicleMessageType", "success");

			resp.sendRedirect(req.getContextPath() + "/vehicles");

		} catch (RuntimeException e) {
			resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to delete vehicle. Please try again.");
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Use POST to delete a vehicle.");
	}
}
