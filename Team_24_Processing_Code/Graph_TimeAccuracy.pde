class GraphTimeAccuracy extends Graph {
  GraphTimeAccuracy(int x, int y, int w, int h) {
    super(x, y, w, h);
  }
  float calculateTimeAccuracy(int[] predDep, int[] actDep, int[] predArr, int[] actArr)
  {
    int timeDiffSum = 0;
    float avgTimeDiff = 0;
    for(int i=0; i<predDep.length; i++) {
       timeDiffSum+=(actDep[i]-predDep[i])+(actArr[i]-predArr[i]);
     }
     avgTimeDiff=timeDiffSum/(predDep.length+predArr.length);
     return avgTimeDiff;
  }
  
  void draw(String[] carriers, float[] accuracy) {
    color boxColour = (50);
    color lineColour = (150);
    int boxLength = width;
    int boxWidth = height;
    int lineThickness = 5;
    int minIncrements = 5;
    int incrementSpace = 20;
    
    fill(boxColour);
    rect(xpos, ypos, boxLength, boxWidth);
    fill(255);
    rect(xpos+(boxLength/2), ypos, 10, boxWidth);
    
    
    for(int i=0; i<carriers.length; i++){
      fill(lineColour);
      rect(xpos+(boxLength/2)+((incrementSpace/minIncrements)*accuracy[i]), ypos, lineThickness, boxWidth);
      
      textAlign(CENTER, TOP);
      text(carriers[i], xpos+(boxLength/2)+((incrementSpace/minIncrements)*accuracy[i]), ypos+boxWidth);
      
    }
    rect(xpos, ypos, boxLength, boxWidth);
    fill(255);
    rect(xpos+(boxLength/2), ypos, 10, boxWidth);
    
    
    for(int i=0; i<carriers.length; i++){
      fill(lineColour);
      rect(xpos+(boxLength/2)+((incrementSpace/minIncrements)*accuracy[i]), ypos, lineThickness, boxWidth);
      
      textAlign(CENTER, TOP);
      text(carriers[i], xpos+(boxLength/2)+((incrementSpace/minIncrements)*accuracy[i]), ypos+boxWidth);
      
    }
  }
}
