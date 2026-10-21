
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

@WebServlet("/addVehicle")
public class AddVehicleServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("adminUsername") == null) {
			resp.sendRedirect(req.getContextPath() + "/adminLogin.jsp");
			return;
		}

		String brand = trim(req.getParameter("brand"));
		String name = trim(req.getParameter("name"));
		String type = trim(req.getParameter("type"));
		String fuelType = trim(req.getParameter("fuelType"));
		String imageUrl = trim(req.getParameter("imageUrl"));

		// Validate required text fields and their lengths.
		if (brand.isEmpty() || name.isEmpty() || type.isEmpty() || fuelType.isEmpty()) {
			showError(req, resp, "Brand, name, type, and fuel type are required.");
			return;
		}

		if (brand.length() > 100 || name.length() > 150 || fuelType.length() > 50) {
			showError(req, resp, "One or more text fields exceed the allowed length.");
			return;
		}

		if (!type.equals("Bike") && !type.equals("Car")) {
			showError(req, resp, "Select a valid vehicle type.");
			return;
		}

		// Validate the optional image URL.
		if (!imageUrl.isEmpty() && !(imageUrl.startsWith("https://") || imageUrl.startsWith("http://"))) {
			showError(req, resp, "Image URL must start with http:// or https://.");
			return;
		}

		double price;
		double mileage;
		int engineCc;

		try {
			price = Double.parseDouble(req.getParameter("price"));
			mileage = Double.parseDouble(req.getParameter("mileage"));
			engineCc = Integer.parseInt(req.getParameter("engineCc"));
		} catch (NumberFormatException | NullPointerException e) {
			showError(req, resp, "Enter valid numeric values for price, mileage, and engine capacity.");
			return;
		}

		if (!Double.isFinite(price) || !Double.isFinite(mileage) || price <= 0 || mileage <= 0 || engineCc <= 0) {
			showError(req, resp, "Price, mileage, and engine capacity must be positive values.");
			return;
		}

		Vehicle v = new Vehicle();
		v.setBrand(brand);
		v.setName(name);
		v.setType(type);
		v.setFuelType(fuelType);
		v.setImageUrl(imageUrl);
		v.setPrice(price);
		v.setMileage(mileage);
		v.setEngineCc(engineCc);

		try {
			VehicleDao dao = new VehicleDaoImpl();

			if (dao.insertVehicle(v)) {
				session.setAttribute("vehicleMessage", "Vehicle added successfully.");
				session.setAttribute("vehicleMessageType", "success");
				resp.sendRedirect(req.getContextPath() + "/vehicles");
			} else {
				showError(req, resp, "Vehicle could not be added. Check the database connection and try again.");
			}
		} catch (RuntimeException e) {
			log("Error adding vehicle", e);
			showError(req, resp, "An unexpected error occurred while adding the vehicle.");
		}
	}

	private String trim(String value) {
		return value == null ? "" : value.trim();
	}

	private void showError(HttpServletRequest req, HttpServletResponse resp, String message)
			throws ServletException, IOException {
		req.setAttribute("formError", message);
		req.getRequestDispatcher("/addVehicle.jsp").forward(req, resp);
	}
}
