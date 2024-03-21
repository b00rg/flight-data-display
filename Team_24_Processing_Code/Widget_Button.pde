class Widget_Button extends Widget{
  
  Widget_Button(int xpos,int ypos, int W, int H, int event){
    super.xpos = xpos;
    super.ypos = ypos;
    super.wide = W;
    super.high = H;
    super.event = event;
    
    super.rounding = 10;
  }
  void renderButton(color myColor){
    fill(myColor);
    rect(super.xpos, super.ypos, super.wide, super.high);
  }
  void mousePressed(){
    if((mouseX > super.xpos && mouseX < super.xpos + super.wide) && (mouseY > super.ypos && mouseY < super.high + super.ypos))
    {
      print(2);
    }
  }
  void draw()
  {
    super.draw();
  }
}
