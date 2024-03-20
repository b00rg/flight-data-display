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
