package com.motoverse.controller;

import java.io.IOException;

import com.motoverse.dao.VehicleDao;
import com.motoverse.dao.VehicleDaoImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/vehicles")
public class VehicleServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String keyword = request.getParameter("keyword");
		String type = request.getParameter("type");
		String fuelType = request.getParameter("fuelType");
		String minPriceText = request.getParameter("minPrice");
		String maxPriceText = request.getParameter("maxPrice");
		String sortBy = request.getParameter("sortBy");

		keyword = keyword == null ? "" : keyword.trim();
		type = type == null ? "" : type.trim();
		fuelType = fuelType == null ? "" : fuelType.trim();
		minPriceText = minPriceText == null ? "" : minPriceText.trim();
		maxPriceText = maxPriceText == null ? "" : maxPriceText.trim();
		sortBy = sortBy == null ? "name" : sortBy.trim();

		// Accept only supported vehicle types.
		if (!type.equalsIgnoreCase("Bike") && !type.equalsIgnoreCase("Car")) {
			type = "";
		} else {
			type = type.equalsIgnoreCase("Bike") ? "Bike" : "Car";
		}

		// Accept only supported fuel types.
		if (!fuelType.equalsIgnoreCase("Petrol") && !fuelType.equalsIgnoreCase("Diesel")
				&& !fuelType.equalsIgnoreCase("Electric") && !fuelType.equalsIgnoreCase("Hybrid")) {
			fuelType = "";
		}

		// Validate sorting option.
		if (!sortBy.equals("name") && !sortBy.equals("priceAsc") && !sortBy.equals("priceDesc")
				&& !sortBy.equals("mileageDesc")) {
			sortBy = "name";
		}

		Double minPrice = null;
		Double maxPrice = null;
		String searchError = null;

		try {
			if (!minPriceText.isEmpty()) {
				minPrice = Double.parseDouble(minPriceText);

				if (!Double.isFinite(minPrice) || minPrice < 0) {
					throw new NumberFormatException();
				}
			}

			if (!maxPriceText.isEmpty()) {
				maxPrice = Double.parseDouble(maxPriceText);

				if (!Double.isFinite(maxPrice) || maxPrice < 0) {
					throw new NumberFormatException();
				}
			}

			if (minPrice != null && maxPrice != null && minPrice > maxPrice) {
				searchError = "Minimum price cannot exceed maximum price.";

				minPrice = null;
				maxPrice = null;
				minPriceText = "";
				maxPriceText = "";
			}

		} catch (NumberFormatException e) {
			searchError = "Enter valid, non-negative minimum and maximum prices.";

			minPrice = null;
			maxPrice = null;
			minPriceText = "";
			maxPriceText = "";
		}

		VehicleDao dao = new VehicleDaoImpl();

		request.setAttribute("vehicles", dao.searchVehicles(keyword, type, fuelType, minPrice, maxPrice, sortBy));

		// Existing attributes used by vehicles.jsp.
		request.setAttribute("keyword", keyword);
		request.setAttribute("selectedType", type);

		// New filter attributes.
		request.setAttribute("selectedFuel", fuelType);
		request.setAttribute("minPrice", minPriceText);
		request.setAttribute("maxPrice", maxPriceText);
		request.setAttribute("selectedSort", sortBy);
		request.setAttribute("searchError", searchError);

		request.getRequestDispatcher("/vehicles.jsp").forward(request, response);
	}
}