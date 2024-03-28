import java.util.ArrayList;
import java.util.HashMap;
import java.sql.*;

AirportGraph graph;
AirportNode hoveredNode = null;
boolean isDragging = false;
float offsetX, offsetY;
PFont labelFont;
String selectedAirportName = null;
int[] selectedAirportData = new int[3]; // Array to hold total, arrivals, and departures

void setup() {
  fullScreen();
  labelFont = createFont("Arial", 14);
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
  background(40); // Set background color to dark grey (similar to Obsidian)
  graph.update(); // Update node positions and check for collisions
  graph.draw();
  
  // Display labels when mouse hovers over a node
  if (hoveredNode != null) {
    fill(255);
    textFont(labelFont);
    textAlign(CENTER, CENTER);
    text(hoveredNode.name, mouseX, mouseY - 20);
  }
  
  // Display selected airport name and flights in a window
  if (selectedAirportName != null) {
    fill(255);
    rect(width/2 - 150, height/2 - 70, 300, 140);
    fill(0);
    textAlign(CENTER, CENTER);
    text(selectedAirportName, width/2, height/2 - 30);
    text("Total: " + selectedAirportData[0], width/2, height/2);
    text("Arrivals: " + selectedAirportData[1], width/2, height/2 + 30);
    text("Departures: " + selectedAirportData[2], width/2, height/2 + 60);
  }
}

void mouseMoved() {
  hoveredNode = graph.getNodeUnderMouse();
}

void mousePressed() {
  if (hoveredNode != null) {
    selectedAirportName = hoveredNode.name;
    QueriesSelect queries = new QueriesSelect();
    selectedAirportData[1] = queries.getArrivals(selectedAirportName);
    selectedAirportData[2] = queries.getDepartures(selectedAirportName);
    selectedAirportData[0] = queries.getArrivals(selectedAirportName) + queries.getDepartures(selectedAirportName);
  } else {
    selectedAirportName = null;
    for (int i = 0; i < selectedAirportData.length; i++) {
      selectedAirportData[i] = 0;
    }
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

  void update() {
    for (AirportNode node : nodes) {
      // Update position based on velocity
      if (!isDragging || (isDragging && node != hoveredNode)) {
        node.x += node.velocityX;
        node.y += node.velocityY;

        // Bouncing off the walls
        if (node.x < node.radius) {
          node.x = node.radius; // Limit left bound
          node.velocityX *= -1; // Reverse x-velocity
        }
        if (node.x > width - node.radius) {
          node.x = width - node.radius; // Limit right bound
          node.velocityX *= -1; // Reverse x-velocity
        }
        if (node.y < node.radius) {
          node.y = node.radius; // Limit top bound
          node.velocityY *= -1; // Reverse y-velocity
        }
        if (node.y > height - node.radius) {
          node.y = height - node.radius; // Limit bottom bound
          node.velocityY *= -1; // Reverse y-velocity
        }
      }

      // Check for collision with other nodes
      for (AirportNode other : nodes) {
        if (node != other && node.intersects(other)) {
          // If nodes intersect, adjust positions
          float dx = other.x - node.x;
          float dy = other.y - node.y;
          float distance = sqrt(dx * dx + dy * dy);
          float overlap = node.radius + other.radius - distance;
          float angle = atan2(dy, dx);
          float targetX = node.x + cos(angle) * overlap / 2;
          float targetY = node.y + sin(angle) * overlap / 2;
          node.x -= cos(angle) * overlap / 2;
          node.y -= sin(angle) * overlap / 2;
          other.x += cos(angle) * overlap / 2;
          other.y += sin(angle) * overlap / 2;
          
          // Update velocities after collision
          float tempVX = node.velocityX;
          float tempVY = node.velocityY;
          node.velocityX = other.velocityX;
          node.velocityY = other.velocityY;
          other.velocityX = tempVX;
          other.velocityY = tempVY;
        }
      }
    }
  }
}

class AirportNode {
  String name;
  int flightCount; // Number of flights
  float x, y; // Position of the airport node
  float radius; // Radius of the node based on number of flights
  HashMap<AirportNode, Float> neighbors; // Neighboring airports and corresponding line thickness
  float velocityX, velocityY; // Velocity of the node

  AirportNode(String name, int flightCount, float nodeSize) {
    this.name = name;
    this.flightCount = flightCount;
    this.radius = nodeSize;
    this.neighbors = new HashMap<AirportNode, Float>();
    // Randomly position the airport node within the sketch window
    x = random(width);
    y = random(height);
    this.velocityX = random(-2, 2); // Random initial velocity
    this.velocityY = random(-2, 2);
  }

  void addNeighbor(AirportNode neighbor, float thickness) {
    neighbors.put(neighbor, thickness);
  }

  void draw() {
    // Draw airport node as a smaller light grey circle
    fill(120); // Adjusted to a lighter grey
    stroke(200); // Adjusted to a lighter grey
    strokeWeight(1); // Adjusted to a thinner line
    ellipse(x, y, radius * 2, radius * 2);
  }

  void updateNeighborPosition(AirportNode movedNode, float thickness) {
    if (neighbors.containsKey(movedNode)) {
      neighbors.put(movedNode, thickness);
    }
  }

  boolean intersects(AirportNode other) {
    float dx = this.x - other.x;
    float dy = this.y - other.y;
    float distance = sqrt(dx * dx + dy * dy);
    return distance < this.radius + other.radius;
  }
}
