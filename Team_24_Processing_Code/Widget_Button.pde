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
