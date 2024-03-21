import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.regex.*;

static ArrayList<RawDataPoint> allDatapoints = new ArrayList<RawDataPoint>();
static ArrayList<WidgetTextBox> textBoxList = new ArrayList<WidgetTextBox>();
Screen screen1 = new Screen();
static boolean[] statsShown = new boolean[18];

PFont TextBoxFont;

void setup() {

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
  
  WidgetTextBox departureTimeSelections = new WidgetTextBox(screen1.HORIZONTAL_DISTANCE_FROM_WALL, screen1.VERTICAL_DISTANCE_FROM_WALL, screen1.WIDTH_B, screen1.HEIGHT_B, TextBoxFont);
  textBoxList.add(departureTimeSelections);
  WidgetTextBox ArrivalTimeSelections = new WidgetTextBox(screen1.HORIZONTAL_DISTANCE_FROM_WALL, screen1.VERTICAL_DISTANCE_FROM_WALL + 500, screen1.WIDTH_B, screen1.HEIGHT_B, TextBoxFont);
  textBoxList.add(ArrivalTimeSelections);
  
  fullScreen();
}

// Setup Display Objects
byte currentlyActiveTab = 0;
boolean isDropDownActive = false;

void draw(){
  background(255,255,255);
  
}

void mouseClicked(){
  if(currentlyActiveTab == 0) // what buttons and textboxes should the programme watch out for
  {
    if(isDropDownActive)
    {
      // todo
    } else 
    {
      for(int i  = 0; i < textBoxList.size(); i++)
      {
        textBoxList.get(i).isClicked();
      }
    }
  }
}
void keyPressed(){
    switch(currentlyActiveTab) 
    {
      case 0:   // User is on tab 1
        if (isAnyTab1UIActive())  // check if there is any active button on screen
        {
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
}

boolean isAnyTab1UIActive()
  {
    for(int i  = 0; i < textBoxList.size(); i++)
      {
        if(textBoxList.get(i).active)
        {
          return true;
        }
      }
      return false;
  }
