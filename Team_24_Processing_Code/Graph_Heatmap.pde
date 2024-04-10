class DensityGraph extends Graph {
    DensityGraph(int x, int y, int wide, int high) {
        super(x, y, wide, high);
    }

    void draw(ArrayList<RouteDataPoint> busyRoutes, ArrayList<RouteDataPoint> allRoutes) {
        // Find the unique origin and destination airports from all routes
        ArrayList<String> airports = new ArrayList<>();
        for (RouteDataPoint data : allRoutes) {
            if (!airports.contains(data.ORIGIN)) {
                airports.add(data.ORIGIN);
            }
            if (!airports.contains(data.DEST)) {
                airports.add(data.DEST);
            }
        }
        airports.sort(String::compareTo);

        float cellSize = width / airports.size();

        // Create a hashmap to store frequencies for busy routes
        HashMap<String, Integer> busyFrequencyMap = new HashMap<>();
        for (RouteDataPoint data : busyRoutes) {
            String route = data.ORIGIN + "-" + data.DEST;
            busyFrequencyMap.put(route, data.FLIGHT_COUNT);
        }

        // Create a hashmap to store frequencies for all routes
        HashMap<String, Integer> allFrequencyMap = new HashMap<>();
        for (RouteDataPoint data : allRoutes) {
            String route = data.ORIGIN + "-" + data.DEST;
            allFrequencyMap.put(route, data.FLIGHT_COUNT);
        }

        // Calculate the maximum flight count from busy routes
        int maxFlightCount = 0;
        for (RouteDataPoint data : busyRoutes) {
            maxFlightCount = Math.max(maxFlightCount, data.FLIGHT_COUNT);
        }

        // Draw the grid
        for (int i = 0; i < airports.size(); i++) {
            for (int j = 0; j < airports.size(); j++) {
                String route = airports.get(i) + "-" + airports.get(j);
                float x = xpos + 50 + i * cellSize;
                float y = ypos + 50 + j * cellSize;

                // Fill the cell with appropriate shade of grey based on frequency
                int busyFrequency = busyFrequencyMap.getOrDefault(route, 0);
                int allFrequency = allFrequencyMap.getOrDefault(route, 0);
                int frequency = busyFrequency > 0 ? busyFrequency : allFrequency; // Use busy frequency if available, otherwise use all frequency
                int shade = (int) map(frequency, 0, maxFlightCount, 255, 0);
                fill(shade);
                rect(x, y, cellSize, cellSize);

                // Determine text color based on shade
                if (shade > 200) {
                    fill(0); // Dark text for light background
                } else {
                    fill(255); // Light text for dark background
                }
                textAlign(CENTER, CENTER);
                if (frequency > 0) {
                    text(frequency, x + cellSize / 2, y + cellSize / 2);
                } else {
                    text("X", x + cellSize / 2, y + cellSize / 2);
                }
            }
        }

        // Draw labels for x-axis (airports)
        textAlign(CENTER, TOP);
        for (int i = 0; i < airports.size(); i++) {
            float x = xpos + 50 + i * cellSize + cellSize / 2;
            float y = ypos + 30;
            text(airports.get(i), x, y);
        }

        // Draw labels for y-axis (airports)
        textAlign(LEFT, CENTER);
        for (int j = 0; j < airports.size(); j++) {
            float x = xpos + 10;
            float y = ypos + 50 + j * cellSize + cellSize / 2;
            text(airports.get(j), x, y);
        }
    }
}
