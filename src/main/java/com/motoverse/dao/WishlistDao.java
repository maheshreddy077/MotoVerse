
package com.motoverse.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.motoverse.model.Vehicle;
import com.motoverse.util.ConnectionFactory;

public class WishlistDao {

	public boolean addToWishlist(int userId, int vehicleId) {
		String sql = "INSERT INTO wishlist (user_id, vehicle_id) VALUES (?, ?)";

		try (Connection con = ConnectionFactory.getCon()) {
			if (con == null) {
				throw new RuntimeException("Database connection failed.");
			}

			try (PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setInt(1, userId);
				ps.setInt(2, vehicleId);

				return ps.executeUpdate() > 0;
			}

		} catch (SQLException e) {
			if (e.getSQLState() != null && e.getSQLState().startsWith("23")) {
				return false;
			}

			throw new RuntimeException("Unable to add wishlist item.", e);
		}
	}

	public List<Vehicle> getWishlist(int userId) {
		List<Vehicle> vehicles = new ArrayList<>();

		String sql = "SELECT v.id, v.brand, v.name, v.type, v.price, "
				+ "v.mileage, v.engine_cc, v.fuel_type, v.image_url " + "FROM wishlist w "
				+ "JOIN vehicles v ON v.id = w.vehicle_id " + "WHERE w.user_id = ? ORDER BY w.created_at DESC";

		try (Connection con = ConnectionFactory.getCon()) {
			if (con == null) {
				throw new RuntimeException("Database connection failed.");
			}

			try (PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setInt(1, userId);

				try (ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						Vehicle v = new Vehicle();

						v.setId(rs.getInt("id"));
						v.setBrand(rs.getString("brand"));
						v.setName(rs.getString("name"));
						v.setType(rs.getString("type"));
						v.setPrice(rs.getDouble("price"));
						v.setMileage(rs.getDouble("mileage"));
						v.setEngineCc(rs.getInt("engine_cc"));
						v.setFuelType(rs.getString("fuel_type"));
						v.setImageUrl(rs.getString("image_url"));

						vehicles.add(v);
					}
				}
			}

		} catch (SQLException e) {
			throw new RuntimeException("Unable to retrieve wishlist.", e);
		}

		return vehicles;
	}

	public boolean removeFromWishlist(int userId, int vehicleId) {
		String sql = "DELETE FROM wishlist WHERE user_id = ? AND vehicle_id = ?";

		try (Connection con = ConnectionFactory.getCon()) {
			if (con == null) {
				throw new RuntimeException("Database connection failed.");
			}

			try (PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setInt(1, userId);
				ps.setInt(2, vehicleId);

				return ps.executeUpdate() > 0;
			}

		} catch (SQLException e) {
			throw new RuntimeException("Unable to remove wishlist item.", e);
		}
	}
}
	