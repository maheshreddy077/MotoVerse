
package com.motoverse.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.motoverse.model.User;
import com.motoverse.util.ConnectionFactory;

public class UserDao {

	public boolean registerUser(User user) {
		String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";

		try (Connection con = ConnectionFactory.getCon()) {
			if (con == null) {
				throw new RuntimeException("Database connection failed.");
			}

			try (PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, user.getName().trim());
				ps.setString(2, user.getEmail().trim().toLowerCase());
				ps.setString(3, user.getPassword());

				return ps.executeUpdate() > 0;
			}

		} catch (SQLException e) {
			if (e.getSQLState() != null && e.getSQLState().startsWith("23")) {
				return false;
			}

			throw new RuntimeException("Unable to register user.", e);
		}
	}

	public User getUserByEmail(String email) {
		String sql = "SELECT id, name, email, password FROM users WHERE email = ?";

		try (Connection con = ConnectionFactory.getCon()) {
			if (con == null) {
				throw new RuntimeException("Database connection failed.");
			}

			try (PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, email.trim().toLowerCase());

				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						return new User(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
								rs.getString("password"));
					}
				}
			}

		} catch (SQLException e) {
			throw new RuntimeException("Unable to retrieve user.", e);
		}

		return null;
	}
}
