class WidgetButton extends Widget{
    int myEvent;
  WidgetButton(int xpos,int ypos, int W, int H, int event){
    super();
    myEvent = event;
    
  }
  void renderButton(color myColor){
    fill(myColor);
    rect(super.xpos, super.ypos, super.wide, super.high);
  }
  
}
