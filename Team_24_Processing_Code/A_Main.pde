// IMPORT FILES
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.regex.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

// THEMES

enum THEMES
{
  DEFAULT,
    GIRLBOSS,
    BOYBOSS,
    DAY,
    DUSK,
    COSMIC,
    RUST,
    MARINE,
    STELLAR,
    COLOURBLIND
}
String themeNames[] = new String[] {"DEFAULT", "GIRLBOSS", "BOYBOSS", "DAY", "DUSK", "COSMIC", "RUST", "MARINE", "STELLAR", "COLOURBLIND"};
WidgetDropDown ThemeSelection;

// STATIC SETUP VARIABLE
static ArrayList<WidgetTextBox> textBoxList = new ArrayList<WidgetTextBox>();
static ArrayList<WidgetButton> buttonList = new ArrayList<WidgetButton>();
static ArrayList<WidgetDropDown> dropDownList = new ArrayList<WidgetDropDown>();
static ArrayList<WidgetButton> TabButtons = new ArrayList<WidgetButton>(); // Tab buttons are in a separate list to control their render order

static WidgetButton ReloadButton;
static WidgetButton moveLeft;
static WidgetButton moveRight;

static WidgetButton cancelledFlights;
static WidgetButton delayedFlights;
static WidgetButton undisturbedFlights;

static WidgetTextBox startDate;
static WidgetTextBox endDate;

static boolean[] statsShown = new boolean[18];
color ON = color(100, 255, 100);
color OFF = color(255, 100, 100);
PFont TextBoxFont, headingFont;
ArrayList<DisplayDataPoint> filteredData;

Screen screen = new Screen();
int currentlyActiveTab = 0;
boolean isDropDownActive = false;
int WIDGET_ROUNDNESS = 10;

