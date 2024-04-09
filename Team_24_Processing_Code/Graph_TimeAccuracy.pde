class GraphTimeAccuracy extends Graph {
  GraphTimeAccuracy(int x, int y, int w, int h) {
    super(x, y, w, h);
  }
  
  void draw(ArrayList<DelaysDataPoint> data) {
    color boxColour = (50);
    color lineColour = (200);
    int boxLength = width;
    int boxWidth = height;
    int lineThickness = 3;
    int minIncrements = 10;
    int incrementSpace = 65;
    // drawing main box
    fill(boxColour);
    rect(xpos, ypos, boxLength, boxWidth);
    fill(255);
    rect(xpos+(boxLength/2), ypos, 5, boxWidth);
    // drawing time increment labels
    fill(boxColour);
    textAlign(CENTER, BOTTOM);
    for (int i=1; i*incrementSpace<boxLength/2; i++)
    {
      rect(xpos+(boxLength/2)+(i*incrementSpace), ypos-10, lineThickness, 10);
      text("+" + i*minIncrements, xpos+(boxLength/2)+(i*incrementSpace), ypos-10);
      rect(xpos+(boxLength/2)-(i*incrementSpace), ypos-10, lineThickness, 10);
      text("-" + i*minIncrements, xpos+(boxLength/2)-(i*incrementSpace), ypos-10);
    }
    // drawing carrier points and their labels
    
    textAlign(CENTER, TOP);
    fill(lineColour);
    for(int i=0; i<data.size(); i++){
      DelaysDataPoint values = data.get(i);
      rect(xpos+(boxLength/2)+((incrementSpace/minIncrements)*values.AVG_DELAY), ypos, lineThickness, boxWidth);
      text(values.MKT_CARRIER, xpos+(boxLength/2)+((incrementSpace/minIncrements)*values.AVG_DELAY), ypos+boxWidth);
      
    }
  }
}
