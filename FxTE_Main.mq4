//+------------------------------------------------------------------+
//|                                                    FxTE_Main.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                                      Tom Marazzo |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|    This File will act as the Main() Control for the Dashboard    |
//+------------------------------------------------------------------+


#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include <FxTE_Component.mqh>
#include <MainMenu.mqh>

#include <stdlib.mqh>
#include <stderror.mqh>


#resource "\\Include\\Controls\\res\\Up.bmp"
#resource "\\Include\\Controls\\res\\Down.bmp"
#resource "\\Include\\Controls\\res\\RightTransp.bmp"

#include <Controls/Dialog.mqh>            //Gets us out Dialog Boxes from the Includes files
#include <Controls/Button.mqh>
#include <Controls/Label.mqh>
#include <Controls/RadioGroup.mqh>
#include <Controls/CheckGroup.mqh> 
#include <Controls/ComboBox.mqh>

CAppDialog Dashboard;

FxTE_Component CompBox;
MainMenu MenuBox;

CBmpButton OurBmpButton;

CButton    MainMenuButton;


int Dashboard_Width=1650;
int Dashboard_Height=600;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {

//+------------------------------------------------------------------+
//|         DIALOG BOXES                                             |
//+------------------------------------------------------------------+

   Dashboard.Create(0,"FxTE Dashboard",0,0,0,Dashboard_Width,Dashboard_Height);               //This creates the Main Dialog box.
   Dashboard.Shift(15,25);

//---Dashboard Button
   MainMenuButton.Create(0,"MainMenu",0,0,0,110,20);
   Dashboard.Add(MainMenuButton);
   MainMenuButton.Color(clrRed);
   MainMenuButton.Width(110);
   MainMenuButton.Height(40);
   MainMenuButton.Text("Main Menu");
   MainMenuButton.Shift(15,5);





//+------------------------------------------------------------------+
//|         BmpButtons                                               |
//+------------------------------------------------------------------+

   OurBmpButton.Create(0,"OurBmpButton",0,0,0,0,0);
   OurBmpButton.BmpNames("::Include\\Controls\\res\\Up.bmp","::Include\\Controls\\res\\Down.bmp");
   Dashboard.Add(OurBmpButton);
   OurBmpButton.Shift(1585,-18);

//---
   Dashboard.Add(CompBox);
   //CompBox.Shift(5,50);
   
   Dashboard.Add(MenuBox);
   
   Dashboard.Run();
   
   

//This enables all of the controls to work in the Box

//--- create timer
   EventSetTimer(60);

//---
   return(INIT_SUCCEEDED);

  } //---END OF OnInit()
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   Dashboard.Destroy(reason);         //Without this line, our box will be destroyed from memory. We MUST have this line.  
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  
  
//   string B_1minText="UP";
//   string S_1minText="DOWN";
//   string N_1minText="NEUTRAL";
////---BUY M5--- 
//
//   double upArrow=iCustom(NULL,PERIOD_M1,"RS",0,1);
//   if(upArrow!=EMPTY_VALUE)
//     {
//      RS_1M.ColorBackground(clrRoyalBlue);
//      B_1minText=RS_1M.Text("UP");
//      RS_1M.Color(clrBlack);
//      //printf("UpArrow");
//
//     }
////---SELL M5---  
//   double downArrow=iCustom(NULL,PERIOD_M1,"RS",1,1);
//   if(downArrow!=EMPTY_VALUE)
//     {
//      RS_1M.ColorBackground(clrCrimson);
//      S_1minText=RS_1M.Text("DN");
//      RS_1M.Color(clrBlack);
//      //printf("DownArrow");
//     }
//   if(upArrow==EMPTY_VALUE && downArrow==EMPTY_VALUE)
//     {
//      printf("NeutArrow");
//      RS_1M.ColorBackground(clrLightGoldenrod);
//      N_1minText=RS_1M.Text("NEUTRAL");
//      RS_1M.Color(clrBlack);
//     }
//
//   RS_1M.FontSize(12);
//   RS_1M.TextAlign(ALIGN_CENTER);
//   CompBox.Add(RS_1M);



  } //---END OF OnTick()
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   Dashboard.OnEvent(id,lparam,dparam,sparam);

   string x;
   if(id==CHARTEVENT_OBJECT_CLICK)
      x=ObjectGetString(0,sparam,OBJPROP_TEXT);

//+------------------------------------------------------------------+
//|  Show/Hide Boxes                                                 |
//+------------------------------------------------------------------+

//-- ADD INSTRUMENT BOX BUTTON  --  This function is meant to enable the 
//ability to hide/show the "CompBox" box from view.

   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="ShowPairBoxButton")
     {
      if(MenuBox.IsVisible())
         MenuBox.Hide();
      else
         MenuBox.Show();
     }

//-- SHOW/HIDE MAIN MENU BOX BUTTON  --  

   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="MenuBox")
     {
      if(MenuBox.IsVisible())
         MenuBox.Hide();
      else
         MenuBox.Show();
     }

   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="OurBmpButton")
      if(OurBmpButton.Pressed())
        {
         Dashboard.Height(30);
         CompBox.Hide();

        }
   else
     {
      Dashboard.Height(Dashboard_Height);
      CompBox.Show();

     }
}



//}//--- END OF ChartEvent function   
//+------------------------------------------------------------------+
//|                  FUNCTIONS                                       |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
