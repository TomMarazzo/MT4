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

CAppDialog Comp;//CDialog Comp;,//Menu;  
CAppDialog Menu,Comp2;                            //Inside Dialog Box is Instanciated here
CButton ShowPairBoxButton;
CButton AddInstrumentBoxButton;                               //CButton gets us access to Button functionality
CButton MainMenuButton;

CLabel Pairs,RS,NS,RX,AO_Peak,RYT_X,YS_Needed,SA,Pinch,SB;
CLabel OneM,FiveM,FifteenM,ThirtyM,OneH,FourH,D1,W1,MN;

CEdit RS_1M;

CBmpButton OurBmpButton,ComponentBoxButton;

CCheckGroup TimeFrames,TechIndicators;

//CComboBox PairsDropDown;

//CScrollV DashboardScrollBox;

CAppDialog Dashboard;
int Dashboard_Width=1650;
int Dashboard_Height=800;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//Component();

//+------------------------------------------------------------------+
//|         DIALOG BOXES                                             |
//+------------------------------------------------------------------+

   Dashboard.Create(0,"FxTE Dashboard",0,0,0,Dashboard_Width,Dashboard_Height);               //This creates the Main Dialog box.
   Dashboard.Shift(5,25);

//DashboardScrollBox.Create(0,"ScrollBox",0,0,Dashboard_Width-200,Dashboard_Width,Dashboard_Height-200);               //This creates the Main Dialog box.
//DashboardScrollBox.Shift(15,35);


//Comp2.Create(0,"",0,0,0,(Dashboard_Width-350),255);                     //This creates the Interior Dialog box.
//Comp2.Shift(5,305);


//---Main Menu Box
   Menu.Create(0,"Menu",0,0,0,350,260);
   Menu.Shift(650,310);

//+------------------------------------------------------------------+
//|         BmpButtons                                               |
//+------------------------------------------------------------------+

   OurBmpButton.Create(0,"OurBmpButton",0,0,0,0,0);
   OurBmpButton.BmpNames("::Include\\Controls\\res\\Up.bmp","::Include\\Controls\\res\\Down.bmp");
   Dashboard.Add(OurBmpButton);
   OurBmpButton.Shift(1585,-18);

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

//---Show/Hide Instrument Box
   ShowPairBoxButton.Create(0,"ShowPairBoxButton",0,0,0,110,20);
   ShowPairBoxButton.Color(clrRed);
   ShowPairBoxButton.Width(110);
   ShowPairBoxButton.Height(40);
   ShowPairBoxButton.Text("Show Instrument");
   ShowPairBoxButton.Shift(200,180);

//---Add Instrument Box
   AddInstrumentBoxButton.Create(0,"AddInstrumentBoxButton",0,0,0,110,20);
   AddInstrumentBoxButton.Color(clrRed);
   AddInstrumentBoxButton.Width(110);
   AddInstrumentBoxButton.Height(40);
   AddInstrumentBoxButton.Text("Add Instrument");
   AddInstrumentBoxButton.Shift(20,180);


//+------------------------------------------------------------------+
//|         DROP-DOWN BUTTONS                                        |
//+------------------------------------------------------------------+


//---List View - CREATES TEH DROP-DOWN of PAIRS
//PairsDropDown.Create(0,"OurListView",0,5,10,125,40);
//PairsDropDown.Shift(210,5);
//numOfPairs();
//for(int i=0; i<=numOfPairs();i++)
//  {
//   string Pairs=PairsDropDown.AddItem(SymbolName(i,0));
//   printf(Symbol());
//  }

//Menu.Add(PairsDropDown);

//+------------------------------------------------------------------+
//| Main Menu Item Selections                                        |
//+------------------------------------------------------------------+

