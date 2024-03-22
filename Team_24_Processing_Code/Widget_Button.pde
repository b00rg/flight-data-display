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
      linkedListCheck(TabButtons);
    } else 
    {
      
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
  void linkedListCheck(ArrayList<WidgetButton> buttonGroup){ // This functions is used for lists of butons where only one button may be on at a time
  // Afte a button is clicked, the button goes through a list that includes itself and it's fellow buttons in the group, and makes sure only it is active
    for(int i = 0; i < buttonGroup.size(); i++)
    {
      if(buttonGroup.get(i) != this)
      {
        buttonGroup.get(i).active = false;
      }
    }
  }
}
