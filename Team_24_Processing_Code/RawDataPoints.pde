class RawDatapoint {
  
  String FL_DATE = null;
  String MKT_CARRIER = null;
  int MKT_CARRIER_FL_NUM = 0;
  
  String ORIGIN = null;
  String ORIGIN_CITY_NAME = null;
  String ORIGIN_STATE_ABR = null;
  int ORIGIN_WAC = 0;
  
  String DEST = null;
  String DEST_CITY_NAME = null;
  String DEST_STATE_ABR = null;
  int DEST_WAC = 0;
  
  int CRS_DEP_TIME = 0;
  int DEP_TIME = 0;
  int CRS_ARR_TIME = 0;
  int ARR_TIME = 0;
  
  int CANCELLED = 0;
  int DIVERTED = 0;
  int DISTANCE = 0;
  
  RawDatapoint (java.sql.ResultSet resultSet) {
    try {
      
      FL_DATE = resultSet.getString("FL_DATE");
      MKT_CARRIER = resultSet.getString("MKT_CARRIER");
      MKT_CARRIER_FL_NUM = resultSet.getInt("MKT_CARRIER_FL_NUM");
      
      ORIGIN = resultSet.getString("ORIGIN");
      ORIGIN_CITY_NAME = resultSet.getString("ORIGIN_CITY_NAME");
      ORIGIN_STATE_ABR = resultSet.getString("ORIGIN_STATE_ABR");
      ORIGIN_WAC = resultSet.getInt("ORIGIN_WAC");
      
      DEST = resultSet.getString("DEST");
      DEST_CITY_NAME = resultSet.getString("DEST_CITY_NAME");
      DEST_STATE_ABR = resultSet.getString("DEST_STATE_ABR");
      DEST_WAC = resultSet.getInt("DEST_WAC");
      
      CRS_DEP_TIME = resultSet.getInt("CRS_DEP_TIME");      
      DEP_TIME = resultSet.getInt("DEP_TIME");
      CRS_ARR_TIME = resultSet.getInt("CRS_ARR_TIME");
      ARR_TIME = resultSet.getInt("ARR_TIME");
      
      CANCELLED = resultSet.getInt("CANCELLED");
      DIVERTED = resultSet.getInt("DIVERTED");
      DISTANCE = resultSet.getInt("DISTANCE");
      
    } 
    catch (java.sql.SQLException e) {
      println("SQLException: " + e.getMessage());
    }
  }

}
