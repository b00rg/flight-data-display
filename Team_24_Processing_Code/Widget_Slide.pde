class WidgetSlide extends Widget {
  int startXpos;
  int endXpos;
  int startYpos;
  int endYpos;
  
  int buttonSize;
  
  int maxValue;
  int minValue;
  
  int thick;
  PVector position;
  boolean isDragging = false; // Track whether the circle is being dragged
  int lastMouseX; // Track the previous mouse x-coordinate
  int lastMouseY; // Track the previous mouse y-coordinate
  
  WidgetSlide(int startX, int endX, int startY, int endY, int size, int max, int min, int thickness) {
    startXpos = startX;
    endXpos = endX;
    startYpos = startY;
    endYpos = endY;
    buttonSize = size;
    maxValue = max;
    minValue = min;
    thick = thickness;
    position = new PVector(startX, startY); // Initialize position vector
  }
  
  // @Override
  void render() {
    strokeWeight(thick);
    fill(255, 255, 255);
    line(startXpos, startYpos, endXpos, endYpos);
    fill(0, 0, 0);
    circle(position.x, position.y, buttonSize);
  }
  
  void isDragged() {
    if (isDragging) {
      // Calculate the change in mouse position since the last frame
      int dx = mouseX - lastMouseX;
      int dy = mouseY - lastMouseY;
      println("X");
      // Update the position of the circle
      position.x += dx;
      position.y += dy;
      
      // Constrain the position within the bounds of the slide
      position.x = constrain(position.x, startXpos, endXpos);
      position.y = constrain(position.y, startYpos - buttonSize / 2, startYpos + buttonSize / 2);
      
      // Update the last mouse coordinates
      lastMouseX = mouseX;
      lastMouseY = mouseY;
    }
  }
  
  // @Override
  boolean isMouseover() {
    println("Z");
    return dist(position.x, position.y, mouseX, mouseY) <= buttonSize / 2;
  }
  
  // @Override
  void mousePressed() {
    if (isMouseover()) {
      println("Dragging is activated");
      isDragging = true; // Start dragging
      lastMouseX = mouseX; // Store initial mouse position
      lastMouseY = mouseY;
    }
  }
  
  // @Override
  void mouseReleased() {
    println("Dragging is deactivated");
    isDragging = false; // Stop dragging
  }
}
