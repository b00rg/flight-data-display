import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.DatabaseMetaData;
import java.util.Collections;
import java.io.FileReader;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;

class Queries {
  
  // MySQL database connection parameters
  String filename = sketchPath() + "/flights2k.csv";
  String url = "jdbc:mysql://localhost:3306/programming_project";
  
  // CHECK IF EMPTY
  String username = "";
  String password = "";
  
  Connection connection;
  
  String databaseName = "programming_project";
  String tableName = "flight_data";
  
  Queries(){
    try {
      
      // CHECK IF CSV
      BufferedReader credsFile = new BufferedReader(new FileReader(sketchPath() + "/creds.txt"));
      Scanner credsScanner = new Scanner(credsFile);
      credsScanner.useDelimiter(",");
      username = credsScanner.next();
      password = credsScanner.next();
      println("Using username " + username + " using password " + password);
      credsScanner.close();
      credsFile.close();
    }
    catch (Exception e) {
      println("Error cannot find file creds.csv");
      exit();
    }
    
    try {
      connection = DriverManager.getConnection(url, username, password);
      println("Connected!");
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
  
  void closeConnection() {
    try {
      if (connection != null) {
        connection.close();
        println("Connection closed");
      }
    } catch (SQLException e) {
      println("SQLException: " + e.getMessage());
    }
  }
  
}
