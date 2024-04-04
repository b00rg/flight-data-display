//IMPORT FILES
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.regex.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

//changes

// THEMES
enum THEMES
  {
    DEFAULT,
    GIRLBOSS,
    BOYBOSS,
    DAY,
    DUSK,
    CUSTOM_THEME,
    COSMIC,
    RUST,
    MARINE,
    STELLAR,
    COLOURBLIND
  }
String themeNames[] = new String[] {"DEFAULT", "GIRLBOSS", "BOYBOSS", "DAY", "NIGHT", "CUSTOM_THEME", "COSMIC", "RUST", "MARINE", "STELLAR", "COLOURBLIND"};
WidgetDropDown ThemeSelection;

//STATIC SETUP VARIABLE
static ArrayList<WidgetTextBox> textBoxList = new ArrayList<WidgetTextBox>();
static ArrayList<WidgetButton> buttonList = new ArrayList<WidgetButton>();
static ArrayList<WidgetDropDown> dropDownList = new ArrayList<WidgetDropDown>();
static ArrayList<WidgetButton> TabButtons = new ArrayList<WidgetButton>(); // Tab buttons are in a seperate list to control their render order

static WidgetButton ReloadButton;
static WidgetButton moveLeft;
static WidgetButton moveRight;

static WidgetButton cancelledFlights;
static WidgetButton delayedFlights;
static WidgetButton undisturbedFlights;

static WidgetTextBox startDate;
static WidgetTextBox endDate;

static boolean[] statsShown = new boolean[18];
color ON = color(100,255,100);
color OFF = color(255,100,100);
PFont TextBoxFont, headingFont;
ArrayList<DisplayDataPoint> filteredData;

Screen screen = new Screen();
int currentlyActiveTab = 0;
boolean isDropDownActive = false;
int WIDGET_ROUNDNESS = 10;

enum WIDGET_TEXT_TYPE{
  TIME,
  DATE
}

ArrayList<BarDataPoint> valuesB;
GraphBar graphB;

ArrayList<PieDataPoint> valuesP;
GraphPie graphP;

ArrayList<RouteDataPoint> valuesDS;
DensityGraph graphD;
SimpleGraph graphS;

ArrayList<RouteDataPoint> valuesA;
Graph graphA;

int displayedGraph = 0;

