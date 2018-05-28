//+------------------------------------------------------------------+
//|                                         FXTE_SingleDashboard.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <stdlib.mqh>
#include <stderror.mqh>

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

CComboBox PairsDropDown;

CLabel RS,NS,RX,AO_Peak,RYT_X,YS_Needed,SA,Pinch,SB;
CLabel RS5,NS5,RX5,AO_Peak5,RYT_X5,YS_Needed5,SA5,Pinch5,SB5;
CLabel RS15,NS15,RX15,AO_Peak15,RYT_X15,YS_Needed15,SA15,Pinch15,SB15;
CLabel RS1H,NS1H,RX1H,AO_Peak1H,RYT_X1H,YS_Needed1H,SA1H,Pinch1H,SB1H;
CLabel RS4H,NS4H,RX4H,AO_Peak4H,RYT_X4H,YS_Needed4H,SA4H,Pinch4H,SB4H;
CLabel RSD1,NSD1,RXD1,AO_PeakD1,RYT_XD1,YS_NeededD1,SAD1,PinchD1,SBD1;
CLabel RSW1,NSW1,RXW1,AO_PeakW1,RYT_XW1,YS_NeededW1,SAW1,PinchW1,SBW1;
CLabel RSM1,NSM1,RXM1,AO_PeakM1,RYT_XM1,YS_NeededM1,SAM1,PinchM1,SBM1;

CLabel OneM,FiveM,FifteenM,ThirtyM,OneH,FourH,D1,W1,MN;

CBmpButton MainBoxBmpButton;

int Dashboard_Width=1800;
int Dashboard_Height=700;

//---- extern inputs -------------------------------------------------
//- This is where you add the currency pairs you want 
extern string PairsList1               = "AUDCAD,AUDJPY,AUDUSD,CADJPY,CHFJPY,EURAUD,EURCAD,EURCHF,EURGBP,EURJPY,EURUSD,";
extern string PairsList2               = "GBPCHF,GBPJPY,GBPUSD,NZDCHF,NZDJPY,NZDUSD,USDCAD,USDCHF,USDJPY,";
extern string PairsList3               = "GLD,SLV,OIL";
//- If your broker names the currency pairs with a suffix for a mini account (like an "m", for example), enter the suffix here
extern string SymbolSuffix             = "";
extern string TimeFrameList            = "5,15,30,60,240,1440,10080";
extern int ShiftSignals                = 1;
extern bool SendAlert_Signals          = true;
extern bool PrintAlert_Signals         = true;
extern bool Draw_IntermediateSignals   = false;
extern int refreshPeriod=PERIOD_M1; // refresh calcultion
extern double SAR_Step = 0.02;
extern double SAR_Max  = 0.2;

string PairsList;
//--------------------------------------------------------------------

