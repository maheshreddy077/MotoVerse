
package com.motoverse.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.motoverse.model.Vehicle;
import com.motoverse.util.ConnectionFactory;

public class VehicleDaoImpl implements VehicleDao {

	private Connection con;

	public VehicleDaoImpl() {
		this.con = ConnectionFactory.getCon();
	}

	@Override
	public boolean insertVehicle(Vehicle v) {
		String sql = "INSERT INTO vehicles " + "(brand, name, type, price, mileage, engine_cc, fuel_type, image_url) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, v.getBrand());
			ps.setString(2, v.getName());
			ps.setString(3, v.getType());
			ps.setDouble(4, v.getPrice());
			ps.setDouble(5, v.getMileage());
			ps.setInt(6, v.getEngineCc());
			ps.setString(7, v.getFuelType());
			ps.setString(8, v.getImageUrl());

			return ps.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean updateVehicle(Vehicle v) {
		String sql = "UPDATE vehicles SET brand=?, name=?, type=?, "
				+ "price=?, mileage=?, engine_cc=?, fuel_type=?, image_url=? " + "WHERE id=?";

		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, v.getBrand());
			ps.setString(2, v.getName());
			ps.setString(3, v.getType());
			ps.setDouble(4, v.getPrice());
			ps.setDouble(5, v.getMileage());
			ps.setInt(6, v.getEngineCc());
			ps.setString(7, v.getFuelType());
			ps.setString(8, v.getImageUrl());
			ps.setInt(9, v.getId());

			return ps.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public void deleteVehicle(Integer id) {
		String sql = "DELETE FROM vehicles WHERE id=?";

		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, id);

			int rowsAffected = ps.executeUpdate();

			if (rowsAffected == 0) {
				throw new RuntimeException("Vehicle not found or already deleted.");
			}

		} catch (SQLException e) {
			throw new RuntimeException("Failed to delete vehicle.", e);
		}
	}

	@Override
	public Vehicle getVehicleById(Integer id) {
		String sql = "SELECT * FROM vehicles WHERE id=?";

		try (PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, id);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapVehicle(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	@Override
	public List<Vehicle> getAllVehicles() {
		List<Vehicle> vehicles = new ArrayList<>();
		String sql = "SELECT * FROM vehicles";

		try (PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				vehicles.add(mapVehicle(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return vehicles;
	}

	private Vehicle mapVehicle(ResultSet rs) throws SQLException {
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
		return v;
	}

	@Override
	public List<Vehicle> searchVehicles(String keyword, String type) {
		return searchVehicles(keyword, type, "", null, null, "name");
	}

	@Override
	public List<Vehicle> searchVehicles(String keyword, String type, String fuelType, Double minPrice, Double maxPrice,
			String sortBy) {

		List<Vehicle> list = new ArrayList<>();

		keyword = keyword == null ? "" : keyword.trim().toLowerCase();
		type = type == null ? "" : type.trim();
		fuelType = fuelType == null ? "" : fuelType.trim();

		String orderBy;

		switch (sortBy == null ? "" : sortBy) {
		case "priceAsc":
			orderBy = "price ASC";
			break;
		case "priceDesc":
			orderBy = "price DESC";
			break;
		case "mileageDesc":
			orderBy = "mileage DESC";
			break;
		case "name":
		default:
			orderBy = "name ASC";
			break;
		}

		String sql = "SELECT * FROM vehicles " + "WHERE (? = '' OR LOWER(brand) LIKE ? OR LOWER(name) LIKE ?) "
				+ "AND (? = '' OR LOWER(type) = LOWER(?)) " + "AND (? = '' OR LOWER(fuel_type) = LOWER(?)) "
				+ "AND (? IS NULL OR price >= ?) " + "AND (? IS NULL OR price <= ?) " + "ORDER BY " + orderBy;

		try (PreparedStatement ps = con.prepareStatement(sql)) {

			int i = 1;

			ps.setString(i++, keyword);
			ps.setString(i++, "%" + keyword + "%");
			ps.setString(i++, "%" + keyword + "%");

			ps.setString(i++, type);
			ps.setString(i++, type);

			ps.setString(i++, fuelType);
			ps.setString(i++, fuelType);

			if (minPrice == null) {
				ps.setNull(i++, java.sql.Types.DOUBLE);
				ps.setNull(i++, java.sql.Types.DOUBLE);
			} else {
				ps.setDouble(i++, minPrice);
				ps.setDouble(i++, minPrice);
			}

			if (maxPrice == null) {
				ps.setNull(i++, java.sql.Types.DOUBLE);
				ps.setNull(i++, java.sql.Types.DOUBLE);
			} else {
				ps.setDouble(i++, maxPrice);
				ps.setDouble(i++, maxPrice);
			}

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(mapVehicle(rs));
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
}
