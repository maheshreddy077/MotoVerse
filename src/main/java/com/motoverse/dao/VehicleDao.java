package com.motoverse.dao;

import java.util.List;
import com.motoverse.model.Vehicle;

public interface VehicleDao {

	boolean insertVehicle(Vehicle v);

	boolean updateVehicle(Vehicle v);

	void deleteVehicle(Integer id);

	Vehicle getVehicleById(Integer id);

	List<Vehicle> getAllVehicles();

	List<Vehicle> searchVehicles(String keyword, String type);

	List<Vehicle> searchVehicles(String keyword, String type, String fuelType, Double minPrice, Double maxPrice,
			String sortBy);
}