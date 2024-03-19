class QueriesSelect extends Queries {
  
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
  
  QueriesSelect() {
    super();
  }
  
  ArrayList<RawDatapoint> getRowsBarGraph(String filterDate, ) {
    
    ArrayList<RawDatapoint> dataList = new ArrayList<RawDatapoint>();
    
    try {
      Statement stmt = connection.createStatement();
      String query = "SELECT * FROM " + super.tableName;
      ResultSet resultSet = stmt.executeQuery(query);
      
      while (resultSet.next()) {
        RawDatapoint dataPoint = new RawDatapoint(resultSet);
        dataList.add(dataPoint);
      }
      
      resultSet.close();
      stmt.close();
    } catch (SQLException e) {
      println("SQLException: " + e.getMessage());
    }
    
    return dataList;
  }
  
  
  
}
