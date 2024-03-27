class Screen
{
  
Screen(){}
 
  // THEME-------------------
  
  // todo.md
  color PRIMARY_COLOR = color(0,50,100), SECONDARY_COLOR = color(200,200, 255), TERTIARY_COLOR = color(100, 200, 200);
  
  int buttonListSize = 0, dropDownListSize = 0, textBoxListSize = 0;

  
  void renderQuitButton()
  {
  }
  
  // TAB 1----------------
  
  // Database interaction panel (DIP)
  int TAB_WIDTH = 500, TAB_BORDER_WIDTH = 20;
  
  int numberOfPages; // The amount of pages that the user can flick through based on the amount of data that needs to be displayed
  int selectedPage = 1, dataBlockYMargin = 5;
  
  // Layout of buttons and drop down menus
  int VERTICAL_DISTANCE_FROM_WALL = 200, VERTICAL_SPACING_OF_BOTTONS = 100, HORIZONTAL_DISTANCE_FROM_WALL = 100;
  int HEIGHT_B = 70, WIDTH_B = 200;
  
  
  
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
  void renderButtons()
  {
    for(int i = 0; i < textBoxList.size(); i++)
    {
      textBoxList.get(i).render();
    }
    for(int i = 0, n = buttonList.size(); i < n; i++)
    {
      buttonList.get(i).render();
    }
    for(int i = 0; i < dropDownList.size(); i++)
    {
      dropDownList.get(i).render();
    }
    startDate.render();
    endDate.render();
  }
  // Renders all the 
  void renderTab1()
  {
    if(filteredData == null || filteredData.size() == 0)
    {
      //do nothing if there is nothing to render in tab 1
    } else 
    {
      int dataBlockWidth =((width - TAB_WIDTH - TAB_BORDER_WIDTH) / 2) - 10;
      int dataBlockHeigh =(int)((float)height / (float)6.5);
      int dataBlockYMove = dataBlockHeigh + 5;
      int dataBlockYpos = height / 10 + 10;
      textSize(20);
      text("Total flights: " + filteredData.size(), 50, 20);
      int temp = 0;
      for(int i = 0; i < 10; i++)
      {        
        try{
          if(i < 5) 
          {
            renderDataBock(TAB_WIDTH + TAB_BORDER_WIDTH + 20 + temp, dataBlockYpos + dataBlockYMove * i, dataBlockWidth, dataBlockHeigh, filteredData.get(i+(selectedPage - 1) * 10));
          } else 
          {
            renderDataBock(TAB_WIDTH + TAB_BORDER_WIDTH + 20 + 10 + dataBlockWidth, dataBlockYpos + dataBlockYMove * (i-5), dataBlockWidth, dataBlockHeigh, filteredData.get(i+(selectedPage - 1) * 10));
          }
        } catch(Exception e)
        {
          break; // This means we tried accessing elements outisde of the array, we run out of elements to display
        }
      }
    }
  }
  void renderDataBock(int xpos, int ypos, int w, int h, DisplayDataPoint D){
    textSize(30);
    fill(SECONDARY_COLOR);
    rect(xpos, ypos, w, h, 10);
    fill(0);
    text("Arrivals: " + D.ORIGIN,xpos + 2, ypos + h / 10);
    text("Time: " + D.ARR_TIME, xpos + 2, ypos + h / 10 * 3);
    text("Destination: " + D.DEST,xpos + 2, ypos + h/2);
    text("Time: " + D.DEP_TIME, xpos + 2,ypos + h/2 + h/4);
    
  }
  
  void renderTab2(){
    //A_CSV_Data_Loader.pie1.render();
   
    switch(graphDisplayed)
    {
      case 0:
        graphB.drawBarChart(valuesB);
        break;
      case 1:
        graphP.drawPieChart(valuesP);
        break;
      default:
        println("No graph found");
        break;
    }
  }

  void printTable()
  {
    for(int i = 0, n = 20 /*temp length*/; i <n; i++)
    {
      
    }
  }
}