//SETUP FUNCTION
void setup() {
  fullScreen();

  // THEME SETUP
  screen.changeTheme(THEMES.DEFAULT);
  //DATA SETUP
  QueriesInitial setupQuery = new QueriesInitial();
  setupQuery.createDatabase();
  setupQuery.useDatabase();
  setupQuery.dropAndCreateTable();
  setupQuery.insertRows();

  TextBoxFont = loadFont("default.vlw");
  headingFont = loadFont("Heading.vlw");

  //DATE TEXT BOX SETUP
  startDate = new WidgetTextBox((int) (width * 0.08), (int) (height * 0.1), screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "DD/MM/YYYY", WIDGET_TEXT_TYPE.DATE);
  endDate = new WidgetTextBox((int) (width * 0.17), (int) (height * 0.1), screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "DD/MM/YYYY", WIDGET_TEXT_TYPE.DATE);
  textBoxList.add(startDate);
  textBoxList.add(endDate);
  
  //TEXTBOX SETUP
  WidgetTextBox departureLowerSelection = new WidgetTextBox((int) (width * 0.08), (int) (height * 0.25), screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "??:??", WIDGET_TEXT_TYPE.TIME);
  WidgetTextBox departureUpperSelection = new WidgetTextBox((int) (width * 0.17), (int) (height * 0.25), screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "??:??", WIDGET_TEXT_TYPE.TIME);
  WidgetTextBox arrivalLowerSelection = new WidgetTextBox((int) (width * 0.08), (int) (height * 0.35), screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "??:??", WIDGET_TEXT_TYPE.TIME);
  WidgetTextBox arrivalUpperSelection = new WidgetTextBox((int) (width * 0.17), (int) (height * 0.35), screen.WIDTH_B, screen.HEIGHT_B, WIDGET_ROUNDNESS, TextBoxFont, "??:??", WIDGET_TEXT_TYPE.TIME);
  textBoxList.add(departureLowerSelection);
  textBoxList.add(departureUpperSelection);
  textBoxList.add(arrivalLowerSelection);
  textBoxList.add(arrivalUpperSelection);
  
  //AIRPORT DROP DOWN SETUP
  QueriesSelect selectQuery = new QueriesSelect();
  String[] departureAirports = selectQuery.getDepartureAirports();
  String[] arrivalAirports = selectQuery.getArrivalAirports();  
  WidgetDropDown departures = new WidgetDropDown((int) (width * 0.13), (int) (height * 0.6), 200, 50, TextBoxFont, arrivalAirports);
  dropDownList.add(departures);
  WidgetDropDown arrivals = new WidgetDropDown((int) (width * 0.13), (int) (height * 0.52), 200, 50, TextBoxFont, departureAirports);
  dropDownList.add(arrivals);
  
  //RELOAD BUTTON SETUP
  ReloadButton = new WidgetButton((int) (width * 0.025),(int) (height * 0.88), 400, 75, 1);
  
  //TAB BUTTON SETUP
  int totalTabWidth = screen.TAB_WIDTH + screen.TAB_BORDER_WIDTH;
  int tabRange = width - totalTabWidth;

  for(int i = 0; i < 3; i++) // We lerp through the upper tab, adding the tab buttons at intervals to make sure they are equally spaced
  {
    int x = (int)(lerp(totalTabWidth, width, (float)(((float)i / (float)3))));    // We use lerop to find the range of the buttons and add them;
    TabButtons.add(new WidgetButton(x,0,tabRange/3, (int)(height / 10), 0));
  }
  TabButtons.get(0).active = true; // Tab 1 is on by default at the start
  
  // THEME BUTTON SETUP
  ThemeSelection = new WidgetDropDown(250, 30, 200, 50, TextBoxFont, themeNames);
  ThemeSelection.currentlySelectedElement = 0;
  
  //SCROLL BUTTON SETUP
  moveLeft = new WidgetButton(1100, 1000, 50, 50, 5);
  moveRight = new WidgetButton(1300, 1000, 50, 50, 5);
  

  cancelledFlights = new WidgetButton(width/20, height / 10 * 7,50, 50, 20);
  delayedFlights = new WidgetButton(width/20 * 2, height / 10 * 7, 50, 50, 20);
  undisturbedFlights = new WidgetButton(width/20 * 3, height / 10 * 7, 50, 50, 20);

  // Tab 1 setup
  // please do not move this outside of setup void, for some reason processing does not likey likey that
  
  // Tab 2 setup
    
  //GRAPH SETUP
  QueriesSelect queries = new QueriesSelect();
  valuesB = queries.getRowsBarGraph();
  valuesP = queries.getRowsPieChart();
  valuesDS = queries.getBusyRoutes();
  valuesA = queries.getAllRoutes();
  
  graphB = new GraphBar(600, 250, 1200, 700);
  graphP = new GraphPie(1300, 560, 800, 800);
  graphD = new DensityGraph(800, 150, 1200, 700);
  graphS = new SimpleGraph(600, 500, 1200, 1000);
  //graphA = new AirportGraph(600, 500, 1200, 1000);
  
  Graph[] graphs = {graphB, graphP, graphD, graphS, graphA};
  screen.numberOfGraphs = graphs.length;
}


void draw(){
  
  background(screen.BACKGROUND);
  
  noStroke();
  
  moveLeft.render();
  moveRight.render();
  // REMINDER: from now on buttons and the tab on the left on the screen are always the same regardless of selected tab
  // User tab selection only effects everything on the right
  screen.renderDIP();
  //ThemeSelection.render();
  ReloadButton.render();
  cancelledFlights.render();
  delayedFlights.render();
  undisturbedFlights.render();
  
  screen.renderButtons();
  //ThemeSelection.render();

  switch(currentlyActiveTab)
  {
    case 0: // user is looking at tab 1
      screen.renderTab1();
      break;
    case 1: // user is lookingat tab 2
      screen.renderTab2();
      break;
    default:
      println("Tab not found");
      currentlyActiveTab = 0;
      break;
  }
  
}


