//+------------------------------------------------------------------+
//| As of Friday 25 May, couldn't get the FXTE_Component and the Comp| 
//| to work.  I need to create teh Box - inside the main file        |
//| after I figure out how to make multiple boxes                    |
//+------------------------------------------------------------------+




//+------------------------------------------------------------------+
//|                                                          FTE.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                                      Tom Marazzo |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <stdlib.mqh>
#include <stderror.mqh>
#include <FxTE_Component.mqh>


#resource "\\Include\\Controls\\res\\Up.bmp"
#resource "\\Include\\Controls\\res\\Down.bmp"
#resource "\\Include\\Controls\\res\\RightTransp.bmp"

#include <Controls/Dialog.mqh>            //Gets us out Dialog Boxes from the Includes files
#include <Controls/Button.mqh>
#include <Controls/Label.mqh>
#include <Controls/RadioGroup.mqh>
#include <Controls/CheckGroup.mqh> 
#include <Controls/ComboBox.mqh>
#include <Controls/Scrolls.mqh>


CAppDialog Dashboard;
FxTE_Component Comp[]; 

CBmpButton OurBmpButton;

//CScrollV DashboardScrollBox;
int Comp_Total=0;

int Dashboard_Width=1600;
int Dashboard_Height=700;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
   int TF_x = 40;
   int TI_x = 100;
   
   //---Indicator Labels Adjustments  
   
   int TI_y=0;                         //"-22" was teh number used before using this var
   
   //---Bmp Up/Down Arrow button
   int arrow_x = 1240;
   int arrow_y = -17;

//+------------------------------------------------------------------+
//|         DIALOG BOXES                                             |
//+------------------------------------------------------------------+

   Dashboard.Create(0,"FxTE Dashboard",0,0,0,Dashboard_Width,Dashboard_Height);               //This creates the Main Dialog box.
   Dashboard.Shift(5,25);
   
   //DashboardScrollBox.Create(0,"ScrollBox",0,0,Dashboard_Width-200,Dashboard_Width,Dashboard_Height-200);               //This creates the Main Dialog box.
   //DashboardScrollBox.Shift(15,35);

//---Template of First Instrument Box
ArrayResize(Comp,3,0);
Comp_Total=3;
   int px=0;
   int py=0;
  int sx=(Dashboard_Width-350);
   int sy=260;
   
   int i;
   for( i=0;i<Comp_Total;i++)
   {   
   //Dashboard.Add(Comp[i]);
 Comp[i].Create(0,"Component Box",0,px,py,px+sx,py+sy);                     //This creates the Interior Dialog box.
Dashboard.Add(Comp[i]);
   px=px+0;
   py=py+50;  
   Comp[i].Shift(px,py);
    
   }
   
 
 ////--- Create 4 tom boxes
//  ArrayResize(TomBox,4,0);
//  TomBox_Total=4;
//  int px=120;
//  int py=40;
//  int sx=120;
//  int sy=40;
//  for(int x=0;x<4;x++)
//  {
//TomBox[x].Create(0,"Tom's Box",0,px,py,px+sx,py+sy);
//  ExtDialog.Add(TomBox[x]);  
//  px=px+0;
//  py=py+41;
//  }
//  //Create 4 tom boxes ends here 
   
 


//+------------------------------------------------------------------+
//|         BmpButtons                                               |
//+------------------------------------------------------------------+

   OurBmpButton.Create(0,"OurBmpButton",0,0,0,0,0);
   OurBmpButton.BmpNames("::Include\\Controls\\res\\Up.bmp","::Include\\Controls\\res\\Down.bmp");
   Dashboard.Add(OurBmpButton);
   OurBmpButton.Shift(1532,-18);






//---
  //Dashboard.Add(Comp[x]); 

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
   int i;
   if(id==CHARTEVENT_OBJECT_CLICK)
      x=ObjectGetString(0,sparam,OBJPROP_TEXT);


   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="OurBmpButton")
      if(OurBmpButton.Pressed())
        {
         Dashboard.Height(30);
         Comp[i].Hide();
        
        }
   else
     {
      Dashboard.Height(Dashboard_Height);
      Comp[i].Show();
      
     }

   


//---Checkbox Group to display TimeFrames INSIDE the Comp[x]

  

  }//--- END OF ChartEvent function   
//+------------------------------------------------------------------+
//|                  FUNCTIONS                                       |
//+------------------------------------------------------------------+

//int numOfPairs()
//  {
//   int num=SymbolsTotal(0);
//   printf("There are "+num+" Pairs with this Broker");
//
//   return num;
//  }
//+------------------------------------------------------------------+
