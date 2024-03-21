class Graph_Pie extends Graph {
  Graph_Pie(){
    super();
  }
  void drawPieChart(ArrayList<PieDataPoint> values){
    String[] labels = {"Flights Cancelled", "Flights Diverted", "Flights As Expected"};
    int totalFlights = values.size();
    float startAngle = 0; 
    float labelX = 10;
    float labelY = 5;
    float colour = 0.0; 
    for (int i = 0; i < labels.length; i++) {
      float angle = radians(map(i, 0, labels.length, 0, 360)); ; // Calculate angle for this slice
      float endAngle = startAngle + angle;
      
      // Calculate slice color 
      // ugly colours
      //colorMode(HSB);
      //fill(map(i, 0, labels.length, 0, 255), 255, 255);
      // greyscale 
      fill(map(i, 0, totalFlights, colour, colour), colour, colour);
      colour += 255.0/totalFlights*2;
      
      // Draw slice
      arc(width/2, height/2, 300, 300, startAngle, endAngle);
      
      // Draw label
      labelY += 15;
      //textAlign(CENTER, CENTER);
      text(labels[i], labelX, labelY);
      
      startAngle += angle;
    }
  }
} 
