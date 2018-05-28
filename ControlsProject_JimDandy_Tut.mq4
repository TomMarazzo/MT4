//+------------------------------------------------------------------+
//|                                 ControlsProject_JimDandy_Tut.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#resource "\\Include\\Controls\\res\\UpTransp.bmp"
#resource "\\Include\\Controls\\res\\DownTransp.bmp"

#include <Controls/Dialog.mqh>            //Gets us out Dialog Boxes from the Includes files
#include <Controls/Button.mqh>
#include <Controls/Label.mqh>
#include <Controls/RadioGroup.mqh>
#include <Controls/CheckGroup.mqh> 
#include <Controls/SpinEdit.mqh>


CAppDialog OurInterface;                  //Main Dialog Box is Instanciated here
CDialog OurDialog, Dialog2;               //Inside Dialog Box is Instanciated here
CButton OurButton;                        //CButton gets us access to Button functionality
CEdit OurEdit;
CLabel OurLabel;

CBmpButton OurBmpButton;

CRadioGroup OurRadioGroup;

CCheckBox OurCheckBox;
CCheckGroup OurCheckGroup;

CSpinEdit OurSpin;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  OurInterface.Create(0,"OurInterface",0,0,0,500,300);               //This creates the Main Dialog box.
  OurInterface.Shift(150,0);
//---
OurBmpButton.Create(0,"OurBmpButton",0,0,0,0,0);
OurBmpButton.BmpNames("::Include\\Controls\\res\\UpTransp.bmp","::Include\\Controls\\res\\DownTransp.bmp");
OurInterface.Add(OurBmpButton);
OurBmpButton.Shift(426,-17);

//---



  OurButton.Create(0,"OurButton",0,0,0,120,25);
  OurButton.Color(clrRed);
  OurButton.Width(200);
  OurButton.Height(50);
  OurButton.Text("Show Dialog");
  
//---
 
  OurDialog.Create(0,"OurDialog",0,0,0,250,200);                     //This creates the Interior Dialog box.
  OurDialog.Shift(0,60);
  //---
  
  //SPIN
   OurSpin.Create(0,"OurSpin",0,0,90,50,120);
   OurSpin.MaxValue(100);
   OurSpin.MinValue(1);
   OurSpin.Value(50);
   OurDialog.Add(OurSpin);
   OurSpin.Shift(10,50);
  
  OurCheckBox.Create(0,"OurCheckBox",0,0,30,75,60);
  OurDialog.Add(OurCheckBox);
  OurCheckBox.Text("Check");
  OurCheckBox.Color(clrRed);
  //---
  OurCheckGroup.Create(0,"OurCheckGroup",0,100,30,230,100);
  OurCheckGroup.AddItem("Grid");
  OurCheckGroup.AddItem("OHLC");
  OurCheckGroup.AddItem("Seperators");
  OurCheckGroup.AddItem("Price Scale");
  OurCheckGroup.AddItem("Volumes");
  OurDialog.Add(OurCheckGroup);
  
  
  Dialog2.Create(0,"Dialog2",0,251,0,451,150);
  //---
  OurRadioGroup.Create(0,"OurRadioGroup",0,0,0,150,100);
  OurRadioGroup.AddItem("White");
  OurRadioGroup.AddItem("Black");
  OurRadioGroup.AddItem("Khaki");
  OurRadioGroup.AddItem("Yellow");
  OurRadioGroup.AddItem("Olive");
  Dialog2.Add(OurRadioGroup);
  Dialog2.Shift(0,60);
  //---
  
  OurLabel.Create(0,"OurLabel",0,0,0,0,0);
  OurLabel.Text(_Symbol+"  "+(string)_Period+"M");
  OurLabel.Color(clrGreen);
  OurLabel.FontSize(10);
  OurLabel.Font("Arial Bold");
  OurInterface.Add(OurLabel);
  OurLabel.Shift(175,-22);
  
  
 //---
  OurEdit.Create(0,"OurEdit",0,0,0,125,30);
  OurEdit.Text(_Symbol);
  OurDialog.Add(OurEdit);
  OurEdit.Color(clrBlue);
  OurEdit.ColorBorder(clrBlack);
  OurEdit.ColorBackground(clrYellow);
  OurEdit.Font("Courier");
  OurEdit.FontSize(14);
  OurEdit.TextAlign(ALIGN_LEFT);
  OurEdit.ReadOnly(false);
  
  //---
  
 
  OurInterface.Add(OurDialog);                                       //This puts the Interior Box, inside the Main Box
  OurInterface.Add(Dialog2);
  OurInterface.Add(OurButton);
  OurInterface.Run();                                                //This enables all of the controls to work in the Box
  