//ADD COMMENT
void mouseClicked()
{
  if(ReloadButton.isClicked())
  {
    ReloadButton.active = true;
    ReloadButton.render();
    ReloadEvent();
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
  screen.pageSelectButtons();
  ThemeSelection.isClicked();
  if(ThemeSelection.currentlySelectedElement == -1)
  {
    ThemeSelection.currentlySelectedElement = 0;
  }
  screen.changeTheme(indexToTheme(ThemeSelection.currentlySelectedElement));
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
      if (!buttonList.isEmpty() && buttonList.get(0).isClicked())
      {
        indexToTheme(1);
        println("Button 0 has been clicked");
      }
      if (buttonList.get(1).isClicked()){
        indexToTheme(2);
        println("Button 1 has been clicked");
      }
      if (buttonList.get(2).isClicked()){
        indexToTheme(2);
        println("Button 2 has been clicked");
      }
      if (buttonList.get(3).isClicked()){
        indexToTheme(3);
        println("Button 3 has been clicked");
      }
      if (buttonList.get(4).isClicked()){
        indexToTheme(4);
        println("Button 4 has been clicked");
      }
      if (buttonList.get(5).isClicked()) {
        indexToTheme(5);
        println("Button 5 has been clicked");
      }
       if (buttonList.get(6).isClicked()) {
        indexToTheme(6);
        println("Button 6 has been clicked");
      }
       if (buttonList.get(7).isClicked()) {
        indexToTheme(7);
        println("Button 7 has been clicked");
      }
       if (buttonList.get(8).isClicked()) {
        indexToTheme(8);
        println("Button 8 has been clicked");
      }
       if (buttonList.get(9).isClicked()) {
        indexToTheme(9);
        println("Button 9 has been clicked");
      }
    }
    for(int i = 0; i < dropDownList.size(); i++)
    {
      dropDownList.get(i).isClicked();
    }
  }
  radioButtonsFlightStatus();
}

// checks which tab is currently active and applies a process depending on the scenario
// At the moment this 


// creates all querry related data pieces and collect the data from input buttons, some of the data is also processed
// to be compatable with our querry system requerments, the filteredData is adjusted to contain the new data - Angelos
void ReloadEvent(){
  // setup place holder values
  boolean depTime;
  int num1;
  int num2;
  
  String selectedArrivalStation = "";
  String selectedDepartureStation = "";
  String date1 = "";
  String date2 = "";
  
  
  // insert user query values to the right places
  if(textBoxList.get(2).textValue != "??:??"){
    depTime = false;
    num1 = Integer.parseInt(textBoxList.get(2).num1.trim());
    //num2 = Integer.parseInt(textBoxList.get(2).num2.trim());
  } 
  if ((textBoxList.get(3).textValue != "??:??"))
  {
    //depTime = true;
    //num1 = Integer.parseInt(textBoxList.get(4).num1.trim());
    num2 = Integer.parseInt(textBoxList.get(3).num1.trim());
  }
  //else 
  {
    depTime = false; // doesn't matter
    num1 = 0000;
    num2 = 0000;
  }

  
  if(dropDownList.get(0).currentlySelectedElement != -1)
  {
    selectedArrivalStation = dropDownList.get(0).elements[dropDownList.get(0).currentlySelectedElement];
  } 
  else {
    selectedArrivalStation = null;
  }
  
  
  if(dropDownList.get(1).currentlySelectedElement != -1)
  {
    selectedDepartureStation = dropDownList.get(1).elements[dropDownList.get(1).currentlySelectedElement];
  } 
  else {
    selectedDepartureStation = null;
  }

  // Process user date range input
  if((startDate.textValue != null || startDate.textValue != startDate.normal) && (endDate.textValue != null || endDate.textValue != endDate.normal))
  {
    date1 = screen.adjustDateInput(startDate.textValue);
    date2 = screen.adjustDateInput(endDate.textValue);
  }
  // Flight status
  boolean wantsCancelled = cancelledFlights.active;
  QueriesSelect selectQuery = new QueriesSelect();
  filteredData = selectQuery.getRowsDisplay(depTime, num1, num2, selectedArrivalStation, selectedDepartureStation, date1, date2);
  String DateRange = null;
  if((startDate.textValue != null || startDate.textValue != startDate.normal) && (endDate.textValue != null || endDate.textValue != endDate.normal))
  {
    date1 = screen.adjustDateInput(startDate.textValue);
    date2 = screen.adjustDateInput(endDate.textValue);
    DateRange = date1 +" - "+ date2;
  }

  int startTime = millis();
  int endTime = millis();
  int elapsed = endTime - startTime;
  println("It took " + elapsed + " milliseconds to generate the new filtered data array");
  // screen setup
  screen.numberOfPages = (int)(filteredData.size() / 10); // number of pages = the number of pages that we need to display the data
  screen.numberOfPages++; // add 1 to take into account 0, i.e what if we have 7 elements to display, we still need 1 page
  screen.selectedPage = 1;
}


