import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collections;
import java.io.FileReader;
import java.util.Arrays;

class QueriesInitial extends Queries {
  
  QueriesInitial() {
    super();
  }

    public void dropDatabase(String databaseName) {
        if (connection != null) {
            try (Statement statement = connection.createStatement()) {
                String sql = "DROP DATABASE " + databaseName;
                statement.executeUpdate(sql);
                System.out.println("Database '" + databaseName + "' dropped successfully!");
            } catch (SQLException e) {
                System.out.println("Error dropping database: " + e.getMessage());
            }
        } else {
            System.out.println("Connection to the database is not established.");
        }
    }

    public void use(String databaseName) {
        if (connection != null) {
            try (Statement statement = connection.createStatement()) {
                String sql = "USE " + databaseName;
                statement.executeUpdate(sql);
                System.out.println("Database '" + databaseName + "' used successfully!");
            } catch (SQLException e) {
                System.out.println("Error using database: " + e.getMessage());
            }
        } else {
            System.out.println("Connection to the database is not established.");
        }
    }

    public void insertInto(String table_name, String[] columns, String[] values) {
        if (connection != null) {
            if (columns.length != values.length) {
                System.out.println("Number of columns does not match the number of values.");
                return;
            }
            try (PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO " + table_name + " (" + String.join(",", columns) + ") VALUES (" + String.join(",", Collections.nCopies(values.length, "?")) + ")")) {
                for (int i = 0; i < values.length; i++) {
                    preparedStatement.setString(i + 1, values[i]);
                }
                preparedStatement.executeUpdate();
                System.out.println("Values inserted into table '" + table_name + "' successfully!");
            } catch (SQLException e) {
                System.out.println("Error inserting values: " + e.getMessage());
            }
        } else {
            System.out.println("Connection to the database is not established.");
        }
    }
  public void insertRows(){
    try {
      Statement statement = connection.createStatement();
      BufferedReader reader = new BufferedReader(new FileReader(filename));
      
      boolean skipHeader = true;
      while (reader.ready()) {
        String line = reader.readLine();
        if (skipHeader) {
          skipHeader = false;
          continue; // Skip the header row
        }

        String[] data = parseCSVLine(line);
        String query = "INSERT INTO flight_data (FL_DATE, MKT_CARRIER, MKT_CARRIER_FL_NUM, ORIGIN, ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, ORIGIN_WAC, DEST, DEST_CITY_NAME, DEST_STATE_ABR, DEST_WAC, CRS_DEP_TIME, DEP_TIME, CRS_ARR_TIME, ARR_TIME, CANCELLED, DIVERTED, DISTANCE) VALUES (";
        for (int i = 0; i < data.length; i++) {
          if (data[i].isEmpty()) {
            query += "NULL";
          } else {
            if (i == 2 || i == 6 || i == 11 || i == 12 || i == 13 || i == 14 || i == 15 || i == 16 || i == 17) { // Integer fields
              query += Integer.parseInt(data[i]);
            } else {
              query += "'" + data[i] + "'";
            }
          }
          if (i < data.length - 1) {
            query += ",";
          }
        }
        query += ")";

        statement.executeUpdate(query);
      }
      statement.close();
      reader.close();
      println("Data inserted successfully!");
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
  public String[] parseCSVLine(String line) {
     return line.split(",");
  }
}
