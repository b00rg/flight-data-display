class Graph_Bar extends Graph {
    Graph_Bar(){
        super();
    }
  
    void drawBarChart(ArrayList<BarDataPoint> values){
        // Set up variables for bar width and spacing
        float barSpacing = 20;
        float topMargin = 50;
        float leftMargin = 50;
        int barColour = 50;
        float barWidth = (width - leftMargin) / values.size() - barSpacing;
        
        float maxVal = 0;
        // Find the maximum value in the dataset
        for (BarDataPoint data : values) {
            maxVal = max(maxVal, data.getTOTAL_DIST());
        }
        
        for (int i = 0; i < values.size(); i++){
            BarDataPoint data = values.get(i);
            // Calculate the height of each bar relative to the canvas height
            float barHeight = map(data.getTOTAL_DIST(), 0, maxVal, 0, height - topMargin);
          
            // Calculate the position of each bar
            float x = leftMargin + i * (barWidth + barSpacing);
            float y = height - barHeight;
          
            // Draw the bar
            fill(barColour);
            rect(x, y, barWidth, barHeight);
          
            // Draw the label
            textAlign(CENTER, CENTER);
            text(data.getMKT_CARRIER(), x + barWidth/2, y - 10);
        }
        drawScale(maxVal, topMargin);
    }
  
    void drawScale(float maxValue, float topMargin){
        float step = maxValue / 5; // Determine the step size for the scale
    
        // Draw tick marks and labels
        for (int i = 0; i <= 5; i++) {
            float yPos = map(i * step, 0, maxValue, height - topMargin, 0);
        
            // Draw tick mark
            line(10, yPos, 0, yPos);
        
            // Draw label
            textAlign(LEFT, CENTER);
            text(nf(i * step, 0, 1), 10, yPos);
        }
    }
}
