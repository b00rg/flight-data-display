class QueriesInitial extends Queries {
  
  QueriesInitial() {
    super();
  }
  
  void insertRows(){
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

}
