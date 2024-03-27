import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.regex.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

static String[] airports = new String[] {"JFK", "DCA", "LAX", "FLL", "SEA", "ORD", "HNL"};

static ArrayList<RawDataPoint> allDatapoints = new ArrayList<RawDataPoint>();
// initiate Global button lists, these store the pointers to all buttons
static ArrayList<WidgetTextBox> textBoxList = new ArrayList<WidgetTextBox>();
static ArrayList<WidgetButton> buttonList = new ArrayList<WidgetButton>();
static ArrayList<WidgetDropDown> dropDownList = new ArrayList<WidgetDropDown>();
static ArrayList<WidgetButton> TabButtons = new ArrayList<WidgetButton>(); // Tab buttons are in a seperate list to control their render order

static WidgetButton ReloadButton;
static WidgetButton moveLeft;
static WidgetButton moveRight;

static WidgetTextBox startDate;
static WidgetTextBox endDate;

enum WIDGET_TEXT_TYPE{
  TIME,
  DATE
}

Screen screen1 = new Screen();
static boolean[] statsShown = new boolean[18];
color ON = color(100,255,100);
color OFF = color(255,100,100);
PFont TextBoxFont;
// Setup Display Objects
ArrayList<DisplayDataPoint> filteredData;

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
  
  QueriesSelect selectQuery = new QueriesSelect();
  ArrayList<DisplayDataPoint> values = selectQuery.getRowsDisplay(true, 600, 200, "JFK", "LAX");
  for (DisplayDataPoint data : values) {
    println("Flight Date: " + data.FL_DATE);
    println("Market Carrier: " + data.MKT_CARRIER);
    println("Origin: " + data.ORIGIN);
    println("Destination: " + data.DEST);
    println("Departure Time: " + data.DEP_TIME);
    println("Arrival Time: " + data.ARR_TIME);
    println("Cancelled: " + data.CANCELLED);
    println("Diverted: " + data.DIVERTED);
    println("---------------------------------------");
  }
  
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
  
  WidgetTextBox departureTimeSelections = new WidgetTextBox(screen1.HORIZONTAL_DISTANCE_FROM_WALL, screen1.VERTICAL_DISTANCE_FROM_WALL+10, screen1.WIDTH_B, screen1.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "??:?? - ??:??", WIDGET_TEXT_TYPE.TIME);
  textBoxList.add(departureTimeSelections);
  WidgetTextBox ArrivalTimeSelections = new WidgetTextBox(screen1.HORIZONTAL_DISTANCE_FROM_WALL, screen1.VERTICAL_DISTANCE_FROM_WALL + 500, screen1.WIDTH_B, screen1.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "??:?? - ??:??", WIDGET_TEXT_TYPE.TIME);
  textBoxList.add(ArrivalTimeSelections);
  
  WidgetDropDown arrivals = new WidgetDropDown(300, 210, 200, 50, TextBoxFont, airports);
  dropDownList.add(arrivals);
  WidgetDropDown departures = new WidgetDropDown(300, 700, 200, 50, TextBoxFont, airports);
  dropDownList.add(departures);
  
  int totalTabWidth = screen.TAB_WIDTH + screen.TAB_BORDER_WIDTH;
  int tabRange = width - totalTabWidth;
  
  for(int i = 0; i < 3; i++) // We lerp through the upper tab, adding the tab buttons at intervals to make sure they are equally spaced
  {
    int x = (int)(lerp(totalTabWidth, width, (float)(((float)i / (float)3))));    // We use lerop to find the range of the buttons and add them;
    TabButtons.add(new WidgetButton(x,0,tabRange/3, (int)(height / 10), 0, ON, OFF));
  }
  TabButtons.get(0).active = true; // Tab 1 is on by default at the start
  ReloadButton = new WidgetButton(50, 50, 50, 50, 1, ON, OFF);
  
  moveLeft = new WidgetButton(1100, 1000, 50, 50, 5, ON, OFF);
  moveRight = new WidgetButton(1300, 1000, 50, 50, 5, ON, OFF);
  
  startDate = new WidgetTextBox(screen1.HORIZONTAL_DISTANCE_FROM_WALL / 2, screen1.VERTICAL_DISTANCE_FROM_WALL - 70, (int)(screen1.WIDTH_B / 1.5), screen1.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "dd/mm/yyyy", WIDGET_TEXT_TYPE.DATE);
  endDate = new WidgetTextBox(screen1.HORIZONTAL_DISTANCE_FROM_WALL *2, screen1.VERTICAL_DISTANCE_FROM_WALL - 70, (int)(screen1.WIDTH_B / 1.5), screen1.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "dd/m/yyyy", WIDGET_TEXT_TYPE.DATE);
  
  textBoxList.add(startDate);
  textBoxList.add(endDate);
  
}
// currentlyActiveTab
void draw(){
  
  background(255,255,255);
  moveLeft.render();
  moveRight.render();
  // REMINDER: from now on buttons and the tab on the left on the screen are always the same regardless of selected tab
  // User tab selection only effects everything on the right
  screen.renderDIP();
  screen.renderButtons();
  switch(currentlyActiveTab)
  {
    case 0: // user is looking at tab 1
      screen.renderTab1();
      break;
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
    screen.renderTab1();
    ReloadButton.active = false;
    ReloadButton.render();
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
  screen.hasUserChangedPage();
  if(isDropDownActive)
  {
    for(int i = 0; i < dropDownList.size(); i++)
    {
      dropDownList.get(i).isClicked();
    }
  } else 
  {
    for(int i  = 0; i < textBoxList.size(); i++)
    {
      textBoxList.get(i).isClicked();
    }
    for(int i = 0; i < buttonList.size(); i++)
    {
      
    }
    for(int i = 0; i < dropDownList.size(); i++)
    {
      dropDownList.get(i).isClicked();
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
void RealoadEvent(){
  // setup place holder values
  int startTimeForReaload = millis();
  boolean depTime;
  int num1;
  int num2;
  
  String selectedAriivalStation = "";
  String selectedDepartureStation = "";
  
  // insert user querry values to the right places
  if(textBoxList.get(1).textValue != "??:?? - ??:??"){
    depTime = false;
    num1 = Integer.parseInt(textBoxList.get(1).num1.trim());
    num2 = Integer.parseInt(textBoxList.get(1).num2.trim());
  } else  if ((textBoxList.get(0).textValue != "??:?? - ??:??"))
  {
    depTime = true;
    num1 = Integer.parseInt(textBoxList.get(0).num1.trim());
    num2 = Integer.parseInt(textBoxList.get(0).num2.trim());
  } else 
  {
    depTime = true; // doesn't matter
    num1 = 0000;
    num2 = 0000;
  }
  if(dropDownList.get(0).currentlySelectedElement != -1)
  {
    selectedAriivalStation = dropDownList.get(0).elements[dropDownList.get(0).currentlySelectedElement];
  } else {selectedAriivalStation = null;}
  if(dropDownList.get(1).currentlySelectedElement != -1)
  {
    selectedDepartureStation = dropDownList.get(1).elements[dropDownList.get(1).currentlySelectedElement];
  } else {selectedDepartureStation = null;}
  
  QueriesSelect selectQuery = new QueriesSelect();
  int startTime = millis();
  filteredData = selectQuery.getRowsDisplay(depTime, num1, num2, selectedAriivalStation, selectedDepartureStation);
  int endTime = millis();
  int elapsed = endTime - startTime;
  println("It took " + elapsed + " milliseconds to generate the new filtered data array");
  // screen setup
  screen.numberOfPages = (int)(filteredData.size() / 10); // number of pages = the number of pages that we need to display the data
  screen.numberOfPages++; // add 1 to take into account 0, i.e what if we have 7 elements to display, we still need 1 page
  screen.selectedPage = 1;
  
  int endTimeForReload = millis();
  int elapsedTimeForReload = endTimeForReload - startTimeForReaload;
  println("It took " + elapsedTimeForReload + " milliseconds to complete ReloadEvent");
  
}
void mouseWheel(MouseEvent event){
  for(int i = 0; i < dropDownList.size(); i++)
  {
    dropDownList.get(i).scroll((int)event.getCount());
  }
}
void updateTabs(){
  for(int i = 0; i < TabButtons.size(); i++)
  {
    if(TabButtons.get(i).active)
    {
      currentlyActiveTab = i;
    }
  }
}
