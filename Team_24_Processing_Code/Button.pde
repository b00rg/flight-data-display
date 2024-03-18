class Button{
  int xpos, ypos, wide, heigh;
  
  Button(int xpos,int ypos, int W, int H){
    this.xpos = xpos;
    this.ypos = ypos;
    wide = W;
    heigh = H;
  }
  void renderButton(color myColor){
    fill(myColor);
    rect(xpos, ypos, wide, heigh);
  }
  boolean MousePress(){
    return (mouseX > xpos && mouseX < xpos + wide) && (mouseY > ypos && mouseY < heigh + ypos);
  }
}
/*
  todo
  Add a selection button at the bottom of tab 1 that allows the user to filter cancelled flights or not
  additionally add a second button so the user can select flights that were not cancelled
  the user should not be able to have both
*/
