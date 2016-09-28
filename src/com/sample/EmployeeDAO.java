package com.sample;
 
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
 
public class EmployeeDAO {
Connection connection;
    Statement stmt;
    private int noOfRecords;

    public EmployeeDAO() { }
 
    private static Connection getConnection() throws SQLException,ClassNotFoundException{
        Connection con = ConnectionFactory.
                getInstance().getConnection();
        return con;
    }
 
    public List<MyData> viewAllEmployees(int offset,int noOfRecords)
    {
        String query = "select SQL_CALC_FOUND_ROWS * from actor_info ORDER BY id DESC limit "
                 + offset + ", " + noOfRecords;
        List<MyData> list = new ArrayList<MyData>();
        MyData employee = null;
        try {
            connection = getConnection();
            stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                employee = new MyData();
                employee.setId(rs.getInt("id"));
                employee.setName(rs.getString("first_name"));
                employee.setLastname(rs.getString("last_name"));
                employee.setInfo(rs.getString("film_info"));
                list.add(employee);
            }
            rs.close();
 
            rs = stmt.executeQuery("SELECT FOUND_ROWS()");
            if(rs.next())
                this.noOfRecords = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }finally
        {
            try {
                if(stmt != null)
                    stmt.close();
                if(connection != null)
                    connection.close();
                } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }
 
    public int getNoOfRecords() {
        return noOfRecords;
    }
}