import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Scanner;
import java.util.ArrayList;

static ArrayList<RawDatapoint> allDatapoints = new ArrayList<RawDatapoint>();
static ArrayList<Widget_TextBox> textBoxList = new ArrayList<Widget_TextBox>();
Screen screen1 = new Screen();

static boolean[] statsShown = new boolean[18];

// Read username and password from a file in "Team_24_Processing_Code\creds.csv". This is in the .gitignore to prevent publishing it.
// To make this work you MUST create a creds.csv file in the Team_24_Processing_Code folder with contents: "username,password" without the quotes and no space after the comment.

void setup() {
  // Display setup
  // Tab 1 setup
  // please do not move this outside of setup void, for some reason processing does not likey likey that

  // MySQL database connection parameters
  String filename = sketchPath() + "/flights2k.csv";
  String url = "jdbc:mysql://localhost:3306/programming_project";
  String username = "";
  String password = "";
  try {
    BufferedReader credsFile = new BufferedReader(new FileReader(sketchPath() + "/creds.csv"));
    Scanner credsScanner = new Scanner(credsFile);
    credsScanner.useDelimiter(",");
    username = credsScanner.next();
    password = credsScanner.next();
    credsScanner.close();
    credsFile.close();
  }
  catch (Exception e) {
    println("Error cannot find file creds.csv");
    exit();
  }


  // Connect to MySQL
  try {
    
    Connection connection = DriverManager.getConnection(url, username, password);
    Statement statement = connection.createStatement();

    BufferedReader reader = new BufferedReader(new FileReader(filename));
    boolean skipHeader = true;
    while (reader.ready()) {
      String line = reader.readLine();
      if (skipHeader) {
        skipHeader = false;
        continue; // Skip the header row
      }

      String[] data = parseCSVLine(line);

      // Construct and execute the INSERT INTO statement
      String query = "INSERT INTO flight_data (FL_DATE, MKT_CARRIER, MKT_CARRIER_FL_NUM, ORIGIN, ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, ORIGIN_WAC, DEST, DEST_CITY_NAME, DEST_STATE_ABR, DEST_WAC, CRS_DEP_TIME, DEP_TIME, CRS_ARR_TIME, ARR_TIME, CANCELLED, DIVERTED, DISTANCE) VALUES (";
      for (int i = 0; i < data.length; i++) {
        if (data[i].isEmpty()) {
          query += "NULL";
        } else {
          if (i == 2 || i == 6 || i == 11 || i == 12 || i == 13 || i == 14 || i == 15 || i == 16 || i == 17) { // Integer fields
            query += Integer.parseInt(data[i]);
          } else {
            query += "'" + data[i] + "'";
          }
        }
        if (i < data.length - 1) {
          query += ",";
        }
      }
      query += ")";

      statement.executeUpdate(query);
    }

    // Close connections
    statement.close();
    connection.close();

    println("Data inserted successfully!");
  }
  catch (Exception e) {
    e.printStackTrace();
  }
  
  //Make Datapoints
  
  for;
  
  // Display setup
  
  // Tab 1 setup
  // please do not move this outside of setup void, for some reason processing does not likey likey that
  Widget_TextBox departureTimeSelections = new Widget_TextBox(screen1.HORIZONTAL_DISTANCE_FROM_WALL, screen1.VERTICAL_DISTANCE_FROM_WALL, screen1.WIDTH_B, screen1.HEIGHT_B);
  screen1.addElement(departureTimeSelections);
  Widget_TextBox ArrivalTimeSelections = new Widget_TextBox(screen1.HORIZONTAL_DISTANCE_FROM_WALL, screen1.VERTICAL_DISTANCE_FROM_WALL + 500, screen1.WIDTH_B, screen1.HEIGHT_B);
  screen1.addElement(ArrivalTimeSelections);
  
  Widget_Button quitButton = new Widget_Button(20, 20, 50, 50, 0);
  screen1.addElement(quitButton);
  
  fullScreen();
}
// Setup Display Objects
byte currentlyActiveTab = 0;
// Tab 1 objects
boolean isDropDownActive = false;

String[] parseCSVLine(String line) {
  // Split line by commas, taking into account quoted values
  String[] parts = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)");

  // Remove surrounding quotes from each part
  for (int i = 0; i < parts.length; i++) {
    parts[i] = parts[i].replaceAll("^\"|\"$", "");
  }

  return parts;
}
void draw(){
  background(255,255,255);
  screen1.draw();
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
