AirportGraph graph;
AirportNode hoveredNode = null;
boolean isDragging = false;
float offsetX, offsetY;

void setup() {
  fullScreen();
  graph = new AirportGraph();
  QueriesSelect queriesSelect = new QueriesSelect();

  // Fetching airport data
  ArrayList<RouteDataPoint> airports = queriesSelect.getAllRoutes();

  // Finding the maximum flight count
  int maxFlightCount = 0;
  for (RouteDataPoint airport : airports) {
    maxFlightCount = max(maxFlightCount, airport.FLIGHT_COUNT);
  }

  // Adding nodes (airports) to the graph
  for (RouteDataPoint airport : airports) {
    float nodeSize = map(airport.FLIGHT_COUNT, 0, maxFlightCount, 5, 25); // Adjust node size based on flight count
    if (!graph.containsNode(airport.ORIGIN)) {
      AirportNode node = new AirportNode(airport.ORIGIN, airport.FLIGHT_COUNT, nodeSize);
      graph.addNode(node);
    }
    if (!graph.containsNode(airport.DEST)) {
      AirportNode destNode = new AirportNode(airport.DEST, airport.FLIGHT_COUNT, nodeSize);
      graph.addNode(destNode);
    }
    float thickness = map(airport.FLIGHT_COUNT, 0, maxFlightCount, 0.5, 2); // Adjust line thickness based on flight count
    graph.connectAirports(airport.ORIGIN, airport.DEST, thickness);
  }
}

void draw() {
  background(0); // Set background color to black (obsidian-like)
  graph.draw();
}

void mouseMoved() {
  hoveredNode = graph.getNodeUnderMouse();
}

void mousePressed() {
  if (hoveredNode != null) {
    isDragging = true;
    offsetX = hoveredNode.x - mouseX;
    offsetY = hoveredNode.y - mouseY;
  }
}

void mouseReleased() {
  isDragging = false;
}

void mouseDragged() {
  if (isDragging && hoveredNode != null) {
    hoveredNode.x = mouseX + offsetX;
    hoveredNode.y = mouseY + offsetY;

    // Update the positions of connected nodes
    graph.updateConnectedNodes(hoveredNode);
  }
}

class AirportGraph {
  ArrayList<AirportNode> nodes;

  AirportGraph() {
    nodes = new ArrayList<AirportNode>();
  }

  void addNode(AirportNode node) {
    nodes.add(node);
  }

  boolean containsNode(String name) {
    for (AirportNode node : nodes) {
      if (node.name.equals(name)) {
        return true;
      }
    }
    return false;
  }

  void connectAirports(String origin, String dest, float thickness) {
    AirportNode originNode = getNodeByName(origin);
    AirportNode destNode = getNodeByName(dest);
    originNode.addNeighbor(destNode, thickness);
    destNode.addNeighbor(originNode, thickness); // Assuming it's a bi-directional connection
  }

  void draw() {
    stroke(150); // Set line color to dark grey
    for (AirportNode node : nodes) {
      node.draw();
      for (AirportNode neighbor : node.neighbors.keySet()) {
        float thickness = node.neighbors.get(neighbor);
        strokeWeight(thickness); // Set line thickness based on route popularity
        line(node.x, node.y, neighbor.x, neighbor.y);
      }
    }
  }

  AirportNode getNodeUnderMouse() {
    for (AirportNode node : nodes) {
      float d = dist(mouseX, mouseY, node.x, node.y);
      if (d < node.radius) {
        return node;
      }
    }
    return null;
  }

  AirportNode getNodeByName(String name) {
    for (AirportNode node : nodes) {
      if (node.name.equals(name)) {
        return node;
      }
    }
    return null;
  }

  void updateConnectedNodes(AirportNode movedNode) {
    for (AirportNode node : nodes) {
      if (node != movedNode && movedNode.neighbors.containsKey(node)) {
        float thickness = movedNode.neighbors.get(node);
        node.updateNeighborPosition(movedNode, thickness);
      }
    }
  }
}

class AirportNode {
  String name;
  float x, y; // Position of the airport node
  float radius; // Radius of the node based on number of flights
  HashMap<AirportNode, Float> neighbors; // Neighboring airports and corresponding line thickness

  AirportNode(String name, int flightCount, float nodeSize) {
    this.name = name;
    this.radius = nodeSize;
    this.neighbors = new HashMap<AirportNode, Float>();
    // Randomly position the airport node within the sketch window
    x = random(width);
    y = random(height);
  }

  void addNeighbor(AirportNode neighbor, float thickness) {
    neighbors.put(neighbor, thickness);
  }

  void draw() {
    // Draw airport node as a smaller light grey circle
    fill(200);
    ellipse(x, y, radius * 2, radius * 2);
  }

  void updateNeighborPosition(AirportNode movedNode, float thickness) {
    if (neighbors.containsKey(movedNode)) {
      neighbors.put(movedNode, thickness);
    }
  }
}
