<<<<<<< HEAD
// IMPORT FILES
=======
//IMPORT FILES
>>>>>>> 825a3c48fea1a9b5c4237c0214692b04d5ce3b5d
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.regex.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

<<<<<<< HEAD
// THEMES

enum THEMES
{
=======
// THEMSE
enum THEMES
  {
>>>>>>> 825a3c48fea1a9b5c4237c0214692b04d5ce3b5d
    DEFAULT,
    GIRLBOSS,
    BOYBOSS,
    DAY,
<<<<<<< HEAD
    DUSK,
    COSMIC,
    RUST,
    MARINE,
    STELLAR,
    COLOURBLIND
}
String themeNames[] = new String[] {"GIRLBOSS", "BOYBOSS", "DAY", "DUSK", "COSMIC", "RUST", "MARINE", "STELLAR", "COLOURBLIND"};
WidgetDropDown ThemeSelection;

// STATIC SETUP VARIABLE
static ArrayList<WidgetTextBox> textBoxList = new ArrayList<WidgetTextBox>();
static ArrayList<WidgetButton> buttonList = new ArrayList<WidgetButton>();
static ArrayList<WidgetDropDown> dropDownList = new ArrayList<WidgetDropDown>();
static ArrayList<WidgetButton> TabButtons = new ArrayList<WidgetButton>(); // Tab buttons are in a separate list to control their render order
=======
    NIGHT,
    CUSTOM_THEME
  }
String themeNames[] = new String[] {"DEFAULT", "GIRLBOSS", "BOYBOSS", "DAY", "NIGHT", "CUSTOM_THEME"};
WidgetDropDown ThemeSelection;
//STATIC SETUP VARIABLE
static ArrayList<WidgetTextBox> textBoxList = new ArrayList<WidgetTextBox>();
static ArrayList<WidgetButton> buttonList = new ArrayList<WidgetButton>();
static ArrayList<WidgetDropDown> dropDownList = new ArrayList<WidgetDropDown>();
static ArrayList<WidgetButton> TabButtons = new ArrayList<WidgetButton>(); // Tab buttons are in a seperate list to control their render order
>>>>>>> 825a3c48fea1a9b5c4237c0214692b04d5ce3b5d

static WidgetButton ReloadButton;
static WidgetButton moveLeft;
static WidgetButton moveRight;

<<<<<<< HEAD
static WidgetButton cancelledFlights;
static WidgetButton delayedFlights;
static WidgetButton undisturbedFlights;

PImage reloadButton;
PImage leftButton;
PImage rightButton;

/*
PImage cancelledButton;
PImage delayedButton;
PImage undisturbedButton;*/

PImage carrierAA;
PImage carrierAS;
PImage carrierB6;
PImage carrierG4;
PImage carrierHA;
PImage carrierNK;
PImage carrierWN;

// Takes in the name of a carrier and returns the associated image
PImage nameToLogo(String name)
{
  switch(name)
  {
    case "AA":
      return carrierAA;
    case "AS":
      return carrierAS;
    case "B6":
      return carrierB6;
    case "G4":
      return carrierG4;
    case "HA":
      return carrierHA;
    case "NK":
      return carrierNK;
    case "WN":
      return carrierWN;
    default:
      return null;
  }
}

static WidgetTextBox startDate;
static WidgetTextBox endDate;
enum WIDGET_TEXT_TYPE {
    TIME,
    DATE
}

// COLORS AND FONTS SETUP
color ON = color(100, 255, 100);
color OFF = color(255, 100, 100);
PFont TextBoxFont, headingFont;

// GLOBAL UI VARIABLES SETUP
Screen screen;
int currentlyActiveTab = 0;
boolean isDropDownActive = false;
int WIDGET_ROUNDNESS = 10;

// STATISTICAL VARIABLES SETUP
static boolean[] statsShown = new boolean[18];
ArrayList<DisplayDataPoint> filteredData;

// GRAPH DECLERATIONS
//ArrayList<BarDataPoint> valuesB;
//GraphBar graphB;

