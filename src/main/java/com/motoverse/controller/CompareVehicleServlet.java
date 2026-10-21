
package com.motoverse.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.motoverse.dao.VehicleDao;
import com.motoverse.dao.VehicleDaoImpl;
import com.motoverse.model.Vehicle;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/compareVehicles")
public class CompareVehicleServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String[] ids = req.getParameterValues("compareId");

		if (ids == null || ids.length != 2 || ids[0].equals(ids[1])) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Please select exactly two different vehicles.");
			return;
		}

		VehicleDao dao = new VehicleDaoImpl();
		List<Vehicle> selectedVehicles = new ArrayList<>();

		try {
			for (String id : ids) {
				int vehicleId = Integer.parseInt(id);
				Vehicle vehicle = dao.getVehicleById(vehicleId);

				if (vehicle == null) {
					resp.sendError(HttpServletResponse.SC_NOT_FOUND, "A selected vehicle could not be found.");
					return;
				}

				selectedVehicles.add(vehicle);
			}
		} catch (NumberFormatException e) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid vehicle ID.");
			return;
		}

		String type1 = selectedVehicles.get(0).getType();
		String type2 = selectedVehicles.get(1).getType();

		if (type1 == null || type2 == null || !type1.equalsIgnoreCase(type2)) {
			resp.setContentType("text/html;charset=UTF-8");
			resp.getWriter().println("<h2>Cannot compare different vehicle types.</h2>");
			resp.getWriter().println("<p>Please select two bikes or two cars.</p>");
			resp.getWriter().println("<a href='" + req.getContextPath() + "/vehicles'>Back to Vehicles</a>");
			return;
		}

		req.setAttribute("vehiclesToCompare", selectedVehicles);

		req.getRequestDispatcher("/compareVehicles.jsp").forward(req, resp);
	}
}
