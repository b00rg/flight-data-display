public static class Queries_Initial extends Queries {
    Queries_Initial() {
      super();
    }

    public static void dropDatabase(String databaseName) {
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

    public static void use(String databaseName) {
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
    String[] parseCSVLine(String line) {
        // Split line by commas, taking into account quoted values
        String[] parts = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)");

        // Remove surrounding quotes from each part
        for (int i = 0; i < parts.length; i++) {
          parts[i] = parts[i].replaceAll("^\"|\"$", "");
        }

        return parts;
    }
    public static void insertInto(String table_name, String[] columns, String[] values) {
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
} 
