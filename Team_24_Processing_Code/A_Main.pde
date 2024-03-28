//IMPORT FILES
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.regex.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


// THEMSE
enum THEMES
  {
    DEFAULT,
    GIRLBOSS,
    BOYBOSS,
    DAY,
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

static WidgetButton ReloadButton;
static WidgetButton moveLeft;
static WidgetButton moveRight;

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


ArrayList<BarDataPoint> valuesB;
GraphBar graphB;

ArrayList<PieDataPoint> valuesP;
GraphPie graphP;
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
  
  
  //TAB BUTTON SETUP
  int totalTabWidth = screen.TAB_WIDTH + screen.TAB_BORDER_WIDTH;
  int tabRange = width - totalTabWidth;

  for(int i = 0; i < 3; i++) // We lerp through the upper tab, adding the tab buttons at intervals to make sure they are equally spaced
  {
    int x = (int)(lerp(totalTabWidth, width, (float)(((float)i / (float)3))));    // We use lerop to find the range of the buttons and add them;
    TabButtons.add(new WidgetButton(x,0,tabRange/3, (int)(height / 10), 0));
  }
  TabButtons.get(0).active = true; // Tab 1 is on by default at the start
  
  //SCROLL BUTTON SETUP
  moveLeft = new WidgetButton(1100, 1000, 50, 50, 5);
  moveRight = new WidgetButton(1300, 1000, 50, 50, 5);
  
  //RELOAD BUTTON SETUP
  ReloadButton = new WidgetButton(50, 50, 50, 50, 1);
 
  // Tab 1 setup
  // please do not move this outside of setup void, for some reason processing does not likey likey that
  
  // Tab 2 setup
    
  //GRAPH SETUP
  QueriesSelect queries = new QueriesSelect();
  valuesB = queries.getRowsBarGraph();
  graphB = new GraphBar(600, 250, 1200, 700);
  valuesP = queries.getRowsPieChart();
  graphP = new GraphPie(1300, 560, 800, 800);
  
  Graph[] graphs = {graphB, graphP};
}


void draw(){
  
  background(screen.BACKGROUND);
  
  moveLeft.render();
  moveRight.render();
  // REMINDER: from now on buttons and the tab on the left on the screen are always the same regardless of selected tab
  // User tab selection only effects everything on the right
  screen.renderDIP();

  //ThemeSelection.render();
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
  ReloadButton.render();
}


//ADD COMMENT
void mouseClicked()
{
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
  hasUserChangedPage();
  /*ThemeSelection.isClicked();
  if(ThemeSelection.currentlySelectedElement == -1)
  {
    ThemeSelection.currentlySelectedElement = 0;
  }
  screen.changeTheme(indexToTheme(ThemeSelection.currentlySelectedElement));*/
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
//<<<<<<< HEAD
/*void keyPressed(){ // todo, lots of this code is redudant since the user always has access to the buttons
=======


// checks which tab is currently active and applies a process depending on the scenario
// At the moment this 
void keyPressed(){ // todo, lots of this code is redudant since the user always has access to the buttons
>>>>>>> d41bd2aa2b6659da3ee33ed79aeb0121c813b11b
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
}*/


// creates all querry related data pieces and collect the data from input buttons, some of the data is also processed
// to be compatable with our querry system requerments, the filteredData is adjusted to contain the new data - Angelos
void RealoadEvent(){
  // setup place holder values
  boolean depTime;
  int num1;
  int num2;
  
  String selectedAriivalStation = "";
  String selectedDepartureStation = "";
  String date1 = "";
  String date2 = "";
  
  
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
  if((startDate.textValue != null || startDate.textValue != startDate.normal) && (endDate.textValue != null || endDate.textValue != endDate.normal))
  {
    date1 = screen.adjustDateInput(startDate.textValue);
    date2 = screen.adjustDateInput(endDate.textValue);
  }
  
  QueriesSelect selectQuery = new QueriesSelect();
  filteredData = selectQuery.getRowsDisplay(depTime, num1, num2, selectedAriivalStation, selectedDepartureStation, date1, date2);
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

// ADD COMMENT
void hasUserChangedPage(){
  if(moveLeft.isClicked())
  {
    switch(currentlyActiveTab)
    {
      case 0:
        screen.selectedPage--;
        if(screen.selectedPage <= 0)
          screen.selectedPage = 1;
        break;
      case 1:
        displayedGraph--;
        if(displayedGraph < 0)
          displayedGraph = 1;
        break;
      default:
        println("No function");
        break;
    }
  }
  
  if(moveRight.isClicked())
  {
    switch(currentlyActiveTab)
    {
      case 0:
        screen.selectedPage++;
        if(screen.selectedPage > screen.numberOfPages)
          screen.selectedPage = screen.numberOfPages;
        break;
      case 1:
        displayedGraph++;
        if(displayedGraph > 1)
          displayedGraph = 0;
        break;
      default:
        println("No function");
        break;
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
      return THEMES.NIGHT;
    default:
      return THEMES.DEFAULT;
  }
}
