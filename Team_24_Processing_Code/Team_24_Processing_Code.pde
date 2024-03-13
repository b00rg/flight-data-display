java.sql.Connection conn;
java.sql.Statement stmt;
boolean queryExecuted = false;

void setup() {
  
    size(400, 400);
    
    // JBDC Driver
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        println("MySQL JDBC Driver loaded successfully");
    } 
    catch (ClassNotFoundException e) {
        println("Error loading MySQL JDBC Driver: " + e.getMessage());
        return;
    }
    
    // Connect to MySQL
    String url = "jdbc:mysql://localhost:3306/programming_project";
    String user = "root";
    String password = "password1234!"; //REPLACE
    
    try {
        conn = java.sql.DriverManager.getConnection(url, user, password);
        println("Connected to the database");
    } catch (java.sql.SQLException e) {
        println("SQLException: " + e.getMessage());
        println("SQLState: " + e.getSQLState());
        println("VendorError: " + e.getErrorCode());
    }
}

void draw() {
    if (!queryExecuted) {
        String query = "SELECT * FROM flight_data";
        try {
            stmt = conn.createStatement();
            java.sql.ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                String ORIGIN = rs.getString("ORIGIN");
                String ORIGIN_CITY_NAME = rs.getString("ORIGIN_CITY_NAME");
                String ORIGIN_STATE_ABR = rs.getString("ORIGIN_STATE_ABR");
                int ORIGIN_WAC = rs.getInt("ORIGIN_WAC");
                println("ORIGIN: " + ORIGIN 
                + ", ORIGIN_CITY_NAME: " + ORIGIN_CITY_NAME
                + ", ORIGIN_STATE_ABR: " + ORIGIN_STATE_ABR
                + ", ORIGIN_WAC: " + ORIGIN_WAC);
            }
            rs.close();
            stmt.close();
            
            queryExecuted = true; // Set the flag to true after executing the query
        } catch (java.sql.SQLException e) {
            println("SQLException: " + e.getMessage());
            println("SQLState: " + e.getSQLState());
            println("VendorError: " + e.getErrorCode());
        }
    }
}
