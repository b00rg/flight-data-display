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
    color lineColour = (200);
    int boxLength = width;
    int boxWidth = height;
    int lineThickness = 3;
    int minIncrements = 5;
    int incrementSpace = 60;
    
    fill(boxColour);
    rect(xpos, ypos, boxLength, boxWidth);
    fill(255);
    rect(xpos+(boxLength/2), ypos, 5, boxWidth);
    
    fill(boxColour);
    textAlign(CENTER, BOTTOM);
    for (int i=1; i*incrementSpace<boxLength/2; i++)
    {
      rect(xpos+(boxLength/2)+(i*incrementSpace), ypos-10, lineThickness, 10);
      text("+" + i*minIncrements, xpos+(boxLength/2)+(i*incrementSpace), ypos-10);
      rect(xpos+(boxLength/2)-(i*incrementSpace), ypos-10, lineThickness, 10);
      text("-" + i*minIncrements, xpos+(boxLength/2)-(i*incrementSpace), ypos-10);
    }
    
    textAlign(CENTER, TOP);    
    for(int i=0; i<carriers.length; i++){
      fill(lineColour);
      rect(xpos+(boxLength/2)+((incrementSpace/minIncrements)*accuracy[i]), ypos, lineThickness, boxWidth);
      
      text(carriers[i], xpos+(boxLength/2)+((incrementSpace/minIncrements)*accuracy[i]), ypos+boxWidth);
      
    }
  }
}
