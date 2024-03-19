class DisplayMaster
{
  
DisplayMaster(){}
  // THEME-------------------
  
  // todo.md
  color PRIMARY_COLOR = color(0,50,100);
  color SECONDARY_COLOR = color(200,200, 255);
  color TERTIARY_COLOR = color(100, 200, 200);
  
  // Quit button config
  int QUIT_B_RIGHT = 20;
  int QUIT_B_DOWN = 20;
  int QUIT_B_SIZE = 50;
  int QUIT_B_ROUNDNESS = 10;
  
  void renderQuitButton()
  {
    fill(255,0,0);
    rect(QUIT_B_RIGHT, QUIT_B_DOWN, QUIT_B_SIZE, QUIT_B_SIZE, QUIT_B_ROUNDNESS);
  }
  
  // TAB 1----------------
  
  // Database interaction panel (DIP)
  int TAB_WIDTH = 500;
  int TAB_BORDER_WIDTH = 20;
  // Layout of buttons and drop down menus
  int VERTICAL_DISTANCE_FROM_WALL = 200;
  int VERTICAL_SPACING_OF_BOTTONS = 100;
  int HORIZONTAL_DISTANCE_FROM_WALL = 100;
  int HEIGHT_B = 70;
  int WIDTH_B = 200;
  
  // drop down buttons
  int NUMBER_OF_DROPDOWNS = 5;
  
  void renderDIP(){
    fill(PRIMARY_COLOR);
    rect(0,0,TAB_WIDTH, displayHeight);
    rect(TAB_WIDTH + TAB_BORDER_WIDTH,0,TAB_BORDER_WIDTH, displayHeight);
    
  }
  

  void renderDropMenu(){
  
  }
  void renderButtons(){
  
  }
}
