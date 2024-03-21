class Screen
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
  
  ArrayList<Widget_Button> buttonList = new ArrayList<Widget_Button>();
  ArrayList<Widget_DropDown> dropDownList = new ArrayList<Widget_DropDown>();
  ArrayList<Widget_TextBox> TextBoxList = new ArrayList<Widget_TextBox>();
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

  void renderTab1(){
    fill(PRIMARY_COLOR);
    rect(0,0,TAB_WIDTH, displayHeight);
    fill(SECONDARY_COLOR);
    rect(TAB_WIDTH + TAB_BORDER_WIDTH,0,TAB_BORDER_WIDTH, displayHeight);
    for(int i = 0; i < textBoxList.size(); i++)
    {
      textBoxList.get(i).render();
    }
  }
  void draw()
  {
    for(int i = 0; i < buttonListSize; i++)
    {
      buttonList.get(i).draw();
    }
 for(int i = 0; i < dropDownListSize; i++)
    {
      dropDownList.get(i).draw();
    }
 for(int i = 0; i < textBoxListSize; i++)
    {
      textBoxList.get(i).draw();
    }
  }

  void addElement(Widget_Button widget)
  {
    buttonList.add(widget);
    buttonListSize++;
  }
  void addElement(Widget_DropDown widget)
  {
    dropDownList.add(widget);
    dropDownListSize++;
  }
  void addElement(Widget_TextBox widget)
  {
    textBoxList.add(widget);
    textBoxListSize++;
  }
  
  void printTable()
  {
    for(int i = 0, n = 20 /*temp length*/; i <n; i++)
    {
      
    }
  }
}