ArrayList<PieDataPoint> valuesP;
GraphPie graphP;

ArrayList<RouteDataPoint> valuesDS;
//DensityGraph graphD;
//SimpleGraph graphS;

ArrayList<RouteDataPoint> valuesA;
AirportGraph graphA;

GraphTimeAccuracy graphT;

int displayedGraph = 0;

// SETUP FUNCTION
void setup() {
  fullScreen();
  screen = new Screen(width, height);
  // THEME SETUP
  screen.changeTheme(THEMES.DEFAULT);
  ThemeSelection = new WidgetDropDown(width / 6, 0, (int)(width * 0.10416), (int)(height*0.037037), TextBoxFont, themeNames, "DEFAULT");
  ThemeSelection.selectedValue = "DEFAULT";
  // DATA SETUP
=======
static WidgetTextBox startDate;
static WidgetTextBox endDate;

static boolean[] statsShown = new boolean[18];
color ON = color(100,255,100);
color OFF = color(255,100,100);
PFont TextBoxFont;
ArrayList<DisplayDataPoint> filteredData;

Screen screen = new Screen();
int currentlyActiveTab = 0;
boolean isDropDownActive = false;
int WIDGET_ROUNDNESS = 10;
  
enum WIDGET_TEXT_TYPE{
  TIME,
  DATE
}


//SETUP FUNCTION
void setup() {
  fullScreen();
  
  // THEME SETUP
  screen.changeTheme(THEMES.DEFAULT);
  //DATA SETUP
>>>>>>> 825a3c48fea1a9b5c4237c0214692b04d5ce3b5d
  QueriesInitial setupQuery = new QueriesInitial();
  setupQuery.createDatabase();
  setupQuery.useDatabase();
  setupQuery.dropAndCreateTable();
  setupQuery.insertRows();

<<<<<<< HEAD
  TextBoxFont = loadFont("default.vlw");
  headingFont = loadFont("Heading.vlw");

  // DATE TEXT BOX SETUP
  startDate = new WidgetTextBox((int) (width * 0.08), (int) (height * 0.1), screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "DD/MM/YYYY", WIDGET_TEXT_TYPE.DATE);
  endDate = new WidgetTextBox((int) (width * 0.17), (int) (height * 0.1), screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "DD/MM/YYYY", WIDGET_TEXT_TYPE.DATE);
  textBoxList.add(startDate);
  textBoxList.add(endDate);

  // TEXTBOX SETUP
  WidgetTextBox departureLowerSelection = new WidgetTextBox((int) (width * 0.08), (int) (height * 0.25), screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "??:??", WIDGET_TEXT_TYPE.TIME);
  WidgetTextBox departureUpperSelection = new WidgetTextBox((int) (width * 0.17), (int) (height * 0.25), screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "??:??", WIDGET_TEXT_TYPE.TIME);
  WidgetTextBox arrivalLowerSelection = new WidgetTextBox((int) (width * 0.08), (int) (height * 0.35), screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "??:??", WIDGET_TEXT_TYPE.TIME);
  WidgetTextBox arrivalUpperSelection = new WidgetTextBox((int) (width * 0.17), (int) (height * 0.35), screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "??:??", WIDGET_TEXT_TYPE.TIME);
  textBoxList.add(departureLowerSelection);
  textBoxList.add(departureUpperSelection);
  textBoxList.add(arrivalLowerSelection);
  textBoxList.add(arrivalUpperSelection);

  // AIRPORT DROP DOWN SETUP
  QueriesSelect selectQuery = new QueriesSelect();
  String[] departureAirports = selectQuery.getDepartureAirports();
  String[] arrivalAirports = selectQuery.getArrivalAirports();
  WidgetDropDown departures = new WidgetDropDown((int) (width * 0.13), (int) (height * 0.6), 200, 50, TextBoxFont, arrivalAirports, "");
  dropDownList.add(departures);
  WidgetDropDown arrivals = new WidgetDropDown((int) (width * 0.13), (int) (height * 0.52), 200, 50, TextBoxFont, departureAirports, "");
  dropDownList.add(arrivals);

  // RELOAD BUTTON SETUP
  ReloadButton = new WidgetButton((int) (width * 0.025), (int) (height * 0.88), 75, 75, 1);
  reloadButton = loadImage("reload.png");

  // TAB BUTTON SETUP
  int totalTabWidth = screen.TAB_WIDTH + screen.TAB_BORDER_WIDTH;
  int tabRange = width - totalTabWidth;

  for (int i = 0; i < 3; i++) // We lerp through the upper tab, adding the tab buttons at intervals to make sure they are equally spaced
  {
    int x = (int) (lerp(totalTabWidth, width, (float)(((float)i / (float)3))));    // We use lerop to find the range of the buttons and add them;
    TabButtons.add(new WidgetButton(x, 0, tabRange/3, (int)(height / 10), 0));
  }
  TabButtons.get(0).active = true; // Tab 1 is on by default at the start

  // SCROLL BUTTON SETUP
  moveLeft = new WidgetButton((int)(width * 0.572916), (int)(height * 0.925925), 50, 50, 5);
  moveRight = new WidgetButton((int)(width * 0.677083), (int)(height * 0.925925), 50, 50, 5);

  
  leftButton = loadImage("left.png");
  rightButton = loadImage("right.png");
  
  
  carrierAA = loadImage(sketchPath() +"/data/airline carriers/aa.png");
  carrierAS = loadImage(sketchPath() +"/data/airline carriers/as.png");
  carrierB6 = loadImage(sketchPath() +"/data/airline carriers/b6.png");
  carrierG4 = loadImage(sketchPath() +"/data/airline carriers/G4.png");
  carrierHA = loadImage(sketchPath() +"/data/airline carriers/ha.png");
  carrierNK = loadImage(sketchPath() +"/data/airline carriers/NK.png");
  carrierWN = loadImage(sketchPath() +"/data/airline carriers/wn.png");
  
  
 
  /*cancelledFlights = new WidgetButton(width/20, height / 10 * 7, 50, 50, 20);
  delayedFlights = new WidgetButton(width/20 * 2, height / 10 * 7, 50, 50, 20);
  undisturbedFlights = new WidgetButton(width/20 * 3, height / 10 * 7, 50, 50, 20);
  
  cancelledButton = loadImage("cancelled.png");
  delayedButton = loadImage("diverted.png");
  undisturbedButton = loadImage("uninterrupted.png");*/
  
  // Tab 1 setup
  // please do not move this outside of setup void, for some reason processing does not like that

  // Tab 2 setup


  // GRAPH SETUP
  
  QueriesSelect queries = new QueriesSelect();
  //valuesB = queries.getRowsBarGraph2();
  valuesP = queries.getRowsPieChart(true, 0000, 2300, null, null, null, null);
  valuesDS = queries.getBusyRoutes();
  valuesA = queries.getAllRoutes();

  //graphB = new GraphBar(600, 250, 1200, 700);
  graphP = new GraphPie(1300, 560, 800, 800);
  //graphD = new DensityGraph(800, 150, 1200, 700);
  //graphS = new SimpleGraph(600, 500, 1200, 1000);
  graphT = new GraphTimeAccuracy(700, 500, 800, 100);

  //Graph[] graphs = {graphB, graphP, graphD, graphS, graphA};
  Graph[] graphs = new Graph[6];
  screen.numberOfGraphs = graphs.length;
  
  // Tab 3 setup
  graphA = new AirportGraph(600, 250, 1200, 700);
}

void draw() {

  /*
  undisturbedFlights.render();
  cancelledFlights.render();
  delayedFlights.render();
   */

  background(screen.BACKGROUND);

  noStroke();

  moveLeft.render();
  moveRight.render();

  screen.renderDIP();
  
  ReloadButton.render();
  screen.renderButtons();
  
  /*
  image(cancelledButton, width/20, height / 10 * 7, 50, 50);
  image(delayedButton, width/20 * 2, height / 10 * 7, 50, 50);
  image(undisturbedButton, width/20 * 3, height / 10 * 7, 50, 50);*/
  
  image(leftButton, (int)(width * 0.572916), (int)(height * 0.925925), 50, 50);
  image(rightButton, (int)(width * 0.677083), (int)(height * 0.925925), 50, 50);
  
  image(reloadButton, (int) (width * 0.025), (int) (height * 0.88), 75, 75);
  
  switch (currentlyActiveTab) {
  case 0: // user is looking at tab 1
    screen.renderTab1();
    break;
  case 1: // user is looking at tab 2
    screen.renderTab2();
    break;
  case 2: // user is looking at tab 2
    screen.renderTab3();
    break;
  default:
    println("Tab not found");
    currentlyActiveTab = 0;
    break;
  }
  ThemeSelection.render();
}

// Goes through every button on the screen and commands them to check if they have been clicked
// This method always updated the tab and theme at the end aswell in case the user clicked anything relating to their selection - Angelos
void mouseClicked() {
  if (ReloadButton.isClicked()) 
  {
    ReloadButton.active = true;
    ReloadButton.render();
    ReloadEvent();
    //screen.renderTab1();
    ReloadButton.active = false;
    ReloadButton.render();
  }
  for (int i = 0; i < TabButtons.size(); i++) 
  { // we first investigate if the user is trying to change tabs
    if (TabButtons.get(i).isMouseover()) {  // For every tab button
      TabButtons.get(i).active = true;  // We find the active button
      for (int j = 0; j < TabButtons.size(); j++) 
      {
        if (TabButtons.get(i) != TabButtons.get(j)) 
        { // We disable all other buttons
          TabButtons.get(j).active = false;
        }
      } // This means that that only tab button is on at any given moment, and if the user clicks the same one twice it makes no difference
      break;
    }
  }
  updateTabs();
  screen.pageSelectButtons();
  ThemeSelection.isClicked();
  if (isDropDownActive) 
  {
    for (int i = 0; i < dropDownList.size(); i++) 
=======
  
  //TEXTBOX SETUP
  TextBoxFont = loadFont("default.vlw");
  WidgetTextBox departureTimeSelections = new WidgetTextBox(250, 500, screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "??:?? - ??:??", WIDGET_TEXT_TYPE.TIME);
  WidgetTextBox arrivalTimeSelections = new WidgetTextBox(50, 500, screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "??:?? - ??:??", WIDGET_TEXT_TYPE.TIME);
  textBoxList.add(departureTimeSelections);
  textBoxList.add(arrivalTimeSelections);
  
  
  //DATE TEXT BOX SETUP
  startDate = new WidgetTextBox(50, 800, (int)(screen.WIDTH_B / 1.5), screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "dd/mm/yyyy", WIDGET_TEXT_TYPE.DATE);
  endDate = new WidgetTextBox(150, 800, (int)(screen.WIDTH_B / 1.5), screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "dd/m/yyyy", WIDGET_TEXT_TYPE.DATE);
  textBoxList.add(startDate);
  textBoxList.add(endDate);
  
  
  //AIRPORT DROP DOWN SETUP
  QueriesSelect selectQuery = new QueriesSelect();
  String[] departureAirports = selectQuery.getDepartureAirports();
  String[] arrivalAirports = selectQuery.getArrivalAirports();  
  WidgetDropDown arrivals = new WidgetDropDown(50, 150, 200, 50, TextBoxFont, departureAirports);
  dropDownList.add(arrivals);
  WidgetDropDown departures = new WidgetDropDown(250, 150, 200, 50, TextBoxFont, arrivalAirports);
  dropDownList.add(departures);
  ArrayList<RouteDataPoint> routes = selectQuery.getBusyRoutes();
  for (int i = 0; i < routes.size(); i++){
    RouteDataPoint route = routes.get(i);
    println(route.ORIGIN + " " + route.DEST + " " + route.FLIGHT_COUNT);
  }
    
  
  //TAB BUTTON SETUP
  int totalTabWidth = screen.TAB_WIDTH + screen.TAB_BORDER_WIDTH;
  int tabRange = width - totalTabWidth;

  for(int i = 0; i < 3; i++) // We lerp through the upper tab, adding the tab buttons at intervals to make sure they are equally spaced
  {
    int x = (int)(lerp(totalTabWidth, width, (float)(((float)i / (float)3))));    // We use lerop to find the range of the buttons and add them;
    TabButtons.add(new WidgetButton(x,0,tabRange/3, (int)(height / 10), 0));
  }
  TabButtons.get(0).active = true; // Tab 1 is on by default at the start
  ReloadButton = new WidgetButton(50, 50, 50, 50, 1);
  // THEME BUTTON SETUP
  ThemeSelection = new WidgetDropDown(250, 20, 200, 50, TextBoxFont, themeNames);
  ThemeSelection.currentlySelectedElement = 0;
  //SCROLL BUTTON SETUP
  moveLeft = new WidgetButton(1100, 1000, 50, 50, 5);
  moveRight = new WidgetButton(1300, 1000, 50, 50, 5);
  
}


void draw(){
  
  background(screen.BACKGROUND);
  
  moveLeft.render();
  moveRight.render();
  // REMINDER: from now on buttons and the tab on the left on the screen are always the same regardless of selected tab
  // User tab selection only effects everything on the right
  screen.renderDIP();
  ThemeSelection.render();
  screen.renderButtons();
  ThemeSelection.render();
  switch(currentlyActiveTab)
  {
    case 0: // user is looking at tab 1
      screen.renderTab1();
      break;
    case 1: // user is lookingat tab 2
  }
  ReloadButton.render();
}


//ADD COMMENT
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
  ThemeSelection.isClicked();
  if(ThemeSelection.currentlySelectedElement == -1)
  {
    ThemeSelection.currentlySelectedElement = 0;
  }
  screen.changeTheme(indexToTheme(ThemeSelection.currentlySelectedElement));
  if(isDropDownActive)
  {
    for(int i = 0; i < dropDownList.size(); i++)
>>>>>>> 825a3c48fea1a9b5c4237c0214692b04d5ce3b5d
    {
      dropDownList.get(i).isClicked();
    }
  } else 
  {
<<<<<<< HEAD
    for (int i = 0; i < textBoxList.size(); i++) 
    {
      textBoxList.get(i).isClicked();
    }
    for (int i = 0; i < dropDownList.size(); i++) 
=======
    for(int i  = 0; i < textBoxList.size(); i++)
    {
      textBoxList.get(i).isClicked();
    }
    for(int i = 0; i < buttonList.size(); i++)
    {
      
    }
    for(int i = 0; i < dropDownList.size(); i++)
>>>>>>> 825a3c48fea1a9b5c4237c0214692b04d5ce3b5d
    {
      dropDownList.get(i).isClicked();
    }
  }
<<<<<<< HEAD
  screen.changeTheme(stringToEnum(ThemeSelection.selectedValue));
}

// creates all query related data pieces and collect the data from input buttons, some of the data is also processed
// to be compatible with our query system requirements, the filteredData attaylist is then adjusted to contain the new data - Angelos
void ReloadEvent() {
  // setup place holder values
  boolean depTime = false;
  int time1 = 0;
  int time2 = 0;

  String selectedArrivalStation = "";
  String selectedDepartureStation = "";
  String date1 = null;
  String date2 = null;

  // TIME SELECTION

  // call the time inputs from the departure and arrival time selection buttons
  if ((textBoxList.get(2).textValue != textBoxList.get(2).normal) && (textBoxList.get(3).textValue != textBoxList.get(3).normal))
  { // if departure airport time selection has a valid input
    time1 = Integer.parseInt(textBoxList.get(2).giveProcessedUserInput());
    time2 = Integer.parseInt(textBoxList.get(3).giveProcessedUserInput());
    textBoxList.get(4).textValue = textBoxList.get(4).normal; // we flush the other time selection buttons in case the user has inputted anything there
    textBoxList.get(5).textValue = textBoxList.get(5).normal;
    depTime = false;
  } else if ((textBoxList.get(4).textValue != textBoxList.get(4).normal) && (textBoxList.get(5).textValue != textBoxList.get(5).normal))
  { // if arrival airport time selection has a valid input
    time1 = Integer.parseInt(textBoxList.get(4).giveProcessedUserInput());
    time2 = Integer.parseInt(textBoxList.get(5).giveProcessedUserInput());
    textBoxList.get(2).textValue = textBoxList.get(2).normal; // we flush the other time selection buttons in case the user has inputted anything there
    textBoxList.get(3).textValue = textBoxList.get(3).normal;
    depTime = true;
  } else
  {
    // we flush all time selection buttons in case the user has inputted anything there that is incomplete and as such invalid
    time1 = 0000;
    time2 = 0000;
    textBoxList.get(2).textValue = textBoxList.get(2).normal;
    textBoxList.get(3).textValue = textBoxList.get(3).normal;
    textBoxList.get(4).textValue = textBoxList.get(4).normal;
    textBoxList.get(5).textValue = textBoxList.get(5).normal;
    depTime = false;
  }


  // DATE SELECTION
  if ((textBoxList.get(0).textValue != "" || textBoxList.get(0).textValue != null) && (textBoxList.get(1).textValue != "" || textBoxList.get(1).textValue != null))
  {
    date1 = textBoxList.get(0).giveProcessedUserInput();
    date2 = textBoxList.get(1).giveProcessedUserInput();
  } else
  {
    // if the user did not give a full date seelction we empty date selection, the dates are left null
    textBoxList.get(0).userInputInvalid();
    textBoxList.get(1).userInputInvalid();
  }


  // AIRPORT SELECTION
  // If the drop down has a selected item on it, selectedArrivalStation stores it
  if (dropDownList.get(0).selectedValue != "") {
    selectedArrivalStation = dropDownList.get(0).selectedValue;
  } else { // or else it becomes null
    selectedArrivalStation = null;
  }
  // Repeat for departure station
  if (dropDownList.get(1).selectedValue != "") {
    selectedDepartureStation = dropDownList.get(1).selectedValue;
  } else {
    selectedDepartureStation = null;
  }
  
  long startTime = System.nanoTime();

  QueriesSelect selectQuery = new QueriesSelect();
  filteredData = selectQuery.getRowsDisplay(depTime, time1, time2, selectedArrivalStation, selectedDepartureStation, date1, date2);

  long endTime = System.nanoTime();
  long elapsedTime = endTime - startTime;
  double elapsedTimeInMs = (double) elapsedTime / 1_000_000.0;
  println("Elapsed Time: " + elapsedTimeInMs + " milliseconds, that is how long it took to add the new data to the filteredData array");

=======
}


// checks which tab is currently active and applies a process depending on the scenario
// At the moment this 
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


// creates all querry related data pieces and collect the data from input buttons, some of the data is also processed
// to be compatable with our querry system requerments, the filteredData is adjusted to contain the new data - Angelos
void RealoadEvent(){
  // setup place holder values
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
  } 
  else {
    selectedAriivalStation = null;
  }
  
  
  if(dropDownList.get(1).currentlySelectedElement != -1)
  {
    selectedDepartureStation = dropDownList.get(1).elements[dropDownList.get(1).currentlySelectedElement];
  } 
  else {
    selectedDepartureStation = null;
  }

  // Process user date range input
  String DateRange = null;
  if((startDate.textValue != null || startDate.textValue != startDate.normal) && (endDate.textValue != null || endDate.textValue != endDate.normal))
  {
    String date1 = screen.adjustDateInput(startDate.textValue);
    String date2 = screen.adjustDateInput(endDate.textValue);
    DateRange = date1 +" - "+ date2;
  }

  
  QueriesSelect selectQuery = new QueriesSelect();
  filteredData = selectQuery.getRowsDisplay(depTime, num1, num2, selectedAriivalStation, selectedDepartureStation);
>>>>>>> 825a3c48fea1a9b5c4237c0214692b04d5ce3b5d
  // screen setup
  screen.numberOfPages = (int)(filteredData.size() / 10); // number of pages = the number of pages that we need to display the data
  screen.numberOfPages++; // add 1 to take into account 0, i.e what if we have 7 elements to display, we still need 1 page
  screen.selectedPage = 1;
<<<<<<< HEAD
}

