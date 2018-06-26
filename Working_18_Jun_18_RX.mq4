//+------------------------------------------------------------------+
//|                                                           RX.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| When the Purple Arrow apears from the (ZigZag 144,89,55), this is|
//|the Royal Pointer. If 34EMA crosses ABOVE 144 Tunnel - it is Long.|
//|If 34EMA crosses BELOW 169 Tunnel - it is Short.                  |
//|The Signal will end when Price goes ABOVE Purple Arrow Value1     |
//|OR BELOW Purple Arrow Value2                                      |                                                
//+------------------------------------------------------------------+


#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 8

#property indicator_color1 clrBlue //Up
#property indicator_color2 clrRed //Down
#property indicator_color3 clrWhite
#property indicator_color4 clrWhite

#property indicator_color5 clrBlue
#property indicator_color6 clrRed
#property indicator_width5 5
#property indicator_width6 5
//--RS Indicator
#property indicator_color7 clrPurple
#property indicator_color8 clrPurple
#property indicator_width7 5
#property indicator_width8 5

//---External User Settings
extern int LowEMA=34;//Fast Moving Average Low
extern int HighEMA=34;//Fast Moving Average High

extern int fastTunnel = 144;//144 EMA Tunnel
extern int slowTunnel = 169;//169 EMA Tunnel

extern ENUM_MA_METHOD method=MODE_EMA;//Select EMA Method
extern ENUM_APPLIED_PRICE appliedToHigh= PRICE_HIGH;
extern ENUM_APPLIED_PRICE appliedToLow = PRICE_LOW;
extern ENUM_APPLIED_PRICE appliedToClose=PRICE_CLOSE;

extern bool ShowMovingAverages=true;//Show Moving Average Lines?

double emaHigh34[];
double emaLow34[];
double ema144[];
double ema169[];
double upArrow[];
double dnArrow[];

double upRS[];
double dnRS[];

string windowsName= "Royal Cross";
string sLabelCode = "RX";
int iWindow;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//---EMA HIGH 34 Buffer  
   SetIndexBuffer(0,emaHigh34);
   SetIndexStyle(0,DRAW_LINE);
   SetIndexLabel(0,"34 EMA");
//---EMA LOW 34 Buffer  
   SetIndexBuffer(1,emaLow34);
   SetIndexStyle(1,DRAW_LINE);
   SetIndexLabel(1,"34 EMA");

//---EMA144 Buffer  
   SetIndexBuffer(2,ema144);
   SetIndexStyle(2,DRAW_LINE);
   SetIndexLabel(2,"144 EMA");
//---EMA169 Buffer  
   SetIndexBuffer(3,ema169);
   SetIndexStyle(3,DRAW_LINE);
   SetIndexLabel(3,"169 EMA");

//---EMA34 Buffer  
   SetIndexBuffer(4,upArrow);
   SetIndexStyle(4,DRAW_ARROW);
   SetIndexArrow(4,233);
   SetIndexLabel(4,"34 EMA Crosses ABOVE 144 EMA");

//---EMA34 Buffer  
   SetIndexBuffer(5,dnArrow);
   SetIndexStyle(5,DRAW_ARROW);
   SetIndexArrow(5,234);
   SetIndexLabel(5,"34 EMA Crosses BELOW 169 EMA");

//   //---RS Up Buffer  
   SetIndexBuffer(6,upRS);
   SetIndexStyle(6,DRAW_ARROW);
   SetIndexArrow(6,233);
   SetIndexLabel(6,"Value 1 RS Indicator Long");

////---RS Down Buffer  
   SetIndexBuffer(7,dnRS);
   SetIndexStyle(7,DRAW_ARROW);
   SetIndexArrow(7,234);
   SetIndexLabel(7,"Value 2 RS Indicator Short");

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
  double price = Bid;
   int lookback=100,lastbar=0;;
   int counted_bars=IndicatorCounted();
   int limit = Bars-counted_bars;
   for(int i = 0;i<limit;i++)
     {

      double currentEMALow34=iMA(NULL,0,LowEMA,0,method,appliedToLow,i);
      double currentEMAHigh34=iMA(NULL,0,HighEMA,0,method,appliedToHigh,i);
      double previousEMALow34=iMA(NULL,0,LowEMA,0,method,appliedToLow,i+1);
      double previousEMAHigh34=iMA(NULL,0,HighEMA,0,method,appliedToHigh,i+1);

      double currentEMA144=iMA(NULL,0,fastTunnel,0,method,appliedToClose,i);
      double previousEMA144=iMA(NULL,0,fastTunnel,0,method,appliedToClose,i+1);
      double currentEMA169=iMA(NULL,0,slowTunnel,0,method,appliedToClose,i);
      double previousEMA169=iMA(NULL,0,slowTunnel,0,method,appliedToClose,i+1);

      double RoyalPointerUp = iCustom(NULL, PERIOD_CURRENT, "RS", 144, 89, 55, 0, i);
      double RoyalPointerDn = iCustom(NULL, PERIOD_CURRENT, "RS", 144, 89, 55, 1, i);

      upRS[i]=RoyalPointerUp;
      for(int j=lookback+lastbar;j>lastbar+1;j--)
        {
         if(upRS[i]!=0)
            Comment("Value of Long RS is ",upRS[i]);
        }
      dnRS[i]=RoyalPointerDn;
      for(int j=lookback+lastbar;j>lastbar+1;j--)
        {
         if(dnRS[i]!=0)
            Comment("Value of Short RS is ",dnRS[i]);
        }

      if(ShowMovingAverages)
        {
         emaHigh34[i]=currentEMAHigh34;
         emaLow34[i]=currentEMALow34;
         ema144[i]=currentEMA144;
         ema169[i]=currentEMA169;

        }
      //LONG
      if(currentEMALow34>currentEMA169 && previousEMALow34<previousEMA169)// && Bid>RoyalPointerUp)

        {
         upArrow[i]=currentEMALow34-0.001;
        }
      //SHORT
      else if(currentEMAHigh34<currentEMA144 && previousEMAHigh34>previousEMA144)// && Bid<RoyalPointerDn)
        {
         dnArrow[i]=currentEMAHigh34+0.001;
        }
      
      //LONG DELETE
      if(price < upRS[i])
      ObjectDelete(0,"upArrow");
   
     }

   return(rates_total);
  }
//+------------------------------------------------------------------+

void SetLabelObject(string sName,string sText,color dColor,int xx,int yy)
  {
   ObjectCreate(sName,OBJ_LABEL,iWindow,0,0);
  }

//+------------------------------------------------------------------+
//| Set Arrow Object
//+------------------------------------------------------------------+
//void SetArrowObject(string sName, int ArrowCode, int iHeight, color dColor, int xx, int yy)
//{
//   ObjectCreate(sName, OBJ_LABEL, iWindow, 0, 0);
//   ObjectSetText(sName,CharToStr(ArrowCode),iHeight, "Wingdings", dColor);
//}
