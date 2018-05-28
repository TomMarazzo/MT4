//+------------------------------------------------------------------+
//|                                          FxTE_Main_Dashboard.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <stdlib.mqh>
#include <stderror.mqh>
//+------------------------------------------------------------------+
//|  ADD THE OTHER CLASSES TO THE MAIN DIOLOG BOX                    |
//+------------------------------------------------------------------+
#include <FxTE_Component.mqh>
#include <MainMenu.mqh>

#resource "\\Include\\Controls\\res\\Up.bmp"
#resource "\\Include\\Controls\\res\\Down.bmp"


#include <Controls/Dialog.mqh>            //Gets us out Dialog Boxes from the Includes files
#include <Controls/Button.mqh>
#include <Controls/Label.mqh>
#include <Controls/RadioGroup.mqh>
#include <Controls/CheckGroup.mqh> 
#include <Controls/ComboBox.mqh>
#include <Controls/Scrolls.mqh>



CAppDialog Dashboard;
FxTE_Component Comp;


MainMenu Menu; //Instansicate the Main Menu Box


CButton MainMenuButton;

CBmpButton MainBmpButton;

//+------------------------------------------------------------------+
//| SET THE DIMENTIONS OF THE MAIN BOX                               |
//+------------------------------------------------------------------+
int Dashboard_Width=1270;
int Dashboard_Height=600;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   int TF_x= 40;
   int TI_x = 100;

//---Indicator Labels Adjustments  

   int TI_y=0;                         //"-22" was the number used before using this var

//---Bmp Up/Down Arrow button
   int arrow_x = 1205;
   int arrow_y = -17;

//+------------------------------------------------------------------+
//|         CREATE MAIN DIALOG BOXES                                 |
//+------------------------------------------------------------------+
   Dashboard.Create(0,"FxTE Dashboard",0,0,0,Dashboard_Width,Dashboard_Height);               //This creates the Main Dialog box.
   Dashboard.Shift(5,25);
//+------------------------------------------------------------------+
//|         BmpButtons                                               |
//+------------------------------------------------------------------+
   MainBmpButton.Create(0,"MainBmpButton",0,0,0,0,0);
   MainBmpButton.BmpNames("::Include\\Controls\\res\\Up.bmp","::Include\\Controls\\res\\Down.bmp");
   Dashboard.Add(MainBmpButton);
   MainBmpButton.Shift(arrow_x,arrow_y);
   
//+------------------------------------------------------------------+
//|         BUTTONS                                                  |
//+------------------------------------------------------------------+
//---Dashboard Button
   MainMenuButton.Create(0,"MainMenuButton",0,0,0,110,20);
   Dashboard.Add(MainMenuButton);
   MainMenuButton.Color(clrRed);
   MainMenuButton.Width(110);
   MainMenuButton.Height(40);
   MainMenuButton.Text("Main Menu");
   MainMenuButton.Shift(15,5);    
//+------------------------------------------------------------------+
//|  CREATE THE MAIN MENU from the Instanciated Object               |
//+------------------------------------------------------------------+
 Dashboard.Add(Menu);
 Dashboard.Add(Comp);
   
//DashboardScrollBox.Create(0,"ScrollBox",0,0,Dashboard_Width-200,Dashboard_Width,Dashboard_Height-200);               //This creates the Main Dialog box.
//DashboardScrollBox.Shift(15,35);

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   Dashboard.Destroy(reason);         //Without this line, our box will be destroyed from memory.MUST have this line.  

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

  }//---END OF OnTick()
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
  //+------------------------------------------------------------------+
  //|  BMP Button to SHOW/HIDE Main Diolog Box                         |
  //+------------------------------------------------------------------+  
   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="MainBmpButton")
      if(MainBmpButton.Pressed())
        {
         Dashboard.Height(30);
          MainMenuButton.Hide();
        }
   else
     {
      Dashboard.Height(Dashboard_Height);
       MainMenuButton.Show();
     }
     
//+------------------------------------------------------------------+
//| BUTTON click to SHOW/HIDE Main Menu Diolog Box                   |
//+------------------------------------------------------------------+
    if(id==CHARTEVENT_OBJECT_CLICK && sparam=="MainMenuButton")
     {
      if(Menu.IsVisible())
      {
         Menu.Hide();
         
         }
      else
         Menu.Show();
     }
     

  }
//+------------------------------------------------------------------+
