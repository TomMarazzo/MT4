//+------------------------------------------------------------------+
//|                                             TestObjectCreate.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
    //SetArrowUpObject();
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
                
                
  {
//---
  SetArrowUpObject();
   
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
void SetArrowUpObject()
  {
  string name = "Tom";
   ObjectCreate(name,OBJ_ARROW_UP,0,0,0);
   //ObjectSetInteger(name,OBJPROP_COLOR,clrYellow);
   //ObjectSetInteger(name,OBJPROP_CORNER,0);
   //ObjectSetInteger(name,OBJPROP_XDISTANCE,40);
   //ObjectSetInteger(name,OBJPROP_YDISTANCE,40);
  }
