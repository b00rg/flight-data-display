class WidgetButton extends Widget{
    int myEvent;
    WidgetButton(int xpos,int ypos, int W, int H, int event){
    super(xpos, ypos, W, H);
    myEvent = event;
    
  }
  void renderButton(color myColor){
    fill(myColor);
    rect(xpos, ypos, wide, high);
  }
  
}
