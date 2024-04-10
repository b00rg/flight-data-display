class QueriesInitial extends Queries {
  
  QueriesInitial() {
    super();
  }
  
  
  // CREATE DATABASE IF NOT EXISTS programming_project;
  void createDatabase() {
    if (connection != null) {
      try{
        Statement statement = connection.createStatement();
        String sql = "CREATE DATABASE IF NOT EXISTS " + super.databaseName + ";";
        statement.executeUpdate(sql);
        System.out.println("Database " + super.databaseName + " created successfully!");
      } 
      catch (SQLException e) {
        System.out.println("Error creating database: " + e.getMessage());
      }
    } 
    else {
      System.out.println("Connection to the database is not established.");
    }
  }
  
  
  // USE programming_project;
  void useDatabase() {
    if (connection != null) {
      try{
        Statement statement = connection.createStatement();
        String sql = "USE " + super.databaseName + ";";
        statement.executeUpdate(sql);
        System.out.println("Database " + super.databaseName + " used successfully!");
      } 
      catch (SQLException e) {
        System.out.println("Error using database: " + e.getMessage());
      }
    } 
    else {
      System.out.println("Connection to the database is not established.");
    }
  }
  
  
  // DROP TABLE flight_data;
  // CREATE TABLE flight_data;
  void dropAndCreateTable() {
    try {
        Statement statement = connection.createStatement();

        // Check if table exists
        DatabaseMetaData metaData = connection.getMetaData();
        ResultSet tables = metaData.getTables(null, null,  super.tableName, null);

        if (tables.next()) {
            // Table exists, drop it
            String dropQuery = "DROP TABLE " + super.tableName;
            statement.executeUpdate(dropQuery);
            System.out.println("Table " +  super.tableName + " dropped successfully.");
        }

        // Create the table
        String createQuery = "CREATE TABLE " +  super.tableName + " ("
                + "FL_DATE DATE, "
                + "MKT_CARRIER VARCHAR(50), "
                + "MKT_CARRIER_FL_NUM DECIMAL, "
                + "ORIGIN VARCHAR(50), "
                + "ORIGIN_CITY_NAME VARCHAR(50), "
                + "ORIGIN_STATE_ABR VARCHAR(50), "
                + "ORIGIN_WAC DECIMAL, "
                + "DEST VARCHAR(50), "
                + "DEST_CITY_NAME VARCHAR(50), "
                + "DEST_STATE_ABR VARCHAR(50), "
                + "DEST_WAC DECIMAL, "
                + "CRS_DEP_TIME DECIMAL, "
                + "DEP_TIME DECIMAL, "
                + "CRS_ARR_TIME DECIMAL, "
                + "ARR_TIME DECIMAL, "
                + "CANCELLED DECIMAL, "
                + "DIVERTED DECIMAL, "
                + "DISTANCE DECIMAL)";
        statement.executeUpdate(createQuery);
        System.out.println("Table " +  super.tableName + " created successfully.");

        statement.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
  }

  
  // INSERT INTO flight_data VALUES (...);
void insertRows() {
    try {
        Statement statement = connection.createStatement();
        BufferedReader reader = new BufferedReader(new FileReader(filename));
        boolean skipHeader = true; // Flag to skip the first line (header)
        String queryPrefix = "INSERT INTO " + super.tableName + " VALUES ";
        List<String> queries = new ArrayList<>();
        int totalRecords = 0; // Variable to count total records read from the file

        // Read data from the file and construct insert queries
        while (reader.ready()) {
            String line = reader.readLine();
            if (skipHeader) {
                skipHeader = false;
                continue; // Skip the header row
            }

            String[] data = parseCSVLine(line);
            StringBuilder queryBuilder = new StringBuilder();
            queryBuilder.append("(");
            for (int i = 0; i < data.length; i++) {
                if (data[i].isEmpty()) {
                    queryBuilder.append("NULL");
                } else {
                    if (i == 0) {
                        // Handle date format conversion
                        // Assuming your date is in the first column
                        String originalString = data[i];
                        int indexOfSpace = originalString.indexOf(' ');
                        String modifiedString = indexOfSpace != -1 ? originalString.substring(0, indexOfSpace) : originalString;
                        String[] parts = modifiedString.split("/");
                        int j = parts.length - 1;
                        String rearrangedString = parts[j] + "-" + parts[j - 2] + "-" + parts[j - 1];
                        queryBuilder.append("'").append(rearrangedString).append("'");
                    } else if (i == 2 || i == 6 || i == 11 || i == 12 || i == 13 || i == 14 || i == 15 || i == 16 || i == 17) { // Integer fields
                        queryBuilder.append(Double.parseDouble(data[i]));
                    } else {
                        queryBuilder.append("'").append(data[i]).append("'");
                    }
                }

                if (i < data.length - 1) {
                    queryBuilder.append(",");
                }
            }
            queryBuilder.append(")");
            queries.add(queryBuilder.toString());

            totalRecords++; // Increment total records counter
        }

        // Calculate the number of times to run the insert query
        int iterations = totalRecords / 100000; // For records of size 100,000
        if (totalRecords % 100000 != 0) {
            iterations++; // If there are remaining records, add one more iteration
        }

        // Execute the insert query loop for the calculated number of iterations
        for (int i = 0; i < iterations; i++) {
            // Construct the batch insert query for this iteration
            StringBuilder batchQuery = new StringBuilder(queryPrefix);
            int startIdx = i * 100000;
            int endIdx = Math.min((i + 1) * 100000, queries.size());
            for (int j = startIdx; j < endIdx; j++) {
                batchQuery.append(queries.get(j));
                if (j < endIdx - 1) {
                    batchQuery.append(",");
                } else {
                    batchQuery.append(";");
                }
            }

            // Execute the batch insert query
            statement.executeUpdate(batchQuery.toString());
        }

        // Close resources
        reader.close();
        statement.close();
        connection.close();

        println("Data inserted successfully!");
    } catch (Exception e) {
        e.printStackTrace();
    }
}

  
  
  // Read CSV line into table
  String[] parseCSVLine(String line) {
    String[] parts = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)");
    for (int i = 0; i < parts.length; i++) {
      parts[i] = parts[i].replaceAll("^\"|\"$", "");
    }
    return parts;
  }
  
}
