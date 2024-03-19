class rawDatapoint {
  
  String FL_DATE;
  String MKT_CARRIER;
  int MKT_CARRIER_FL_NUM;
  
  String ORIGIN;
  String ORIGIN_CITY_NAME;
  String ORIGIN_STATE_ABR;
  int ORIGIN_WAC;
  
  String DEST;
  String DEST_CITY_NAME;
  String DEST_STATE_ABR;
  int DEST_WAC;
  
  int CRS_DEP_TIME;
  int DEP_TIME;
  int CRS_ARR_TIME;
  int ARR_TIME;
  
  int CANCELLED;
  int DIVERTED;
  int DISTANCE;
  
  rawDatapoint (java.sql.ResultSet resultSet) {
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
      
    } catch (java.sql.SQLException e) {
            println("SQLException: " + e.getMessage());
        }
}
  
  public String toString()
  {
    String result = "";
    
    result += ("\nFL_DATE: " + FL_DATE + ", MKT_CARRIER: " + MKT_CARRIER + ", MKT_CARRIER_FL_NUM: " + MKT_CARRIER_FL_NUM);
    result += ("\nORIGIN: " + ORIGIN + ", ORIGIN_CITY_NAME: " + ORIGIN_CITY_NAME + ", ORIGIN_STATE_ABR: " + ORIGIN_STATE_ABR + ", ORIGIN_WAC: " + ORIGIN_WAC);
    result += ("\nDEST: " + DEST + ", DEST_CITY_NAME: " + DEST_CITY_NAME + ", DEST_STATE_ABR: " + DEST_STATE_ABR + ", DEST_WAC: " + DEST_WAC);
    result += ("\nCRS_DEP_TIME: " + CRS_DEP_TIME + ", DEP_TIME: " + DEP_TIME + ", CRS_ARR_TIME: " + CRS_ARR_TIME + ", ARR_TIME: " + ARR_TIME);
    result += ("\nCANCELLED: " + CANCELLED + ", DIVERTED: " + DIVERTED + ", DISTANCE: " + DISTANCE);
    
    return result;
  }
}
