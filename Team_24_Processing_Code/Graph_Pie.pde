import java.util.*;

class GraphPie extends Graph {
    GraphPie(int x, int y, int wide, int high) {
        super(x, y, wide, high);
    }

   void drawPieChart(ArrayList<PieDataPoint> values) {
    // Consolidate values to ensure no repeats
    ArrayList<PieDataPoint> consolidatedValues = consolidateValues(values);

    // Initialize variables for angles and legend
    float total = sumCounts(consolidatedValues);
    float startAngle = 0;

    // Loop through each data point to draw the pie chart slices and legend
    for (PieDataPoint data : consolidatedValues) {
        float angle = radians(map(data.COUNT_CANCELLED + data.COUNT_DIVERTED + data.COUNT_EXPECTED, 0, total, 0, 360)); // Calculate angle for this slice
        float endAngle = startAngle + angle; // Calculate end angle for this slice

        // Set color based on the type of data point
        color sliceColor = getColorForDataPoint(consolidatedValues.indexOf(data));
        fill(sliceColor);
        noStroke(); // Remove stroke to hide white lines

        // Draw slice of the pie chart
        arc(xpos, ypos, width, height, startAngle, endAngle);

        // Draw legend
        drawLegend(consolidatedValues.indexOf(data), sliceColor);

        // Update start angle for next slice
        startAngle += angle;
    }
}


    // Method to consolidate values to avoid repeats
    ArrayList<PieDataPoint> consolidateValues(ArrayList<PieDataPoint> values) {
        ArrayList<PieDataPoint> consolidatedValues = new ArrayList<>();
        HashMap<String, PieDataPoint> valueMap = new HashMap<>();

        // Consolidate values using a hashmap to track repeats
        for (PieDataPoint data : values) {
            String key = data.toString();
            if (valueMap.containsKey(key)) {
                PieDataPoint existingData = valueMap.get(key);
                existingData.COUNT_CANCELLED += data.COUNT_CANCELLED;
                existingData.COUNT_DIVERTED += data.COUNT_DIVERTED;
                existingData.COUNT_EXPECTED += data.COUNT_EXPECTED;
            } else {
                valueMap.put(key, data);
            }
        }

        // Convert hashmap back to arraylist
        consolidatedValues.addAll(valueMap.values());
        return consolidatedValues;
    }

    // Method to draw legend
    void drawLegend(int index, color sliceColor) {
        String legendLabel = " ";
        // Assign legend label based on index
        if (index == 0 ) {
            legendLabel = "Cancelled flights";
        } else if (index == 1 ) {
            legendLabel = "Diverted flights";
        } else if(index == 2) {
            legendLabel = "Expected flights";
        }

        // Draw legend
        fill(0);
        textSize(24);
        textAlign(LEFT, CENTER);
        fill(sliceColor);
        text(legendLabel, xpos - (width*0.75),  ypos + (height*0.4) + (index*30));
    }

    // Method to calculate the total count of all data points
    int sumCounts(ArrayList<PieDataPoint> values) {
        int sum = 0;
        for (PieDataPoint data : values) {
            sum += data.COUNT_CANCELLED + data.COUNT_DIVERTED + data.COUNT_EXPECTED;
        }
        return sum;
    }

    // Method to get color for a specific data point index
    color getColorForDataPoint(int index) {
        // Set colors based on the index (you can modify this according to your preference)
        if (index == 0) {
            return color(200, 0, 0); // Red for cancelled flights
        } else if (index == 1) {
            return color(0, 200, 0); // Green for diverted flights
        } else {
            return color(0, 0, 200); // Blue for expected flights
        }
    }
}