//---TimeFrame Selector inside Main Menu
   TimeFrames.Create(0,"TimeFrames",0,0,0,150,170);
   TimeFrames.AddItem("1M");
   TimeFrames.AddItem("5M");
   TimeFrames.AddItem("15M");
   TimeFrames.AddItem("30M");
   TimeFrames.AddItem("1H");
   TimeFrames.AddItem("4H");
   TimeFrames.AddItem("D1");
   TimeFrames.AddItem("W1");
   TimeFrames.AddItem("MN");
   Menu.Add(TimeFrames);
   TimeFrames.Shift(0,0);

//---Technical Indicators Selector inside Main Menu
   TechIndicators.Create(0,"TechIndicators",0,0,0,100,170);
   TechIndicators.AddItem("RS");
   TechIndicators.AddItem("NS");
   TechIndicators.AddItem("RX");
   TechIndicators.AddItem("AO Peak");
   TechIndicators.AddItem("RYT X");
   TechIndicators.AddItem("YS Needed");
   TechIndicators.AddItem("SA");
   TechIndicators.AddItem("Pinch");
   TechIndicators.AddItem("SB");
   Menu.Add(TechIndicators);
   TechIndicators.Shift(100,0);

//---
//Dashboard.Add(DashboardScrollBox); 
//Dashboard.Add(Comp); 
//Dashboard.Add(Comp2);  


   Dashboard.Add(Menu);

   Menu.Add(ShowPairBoxButton);
   Menu.Add(AddInstrumentBoxButton);

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
//   Comp.Add(RS_1M);



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
//|  ADD Component Boxes                                             |
//+------------------------------------------------------------------+      

//-- Add INSTRUMENT BOX BUTTON  --  This function is meant to enable the 
//ability to ADD the "Comp" box to the Dashboard.

   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="AddInstrumentBoxButton")
     {
      Component();

     }

//+------------------------------------------------------------------+
//|  Show/Hide Boxes                                                 |
//+------------------------------------------------------------------+

//-- SHOW INSTRUMENT BOX BUTTON  --  This function is meant to enable the 
//ability to hide/show the "Comp" box from view.

   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="ShowPairBoxButton")
     {
      if(Comp.IsVisible())
         Comp.Hide();
      else
         Comp.Show();
     }

//-- SHOW/HIDE MAIN MENU BOX BUTTON  --  

   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="MainMenuButton")
     {
      if(Menu.IsVisible())
         Menu.Hide();
      else
         Menu.Show();
     }

   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="OurBmpButton")
      if(OurBmpButton.Pressed())
        {
         Dashboard.Height(30);
         Comp.Hide();
         MainMenuButton.Hide();
        }
   else
     {
      Dashboard.Height(Dashboard_Height);
      Comp.Show();
      MainMenuButton.Show();
     }

   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="ComponentBoxButton")
      if(ComponentBoxButton.Pressed())
        {
         Comp.Height(30);
         //PairsDropDown.Hide();
         OneM.Hide();
         FiveM.Hide();
         FifteenM.Hide();
         ThirtyM.Hide();
         OneH.Hide();
         FourH.Hide();
         D1.Hide();
         W1.Hide();
         MN.Hide();
         //--CI Labels
         RS.Hide();
         NS.Hide();
         RX.Hide();
         AO_Peak.Hide();
         RYT_X.Hide();
         YS_Needed.Hide();
         SA.Hide();
         Pinch.Hide();
         SB.Hide();
        }
   else
     {
      Comp.Height(235);
      //PairsDropDown.Show();
      OneM.Show();
      OneM.Show();
      FiveM.Show();
      FifteenM.Show();
      ThirtyM.Show();
      OneH.Show();
      FourH.Show();
      D1.Show();
      W1.Show();
      MN.Show();
      //--CI Labels
      RS.Show();
      NS.Show();
      RX.Show();
      AO_Peak.Show();
      RYT_X.Show();
      YS_Needed.Show();
      SA.Show();
      Pinch.Show();
      SB.Show();
     }

