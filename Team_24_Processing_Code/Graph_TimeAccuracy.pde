class Graph_TimeAccuracy extends Graph {
<<<<<<< Updated upstream
  Graph_TimeAccuracy() {
    super();
=======
  int xpos, ypos, high, wide;
  Graph_TimeAccuracy(int x, int y, int h, int w) {
    super(x, y, h, w);
>>>>>>> Stashed changes
  }
  int calculateTimeAccuracy(int[] predDep, int[] actDep, int[] predArr, int[] actArr)
  {
    int timeDiffSum = 0;
    int avgTimeDiff = 0;
<<<<<<< Updated upstream
    for(i=0; i<predDep.length; i++) {
=======
    for(int i=0; i<predDep.length; i++) {
>>>>>>> Stashed changes
       timeDiffSum+=(actDep[i]-predDep[i])+(actArr[i]-predArr[i]);
     }
     avgTimeDiff=timeDiffSum/(predDep.length+predArr.length);
     return avgTimeDiff;
  }
  
  void drawAccuracyGraph(String[] carriers, int[] accuracy) {
<<<<<<< Updated upstream
    float x, y;
=======
>>>>>>> Stashed changes
    color boxColour = (50);
    color lineColour = (150);
    int boxLength = 100;
    int boxWidth = 20;
    int lineThickness = 5;
    int minIncrements = 5;
    int incrementSpace = 20;
    
    fill(boxColour);
<<<<<<< Updated upstream
    rect(x, y, boxLength, boxWidth);
    fill(255);
    rect(x+(boxLength/2), y, 10, boxWidth);
    
    
    for(i=0; i<carriers.length; i++){
      fill(lineColour);
      rect(x+(boxLength/2)+((incrementSpace/minIncrements)*accuracy[i]), y, lineThickness, boxWidth);
      
      textAllign(CENTER, TOP);
      text(carriers[i]);
      
    }
=======
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
>>>>>>> Stashed changes
