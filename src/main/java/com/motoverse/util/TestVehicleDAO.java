package com.motoverse.util;

import com.motoverse.dao.VehicleDao;
import com.motoverse.dao.VehicleDaoImpl;
import com.motoverse.model.Vehicle;

public class TestVehicleDAO {
	public static void main(String[] args) {

		VehicleDao dao = new VehicleDaoImpl();

		for (Vehicle v : dao.getAllVehicles()) {
			System.out.println(v.getId() + " | " + v.getBrand() + " | " + v.getName() + " | " + v.getPrice());
		}
	}
}