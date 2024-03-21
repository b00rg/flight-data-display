class Graph_TimePredictAccuracy extends Graph {
  Graph_TimePredictAccuracy() {
    super();
  }
  int calculateTimeAccuracy(int[] predDep, int[] actDep, int[] predArr, int[] actArr)
  {
    int timeDiffSum = 0;
    int avgTimeDiff = 0;
    for(i=0; i<predDep.length; i++) {
       timeDiffSum+=(actDep[i]-predDep[i])+(actArr[i]-predArr[i]);
     }
     avgTimeDiff=timeDiffSum/(predDep.length+predArr.length);
     return avgTimeDiff;
  }
  
  void drawAccuracyGraph(String[] carriers, int[] accuracy) {
    float x, y;
    color boxColour = (50);
    int boxLength = 100;
    int boxWidth = 20;
    int lineThickness = 5;
    int minIncrements = 5;
    int incrementSpace = 20;
    
    fill(boxColour);
    rect(x, y, boxLength, boxWidth);
    fill(255);
    rect(x+(boxLength/2), y, lineThickness, boxWidth);
    
    
    for(i=0; i<carriers.length; i++){
      
    }
    
