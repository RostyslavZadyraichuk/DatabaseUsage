package com.zadyraichuk.jdbc;

import lombok.Getter;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.SQLTimeoutException;

public class JdbcConfig {

    @Getter
    private static final JdbcConfig instance = new JdbcConfig();

    private static final String JDBC_URL = "jdbc:mysql://127.0.0.1:3306/java_database_usage?serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "admin";

    @Getter
    private final Connection connection;

    private JdbcConfig() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("Error: unable to load driver class");
            e.printStackTrace();
        } catch (SQLTimeoutException e) {
            System.out.println("Error: Connection is not stable; Timeout error");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Error: unable to connect to database");
            e.printStackTrace();
        }

        this.connection = connection;
    }
}