enum WIDGET_TEXT_TYPE {
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

// SETUP FUNCTION
void setup() {
  fullScreen();

  // THEME SETUP
  screen.changeTheme(THEMES.DEFAULT);
  ThemeSelection = new WidgetDropDown(width / 6, 0, 200, 40, TextBoxFont, themeNames);
  ThemeSelection.currentlySelectedElement = 0;
  // DATA SETUP
  QueriesInitial setupQuery = new QueriesInitial();
  setupQuery.createDatabase();
  setupQuery.useDatabase();
  setupQuery.dropAndCreateTable();
  setupQuery.insertRows();

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
  WidgetDropDown departures = new WidgetDropDown((int) (width * 0.13), (int) (height * 0.6), 200, 50, TextBoxFont, arrivalAirports);
  dropDownList.add(departures);
  WidgetDropDown arrivals = new WidgetDropDown((int) (width * 0.13), (int) (height * 0.52), 200, 50, TextBoxFont, departureAirports);
  dropDownList.add(arrivals);

  // RELOAD BUTTON SETUP
  ReloadButton = new WidgetButton((int) (width * 0.025), (int) (height * 0.88), 400, 75, 1);

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
  moveLeft = new WidgetButton(1100, 1000, 50, 50, 5);
  moveRight = new WidgetButton(1300, 1000, 50, 50, 5);
  /*
  cancelledFlights = new WidgetButton(width/20, height / 10 * 7, 50, 50, 20);
   delayedFlights = new WidgetButton(width/20 * 2, height / 10 * 7, 50, 50, 20);
   undisturbedFlights = new WidgetButton(width/20 * 3, height / 10 * 7, 50, 50, 20);
   */
  // Tab 1 setup
  // please do not move this outside of setup void, for some reason processing does not like that

  // Tab 2 setup

  // GRAPH SETUP
  QueriesSelect queries = new QueriesSelect();
  valuesB = queries.getRowsBarGraph();
  valuesP = queries.getRowsPieChart();
  valuesDS = queries.getBusyRoutes();
  valuesA = queries.getAllRoutes();

  graphB = new GraphBar(600, 250, 1200, 700);
  graphP = new GraphPie(1300, 560, 800, 800);
  graphD = new DensityGraph(800, 150, 1200, 700);
  graphS = new SimpleGraph(600, 500, 1200, 1000);
  // graphA = new AirportGraph(600, 500, 1200, 1000);

  Graph[] graphs = {graphB, graphP, graphD, graphS, graphA};
  screen.numberOfGraphs = graphs.length;
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
  
  switch (currentlyActiveTab) {
  case 0: // user is looking at tab 1
    screen.renderTab1();
    break;
  case 1: // user is looking at tab 2
    screen.renderTab2();
    break;
  default:
    println("Tab not found");
    currentlyActiveTab = 0;
    break;
  }
  ThemeSelection.render();
}

// ADD COMMENT
void mouseClicked() {
  if (ReloadButton.isClicked()) {
    ReloadButton.active = true;
    ReloadButton.render();
    ReloadEvent();
    screen.renderTab1();
    ReloadButton.active = false;
    ReloadButton.render();
  }
  for (int i = 0; i < TabButtons.size(); i++) { // we first investigate if the user is trying to change tabs
    if (TabButtons.get(i).isMouseover()) {  // For every tab button
      TabButtons.get(i).active = true;  // We find the active button
      for (int j = 0; j < TabButtons.size(); j++) {
        if (TabButtons.get(i) != TabButtons.get(j)) { // We disable all other buttons
          TabButtons.get(j).active = false;
        }
      } // This means that that only tab button is on at any given moment, and if the user clicks the same one twice it makes no difference
      break;
    }
  }

  updateTabs();
  screen.pageSelectButtons();
  ThemeSelection.isClicked();
  if (ThemeSelection.currentlySelectedElement == -1) {
    ThemeSelection.currentlySelectedElement = 0;
  }
  screen.changeTheme(indexToTheme(ThemeSelection.currentlySelectedElement));
  if (isDropDownActive) {
    for (int i = 0; i < dropDownList.size(); i++) {
      dropDownList.get(i).isClicked();
    }
  } else {
    for (int i = 0; i < textBoxList.size(); i++) {
      textBoxList.get(i).isClicked();
    }
    for (int i = 0; i < buttonList.size(); i++) {
    }
    for (int i = 0; i < dropDownList.size(); i++) {
      dropDownList.get(i).isClicked();
    }
  }
  //radioButtonsFlightStatus();
}

// checks which tab is currently active and applies a process depending on the scenario
// At the moment this

// creates all query related data pieces and collect the data from input buttons, some of the data is also processed
// to be compatible with our query system requirements, the filteredData is adjusted to contain the new data - Angelos
void ReloadEvent() {
  // setup place holder values
  boolean depTime;
  int num1;
  int num2;

  String selectedArrivalStation = "";
  String selectedDepartureStation = "";
  String date1 = null;
  String date2 = null;

  // TIME SELECTION
  // call the time inputs from the departure and arrival time selection buttons
  if ((textBoxList.get(2).textValue != textBoxList.get(2).normal) && (textBoxList.get(3).textValue != textBoxList.get(3).normal))
  { // if departure airport time selection has a valid input
    num1 = Integer.parseInt(textBoxList.get(2).giveProcessedUserInput());
    num2 = Integer.parseInt(textBoxList.get(3).giveProcessedUserInput());
    textBoxList.get(4).textValue = textBoxList.get(4).normal; // we flush the other time selection buttons in case the user has inputted anything there
    textBoxList.get(5).textValue = textBoxList.get(5).normal;
    depTime = false;
  } else if ((textBoxList.get(4).textValue != textBoxList.get(4).normal) && (textBoxList.get(5).textValue != textBoxList.get(5).normal))
  { // if arrival airport time selection has a valid input
    num1 = Integer.parseInt(textBoxList.get(4).giveProcessedUserInput());
    num2 = Integer.parseInt(textBoxList.get(5).giveProcessedUserInput());
    textBoxList.get(2).textValue = textBoxList.get(2).normal; // we flush the other time selection buttons in case the user has inputted anything there
    textBoxList.get(3).textValue = textBoxList.get(3).normal;
    depTime = true;
  } else
  {
    // we flush all time selection buttons in case the user has inputted anything there that is incomplete and as such invalid
    num1 = 0000;
    num2 = 0000;
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
    println("The input i got for time selection is: \n date1 = " + date1 + "\ndate2 = " + date2);
  } else
  {
    // if the user did not give a full date seelction we empty date selection, the dates are left null
    textBoxList.get(0).userInputInvalid();
    textBoxList.get(1).userInputInvalid();
  }


  // AIRPORT SELECTION
  // If the drop down has a selected item on it, selectedArrivalStation stores it
  if (dropDownList.get(0).currentlySelectedElement != -1) {
    selectedArrivalStation = dropDownList.get(0).elements[dropDownList.get(0).currentlySelectedElement];
  } else { // or else it becomes null
    selectedArrivalStation = null;
  }
  // Repeat for departure station
  if (dropDownList.get(1).currentlySelectedElement != -1) {
    selectedDepartureStation = dropDownList.get(1).elements[dropDownList.get(1).currentlySelectedElement];
  } else {
    selectedDepartureStation = null;
  }

  QueriesSelect selectQuery = new QueriesSelect();
  if (date1 == null) {
    println("test case passed for date1");
  } else {
    println(date1);
  }
  if (date2 == null) {
    println("test case passed for date2");
  } else {
    println(date2);
  }
  filteredData = selectQuery.getRowsDisplay(depTime, num1, num2, selectedArrivalStation, selectedDepartureStation, date1, date2);


  // screen setup
  screen.numberOfPages = (int)(filteredData.size() / 10); // number of pages = the number of pages that we need to display the data
  screen.numberOfPages++; // add 1 to take into account 0, i.e what if we have 7 elements to display, we still need 1 page
  screen.selectedPage = 1;
}

// check user scroll input, and apply the scroll to all active drop down buttons, inactive drop down buttons simply ignore this call - Angelos
void mouseWheel(MouseEvent event) {
  for (int i = 0; i < dropDownList.size(); i++) {
    dropDownList.get(i).scroll((int)event.getCount());
  }
  ThemeSelection.scroll((int)event.getCount());
}

void keyPressed() {
  int keyIndex = -1;
  for (int i = 0, n = textBoxList.size(); i < n; i++) {
    if (textBoxList.get(i).active) {
      textBoxList.get(i).input(key);
    }
  }
}

// Updates the user tabs at the top of the screen to reflect which tab is currently active and deactivate all other tabs - Angelos
void updateTabs() {
  for (int i = 0; i < TabButtons.size(); i++) {
    if (TabButtons.get(i).active) {
      currentlyActiveTab = i;
    }
  }
}

// In modern java an enum can be associated to a number, not in processing, this function converts the index of the theme that the user has selected
// in the theme selection button to the corresponding theme in the enum, this is a product of using processing unfortunately (I'm assuming this was Angelos)
THEMES indexToTheme(int index) {
  switch(index) {
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
