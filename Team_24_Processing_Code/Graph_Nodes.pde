AirportGraph graph;
AirportNode hoveredNode = null;

void setup() {
  fullScreen();
  graph = new AirportGraph();
  QueriesSelect queriesSelect = new QueriesSelect();

  // Fetching airport data
  ArrayList<RouteDataPoint> airports = queriesSelect.getAllRoutes();

  // Adding nodes (airports) to the graph
  for (RouteDataPoint airport : airports) {
    AirportNode node = new AirportNode(airport.ORIGIN);
    graph.addNode(node);
    AirportNode destNode = new AirportNode(airport.DEST);
    graph.addNode(destNode);
    graph.connectAirports(node, destNode);
  }
}

void draw() {
  background(0); // Set background color to black (obsidian-like)
  graph.draw();
}

void mouseMoved() {
  hoveredNode = graph.getNodeUnderMouse();
}

class AirportGraph {
  ArrayList<AirportNode> nodes;

  AirportGraph() {
    nodes = new ArrayList<AirportNode>();
  }

  void addNode(AirportNode node) {
    nodes.add(node);
  }

  void connectAirports(AirportNode node1, AirportNode node2) {
    node1.addNeighbor(node2);
    node2.addNeighbor(node1); // Assuming it's a bi-directional connection
  }

  void draw() {
    stroke(255); // Set line color to white
    for (AirportNode node : nodes) {
      node.draw();
      for (AirportNode neighbor : node.neighbors) {
        // Draw a line between airports
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
}

class AirportNode {
  String name;
  float x, y; // Position of the airport node
  float radius = 5; // Radius of the node
  ArrayList<AirportNode> neighbors;

  AirportNode(String name) {
    this.name = name;
    neighbors = new ArrayList<AirportNode>();
    // Randomly position the airport node within the sketch window
    x = random(width);
    y = random(height);
  }

  void addNeighbor(AirportNode neighbor) {
    neighbors.add(neighbor);
  }

  void draw() {
    // Draw airport node as a small white circle
    fill(255);
    ellipse(x, y, radius * 2, radius * 2);
    // Draw airport name only when the mouse hovers over it
    if (hoveredNode == this) {
      textAlign(CENTER, BOTTOM);
      fill(255);
      text(name, x, y - 5);
    }
  }
}
