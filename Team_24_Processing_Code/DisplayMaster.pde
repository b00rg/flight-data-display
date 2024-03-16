class DisplayMaster
{
  // THEME-------------------
  // todo.md
  color PRIMARY_COLOR = color(255,255,255);
  color SECONDARY_COLOR = color(200,200, 255);
  color TERTIARY_COLOR = color(100, 200, 200);
  // Quit button config
  int QUIT_B_RIGHT = 20;
  int QUIT_B_DOWN = 20;
  int QUIT_B_SIZE = 50;
  int QUIT_B_ROUNDNESS = 10;
  DisplayMaster(){}
  
  void renderQuitButton()
  {
    fill(255,0,0);
    rect(QUIT_B_RIGHT, QUIT_B_DOWN, QUIT_B_SIZE, QUIT_B_SIZE, QUIT_B_ROUNDNESS);
  }
  // TAB 1----------------
  // Database interaction panel (DIP)
  int TAB_WIDTH = 180;
  int TAB_BORDER_WIDTH = 20;
  int VERTICAL_SPACING_OF_BOTTONS = 30;
  
  void renderDIP(){
    rect(0,0,TAB_WIDTH, displayHeight);
  }
}
