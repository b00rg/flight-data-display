class Heatmap extends Graph {
    ArrayList<RouteDataPoint> dataPoints;

    void drawHeatMap(ArrayList<RouteDataPoint> values) {
        int gridSize = 20; // Size of grid cells
        int maxCount = 0; // Maximum flight count

        // Find maximum flight count
        for (RouteDataPoint data : values) {
            maxCount = Math.max(maxCount, data.FLIGHT_COUNT);
        }

        // Draw grid and color each cell based on flight count
        for (RouteDataPoint dp : dataPoints) {
            // Calculate cell position based on origin and destination airports
            int i = hashAirport(dp.ORIGIN); // Assuming hashAirport() converts airport code to grid index
            int j = hashAirport(dp.DEST);

            // Calculate total flight count within current grid cell
            int totalFlightCount = dp.FLIGHT_COUNT;

            // Map flight count to color
            float hue = map(totalFlightCount, 0, maxCount, 0, 255);
            fill(hue, 255, 255); // Assuming fill method is available
            rect(i * gridSize, j * gridSize, gridSize, gridSize); // Assuming rect method is available
        }
    }

    // Method to hash airport code to grid index (for simplicity, you can modify this according to your needs)
    int hashAirport(String airportCode) {
        // Example hash function: just return the ASCII value of the first character
        return (int) airportCode.charAt(0);
    }
}
