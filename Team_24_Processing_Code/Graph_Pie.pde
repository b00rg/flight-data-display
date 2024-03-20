class Graph_Pie extends Graph {
  Graph_Pie(){
    super();
  }
  void drawPieChart(float[] values, String[] labels){
    float total = 0;
    for (int i = 0; i<values.length; i++){
      total += values[i];
    }
    float startAngle = 0; 
    float labelX = 10;
    float labelY = 5;
    for (int i = 0; i < values.length; i++) {
      float angle = radians(map(values[i], 0, total, 0, 360)); // Calculate angle for this slice
      float endAngle = startAngle + angle;
      
      // Calculate slice color (you can define your own color scheme)
      colorMode(HSB); 
      fill(map(i, 0, values.length, 0, 255), 255, 255);
      
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