//--- create timer
   EventSetTimer(60);
      
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
    OurInterface.Destroy(reason);         //Without this line, our box will be destroyed from memory. We MUST have this line.  
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
}
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   OurInterface.OnEvent(id,lparam,dparam,sparam);  
   
   string x;
   if(id==CHARTEVENT_OBJECT_CLICK)
   x=ObjectGetString(0,sparam,OBJPROP_TEXT);
   
                     //This function is meant to enable the ability to hide/show the "OurDialog" box from view.
   if(id==CHARTEVENT_OBJECT_CLICK&&sparam=="OurButton")
   {
   if(OurDialog.IsVisible())
   OurDialog.Hide();
   else
   OurDialog.Show();
   }
   
   if(id==CHARTEVENT_OBJECT_ENDEDIT&&sparam=="OurEdit")
   Print("Edit box contains ",OurEdit.Text());
   if(id==CHARTEVENT_OBJECT_CLICK&&sparam=="OurLabel")
   OurInterface.Shift(0,30);
   
    if(id==CHARTEVENT_OBJECT_CLICK&&sparam=="OurBmpButton")
    if(OurBmpButton.Pressed())
    {
    OurInterface.Height(30);
    OurButton.Hide();
    OurDialog.Hide();
    Dialog2.Hide();
    }
    else
    {
    OurInterface.Height(300);
    OurButton.Show();
    OurDialog.Show();
    Dialog2.Show();
    }
    
    if(id==CHARTEVENT_OBJECT_CLICK&&sparam=="OurRadioGroupItem0Button")
    ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrWhite);
   if(id==CHARTEVENT_OBJECT_CLICK&&sparam=="OurRadioGroupItem1Button")
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack);
   if(id==CHARTEVENT_OBJECT_CLICK&&sparam=="OurRadioGroupItem2Button")
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrKhaki);
   if(id==CHARTEVENT_OBJECT_CLICK&&sparam=="OurRadioGroupItem3Button")
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrYellow);
   if(id==CHARTEVENT_OBJECT_CLICK&&sparam=="OurRadioGroupItem4Button")
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrOlive);
   
   if(id==CHARTEVENT_OBJECT_CLICK&&sparam=="OurCheckBoxButton")
   if(OurCheckBox.Checked()) Print("checked");
   else Print ("Not Checked");
   
   //---Checkbox Group
   
    if(id==CHARTEVENT_OBJECT_CLICK&& x=="Grid")
    {
    if(OurCheckGroup.Check(0))
    ChartSetInteger(0,CHART_SHOW_GRID, false);
    else
    ChartSetInteger(0,CHART_SHOW_GRID, true);
    }
    
    
    if(id==CHARTEVENT_OBJECT_CLICK&& x=="OHLC")
    {
    if(OurCheckGroup.Check(1))
    ChartSetInteger(0,CHART_SHOW_OHLC, false);
    else
    ChartSetInteger(0,CHART_SHOW_OHLC, true);
    }
    
    
    if(id==CHARTEVENT_OBJECT_CLICK&& x=="Separators")
    {
    if(OurCheckGroup.Check(2))
    ChartSetInteger(0,CHART_SHOW_PERIOD_SEP, false);
    else
    ChartSetInteger(0,CHART_SHOW_PERIOD_SEP, true);
    }
    
    
    if(id==CHARTEVENT_OBJECT_CLICK&& x=="Price Scale")
    {
    if(OurCheckGroup.Check(3))
    ChartSetInteger(0,CHART_SHOW_PRICE_SCALE, false);
    else
    ChartSetInteger(0,CHART_SHOW_PRICE_SCALE, true);
    }
    
    
    if(id==CHARTEVENT_OBJECT_CLICK&& x=="Volumes")
    {
    if(OurCheckGroup.Check(4))
    ChartSetInteger(0,CHART_SHOW_VOLUMES, false);
    else
    ChartSetInteger(0,CHART_SHOW_VOLUMES, true);
    }
    
   if(id==CHARTEVENT_OBJECT_CLICK&& sparam=="OurSpinDec")
   Print("The Spin edit is set to ", OurSpin.Value());
   if(id==CHARTEVENT_OBJECT_CLICK&& sparam=="OurSpinInc")
   Print("The Slider edit is set to ", OurSpin.Value());
    
   
  }
//+------------------------------------------------------------------+
