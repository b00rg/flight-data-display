/*import java.util.ArrayList;
import java.util.HashMap;

Graph graph = graphA;
AirportNode hoveredNode = null;
boolean isDragging = false;
float offsetX, offsetY;
//PFont labelFont;
String selectedAirportName = null;
int[] selectedAirportData = new int[3]; // Array to hold total, arrivals, and departures
float prevSelectedNodeX, prevSelectedNodeY;

/*void setup() {
    fullScreen();
    labelFont = createFont("Arial", 14);
    graph = new AirportGraph();
    QueriesSelect queriesSelect = new QueriesSelect(); // Instantiate QueriesSelect object

    // Fetching airport data
    ArrayList<RouteDataPoint> airports = queriesSelect.getAllRoutes();
  // Finding the maximum flight count
  int maxFlightCount = getMaxFlightCount(airports);

  // Adding nodes (airports) to the graph
  addNodesToGraph(airports, maxFlightCount);
}*/

/*void draw() {
  background(40); // Set background color to dark grey (similar to Obsidian)
  graph.update(); // Update node positions and check for collisions
  graph.draw();
  
  // Display labels when mouse hovers over a node
  displayHoveredNodeLabel();

  // Display selected airport name and flights in a window
  displaySelectedAirportData();
}*/
/*
void mousePressed() {
  if (hoveredNode != null) {
    selectAirport();
    isDragging = true;
    offsetX = mouseX - hoveredNode.x;
    offsetY = mouseY - hoveredNode.y;
  } else {
    deselectAirport();
  }
}

void mouseDragged() {
  if (isDragging && hoveredNode != null) {
    // Calculate the difference between the current and previous mouse positions
    float deltaX = mouseX - pmouseX;
    float deltaY = mouseY - pmouseY;

    // Update position of the main dragged node
    hoveredNode.x += deltaX;
    hoveredNode.y += deltaY;

    // Update positions of connected nodes (neighbors)
    for (AirportNode neighbor : hoveredNode.neighbors.keySet()) {
      // Calculate dampening factors based on the size of the nodes
      float nodeSizeRatio = hoveredNode.radius / neighbor.radius; // Calculate size ratio
      float dampeningFactor = 0.2 * nodeSizeRatio; // Adjust the dampening factor based on size ratio
      
      // Apply dampening effect to the movement of connected nodes
      float neighborDeltaX = deltaX * dampeningFactor; // Apply dampening to the horizontal movement
      float neighborDeltaY = deltaY * dampeningFactor; // Apply dampening to the vertical movement
      
      // Update position of the connected node
      neighbor.x += neighborDeltaX;
      neighbor.y += neighborDeltaY;
      
      // Update positions of nodes connected to the connected node
      for (AirportNode nestedNeighbor : neighbor.neighbors.keySet()) {
        // Calculate nested dampening factors based on the size of the nodes
        float nestedNodeSizeRatio = neighbor.radius / nestedNeighbor.radius; // Calculate size ratio
        float nestedDampeningFactor = 0.1 * nestedNodeSizeRatio; // Adjust the nested dampening factor based on size ratio
        
        // Apply further dampening effect to the movement of nested connected nodes
        float nestedNeighborDeltaX = neighborDeltaX * nestedDampeningFactor; // Apply dampening to the horizontal movement
        float nestedNeighborDeltaY = neighborDeltaY * nestedDampeningFactor; // Apply dampening to the vertical movement
        
        // Update position of the nested connected node
        nestedNeighbor.x += nestedNeighborDeltaX;
        nestedNeighbor.y += nestedNeighborDeltaY;
      }
    }
    
    // Update the original mouse position
    offsetX = mouseX - hoveredNode.x;
    offsetY = mouseY - hoveredNode.y;
  }
}




void updateConnectedNodes(AirportNode node, float deltaX, float deltaY, float strength, int maxDepth, int currentDepth) {
  if (currentDepth > maxDepth) {
    return; // Stop recursion if maximum depth is reached
  }

  for (AirportNode neighbor : node.neighbors.keySet()) {
    // Calculate the direction vector from the dragged node to its neighbor
    float directionX = neighbor.x - node.x;
    float directionY = neighbor.y - node.y;

    // Calculate the distance between the dragged node and its neighbor
    float distance = sqrt(directionX * directionX + directionY * directionY);

    // Define a factor to reduce movement strength based on distance
    float movementFactor = strength / (1 + distance);

    // Move the neighbor in the direction of the vector with reduced strength
    neighbor.x += deltaX * movementFactor;
    neighbor.y += deltaY * movementFactor;

    // Recursively update connected nodes of the neighbor
    updateConnectedNodes(neighbor, deltaX, deltaY, movementFactor * 0.8, maxDepth, currentDepth + 1); // Adjust the factor for less strength in subsequent nodes
  }
}




void mouseReleased() {
  // Stop dragging when the mouse is released
  isDragging = false;
}

int getMaxFlightCount(ArrayList<RouteDataPoint> airports) {
  int maxFlightCount = 0;
  for (RouteDataPoint airport : airports) {
    maxFlightCount = max(maxFlightCount, airport.FLIGHT_COUNT);
  }
  return maxFlightCount;
}

void displayHoveredNodeLabel() {
  if (hoveredNode != null) {
    fill(255);
    textFont(labelFont);
    textAlign(CENTER, CENTER);
    text(hoveredNode.name, mouseX, mouseY - 20);
  }
}

void selectAirport() {
  selectedAirportName = hoveredNode.name;
  QueriesSelect queries = new QueriesSelect();
  selectedAirportData[1] = queries.getArrivals(selectedAirportName);
  selectedAirportData[2] = queries.getDepartures(selectedAirportName);
  selectedAirportData[0] = selectedAirportData[1] + selectedAirportData[2];
}

void deselectAirport() {
  selectedAirportName = null;
  isDragging = false;
  for (int i = 0; i < selectedAirportData.length; i++) {
    selectedAirportData[i] = 0;
  }
}

void displaySelectedAirportData() {
  if (selectedAirportName != null) {
    AirportNode selectedNode = null;
    for (AirportNode node : graph.nodes) {
      if (node.name.equals(selectedAirportName)) {
        selectedNode = node;
        break;
      }
    }
    if (selectedNode != null) {
      float textBoxWidth = 200; // Adjust as needed
      float textBoxHeight = 100; // Adjust as needed
      
      // Calculate the ideal position of the bounding box relative to the node
      float idealTextBoxX = selectedNode.x - textBoxWidth / 2;
      float idealTextBoxY = selectedNode.y - selectedNode.radius - textBoxHeight - 20; // Position the bounding box above the node
      
      // Adjust position if the bounding box would appear off-screen while maintaining the same distance from the node
      float textBoxX = idealTextBoxX;
      float textBoxY = idealTextBoxY;
      
      // If the node collides with the left or right edge of the screen, move the bounding box left or right
      if (selectedNode.x - textBoxWidth / 2 < 0) {
        textBoxX = 0;
      } else if (selectedNode.x + textBoxWidth / 2 > width) {
        textBoxX = width - textBoxWidth;
      }
      
      // If the node collides with the top or bottom edge of the screen, move the bounding box up or down
      if (selectedNode.y - selectedNode.radius - textBoxHeight - 20 < 0) {
        textBoxY = 0;
      } else if (selectedNode.y - selectedNode.radius - textBoxHeight - 20 > height) {
        textBoxY = height - textBoxHeight;
      }

      fill(0, 0, 0, 100); // Transparent black with alpha at 100 (adjust for desired level)
      stroke(0, 0, 0, 150); // Dark grey border with some transparency (adjust alpha)
      rect(textBoxX, textBoxY, textBoxWidth, textBoxHeight);

      fill(255); // White text for clear visibility
      textAlign(CENTER, CENTER);
      text(selectedAirportName, textBoxX + textBoxWidth / 2, textBoxY + 20); // Center the text horizontally
      text("Total: " + selectedAirportData[0], textBoxX + textBoxWidth / 2, textBoxY + 40);
      text("Arrivals: " + selectedAirportData[1], textBoxX + textBoxWidth / 2, textBoxY + 60);
      text("Departures: " + selectedAirportData[2], textBoxX + textBoxWidth / 2, textBoxY + 80);
    }
  }
}


class AirportGraph extends Graph {
  ArrayList<AirportNode> nodes;

  AirportGraph(int x, int y, int wide, int high)
  {
    super(x, y, wide, high);
    
    nodes = new ArrayList<AirportNode>();
    int maxFlightCount = getMaxFlightCount(valuesA);
    addNodesToGraph(valuesA, maxFlightCount);
  }
  
  void addNodeToGraph(String name, int flightCount, float nodeSize) {
  if (!containsNode(name)) {
    AirportNode node = new AirportNode(name, flightCount, nodeSize);
    addNode(node);
  }
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
  
  void addNodesToGraph(ArrayList<RouteDataPoint> airports, int maxFlightCount) {
    for (RouteDataPoint airport : airports) {
      float nodeSize = map(airport.FLIGHT_COUNT, 0, maxFlightCount, 5, 25); // Adjust node size based on flight count
      addNodeToGraph(airport.ORIGIN, airport.FLIGHT_COUNT, nodeSize);
      addNodeToGraph(airport.DEST, airport.FLIGHT_COUNT, nodeSize);
      float thickness = map(airport.FLIGHT_COUNT, 0, maxFlightCount, 0.5, 2); // Adjust line thickness based on flight count
      connectAirports(airport.ORIGIN, airport.DEST, thickness);
    }
  }

  void draw() {
    if (isDragging || selectedAirportName != null) {
      // If any node is being dragged or a node is selected, change the graph color to a lighter shade of grey
      background(180); // Adjusted to a lighter shade of grey
    } else {
      background(40); // Default background color (dark grey)
    }

    for (AirportNode node : nodes) {
      if (isDragging && node == hoveredNode) {
        // If the node is being dragged, keep it white
        fill(255);
      } else if (selectedAirportName != null && node.name.equals(selectedAirportName)) {
        // If the node is selected, keep it white
        fill(255);
      } else {
        fill(120); // Default fill color for non-selected nodes
      }

      stroke(200); // Adjusted to a lighter grey
      strokeWeight(1); // Adjusted to a thinner line
      ellipse(node.x, node.y, node.radius * 2, node.radius * 2);

      for (AirportNode neighbor : node.neighbors.keySet()) {
        float thickness = node.neighbors.get(neighbor);
        stroke(150, 100); // Set line color to dark grey with lower transparency
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
  
  void mouseMoved() {
    hoveredNode = getNodeUnderMouse();
  }

  AirportNode getNodeByName(String name) {
    for (AirportNode node : nodes) {
      if (node.name.equals(name)) {
        return node;
      }
    }
    return null;
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

  boolean intersects(AirportNode other) {
    float dx = this.x - other.x;
    float dy = this.y - other.y;
    float distance = sqrt(dx * dx + dy * dy);
    return distance < this.radius + other.radius;
  }
}*/