int OnInit()
  {
//---
PairsList = StringConcatenate(PairsList1,PairsList2,PairsList3);

//---Timeframe Labels Adjustments  
   int TF_x       = 40;
   int TF_y       = 10;
   //---Indicator Labels Adjustments  
   int TI_x       = 100;
   
   int TI_y       = 25;              
//---Bmp Up/Down Arrow button
   int arrow_x = 1730;
   int arrow_y = -17;
//+------------------------------------------------------------------+
//|         DIALOG BOX                                             |
//+------------------------------------------------------------------+

   Dashboard.Create(0,"FXTE Dashboard",0,0,0,Dashboard_Width,Dashboard_Height);               //This creates the Main Dialog box.
   Dashboard.Shift(5,25);

//+------------------------------------------------------------------+
//|         BmpButtons                                               |
//+------------------------------------------------------------------+

   MainBoxBmpButton.Create(0,"MainBoxBmpButton",0,0,0,0,0);
   MainBoxBmpButton.BmpNames("::Include\\Controls\\res\\Up.bmp","::Include\\Controls\\res\\Down.bmp");
   Dashboard.Add(MainBoxBmpButton);
   MainBoxBmpButton.Shift(arrow_x,arrow_y);


//+------------------------------------------------------------------+
//|         DROP-DOWN BUTTONS                                        |
//+------------------------------------------------------------------+
//---List View - CREATES THE DROP-DOWN of PAIRS
   PairsDropDown.Create(0,"Drop-Downs",0,1,10,80,30);
   PairsDropDown.Shift(2,40);
   
   for(int i=0; i<=numOfPairs();i++)
     {
      PairsDropDown.AddItem((SymbolName(i,0)),0);
      printf(Symbol());
     }

   Dashboard.Add(PairsDropDown);

 



//--- Indicator -Horizontal Labels--//
//+------------------------------------------------------------------+
//|                1Min Labels                                       |
//+------------------------------------------------------------------+

   OneM.Create(0,"1M",0,0,0,0,0);
   OneM.Text("1M");
   OneM.Color(clrBlue);
   OneM.FontSize(12);
   OneM.Font("Arial Bold");
   Dashboard.Add(OneM);
   OneM.Shift((TI_x+110),TF_y);
//---RS Label

   RS.Create(0,"RS",0,0,0,0,0);
   RS.Text("RS");
   RS.Color(clrBlack);
   RS.FontSize(9);
   RS.Font("Arial Bold");
   Dashboard.Add(RS);
   RS.Shift((TI_x+10),TI_y);

//---RS Indicators
   //RS_1M.Create(0, "RS_1M",0,0,0,75,25);
   //RS_1M.Text("RS_1M");
   //RS_1M.Color(clrBlack);
   //RS_1M.FontSize(10);
   //RS_1M.Font("Arial Bold");
   //Dashboard.Add(RS_1M);
   //RS_1M.Shift((TI_x+185),3);



//---NS Label

   NS.Create(0,"NS",0,0,0,0,0);
   NS.Text("NS");
   NS.Color(clrBlack);
   NS.FontSize(9);
   NS.Font("Arial Bold");
   Dashboard.Add(NS);
   NS.Shift(TI_x+(30),TI_y);

//---RX Label

   RX.Create(0,"RX",0,0,0,0,0);
   RX.Text("RX");
   RX.Color(clrBlack);
   RX.FontSize(9);
   RX.Font("Arial Bold");
   Dashboard.Add(RX);
   RX.Shift((TI_x+50),TI_y);

//---AO Peak Label

   AO_Peak.Create(0,"AO Peak",0,0,0,0,0);
   AO_Peak.Text("AO");
   AO_Peak.Color(clrBlack);
   AO_Peak.FontSize(9);
   AO_Peak.Font("Arial Bold");
   Dashboard.Add(AO_Peak);
   AO_Peak.Shift((TI_x+70),TI_y);

//---RYT_X  Label

   RYT_X.Create(0,"RYT X",0,0,0,0,0);
   RYT_X.Text("RYT X");
   RYT_X.Color(clrBlack);
   RYT_X.FontSize(9);
   RYT_X.Font("Arial Bold");
   Dashboard.Add(RYT_X);
   RYT_X.Shift((TI_x +90),TI_y);

//---YS_Needed  Label

   YS_Needed.Create(0,"YS Needed",0,0,0,0,0);
   YS_Needed.Text("YS");
   YS_Needed.Color(clrBlack);
   YS_Needed.FontSize(9);
   YS_Needed.Font("Arial Bold");
   Dashboard.Add(YS_Needed);
   YS_Needed.Shift((TI_x+130),TI_y);

//---SA Label

   SA.Create(0,"SA",0,0,0,0,0);
   SA.Text("SA");
   SA.Color(clrBlack);
   SA.FontSize(9);
   SA.Font("Arial Bold");
   Dashboard.Add(SA);
   SA.Shift((TI_x+150),TI_y);

//---Pinch Label

   Pinch.Create(0,"Pinch",0,0,0,0,0);
   Pinch.Text("Pinch");
   Pinch.Color(clrBlack);
   Pinch.FontSize(9);
   Pinch.Font("Arial Bold");
   Dashboard.Add(Pinch);
   Pinch.Shift((TI_x +170),TI_y);

//---SB Label

   SB.Create(0,"SB",0,0,0,0,0);
   SB.Text("SB");
   SB.Color(clrBlack);
   SB.FontSize(9);
   SB.Font("Arial Bold");
   Dashboard.Add(SB);
   SB.Shift((TI_x+205),TI_y);

//+------------------------------------------------------------------+
//|                5 Min Labels                                      |
//+------------------------------------------------------------------+

//--- Indicator -Horizontal Labels--//
   FiveM.Create(0,"5M",0,0,0,0,0);
   FiveM.Text("5M");
   FiveM.Color(clrBlue);
   FiveM.FontSize(12);
   FiveM.Font("Arial Bold");
   Dashboard.Add(FiveM);
   FiveM.Shift((TI_x+310),TF_y);
//---RS Label

   RS5.Create(0,"RS5",0,0,0,0,0);
   RS5.Text("RS");
   RS5.Color(clrBlack);
   RS5.FontSize(9);
   RS5.Font("Arial Bold");
   Dashboard.Add(RS5);
   RS5.Shift((TI_x+230),TI_y);

//---RS Indicators
   //RS_1M.Create(0, "RS_1M",0,0,0,75,25);
   //RS_1M.Text("RS_1M");
   //RS_1M.Color(clrBlack);
   //RS_1M.FontSize(10);
   //RS_1M.Font("Arial Bold");
   //Dashboard.Add(RS_1M);
   //RS_1M.Shift((TI_x+185),3);



//---NS Label

   NS5.Create(0,"NS5",0,0,0,0,0);
   NS5.Text("NS");
   NS5.Color(clrBlack);
   NS5.FontSize(9);
   NS5.Font("Arial Bold");
   Dashboard.Add(NS5);
   NS5.Shift(TI_x+(250),TI_y);

//---RX Label

   RX5.Create(0,"RX5",0,0,0,0,0);
   RX5.Text("RX");
   RX5.Color(clrBlack);
   RX5.FontSize(9);
   RX5.Font("Arial Bold");
   Dashboard.Add(RX5);
   RX5.Shift((TI_x+270),TI_y);

//---AO Peak Label

   AO_Peak5.Create(0,"AO Peak5",0,0,0,0,0);
   AO_Peak5.Text("AO");
   AO_Peak5.Color(clrBlack);
   AO_Peak5.FontSize(9);
   AO_Peak5.Font("Arial Bold");
   Dashboard.Add(AO_Peak5);
   AO_Peak5.Shift((TI_x+290),TI_y);

//---RYT_X  Label

   RYT_X5.Create(0,"RYT X5",0,0,0,0,0);
   RYT_X5.Text("RYT X");
   RYT_X5.Color(clrBlack);
   RYT_X5.FontSize(9);
   RYT_X5.Font("Arial Bold");
   Dashboard.Add(RYT_X5);
   RYT_X5.Shift((TI_x +310),TI_y);

//---YS_Needed  Label

   YS_Needed5.Create(0,"YS Needed5",0,0,0,0,0);
   YS_Needed5.Text("YS");
   YS_Needed5.Color(clrBlack);
   YS_Needed5.FontSize(9);
   YS_Needed5.Font("Arial Bold");
   Dashboard.Add(YS_Needed5);
   YS_Needed5.Shift((TI_x+350),TI_y);

//---SA Label

   SA5.Create(0,"SA5",0,0,0,0,0);
   SA5.Text("SA");
   SA5.Color(clrBlack);
   SA5.FontSize(9);
   SA5.Font("Arial Bold");
   Dashboard.Add(SA5);
   SA5.Shift((TI_x+370),TI_y);

//---Pinch Label

   Pinch5.Create(0,"Pinch5",0,0,0,0,0);
   Pinch5.Text("Pinch");
   Pinch5.Color(clrBlack);
   Pinch5.FontSize(9);
   Pinch5.Font("Arial Bold");
   Dashboard.Add(Pinch5);
   Pinch5.Shift((TI_x +390),TI_y);

//---SB Label

   SB5.Create(0,"SB5",0,0,0,0,0);
   SB5.Text("SB");
   SB5.Color(clrBlack);
   SB5.FontSize(9);
   SB5.Font("Arial Bold");
   Dashboard.Add(SB5);
   SB5.Shift((TI_x+425),TI_y);


 
//----
Dashboard.Run();

   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Delete_TextObjects()
  {
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {

  }
//---END OF OnTick()
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {

//---This allows you to take the value of the Edit Box and use it

//---
   Dashboard.OnEvent(id,lparam,dparam,sparam);

   string x;
   if(id==CHARTEVENT_OBJECT_CLICK)
      x=ObjectGetString(0,sparam,OBJPROP_TEXT);

   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="MainBoxBmpButton")
      if(MainBoxBmpButton.Pressed())
        {
         Dashboard.Height(30);

        }
   else
     {
      Dashboard.Height(Dashboard_Height);

     }
  }
//+------------------------------------------------------------------+
//--- END OF ChartEvent function   
//+------------------------------------------------------------------+
//|                  FUNCTIONS                                       |
//+------------------------------------------------------------------+

int numOfPairs()
  {
   int num=SymbolsTotal(0);
   printf("There are "+num+" Pairs with this Broker");

   return num;
  }
//+------------------------------------------------------------------+