//This function is meant to enable the ability to hide/show the a NEW box from view.
   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="AddCompBoxButton")
     {
      if(Comp.IsVisible())
         Comp.Hide();
      else
         Comp.Show();
     }

//---Checkbox Group to display TimeFrames INSIDE the Comp

   if(id==CHARTEVENT_OBJECT_CLICK && x=="1M")
     {
      if(OneM.IsVisible())
        {
         OneM.Hide();
         Comp.Height(255);
        }
      else
        {
         OneM.Show();
         Comp.Height(270);
        }
     }
   if(id==CHARTEVENT_OBJECT_CLICK && x=="5M")
     {
      if(FiveM.IsVisible())
         FiveM.Hide();
      else
         FiveM.Show();
     }

   if(id==CHARTEVENT_OBJECT_CLICK && x=="15M")
     {
      if(FifteenM.IsVisible())
         FifteenM.Hide();
      else
         FifteenM.Show();
     }
   if(id==CHARTEVENT_OBJECT_CLICK && x=="30M")
     {
      if(ThirtyM.IsVisible())
         ThirtyM.Hide();
      else
         ThirtyM.Show();
     }

   if(id==CHARTEVENT_OBJECT_CLICK && x=="1H")
     {
      if(OneH.IsVisible())
         OneH.Hide();
      else
         OneH.Show();
     }

   if(id==CHARTEVENT_OBJECT_CLICK && x=="4H")
     {
      if(FourH.IsVisible())
         FourH.Hide();
      else
         FourH.Show();
     }
   if(id==CHARTEVENT_OBJECT_CLICK && x=="D1")
     {
      if(D1.IsVisible())
         D1.Hide();
      else
         D1.Show();
     }
   if(id==CHARTEVENT_OBJECT_CLICK && x=="W1")
     {
      if(W1.IsVisible())
         W1.Hide();
      else
         W1.Show();
     }
   if(id==CHARTEVENT_OBJECT_CLICK && x=="MN")
     {
      if(MN.IsVisible())
         MN.Hide();
      else
         MN.Show();
     }

//---Checkbox Group to display CI's INSIDE the Comp

   if(id==CHARTEVENT_OBJECT_CLICK && x=="RS")
     {
      if(RS.IsVisible())
        {
         RS.Hide();
         Comp.Width(1285);
        }
      else
        {
         RS.Show();
         Comp.Width(1300);
        }
     }
   if(id==CHARTEVENT_OBJECT_CLICK && x=="NS")
     {
      if(NS.IsVisible())
         NS.Hide();
      else
         NS.Show();
     }

   if(id==CHARTEVENT_OBJECT_CLICK && x=="RX")
     {
      if(RX.IsVisible())
         RX.Hide();
      else
         RX.Show();
     }
   if(id==CHARTEVENT_OBJECT_CLICK && x=="AO Peak")
     {
      if(AO_Peak.IsVisible())
         AO_Peak.Hide();
      else
         AO_Peak.Show();
     }

   if(id==CHARTEVENT_OBJECT_CLICK && x=="RYT X")
     {
      if(RYT_X.IsVisible())
         RYT_X.Hide();
      else
         RYT_X.Show();
     }

   if(id==CHARTEVENT_OBJECT_CLICK && x=="YS Needed")
     {
      if(YS_Needed.IsVisible())
         YS_Needed.Hide();
      else
         YS_Needed.Show();
     }
   if(id==CHARTEVENT_OBJECT_CLICK && x=="SA")
     {
      if(SA.IsVisible())
         SA.Hide();
      else
         SA.Show();
     }
   if(id==CHARTEVENT_OBJECT_CLICK && x=="Pinch")
     {
      if(Pinch.IsVisible())
         Pinch.Hide();
      else
         Pinch.Show();
     }
   if(id==CHARTEVENT_OBJECT_CLICK && x=="SB")
     {
      if(SB.IsVisible())
         SB.Hide();
      else
         SB.Show();
     }

  }//--- END OF ChartEvent function   
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

