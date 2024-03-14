java.sql.Connection conn;
java.sql.Statement stmt;
import java.util.ArrayList;

PFont font;

void setup() {
    size(750, 750);
    // Load the MySQL JDBC driver class
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        println("MySQL JDBC Driver loaded successfully");
    } catch (ClassNotFoundException e) {
        println("Error loading MySQL JDBC Driver: " + e.getMessage());
        return;
    }
    
    // Connect to the database
    String url = "jdbc:mysql://localhost:3306/programming_project";
    String user = "root";
    String password = "DKTX0rk7fg5+";
    
    try {
        conn = java.sql.DriverManager.getConnection(url, user, password);
        println("Connected to the database");
    } catch (java.sql.SQLException e) {
        println("SQLException: " + e.getMessage());
        println("SQLState: " + e.getSQLState());
        println("VendorError: " + e.getErrorCode());
    }
    
    font = loadFont("ArialMT-10.vlw");
    textFont(font);
}

boolean queryExecuted = false; // Flag to track if the query has been executed
int index = 0;
ArrayList<Datapoint> datapoints = new ArrayList<Datapoint>();

void draw() {
    background(0);
  
    // Check if the query has already been executed
    if (!queryExecuted) {
        // Example query to select all rows from a table
        String query = "SELECT * FROM flight_data";
        try {
            stmt = conn.createStatement();
            java.sql.ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                // Process results
                datapoints.add(new Datapoint(rs));
                
                /*String ORIGIN = rs.getString("ORIGIN");
                String ORIGIN_CITY_NAME = rs.getString("ORIGIN_CITY_NAME");
                String ORIGIN_STATE_ABR = rs.getString("ORIGIN_STATE_ABR");
                int ORIGIN_WAC = rs.getInt("ORIGIN_WAC");
                // Print or do something with the data
                println("ORIGIN: " + ORIGIN 
                + ", ORIGIN_CITY_NAME: " + ORIGIN_CITY_NAME
                + ", ORIGIN_STATE_ABR: " + ORIGIN_STATE_ABR
                + ", ORIGIN_WAC: " + ORIGIN_WAC);*/
                
                index++;
            }
            rs.close();
            stmt.close();
            
            queryExecuted = true; // Set the flag to true after executing the query
        } catch (java.sql.SQLException e) {
            println("SQLException: " + e.getMessage());
            println("SQLState: " + e.getSQLState());
            println("VendorError: " + e.getErrorCode());
        }
        for(int i = 0; i < index; i++)
        {
            println(datapoints.get(i).toString());
        }
    }
    for(int i = 0; i < index; i++)
    {
       text(datapoints.get(i).toString(), 20, 10 + 100*i);
    }
}

void stop() {
    try {
        if (conn != null)
            conn.close();
        println("Connection closed");
    } catch (java.sql.SQLException e) {
        println("SQLException: " + e.getMessage());
    }
    super.stop();
}
