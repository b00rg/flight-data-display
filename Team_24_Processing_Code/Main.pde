import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Scanner;
import java.util.ArrayList;


void setup() {

  //DO NOT DELETE
  QueriesInitial setupQuery = new QueriesInitial();
  
  setupQuery.createDatabase();
  setupQuery.useDatabase();
  setupQuery.dropAndCreateTable();
  setupQuery.insertRows();
  //DO NOT DELETE  

  size(500, 500);
  QueriesSelect queries = new QueriesSelect();
  ArrayList<BarDataPoint> values = queries.getRowsBarGraph();
  
  Graph_Bar graph = new Graph_Bar();
  graph.drawBarChart(values);
}
