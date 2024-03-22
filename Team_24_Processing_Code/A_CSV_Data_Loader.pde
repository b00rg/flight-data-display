import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.regex.*;

static ArrayList<RawDataPoint> allDatapoints = new ArrayList<RawDataPoint>();
// initiate Global button lists, these store the pointers to all buttons
static ArrayList<WidgetTextBox> textBoxList = new ArrayList<WidgetTextBox>();
static ArrayList<WidgetButton> buttonList = new ArrayList<WidgetButton>();
static ArrayList<WidgetDropDown> dropDownList = new ArrayList<WidgetDropDown>();
static ArrayList<WidgetButton> TabButtons = new ArrayList<WidgetButton>(); // Tab buttons are in a seperate list to control their render order
static WidgetButton ReloadButton;
Screen screen1 = new Screen();
static boolean[] statsShown = new boolean[18];
color ON = color(100,255,100);
color OFF = color(255,100,100);
PFont TextBoxFont;
// Setup Display Objects
Screen screen = new Screen();
int currentlyActiveTab = 0;
boolean isDropDownActive = false;
int WIDGET_ROUNDNESS = 10;
void setup() {
  fullScreen();
  //DO NOT DELETE
  QueriesInitial setupQuery = new QueriesInitial();
  
  setupQuery.createDatabase();
  setupQuery.useDatabase();
  setupQuery.dropAndCreateTable();
  setupQuery.insertRows();
  //DO NOT DELETE  

  /*
  //draw the pie chart
  size(500, 500);
  QueriesSelect queries = new QueriesSelect();
  ArrayList<BarDataPoint> values = queries.getRowsBarGraph();
  
  Graph_Bar graph = new Graph_Bar();
  graph.drawBarChart(values);
  */
  
  // Display setup
  // Tab 1 setup
  // please do not move this outside of setup void, for some reason processing does not likey likey that

  
  
  //Make Datapoints
  
  //for;
  
  // Display setup
  
  // Tab 1 setup
  // please do not move this outside of setup void, for some reason processing does not likey likey that
  TextBoxFont = loadFont("default.vlw");
  
  WidgetTextBox departureTimeSelections = new WidgetTextBox(screen1.HORIZONTAL_DISTANCE_FROM_WALL, screen1.VERTICAL_DISTANCE_FROM_WALL, screen1.WIDTH_B, screen1.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont);
  textBoxList.add(departureTimeSelections);
  WidgetTextBox ArrivalTimeSelections = new WidgetTextBox(screen1.HORIZONTAL_DISTANCE_FROM_WALL, screen1.VERTICAL_DISTANCE_FROM_WALL + 500, screen1.WIDTH_B, screen1.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont);
  textBoxList.add(ArrivalTimeSelections);
  int totalTabWidth = screen.TAB_WIDTH + screen.TAB_BORDER_WIDTH;
  int tabRange = width - totalTabWidth;
  
  for(int i = 0; i < 3; i++) // We lerp through the upper tab, adding the tab buttons at intervals to make sure they are equally spaced
  {
    int x = (int)(lerp(totalTabWidth, width, (float)(((float)i / (float)3))));    // We use lerop to find the range of the buttons and add them;
    TabButtons.add(new WidgetButton(x,0,tabRange/3, (int)(height / 10), 0, ON, OFF));
  }
  TabButtons.get(0).active = true; // Tab 1 is on by default at the start
  ReloadButton = new WidgetButton(50, 50, 100, 100, WIDGET_ROUNDNESS, ON, OFF);
}
// currentlyActiveTab
void draw(){
  
  background(255,255,255);
  // REMINDER: from now on buttons and the tab on the left on the screen are always the same regardless of selected tab
  // User tab selection only effects everything on the right
  screen.renderDIP();
  screen.renderButtons();
  switch(currentlyActiveTab)
  {
    case 0: // user is looking at tab 1
    // We must only render elements relevant to tab 1
    case 1: // user is lookingat tab 2
  }
  ReloadButton.render();
}

void mouseClicked(){
  if(ReloadButton.isClicked())
  {
    ReloadButton.active = true;
    ReloadButton.render();
    RealoadEvent();
  }
  for(int i = 0; i < TabButtons.size(); i++) // we first investigate if the user is trying to change tabs
  {
     if(TabButtons.get(i).isMouseover())  // For every tab button
     {
       TabButtons.get(i).active = true;  // We find the active button
       for(int j = 0; j < TabButtons.size(); j++)
       {
         if(TabButtons.get(i) != TabButtons.get(j)) // We disable all other buttons
         {
           TabButtons.get(j).active = false;
         }
       } // This means that that only tab button is on at any given moment, and if the user clicks the same one twice it makes no difference
       break;
     }
  }
  updateTabs();
  if(isDropDownActive)
  {
    // todo
  } else 
  {
    for(int i  = 0; i < textBoxList.size(); i++)
    {
      textBoxList.get(i).isClicked();
    }
    for(int i = 0; i < buttonList.size(); i++)
    {
      
    }
    
  }
}
void keyPressed(){ // todo, lots of this code is redudant since the user always has access to the buttons
    switch(currentlyActiveTab) 
    {
      case 0:   // User is on tab 1

        for(int i  = 0; i < textBoxList.size(); i++)
        {
          if(textBoxList.get(i).active)
          {
          textBoxList.get(i).input(key);
          delay(10); // We must delay to stop the user from accidentally holding a key causing many inputs at once
          }
        }
    }
}
void RealoadEvent(){}
void updateTabs(){
  for(int i = 0; i < TabButtons.size(); i++)
  {
    if(TabButtons.get(i).active)
    {
      currentlyActiveTab = i;
    }
  }
}
