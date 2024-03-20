import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Scanner;
import java.util.ArrayList;

static ArrayList<TimeTextbox> textBoxList = new ArrayList<TimeTextbox>();

// Read username and password from a file in "Team_24_Processing_Code\creds.csv". This is in the .gitignore to prevent publishing it.
// To make this work you MUST create a creds.csv file in the Team_24_Processing_Code folder with contents: "username,password" without the quotes and no space after the comment.

void setup() {
<<<<<<<< HEAD:Team_24_Processing_Code/A_CSV_Data_Loader.pde
  // Display setup
  // Tab 1 setup
  // please do not move this outside of setup void, for some reason processing does not likey likey that
  TimeTextbox departureTimeSelections = new TimeTextbox(DisplayMaster.HORIZONTAL_DISTANCE_FROM_WALL, DisplayMaster.VERTICAL_DISTANCE_FROM_WALL, DisplayMaster.WIDTH_B, DisplayMaster.HEIGHT_B);
  textBoxList.add(departureTimeSelections);
  TimeTextbox ArrivalTimeSelections = new TimeTextbox(DisplayMaster.HORIZONTAL_DISTANCE_FROM_WALL, DisplayMaster.VERTICAL_DISTANCE_FROM_WALL + 500, DisplayMaster.WIDTH_B, DisplayMaster.HEIGHT_B);
  textBoxList.add(ArrivalTimeSelections);
  
  //DisplayMaster.renderTestButton();
  //println("1");

  
  String filename = sketchPath() + "/flights2k.csv";
  String delimiter = ",";
========
>>>>>>>> 696ac417465ad7c0fd3aa93898752119a6076a8a:Team_24_Processing_Code/Main.pde

  // Display setup
  
  // Tab 1 setup
  // please do not move this outside of setup void, for some reason processing does not likey likey that
/*  TimeTextbox departureTimeSelections = new TimeTextbox(DisplayMaster.HORIZONTAL_DISTANCE_FROM_WALL, DisplayMaster.VERTICAL_DISTANCE_FROM_WALL, DisplayMaster.WIDTH_B, DisplayMaster.HEIGHT_B);
  textBoxList.add(departureTimeSelections);
  TimeTextbox ArrivalTimeSelections = new TimeTextbox(DisplayMaster.HORIZONTAL_DISTANCE_FROM_WALL, DisplayMaster.VERTICAL_DISTANCE_FROM_WALL + 500, DisplayMaster.WIDTH_B, DisplayMaster.HEIGHT_B);
  textBoxList.add(ArrivalTimeSelections);
  
  fullScreen();
}
// Setup Display Objects
byte currentlyActiveTab = 0;
DisplayMaster DisplayMaster = new DisplayMaster();
// Tab 1 objects
boolean isDropDownActive = false;

String[] parseCSVLine(String line) {
  // Split line by commas, taking into account quoted values
  String[] parts = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)");

  // Remove surrounding quotes from each part
  for (int i = 0; i < parts.length; i++) {
    parts[i] = parts[i].replaceAll("^\"|\"$", "");
  }

  return parts;*/
}
void draw(){
  println();
  /*background(255,255,255);
  if(currentlyActiveTab == 0)
  {
  DisplayMaster.renderDIP();
  }
  DisplayMaster.renderQuitButton();*/
}
/*void mouseClicked(){
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
  }*/
