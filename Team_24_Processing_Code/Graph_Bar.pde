/*class GraphBar extends Graph {

  GraphBar(int x, int y, int wide, int high) {
    super(x, y, wide, high);
  }


  void drawBarChart(ArrayList<BarDataPoint1> values) {
    // Set up variables for bar width, spacing, margins, and color
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

    // Loop through the ArrayList of BarDataPoint objects to draw each bar
    for (int i = 0; i < values.size(); i++) {
      BarDataPoint data = values.get(i);
      // Calculate the height of each bar relative to the canvas height
      float barHeight = map(data.getTOTAL_DIST(), 0, maxVal, 0, height - topMargin);

      // Calculate the position of each bar
      float x = xpos + leftMargin + i * (barWidth + barSpacing);
      float y = ypos + height - barHeight;

      // Draw the bar
      fill(barColour);
      rect(x, y, barWidth, barHeight);

      // Draw the label
      textAlign(CENTER, CENTER - 20);
      text(data.getMKT_CARRIER(), x + barWidth/2, y - 10);

    }
    // Draw the scale based on the maximum value and top margin
    drawScale(maxVal, topMargin);
  }

  // Method to draw the scale for the bar chart

  void drawScale(float maxValue, float topMargin) {
    float step = maxValue / 5; // Determine the step size for the scale

    // Draw tick marks and labels
    for (int i = 0; i <= 5; i++) {
      float yPos = map(ypos + (i * step), 0, maxValue, height, 0);

      // Draw tick mark
      line(xpos + 10, yPos, xpos, yPos);

      // Draw label
      textAlign(LEFT, CENTER);
      text(nf(i * (step / 1000), 0, 1) + "k", xpos - 20, yPos + ypos);
    }
  }
}