// check user scroll input, and apply the scroll to all active drop down buttons, inactive drop down buttons simply ignore this call - Angelos
void mouseWheel(MouseEvent event){
  for(int i = 0; i < dropDownList.size(); i++)
  {
    dropDownList.get(i).scroll((int)event.getCount());
  }
}

void keyPressed()
{
  int keyIndex = -1;
  for(int i = 0, n = textBoxList.size(); i < n; i++)
  {
    if(textBoxList.get(i).active)
    {
      textBoxList.get(i).input(key);
    }
  }
}

// Updates the user tabs at the top of the screen to reflect which tab is currently active and de activate all other tabs - Angelos
void updateTabs(){
  for(int i = 0; i < TabButtons.size(); i++)
  {
    if(TabButtons.get(i).active)
    {
      currentlyActiveTab = i;
    }
  }
}

// In modern java an enum can be associated to a number, not in processing, this function converts the index of the theme that the user has selected
// in the theme selection button to the curresponding theme in the enum, this is a product of using processing unfortunetly (i'm assuming this was angelos)
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
      return THEMES.DUSK;
    case 5:
      return THEMES.COSMIC;
    case 6:
      return THEMES.RUST;
    case 7:
      return THEMES.MARINE;
    case 8:
      return THEMES.STELLAR;
    case 9:
      return THEMES.COLOURBLIND;
    default:
      return THEMES.DEFAULT;
  }
}


// This function simply ensures that only one of the 3 radio buttons at the bottom of the buttons display is active
// And that if the user clicks on an active one they are all disabled - Angelos
void radioButtonsFlightStatus()
  {
      if(cancelledFlights.isClicked())
    {
      if(!cancelledFlights.active)
      {
        cancelledFlights.active = true;
        delayedFlights.active = false;
        undisturbedFlights.active = false;
      } else 
      {
        cancelledFlights.active = false;
        delayedFlights.active = false;
        undisturbedFlights.active = false;
      }
    }
    if(delayedFlights.isClicked())
    {
      if(!delayedFlights.active)
      {
        cancelledFlights.active = false;
        delayedFlights.active = true;
        undisturbedFlights.active = false;
      } else 
      {
        cancelledFlights.active = false;
        delayedFlights.active = false;
        undisturbedFlights.active = false;
      }
    }
    if(undisturbedFlights.isClicked())
    {
      if(!undisturbedFlights.active)
      {
        cancelledFlights.active = false;
        delayedFlights.active = false;
        undisturbedFlights.active = true;
      } else 
      {
        cancelledFlights.active = false;
        delayedFlights.active = false;
        undisturbedFlights.active = false;
      }
    }
  }