void Component()
  {
//CComboBox PairsDropDown;



//---Timeframe Labels Adjustments 
   int TF_x = 40;
   int TF_y = 20;
//---Indicator Labels Adjustments  
   int TI_x=100;
   int TI_y=0; //"-22" was teh number used before using this var

//---Bmp Up/Down Arrow button
   int arrow_x = 1238;
   int arrow_y = -17;

//---Template of First Instrument Box
   Comp.Create(0,"",0,0,0,(Dashboard_Width-350),270);                     //This creates the Interior Dialog box.
   Comp.Shift(10,100);

//--- BmpButtons 
   ComponentBoxButton.Create(0,"ComponentBoxButton",0,0,0,0,0);
   ComponentBoxButton.BmpNames("::Include\\Controls\\res\\Up.bmp","::Include\\Controls\\res\\Down.bmp");
   Comp.Add(ComponentBoxButton);
   ComponentBoxButton.Shift(arrow_x,arrow_y);

//PairsDropDown.Create(0,"OurListView",0,5,10,125,40);
//PairsDropDown.Shift(10,5);
//numOfPairs();
//for(int i=0; i<=numOfPairs();i++)
//  {
//   string Pairs=PairsDropDown.AddItem(SymbolName(i,0));
//   printf(Symbol());
//  }

//Comp.Add(PairsDropDown);

//--- Timeframe -Vertical Labels--// 

//---1M Label

   OneM.Create(0,"1M",0,TF_x,TF_y+0,0,0);
   OneM.Text("1M");
   OneM.Color(clrBlack);
   OneM.FontSize(10);
   OneM.Font("Arial Bold");
   Comp.Add(OneM);
//OneM.Shift(150,50);

//---5M Label

   FiveM.Create(0,"5M",0,TF_x,TF_y+26,0,0);
   FiveM.Text("5M");
   FiveM.Color(clrBlack);
   FiveM.FontSize(10);
   FiveM.Font("Arial Bold");
   Comp.Add(FiveM);
//FiveM.Shift(0,50);

//---15M Label

   FifteenM.Create(0,"15M",0,TF_x,TF_y+52,0,0);
   FifteenM.Text("15M");
   FifteenM.Color(clrBlack);
   FifteenM.FontSize(10);
   FifteenM.Font("Arial Bold");
   Comp.Add(FifteenM);
//FifteenM.Shift(0,50);

//---30M Label

   ThirtyM.Create(0,"30M",0,TF_x,TF_y+78,0,0);
   ThirtyM.Text("30M");
   ThirtyM.Color(clrBlack);
   ThirtyM.FontSize(10);
   ThirtyM.Font("Arial Bold");
   Comp.Add(ThirtyM);
//FifteenM.Shift(0,50);

//---1H Label

   OneH.Create(0,"1H",0,TF_x,TF_y+104,0,0);
   OneH.Text("1H");
   OneH.Color(clrBlack);
   OneH.FontSize(10);
   OneH.Font("Arial Bold");
   Comp.Add(OneH);
//OneH.Shift(0,50);

//---4H Label

   FourH.Create(0,"4H",0,TF_x,TF_y+130,0,0);
   FourH.Text("4H");
   FourH.Color(clrBlack);
   FourH.FontSize(10);
   FourH.Font("Arial Bold");
   Comp.Add(FourH);
//FourH.Shift(0,50);  

//---D Label

   D1.Create(0,"Daily",0,TF_x,TF_y+156,0,0);
   D1.Text("Daily");
   D1.Color(clrBlack);
   D1.FontSize(10);
   D1.Font("Arial Bold");
   Comp.Add(D1);
//D.Shift(0,50);  

//---W Label

   W1.Create(0,"Weekly",0,TF_x,TF_y+182,0,0);
   W1.Text("Weekly");
   W1.Color(clrBlack);
   W1.FontSize(10);
   W1.Font("Arial Bold");
   Comp.Add(W1);
//W.Shift(0,50);    

//---M Label

   MN.Create(0,"Monthly",0,TF_x,TF_y+206,0,0);
   MN.Text("Monthly");
   MN.Color(clrBlack);
   MN.FontSize(10);
   MN.Font("Arial Bold");
   Comp.Add(MN);
//M.Shift(0,50);    

//--- Indicator -Horizontal Labels--//
//Pairs.Create(0,Pairs,0,0,0,0,0); 

//---RS Label

   RS.Create(0,"RS",0,0,0,0,0);
   RS.Text("RS");
   RS.Color(clrBlack);
   RS.FontSize(10);
   RS.Font("Arial Bold");
   Comp.Add(RS);
   RS.Shift((TI_x+210),TI_y);

//---RS Indicators
//RS_1M.Create(0, "RS_1M",0,0,0,75,25);
//RS_1M.Text("RS_1M");
//RS_1M.Color(clrBlack);
//RS_1M.FontSize(10);
//RS_1M.Font("Arial Bold");
//Comp.Add(RS_1M);
//RS_1M.Shift((TI_x+185),3);



//---NS Label

   NS.Create(0,"NS",0,0,0,0,0);
   NS.Text("NS");
   NS.Color(clrBlack);
   NS.FontSize(10);
   NS.Font("Arial Bold");
   Comp.Add(NS);
   NS.Shift((TI_x+295),TI_y);

//---RX Label

   RX.Create(0,"RX",0,0,0,0,0);
   RX.Text("RX");
   RX.Color(clrBlack);
   RX.FontSize(10);
   RX.Font("Arial Bold");
   Comp.Add(RX);
   RX.Shift((TI_x+370),TI_y);

//---AO Peak Label

   AO_Peak.Create(0,"AO Peak",0,0,0,0,0);
   AO_Peak.Text("AO Peak");
   AO_Peak.Color(clrBlack);
   AO_Peak.FontSize(10);
   AO_Peak.Font("Arial Bold");
   Comp.Add(AO_Peak);
   AO_Peak.Shift((TI_x+445),TI_y);

//---RYT_X  Label

   RYT_X.Create(0,"RYT X",0,0,0,0,0);
   RYT_X.Text("RYT X");
   RYT_X.Color(clrBlack);
   RYT_X.FontSize(10);
   RYT_X.Font("Arial Bold");
   Comp.Add(RYT_X);
   RYT_X.Shift((TI_x+570),TI_y);

//---YS_Needed  Label

   YS_Needed.Create(0,"YS Needed",0,0,0,0,0);
   YS_Needed.Text("YS Needed");
   YS_Needed.Color(clrBlack);
   YS_Needed.FontSize(10);
   YS_Needed.Font("Arial Bold");
   Comp.Add(YS_Needed);
   YS_Needed.Shift((TI_x+670),TI_y);

//---SA Label

   SA.Create(0,"SA",0,0,0,0,0);
   SA.Text("SA");
   SA.Color(clrBlack);
   SA.FontSize(10);
   SA.Font("Arial Bold");
   Comp.Add(SA);
   SA.Shift((TI_x+825),TI_y);

//---Pinch Label

   Pinch.Create(0,"Pinch",0,0,0,0,0);
   Pinch.Text("Pinch");
   Pinch.Color(clrBlack);
   Pinch.FontSize(10);
   Pinch.Font("Arial Bold");
   Comp.Add(Pinch);
   Pinch.Shift((TI_x+910),TI_y);

//---SB Label

   SB.Create(0,"SB",0,0,0,0,0);
   SB.Text("SB");
   SB.Color(clrBlack);
   SB.FontSize(10);
   SB.Font("Arial Bold");
   Comp.Add(SB);
   SB.Shift((TI_x+1020),TI_y);

  }
//+------------------------------------------------------------------+
