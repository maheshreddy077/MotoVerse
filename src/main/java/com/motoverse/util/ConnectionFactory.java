
package com.motoverse.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {

    public static Connection getCon() {
        String url = System.getenv("MOTOVERSE_DB_URL");
        String username = System.getenv("MOTOVERSE_DB_USER");
        String password = System.getenv("MOTOVERSE_DB_PASSWORD");

        if (url == null || username == null || password == null) {
            throw new IllegalStateException(
                "Database environment variables are not configured."
            );
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException e) {
            throw new IllegalStateException(
                "Unable to connect to the MotoVerse database.", e
            );
        }
    }
}
