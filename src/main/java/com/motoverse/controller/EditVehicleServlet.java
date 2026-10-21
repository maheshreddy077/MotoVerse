
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
import jakarta.servlet.http.HttpSession;

@WebServlet("/editVehicle")
public class EditVehicleServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private boolean isAdminLoggedIn(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		return session != null && session.getAttribute("adminUsername") != null;
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		if (!isAdminLoggedIn(req)) {
			resp.sendRedirect(req.getContextPath() + "/adminLogin.jsp");
			return;
		}

		String idParam = req.getParameter("id");
		int id;

		try {
			id = Integer.parseInt(idParam);
			if (id <= 0) {
				throw new NumberFormatException();
			}
		} catch (NumberFormatException | NullPointerException e) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid vehicle ID.");
			return;
		}

		VehicleDao dao = new VehicleDaoImpl();
		Vehicle vehicle = dao.getVehicleById(id);

		if (vehicle == null) {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Vehicle not found.");
			return;
		}

		req.setAttribute("vehicle", vehicle);
		req.getRequestDispatcher("/editVehicle.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		if (!isAdminLoggedIn(req)) {
			resp.sendRedirect(req.getContextPath() + "/adminLogin.jsp");
			return;
		}

		String idText = trim(req.getParameter("id"));
		String brand = trim(req.getParameter("brand"));
		String name = trim(req.getParameter("name"));
		String type = trim(req.getParameter("type"));
		String fuelType = trim(req.getParameter("fuelType"));
		String imageUrl = trim(req.getParameter("imageUrl"));

		int id;
		double price;
		double mileage;
		int engineCc;

		try {
			id = Integer.parseInt(idText);
			price = Double.parseDouble(req.getParameter("price"));
			mileage = Double.parseDouble(req.getParameter("mileage"));
			engineCc = Integer.parseInt(req.getParameter("engineCc"));
		} catch (NumberFormatException | NullPointerException e) {
			showEditError(req, resp, "Enter valid numeric values.", idText);
			return;
		}

		if (id <= 0) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid vehicle ID.");
			return;
		}

		if (brand.isEmpty() || name.isEmpty() || type.isEmpty() || fuelType.isEmpty()) {
			showEditError(req, resp, "Brand, name, type, and fuel type are required.", idText);
			return;
		}

		if (brand.length() > 100 || name.length() > 150 || fuelType.length() > 50) {
			showEditError(req, resp, "One or more text fields exceed the allowed length.", idText);
			return;
		}

		if (!type.equals("Bike") && !type.equals("Car")) {
			showEditError(req, resp, "Select a valid vehicle type.", idText);
			return;
		}

		if (!imageUrl.isEmpty() && !(imageUrl.startsWith("https://") || imageUrl.startsWith("http://"))) {
			showEditError(req, resp, "Image URL must start with http:// or https://.", idText);
			return;
		}

		if (!Double.isFinite(price) || !Double.isFinite(mileage) || price <= 0 || mileage <= 0 || engineCc <= 0) {
			showEditError(req, resp, "Price, mileage, and engine capacity must be positive values.", idText);
			return;
		}

		Vehicle vehicle = new Vehicle();
		vehicle.setId(id);
		vehicle.setBrand(brand);
		vehicle.setName(name);
		vehicle.setType(type);
		vehicle.setFuelType(fuelType);
		vehicle.setImageUrl(imageUrl);
		vehicle.setPrice(price);
		vehicle.setMileage(mileage);
		vehicle.setEngineCc(engineCc);

		try {
			VehicleDao dao = new VehicleDaoImpl();

			if (dao.updateVehicle(vehicle)) {
				HttpSession session = req.getSession(false);
				session.setAttribute("vehicleMessage", "Vehicle updated successfully.");
				session.setAttribute("vehicleMessageType", "success");
				resp.sendRedirect(req.getContextPath() + "/vehicles");
			} else {
				showEditError(req, resp, "Vehicle could not be updated. Check the database and try again.", idText);
			}
		} catch (RuntimeException e) {
			log("Error updating vehicle", e);
			showEditError(req, resp, "An unexpected error occurred while updating the vehicle.", idText);
		}
	}

	private String trim(String value) {
		return value == null ? "" : value.trim();
	}

	private void showEditError(HttpServletRequest req, HttpServletResponse resp, String message, String idText)
			throws ServletException, IOException {

		req.setAttribute("formError", message);

		try {
			int id = Integer.parseInt(idText);
			if (id > 0) {
				VehicleDao dao = new VehicleDaoImpl();
				Vehicle vehicle = dao.getVehicleById(id);

				if (vehicle != null) {
					req.setAttribute("vehicle", vehicle);
				}
			}
		} catch (NumberFormatException ignored) {
			// The submitted ID is invalid; the JSP can show its existing not-found state.
		}

		req.getRequestDispatcher("/editVehicle.jsp").forward(req, resp);
	}
}
