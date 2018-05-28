//+------------------------------------------------------------------+
//|                                               FxTE_Component.mqh |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#resource "\\Include\\Controls\\res\\Up.bmp"
#resource "\\Include\\Controls\\res\\Down.bmp"
#resource "\\Include\\Controls\\res\\RightTransp.bmp"

#include <Controls/Dialog.mqh>            //Gets us out Dialog Boxes from the Includes files
#include <Controls/Button.mqh>
#include <Controls/Label.mqh>
#include <Controls/RadioGroup.mqh>
#include <Controls/CheckGroup.mqh> 
#include <Controls/ComboBox.mqh>

#include <MainMenu.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class FxTE_Component : public CDialog
  {
public:
   CDialog           CompBox;

   CLabel            RS,NS,RX,AO_Peak,RYT_X,YS_Needed,SA,Pinch,SB;
   CLabel            OneM,FiveM,FifteenM,ThirtyM,OneH,FourH,D1,W1,MN;

   

   CBmpButton        ComponentBoxBmpButton;
   
   

   //CEdit             RS_1M;

public:
                     FxTE_Component();
//+------------------------------------------------------------------+
//|                  MEMBER FUNCTIONS                                |
//+------------------------------------------------------------------+

int numOfPairs()
  {
   int num=SymbolsTotal(0);
   printf("There are "+num+" Pairs with this Broker");

   return num;
  }
   
   void OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
  
                    ~FxTE_Component();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
FxTE_Component::FxTE_Component()
  {
//---Template of First Instrument Box
   CompBox.Create(0,"",0,0,0,1200,270); 
   CompBox.Shift(50,50);                    //This creates the Interior Dialog box.
   
   
//---Timeframe Labels Adjustments 
   int TF_x = 40;
   int TF_y = 20;
//---Indicator Labels Adjustments  
   int TI_x=50;
   int TI_y=0;                         

//---BmpButton
//---Bmp Up/Down Arrow button
   int arrow_x = 1130;
   int arrow_y = -17;

   ComponentBoxBmpButton.Create(0,"ComponentBoxBmpButton",0,0,0,0,0);
   ComponentBoxBmpButton.BmpNames("::Include\\Controls\\res\\Up.bmp","::Include\\Controls\\res\\Down.bmp");
   CompBox.Add(ComponentBoxBmpButton);
   ComponentBoxBmpButton.Shift(arrow_x,arrow_y); //Dashboard_Width-68,-18


//--- Timeframe -Vertical Labels--// 

//---1M Label

   OneM.Create(0,"1M",0,TF_x,0,0,0);
   OneM.Text("1M");
   OneM.Color(clrBlack);
   OneM.FontSize(10);
   OneM.Font("Arial Bold");
   CompBox.Add(OneM);
//OneM.Shift(150,50);

//---5M Label

   FiveM.Create(0,"5M",0,TF_x,26,0,0);
   FiveM.Text("5M");
   FiveM.Color(clrBlack);
   FiveM.FontSize(10);
   FiveM.Font("Arial Bold");
   CompBox.Add(FiveM);
//FiveM.Shift(0,50);

//---15M Label

   FifteenM.Create(0,"15M",0,TF_x,52,0,0);
   FifteenM.Text("15M");
   FifteenM.Color(clrBlack);
   FifteenM.FontSize(10);
   FifteenM.Font("Arial Bold");
   CompBox.Add(FifteenM);
//FifteenM.Shift(0,50);

//---30M Label

   ThirtyM.Create(0,"30M",0,TF_x,78,0,0);
   ThirtyM.Text("30M");
   ThirtyM.Color(clrBlack);
   ThirtyM.FontSize(10);
   ThirtyM.Font("Arial Bold");
   CompBox.Add(ThirtyM);
//FifteenM.Shift(0,50);

//---1H Label

   OneH.Create(0,"1H",0,TF_x,104,0,0);
   OneH.Text("1H");
   OneH.Color(clrBlack);
   OneH.FontSize(10);
   OneH.Font("Arial Bold");
   CompBox.Add(OneH);
//OneH.Shift(0,50);

//---4H Label

   FourH.Create(0,"4H",0,TF_x,130,0,0);
   FourH.Text("4H");
   FourH.Color(clrBlack);
   FourH.FontSize(10);
   FourH.Font("Arial Bold");
   CompBox.Add(FourH);
//FourH.Shift(0,50);  

//---D Label

   D1.Create(0,"Daily",0,TF_x,156,0,0);
   D1.Text("Daily");
   D1.Color(clrBlack);
   D1.FontSize(10);
   D1.Font("Arial Bold");
   CompBox.Add(D1);
//D.Shift(0,50);  

//---W Label

   W1.Create(0,"Weekly",0,TF_x,182,0,0);
   W1.Text("Weekly");
   W1.Color(clrBlack);
   W1.FontSize(10);
   W1.Font("Arial Bold");
   CompBox.Add(W1);
//W.Shift(0,50);    

//---M Label

   MN.Create(0,"Monthly",0,TF_x,206,0,0);
   MN.Text("Monthly");
   MN.Color(clrBlack);
   MN.FontSize(10);
   MN.Font("Arial Bold");
   CompBox.Add(MN);
//M.Shift(0,50);    

//--- Indicator -Horizontal Labels--//

//---RS Label

   RS.Create(0,"RS",0,0,0,0,0);
   RS.Text("RS");
   RS.Color(clrBlack);
   RS.FontSize(10);
   RS.Font("Arial Bold");
   CompBox.Add(RS);
   RS.Shift((TI_x+210),-22);

//---RS Indicators
//   RS_1M.Create(0, "RS_1M",0,0,0,75,25);
//   RS_1M.Text("RS_1M");
//   RS_1M.Color(clrBlack);
//   RS_1M.FontSize(10);
//   RS_1M.Font("Arial Bold");
//   CompBox.Add(RS_1M);
//   RS_1M.Shift((100+185),3);
//
//---NS Label

   NS.Create(0,"NS",0,0,0,0,0);
   NS.Text("NS");
   NS.Color(clrBlack);
   NS.FontSize(10);
   NS.Font("Arial Bold");
   CompBox.Add(NS);
   NS.Shift((TI_x+295),-22);

//---RX Label

   RX.Create(0,"RX",0,0,0,0,0);
   RX.Text("RX");
   RX.Color(clrBlack);
   RX.FontSize(10);
   RX.Font("Arial Bold");
   CompBox.Add(RX);
   RX.Shift((TI_x+370),-22);

//---AO Peak Label

   AO_Peak.Create(0,"AO Peak",0,0,0,0,0);
   AO_Peak.Text("AO Peak");
   AO_Peak.Color(clrBlack);
   AO_Peak.FontSize(10);
   AO_Peak.Font("Arial Bold");
   CompBox.Add(AO_Peak);
   AO_Peak.Shift((TI_x+445),-22);

//---RYT_X  Label

   RYT_X.Create(0,"RYT X",0,0,0,0,0);
   RYT_X.Text("RYT X");
   RYT_X.Color(clrBlack);
   RYT_X.FontSize(10);
   RYT_X.Font("Arial Bold");
   CompBox.Add(RYT_X);
   RYT_X.Shift((TI_x+570),-22);

//---YS_Needed  Label

   YS_Needed.Create(0,"YS Needed",0,0,0,0,0);
   YS_Needed.Text("YS Needed");
   YS_Needed.Color(clrBlack);
   YS_Needed.FontSize(10);
   YS_Needed.Font("Arial Bold");
   CompBox.Add(YS_Needed);
   YS_Needed.Shift((TI_x+670),-22);

//---SA Label

   SA.Create(0,"SA",0,0,0,0,0);
   SA.Text("SA");
   SA.Color(clrBlack);
   SA.FontSize(10);
   SA.Font("Arial Bold");
   CompBox.Add(SA);
   SA.Shift((TI_x+825),-22);

//---Pinch Label

   Pinch.Create(0,"Pinch",0,0,0,0,0);
   Pinch.Text("Pinch");
   Pinch.Color(clrBlack);
   Pinch.FontSize(10);
   Pinch.Font("Arial Bold");
   CompBox.Add(Pinch);
   Pinch.Shift((TI_x+910),-22);

//---SB Label

   SB.Create(0,"SB",0,0,0,0,0);
   SB.Text("SB");
   SB.Color(clrBlack);
   SB.FontSize(10);
   SB.Font("Arial Bold");
   CompBox.Add(SB);
   SB.Shift((TI_x+1020),-22);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
FxTE_Component::~FxTE_Component()
  {
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void FxTE_Component::OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
  
  //---This allows you to take the value of the Edit Box and use it
//  if(id==CHARTEVENT_OBJECT_ENDEDIT&&sparam=="InstruLabel")
//  string EditBox = InstruLabel.Text();
//  printf("Edit Box contains "+ InstruLabel.Text());
////---
//   Dashboard.OnEvent(id,lparam,dparam,sparam);
//
//   string x;
//   if(id==CHARTEVENT_OBJECT_CLICK)
//      x=ObjectGetString(0,sparam,OBJPROP_TEXT);

//+------------------------------------------------------------------+
//|  Show/Hide Boxes                                                 |
//+------------------------------------------------------------------+

//-- ADD INSTRUMENT BOX BUTTON  --  This function is meant to enable the 
//ability to hide/show the "Comp1" box from view.

   //if(id==CHARTEVENT_OBJECT_CLICK && sparam=="ShowPairBoxButton")
   //  {
   //   if(Comp1.IsVisible())
   //      Comp1.Hide();
   //   else
   //      Comp1.Show();
   //  }

//-- SHOW/HIDE MAIN MENU BOX BUTTON  --  


   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="ComponentBoxBmpButton")
      if(ComponentBoxBmpButton.Pressed())
        {
         CompBox.Height(30);
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
        }
   else
     {
      CompBox.Height(270);
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
     }

////This function is meant to enable the ability to hide/show the a NEW box from view.
//   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="AddCompBoxButton")
//     {
//      if(Comp1.IsVisible())
//         Comp1.Hide();
//      else
//         Comp1.Show();
//     }
//
////---Checkbox Group to display TimeFrames INSIDE the Comp1
//
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="1M")
//     {
//      if(OneM.IsVisible())
//        {
//         OneM.Hide();
//         Comp1.Height();
//        }
//      else
//        {
//         OneM.Show();
//         Comp1.Height();
//        }
//     }
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="5M")
//     {
//      if(FiveM.IsVisible())
//         FiveM.Hide();
//      else
//         FiveM.Show();
//     }
//
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="15M")
//     {
//      if(FifteenM.IsVisible())
//         FifteenM.Hide();
//      else
//         FifteenM.Show();
//     }
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="30M")
//     {
//      if(ThirtyM.IsVisible())
//         ThirtyM.Hide();
//      else
//         ThirtyM.Show();
//     }
//
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="1H")
//     {
//      if(OneH.IsVisible())
//         OneH.Hide();
//      else
//         OneH.Show();
//     }
//
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="4H")
//     {
//      if(FourH.IsVisible())
//         FourH.Hide();
//      else
//         FourH.Show();
//     }
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="D1")
//     {
//      if(D1.IsVisible())
//         D1.Hide();
//      else
//         D1.Show();
//     }
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="W1")
//     {
//      if(W1.IsVisible())
//         W1.Hide();
//      else
//         W1.Show();
//     }
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="MN")
//     {
//      if(MN.IsVisible())
//         MN.Hide();
//      else
//         MN.Show();
//     }
//
////---Checkbox Group to display CI's INSIDE the Comp1
//
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="RS")
//     {
//      if(RS.IsVisible())
//        {
//         RS.Hide();
//         Comp1.Width();
//        }
//      else
//        {
//         RS.Show();
//         Comp1.Width();
//        }
//     }
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="NS")
//     {
//      if(NS.IsVisible())
//         NS.Hide();
//      else
//         NS.Show();
//     }
//
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="RX")
//     {
//      if(RX.IsVisible())
//         RX.Hide();
//      else
//         RX.Show();
//     }
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="AO Peak")
//     {
//      if(AO_Peak.IsVisible())
//         AO_Peak.Hide();
//      else
//         AO_Peak.Show();
//     }
//
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="RYT X")
//     {
//      if(RYT_X.IsVisible())
//         RYT_X.Hide();
//      else
//         RYT_X.Show();
//     }
//
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="YS Needed")
//     {
//      if(YS_Needed.IsVisible())
//         YS_Needed.Hide();
//      else
//         YS_Needed.Show();
//     }
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="SA")
//     {
//      if(SA.IsVisible())
//         SA.Hide();
//      else
//         SA.Show();
//     }
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="Pinch")
//     {
//      if(Pinch.IsVisible())
//         Pinch.Hide();
//      else
//         Pinch.Show();
//     }
//   if(id==CHARTEVENT_OBJECT_CLICK && x=="SB")
//     {
//      if(SB.IsVisible())
//         SB.Hide();
//      else
//         SB.Show();
//     }

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
