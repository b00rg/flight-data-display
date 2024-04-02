// Define a class GraphPie which extends the Graph class
// Constructor for the GraphPie class
class GraphPie extends Graph {
  GraphPie(){
     super(); // Call the constructor of the superclass
  }
  // Method to draw a pie chart based on provided PieDataPoint values
  void drawPieChart(ArrayList<PieDataPoint> values){
// Define labels for the slices of the pie chart
    String[] labels = {"Flights Cancelled", "Flights Diverted", "Flights As Expected"};
    // Initialize variables for angles, label positions, and color
    int totalFlights = values.size();
    float startAngle = 0; 
    float labelX = 10;
    float labelY = 5;
    float colour = 0.0; 
    // Loop through each label to draw the pie chart slices
    for (int i = 0; i < labels.length; i++) {
      float angle = radians(map(i, 0, labels.length, 0, 360)); ; // Calculate angle for this slice
      // Calculate angle for this slice based on its position in the labels array
      float endAngle = startAngle + angle;       // Calculate end angle for this slice

      // Calculate slice color based on its position in the labels array
      // Calculate slice color 
      // ugly colours
      //colorMode(HSB);
      //fill(map(i, 0, labels.length, 0, 255), 255, 255);
      // greyscale 
      fill(map(i, 0, totalFlights, colour, colour), colour, colour);
      colour += 255.0/totalFlights*2; // Increment color for next slice
      
       // Draw slice of the pie chart
      arc(width/2, height/2, 300, 300, startAngle, endAngle);
      
      // Draw label for this slice
      labelY += 15;
      //textAlign(CENTER, CENTER);
      text(labels[i], labelX, labelY);

      // Update start angle for next slice
      startAngle += angle;
    }
  }
} 
