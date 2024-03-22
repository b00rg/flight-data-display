class Screen
{
  
Screen(){}
 
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
  
  ArrayList<WidgetButton> buttonList = new ArrayList<WidgetButton>();
  ArrayList<WidgetDropDown> dropDownList = new ArrayList<WidgetDropDown>();
  ArrayList<WidgetTextBox> TextBoxList = new ArrayList<WidgetTextBox>();
  int buttonListSize = 0, dropDownListSize = 0, textBoxListSize = 0;

  
  void renderQuitButton()
  {
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
    renderUpperTab();
    fill(PRIMARY_COLOR);
    rect(0,0,TAB_WIDTH, displayHeight);
    fill(SECONDARY_COLOR);
    rect(TAB_WIDTH,0,TAB_BORDER_WIDTH, displayHeight);
  }
  void renderUpperTab(){
    fill(PRIMARY_COLOR);
    rect(0,0,width, (int)(height/10));
    stroke(SECONDARY_COLOR);
    strokeWeight(5);
    for(int i = 0; i < TabButtons.size(); i++)
    {
      TabButtons.get(i).render();
    }
    strokeWeight(0);
  }
  void renderButtons(){
    for(int i = 0; i < textBoxList.size(); i++)
    {
      textBoxList.get(i).render();
    }
    for(int i = 0; i < buttonList.size(); i++)
    {
      buttonList.get(i).render();
    }
  }
  void renderTab1(){
    // todo
  }
  
  void printTable()
  {
    for(int i = 0, n = 20 /*temp length*/; i <n; i++)
    {
      
    }
  }
}
