import java.util.ArrayList;
import java.util.HashMap;

class AirportGraph extends Graph
{
  ArrayList<AirportNode> nodes = new ArrayList<AirportNode>();
  QueriesSelect queriesSelect = new QueriesSelect(); // Instantiate QueriesSelect object
  ArrayList<RouteDataPoint> airports = queriesSelect.getAllRoutes();
    
  AirportNode hoveredNode = null;
  boolean isDragging = false;
  float offsetX, offsetY;
  PFont labelFont;
    
  String selectedAirportName = null;
  int[] selectedAirportData = new int[3]; // Array to hold total, arrivals, and departures
    
  float prevSelectedNodeX, prevSelectedNodeY;
  int maxFlightCount = getMaxFlightCount(airports);
  
  AirportGraph(int x, int y, int wide, int high) 
  {
    super(x, y, wide, high);
    addNodesToGraph(airports, maxFlightCount);
  }
  
  boolean containsNode(String name)
  {
    for (AirportNode node : nodes)
    {
      if (node.name.equals(name))
        return true;
    }
    return false;
  }
  
  /////////// GRAPH SETUP ////////////////
  void addNodesToGraph(ArrayList<RouteDataPoint> airports, int maxFlightCount)
  {
    for (RouteDataPoint airport : airports) 
    {
      float nodeSize = map(airport.FLIGHT_COUNT, 0, maxFlightCount, 5, 25); // Adjust node size based on flight count
      addNode(airport.ORIGIN, airport.FLIGHT_COUNT, nodeSize);
      addNode(airport.DEST, airport.FLIGHT_COUNT, nodeSize);
      float thickness = map(airport.FLIGHT_COUNT, 0, maxFlightCount, 0.5, 2); // Adjust line thickness based on flight count
      connectAirports(airport.ORIGIN, airport.DEST, thickness);
    }
  }
  
  void addNode(String name, int flightCount, float nodeSize)
  {
    if (!containsNode(name))
    {
      AirportNode node = new AirportNode(this, name, flightCount, nodeSize);
      nodes.add(node);
    }
  }
  