// check user scroll input, and apply the scroll to all active drop down buttons, inactive drop down buttons simply ignore this call - Angelos
void mouseWheel(MouseEvent event) {
  for (int i = 0; i < dropDownList.size(); i++) {
    dropDownList.get(i).scroll((int)event.getCount());
  }
  ThemeSelection.scroll((int)event.getCount());
}

// checks if the any buttons that can accept text input are active, if yes, it sends them the input to be processed - Angelos
void keyPressed() {
  for (int i = 0, n = textBoxList.size(); i < n; i++) {
    if (textBoxList.get(i).active) {
      textBoxList.get(i).input(key);
    }
  }
  if(ThemeSelection.amIActive)
  {
    ThemeSelection.searchBarinput(key);
  }
  for (int i = 0; i < dropDownList.size(); i++) 
  {
    if(dropDownList.get(i).amIActive)
    {
      dropDownList.get(i).searchBarinput(key);
    }
  }
}

// Updates the user tabs at the top of the screen to reflect which tab is currently active and deactivate all other tabs - Angelos
void updateTabs() {
  for (int i = 0; i < TabButtons.size(); i++) {
    if (TabButtons.get(i).active) {
=======
  
}


// check user scroll input, and apply the scroll to all active drop down buttons, inactive drop down buttons simply ignore this call - Angelos
void mouseWheel(MouseEvent event){
  for(int i = 0; i < dropDownList.size(); i++)
  {
    dropDownList.get(i).scroll((int)event.getCount());
  }
}


// Updates the user tabs at the top of the screen to reflect which tab is currently active and de activate all other tabs - Angelos
void updateTabs(){
  for(int i = 0; i < TabButtons.size(); i++)
  {
    if(TabButtons.get(i).active)
    {
>>>>>>> 825a3c48fea1a9b5c4237c0214692b04d5ce3b5d
      currentlyActiveTab = i;
    }
  }
}

<<<<<<< HEAD
// takes the input of the themes button and returns the selected enum
// In java there are better ways to do this, but with processing this is as good as it gets - Angelos
THEMES stringToEnum(String input) {
    switch(input) {
        case "DEFAULT":
            return THEMES.DEFAULT;
        case "GIRLBOSS":
            return THEMES.GIRLBOSS;
        case "BOYBOSS":
            return THEMES.BOYBOSS;
        case "DAY":
            return THEMES.DAY;
        case "DUSK":
            return THEMES.DUSK;
        case "COSMIC":
            return THEMES.COSMIC;
        case "RUST":
            return THEMES.RUST;
        case "MARINE":
            return THEMES.MARINE;
        case "STELLAR":
            return THEMES.STELLAR;
        case "COLOURBLIND":
            return THEMES.COLOURBLIND;
        default:
            return THEMES.DEFAULT;
    }
}
// This function simply ensures that only one of the 3 radio buttons at the bottom of the buttons display is active
// And that if the user clicks on an active one they are all disabled - Angelos

/*
void radioButtonsFlightStatus() {
 if (cancelledFlights.isClicked()) {
 if (!cancelledFlights.active) {
 cancelledFlights.active = true;
 delayedFlights.active = false;
 undisturbedFlights.active = false;
 } else {
 cancelledFlights.active = false;
 delayedFlights.active = false;
 undisturbedFlights.active = false;
 }
 }
 if (delayedFlights.isClicked()) {
 if (!delayedFlights.active) {
 cancelledFlights.active = false;
 delayedFlights.active = true;
 undisturbedFlights.active = false;
 } else {
 cancelledFlights.active = false;
 delayedFlights.active = false;
 undisturbedFlights.active = false;
 }
 }
 if (undisturbedFlights.isClicked()) {
 if (!undisturbedFlights.active) {
 cancelledFlights.active = false;
 delayedFlights.active = false;
 undisturbedFlights.active = true;
 } else {
 cancelledFlights.active = false;
 delayedFlights.active = false;
 undisturbedFlights.active = false;
 }
 }
}
*/



void mousePressed()
{ 
  if (graphA.hoveredNode != null) 
  {
    graphA.selectAirport();
    graphA.isDragging = true;
    graphA.offsetX = mouseX - graphA.hoveredNode.x;
    graphA.offsetY = mouseY - graphA.hoveredNode.y;
  } 
  else
  graphA.deselectAirport();
}

void mouseReleased()
{
  // Stop dragging when the mouse is released
  graphA.isDragging = false;
}

void mouseMoved()
{
  graphA.hoveredNode = graphA.getNodeUnderMouse();
}

void mouseDragged() {
  if (graphA.isDragging && graphA.hoveredNode != null)
  {
    // Calculate the difference between the current and previous mouse positions
    float deltaX = mouseX - pmouseX;
    float deltaY = mouseY - pmouseY;
     // Update position of the main dragged node
    graphA.hoveredNode.x += deltaX;
    graphA.hoveredNode.y += deltaY;

    // Update positions of connected nodes (neighbors)
    for (AirportNode neighbor : graphA.hoveredNode.neighbors.keySet())
    {
      // Calculate dampening factors based on the size of the nodes
      float nodeSizeRatio = graphA.hoveredNode.radius / neighbor.radius; // Calculate size ratio
      float dampeningFactor = 0.2 * nodeSizeRatio; // Adjust the dampening factor based on size ratio
      
      // Apply dampening effect to the movement of connected nodes
      float neighborDeltaX = deltaX * dampeningFactor; // Apply dampening to the horizontal movement
      float neighborDeltaY = deltaY * dampeningFactor; // Apply dampening to the vertical movement
      
      // Update position of the connected node
      neighbor.x += neighborDeltaX;
      neighbor.y += neighborDeltaY;
      
      // Update positions of nodes connected to the connected node
      for (AirportNode nestedNeighbor : neighbor.neighbors.keySet()) {
        // Calculate nested dampening factors based on the size of the nodes
        float nestedNodeSizeRatio = neighbor.radius / nestedNeighbor.radius; // Calculate size ratio
        float nestedDampeningFactor = 0.1 * nestedNodeSizeRatio; // Adjust the nested dampening factor based on size ratio
        
        // Apply further dampening effect to the movement of nested connected nodes
        float nestedNeighborDeltaX = neighborDeltaX * nestedDampeningFactor; // Apply dampening to the horizontal movement
        float nestedNeighborDeltaY = neighborDeltaY * nestedDampeningFactor; // Apply dampening to the vertical movement
       
        // Update position of the nested connected node
        nestedNeighbor.x += nestedNeighborDeltaX;
        nestedNeighbor.y += nestedNeighborDeltaY;
      }
    }
    
      // Update the original mouse position
    graphA.offsetX = mouseX - graphA.hoveredNode.x;
    graphA.offsetY = mouseY - graphA.hoveredNode.y;
=======

// In modern java an enum can be associated to a number, not in processing, this function converts the index of the theme that the user has selected
// in the theme selection button to the curresponding theme in the enum, this is a product of using processing unfortunetly
THEMES indexToTheme(int index)
{
  switch(index)
  {
    case 1:
      return THEMES.GIRLBOSS;
    case 2:
      return THEMES.BOYBOSS;
    case 3:
      return THEMES.DAY;
    case 4:
      return THEMES.NIGHT;
    default:
      return THEMES.DEFAULT;
>>>>>>> 825a3c48fea1a9b5c4237c0214692b04d5ce3b5d
  }
}
