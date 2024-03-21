class WidgetButton extends Widget{
    color ON, OFF;
    WidgetButton(int xpos,int ypos, int W, int H, color on, color off){
    super(xpos, ypos, W, H);
    ON = on;
    OFF = off;
  }
  void isClicked(){
    if(isMouseover())  // if the mouse is clicked, and the mouse is over the button...
    {
      
      active = !active;
    } else 
    {
      println("tab");
    }
  }
  void render(){
    if(active)
    {
      fill(ON);
    } else         // We choose the color of the botton base on it's current status
    {
      fill(OFF);
    }
    rect(xpos, ypos, wide, high);
  }
  
}
