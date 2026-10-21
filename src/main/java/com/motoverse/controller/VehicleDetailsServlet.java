
package com.motoverse.controller;

import java.io.IOException;

import com.motoverse.dao.VehicleDao;
import com.motoverse.dao.VehicleDaoImpl;
import com.motoverse.model.Vehicle;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/vehicleDetails")
public class VehicleDetailsServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String idText = request.getParameter("id");

		if (idText == null || !idText.matches("\\d+")) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid vehicle ID.");
			return;
		}

		try {
			int id = Integer.parseInt(idText);

			VehicleDao dao = new VehicleDaoImpl();
			Vehicle vehicle = dao.getVehicleById(id);

			if (vehicle == null) {
				response.sendError(HttpServletResponse.SC_NOT_FOUND, "Vehicle not found.");
				return;
			}

			request.setAttribute("vehicle", vehicle);

			request.getRequestDispatcher("/vehicleDetails.jsp").forward(request, response);

		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid vehicle ID.");
		}
	}
}
