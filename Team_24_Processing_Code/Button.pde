class Button{
  private int xpos, ypos, wide, high, event;
  
  Button(int xpos,int ypos, int W, int H, int event){
    this.xpos = xpos;
    this.ypos = ypos;
    wide = W;
    high = H;
    this.event = event;
  }
  void renderButton(color myColor){
    fill(myColor);
    rect(xpos, ypos, wide, high);
  }
  void mousePressed(){
    if((mouseX > xpos && mouseX < xpos + wide) && (mouseY > ypos && mouseY < high + ypos))
    {
      DisplayMaster.EventHandler(event);
      //print(2);
    }
  }
}
/*
  todo
  Add a selection button at the bottom of tab 1 that allows the user to filter cancelled flights or not
  additionally add a second button so the user can select flights that were not cancelled
  the user should not be able to have both
*/
