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
    for(int i = 0; i < 18; i++)
    {
      if(statsShown[i])
      {
        switch(i)
        {
          case 0:
            result += ("FL_DATE: " + FL_DATE + ", ");
            break;
          case 1:
            result += ("MKT_CARRIER: " + MKT_CARRIER + ", ");
            break;
          case 2:
            result += ("MKT_CARRIER_FL_NUM: " + MKT_CARRIER_FL_NUM + ", ");
            break;
          case 3:
            result += ("ORIGIN: " + ORIGIN + ", ");
            break;
          case 4:
            result += ("ORIGIN_CITY_NAME: " + ORIGIN_CITY_NAME + ", ");
            break;
          case 5:
            result += ("ORIGIN_STATE_ABR: " + ORIGIN_STATE_ABR + ", ");
            break;
          case 6:
            result += ("ORIGIN_WAC: " + ORIGIN_WAC + ", ");
            break;
          case 7:
            result += ("DEST: " + DEST + ", ");
            break;
          case 8:
            result += ("DEST_CITY_NAME: " + DEST_CITY_NAME + ", ");
            break;
          case 9:
            result += ("DEST_STATE_ABR: " + DEST_STATE_ABR + ", ");
            break;
          case 10:
            result += ("DEST_WAC: " + DEST_WAC + ", ");
            break;
          case 11:
            result += ("CRS_DEP_TIME: " + CRS_DEP_TIME + ", ");
            break;
          case 12:
            result += ("DEP_TIME: " + DEP_TIME + ",");
            break;
          case 13:
            result += ("CRS_ARR_TIME: " + CRS_ARR_TIME + ", ");
            break;
          case 14:
            result += ("ARR_TIME: " + ARR_TIME + ", ");
            break;
          case 15:
            result += ("CANCELLED: " + CANCELLED + ", ");
            break;
          case 16:
            result += ("DIVERTED: " + DIVERTED + ", ");
            break;
          case 17:
            result += ("DISTANCE: " + DISTANCE + ", ");
            break;
          default:
            println("No data found at address i");
            break;
        }
      }
    }
    
    return result;
  }
}
