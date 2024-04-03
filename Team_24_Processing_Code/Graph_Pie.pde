class GraphPie extends Graph 
{
  GraphPie(int x, int y, int wide, int high)
  {
     super(x, y, wide, high);
  }
  void drawPieChart(ArrayList<PieDataPoint> values){
    String[] labels = {"Flights Cancelled", "Flights Diverted", "Flights As Expected"};
    int totalFlights = values.size();
    float startAngle = 0; 
    float labelX = xpos - width * 0.7;
    float labelY = ypos + width * 0.2;
    float colour = 0.0, colourB = 150.0; 
    for (int i = 0; i < labels.length; i++) 
    {
      float angle = radians(map(i, 0, labels.length, 0, 360)); // Calculate angle for this slice
      float endAngle = startAngle + angle;
      
      // Calculate slice color 
      // ugly colours
      //colorMode(HSB);
      //fill(map(i, 0, labels.length, 0, 255), 255, 255);
      // greyscale 
      fill(map(i, 0, totalFlights, colourB, colourB), colour, colour);
      colour += 255.0/totalFlights*2;
      
      // Draw slice
      arc(xpos, ypos, width, width, startAngle, endAngle);
      
      // Draw label
      labelY += 40;
      //textAlign(CENTER, CENTER);
      text(labels[i], labelX, labelY);
      
      startAngle += angle;
    }
  }
} 
