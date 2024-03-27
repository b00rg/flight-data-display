import java.util.ArrayList;

class SimpleGraph extends Graph {

    void draw(ArrayList<RouteDataPoint> values) {
        // Set up variables for drawing
        float topMargin = 50;
        float leftMargin = 50;
        float pointSpacing = (width - leftMargin) / values.size();
        
        // Find the maximum flight count to scale the graph
        int maxFlightCount = 0;
        for (RouteDataPoint data : values) {
            maxFlightCount = Math.max(maxFlightCount, data.FLIGHT_COUNT);
        }
        
        // Draw the density graph
        beginShape();
        noFill();
        stroke(50, 100, 200); // Example color, change as needed
        strokeWeight(2);
        for (int i = 0; i < values.size(); i++) {
            RouteDataPoint data = values.get(i);
            
            // Calculate the height of each point relative to the canvas height
            float pointHeight = map(data.FLIGHT_COUNT, 0, maxFlightCount, height - topMargin, topMargin);
            
            // Calculate the x-coordinate of each point
            float x = leftMargin + i * pointSpacing;
            
            // Draw the point
            vertex(x, pointHeight);
            
            // Draw the label at the bottom
            textAlign(CENTER, TOP);
            text(data.ORIGIN + " to " + data.DEST, x, height - 10);
        }
        endShape();
        
        // Draw the scale
        drawScale(maxFlightCount, topMargin);
    }

    void drawScale(int maxValue, float topMargin) {
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