  void connectAirports(String origin, String dest, float thickness)
  {
    AirportNode originNode = getNodeByName(origin);
    AirportNode destNode = getNodeByName(dest);
    originNode.addNeighbor(destNode, thickness);
    destNode.addNeighbor(originNode, thickness); // Assuming it's a bi-directional connection
  }

 
  /////////////// GRAPH ACTIVITY /////////////////////////
  void update() 
  {
    text("CONNECTING FLIGHTS", xpos + (width/2) -100, ypos - 100);
    
    for (AirportNode node : nodes) 
    {
      // Update position based on velocity
      if (!isDragging || (isDragging && node != hoveredNode)) 
      {
        node.x += node.velocityX;
        node.y += node.velocityY;

        // Bouncing off the walls
        if (node.x < node.radius + xpos) 
        {
          node.x = node.radius + xpos; // Limit left bound
          node.velocityX *= -1; // Reverse x-velocity
        }
        
        if (node.x > xpos + width - node.radius) 
        {
          node.x = xpos + width - node.radius; // Limit right bound
          node.velocityX *= -1; // Reverse x-velocity
        }
        
        if (node.y < node.radius + ypos)
        {
          node.y = ypos + node.radius; // Limit top bound
          node.velocityY *= -1; // Reverse y-velocity
        }
        
        if (node.y > ypos + height - node.radius)
        {
          node.y = ypos + height - node.radius; // Limit bottom bound
          node.velocityY *= -1; // Reverse y-velocity
        }
        
      }

      // Check for collision with other nodes
      for (AirportNode other : nodes)
      {
        if (node != other && node.intersects(other))
        {
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
  
  void updateConnectedNodes(AirportNode node, float deltaX, float deltaY, float strength, int maxDepth, int currentDepth)
  {
    if (currentDepth > maxDepth)
    {
      return; // Stop recursion if maximum depth is reached
    }

    for (AirportNode neighbor : node.neighbors.keySet())
    {
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

  void draw()
  {
    // If any node is being dragged or a node is selected, change the graph color to a lighter shade of grey
    /*if (isDragging || selectedAirportName != null) 
      background(180); // Adjusted to a lighter shade of grey
    else
      background(40); // Default background color (dark grey)*/
  

    for (AirportNode node : nodes) 
    {
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

      for (AirportNode neighbor : node.neighbors.keySet())
      {
        float thickness = node.neighbors.get(neighbor);
        stroke(150, 100); // Set line color to dark grey with lower transparency
        strokeWeight(thickness); // Set line thickness based on route popularity
        line(node.x, node.y, neighbor.x, neighbor.y);
      }
    }
  }
  
  
  ///////////// GRAPH INTERACTION //////////////////
  
  void selectAirport()
  {
    selectedAirportName = hoveredNode.name;
    QueriesSelect queries = new QueriesSelect();
    selectedAirportData[1] = queries.getArrivals(selectedAirportName);
    selectedAirportData[2] = queries.getDepartures(selectedAirportName);
    selectedAirportData[0] = selectedAirportData[1] + selectedAirportData[2];
  }

  void deselectAirport() 
  {
    selectedAirportName = null;
    isDragging = false;
    for (int i = 0; i < selectedAirportData.length; i++)
    {
      selectedAirportData[i] = 0;
    }
  }
  
  AirportNode getNodeUnderMouse() 
  {
    for (AirportNode node : nodes) 
    {
      float d = dist(mouseX, mouseY, node.x, node.y);
      if (d < node.radius)
        return node;
    }
    return null;
  }
  
  void displayHoveredNodeLabel()
  {
    if (hoveredNode != null)
    {
      fill(255);
      textFont(TextBoxFont);
      textAlign(CENTER, CENTER);
      text(hoveredNode.name, mouseX, mouseY - 20);
    }
  }
  
  void displaySelectedAirportData()
  {
    if (selectedAirportName != null)
    {
      AirportNode selectedNode = null;
      for (AirportNode node : nodes)
      {
        if (node.name.equals(selectedAirportName))
        {
          selectedNode = node;
          break;
        }
      }
      
      if (selectedNode != null) 
      {
        float textBoxWidth = 200; // Adjust as needed
        float textBoxHeight = 100; // Adjust as needed
      
        // Calculate the ideal position of the bounding box relative to the node
        float idealTextBoxX = selectedNode.x - textBoxWidth / 2;
        float idealTextBoxY = selectedNode.y - selectedNode.radius - textBoxHeight - 20; // Position the bounding box above the node
      
        // Adjust position if the bounding box would appear off-screen while maintaining the same distance from the node
        float textBoxX = idealTextBoxX;
        float textBoxY = idealTextBoxY;
      
        // If the node collides with the left or right edge of the screen, move the bounding box left or right
        if (selectedNode.x - textBoxWidth / 2 < 0)
          textBoxX = 0;
        else if (selectedNode.x + textBoxWidth / 2 > width)
        textBoxX = width - textBoxWidth;
      
        // If the node collides with the top or bottom edge of the screen, move the bounding box up or down
        if (selectedNode.y - selectedNode.radius - textBoxHeight - 20 < 0)
          textBoxY = 0;
        else if (selectedNode.y - selectedNode.radius - textBoxHeight - 20 > height)
            textBoxY = height - textBoxHeight;

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
  
  ///////////////// GRAPH STATS /////////////////////
  int getMaxFlightCount(ArrayList<RouteDataPoint> airports)
  {
    int maxFlightCount = 0;
    for (RouteDataPoint airport : airports)
    {
      maxFlightCount = max(maxFlightCount, airport.FLIGHT_COUNT);
    }
  return maxFlightCount;
  }
  
  AirportNode getNodeByName(String name)
  {
    for (AirportNode node : nodes)
    {
      if (node.name.equals(name))
        return node;
    }
    return null;
  }
}

class AirportNode {
  AirportGraph parentGraph;
  String name;
  int flightCount; // Number of flights
  float x, y; // Position of the airport node
  float radius; // Radius of the node based on number of flights
  HashMap<AirportNode, Float> neighbors; // Neighboring airports and corresponding line thickness
  float velocityX, velocityY; // Velocity of the node

  AirportNode(AirportGraph graph, String name, int flightCount, float nodeSize)
  {
    parentGraph = graph;
    this.name = name;
    this.flightCount = flightCount;
    this.radius = nodeSize;
    this.neighbors = new HashMap<AirportNode, Float>();
    // Randomly position the airport node within the sketch window
    x = parentGraph.xpos + random(parentGraph.width);
    y = parentGraph.ypos + random(parentGraph.height);
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
}
