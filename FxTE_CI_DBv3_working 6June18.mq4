//+------------------------------------------------------------------+
//|                                 FxTE_CI_DBv3_working 6June18.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//#property strict
#include <stdlib.mqh>
#include <stderror.mqh>
#include <Controls/Label.mqh>

//CLabel Instrument;
//CLabel RS,NS,RX,AO_Peak,RYT_X,YS_Needed,SA,Pinch,SB;

#property indicator_chart_window


//---Instrument variables
extern string SymbolSuffix       =  "";//- If your broker names the currency pairs with a suffix for a mini account (like an "m", for example), enter the suffix here
extern string PairsList1         =  "AUDCAD,AUDJPY,AUDUSD,CADJPY,CHFJPY,EURAUD,EURCAD,EURCHF,EURGBP,EURJPY,EURUSD,";
extern string PairsList2         =  "GBPCHF,GBPJPY,GBPUSD,NZDCHF,NZDJPY,NZDUSD,USDCAD,USDCHF,USDJPY,";
extern string PairsList3         =  "GLD,SLV,OIL";//- This is where you add the currency pairs you want

//---Custom Indicator variables
extern bool RS                   =  true;
extern bool NS                   =  true;
extern bool RX                   =  true;
extern bool AO_Peak              =  true;
extern bool RYT_X                =  true;
extern bool YS_Needed            =  true;
extern bool SA                   =  true;
extern bool Pinch                =  true;
extern bool SB                   =  true;
extern string CustomIndicatorList=  "RX,YX,YWX,RYT X,AO Peak,YS Needed,SA,Pinch,SB";

//---Timeframe Variables
extern string TimeFrameList      =  "5,15,30,60,240,1440";
//---- colors
extern color colorTitle          =  clrDodgerBlue;    //Custom Indicator Titles
extern color colorInstrument     =  clrOrchid;        //Instrument Color
extern int FontSize              =  9;
extern int ColumnSpacing         =  150;              //Sets the horizontal distance between each CI titles

//extern color colorTimeFrame    =  clrWhite; 

extern color backgroundColor     = clrBlack; //Set Background Color
extern bool ShowGrid             = false;
int NumberCustomIndcators;
double iCI[10];
string sCI[10];



extern int ShiftSignals=1;
extern int refreshPeriod=PERIOD_M1; // refresh calcultion
extern double SAR_Step = 0.02;
extern double SAR_Max  = 0.2;
//---- constants
string windowsName= "Forex Trader's Edge";
string sLabelCode = "FXTE Dashboard";
int Corner_LeftUp = 0;
int Corner_RightUp= 1;
int Corner_LeftDn = 2;
int Corner_RightDn= 3;

//---- variables
string PairsList;
string Pair[100]; //Pairs array

int nCustomIndicatorTitles=20;

int nTitles=30;
string Title_1[50];
datetime oldTime,thisTime;
bool CurrentTimeFrameOK;
double iTimeFrame[10];
string sTimeFrame[10];
int TimeFrame;
string CI;
int NumberSymbols,NumberTimeFrames;

int iWindow,iCorner;
int xCol[50],yRow[50];

//CURRENCY PAIRS
int colDB_Pairs;
//TIMEFRAME COLUMN
//int iColDB_First, colDB_M5, colDB_M15, colDB_M30, colDB_H1, colDB_H4, colDB_D1, colDB_W1;

//CI COLUMN
int iColDB_First,colDB_RX,colDB_YX,colDB_YWX,colDB_RYT_X,colDB_AO_Peak,colDB_YS_Needed,colDB_SA,colDB_Pinch,colDB_SB;

int xLeftTitle=20;
int xCurrentTime=3;

int yCurrentTime=15;
int yTitle_1=50;

int rowStep=30;                                       //Vertical height of each row
int colStep= 150;
int colStepTimeFrames=85;

color colorTime=clrDarkGray;

//-- Signal buffers
double dSAR[30][10][5], dRX[30][10][5][30], dYX[30][10][5][30], dYWX[30][10][5][30],dRYT_X[30][10][5][30],dAO_Peak[30][10][5][30], dYS_Needed[30][10][5][30],dSA[30][10][5][30],dPinch[30][10][5][30],dSB[30][10][5][30],AlertSignal[30][10];

color colorPlusIndi  = Green;
color colorMinusIndi = Red;
color colorPlusSignal  = DeepSkyBlue;
color colorMinusSignal = Magenta;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {

   PairsList=StringConcatenate(PairsList1,PairsList2,PairsList3);
   iCorner=Corner_LeftUp;
   CurrentTimeFrameOK=false;
   TimeFrame=Period();
   CI=CustomIndicatorList;
   oldTime=0;
//----   
   IndicatorShortName(windowsName);
   SetIndexLabel(0,windowsName);
//-- clear Titles
   for(int i=0; i<=50; i++)
     {
      Title_1[i]="";
      //Title_2[i] = "";
     }
//-- clear Time Frames
   for(i=0; i<=10; i++)
     {
      iCI[i] = 0;
      sCI[i] = "";
      iTimeFrame[i] = 0;
      sTimeFrame[i] = "";
     }

//---- Instrument Pairs
   Get_PairListNames();    //MUST KEEP TO DISPLAY PAIRS
   Set_Initialisations();  //MUST KEEP TO DISPLAY PAIRS
   Show_TitlesLeft();      //MUST KEEP TO DISPLAY PAIRS
   Show_TitlesUpper();

//----Custom Indicator Titles;
//Get_CustomIndicatorList();

//---- indicators 
//Get_IndicatorValues();
   Write_CurrentTime(xCurrentTime,yCurrentTime);
   
   //---Display Chart Settings   
   ChartBackColorSet(backgroundColor,0);
   ChartForeColorSet(backgroundColor,0); 
   ChartShowGridSet(ShowGrid,0);
   ChartUpColorSet(backgroundColor,0);
   ChartDownColorSet(backgroundColor,0); 
   ChartLineColorSet(backgroundColor,0); 
   ChartBullColorSet(backgroundColor,0);
   ChartBearColorSet(backgroundColor,0);
   ChartBidColorSet(backgroundColor,0);
   ChartAutoscrollSet(false,0);
   ChartShowOHLCSet(false,0);
   
   //---Get the values from teh indicators   
   Get_IndicatorValues();
  

   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|      END OF onInit()                                             |
//+------------------------------------------------------------------+
bool Check_ShiftSignals()
  {
   if(ShiftSignals<0)
     {
      Alert("ShiftSignals must be greater or equal 0!");
      return(false);
     }
   return(true);
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

//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
   Delete_TextObjects();
   Sleep(500);
   Delete_TextObjects();
//----
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Delete_TextObjects()
  {
   ObjectsDeleteAll(1,OBJ_LABEL);
   ObjectsDeleteAll(1,OBJ_TEXT);
   ObjectsDeleteAll(1,OBJ_ARROW);
   return;
  }
//+------------------------------------------------------------------+

//####################################################################

//+------------------------------------------------------------------+
//|      Set the Columns for the Custom Indicators                   |
//+------------------------------------------------------------------+
void Set_ColumnNumbers()
  {
   int iCol=1;
   colDB_Pairs=iCol; iCol=iCol+1;            //Pairs

   colDB_RX=iCol; iCol=iCol+1;          //Begining of CIs
   colDB_YX = iCol; iCol = iCol +1;
   colDB_YWX = iCol; iCol = iCol +1;
   colDB_RYT_X=iCol; iCol=iCol+1;
   colDB_AO_Peak=iCol; iCol=iCol+1;
   colDB_YS_Needed=iCol; iCol=iCol+1;
   colDB_SA=iCol; iCol=iCol+1;
   colDB_Pinch=iCol; iCol=iCol+1;
   colDB_SB=iCol; iCol=iCol+1;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Set_Initialisations()
  {
   int i;
   Set_ColumnNumbers();
   string thisTimeFrame=Get_sPeriod(Period());

//-- Title 1 => Custom Indicators
   //Title_1[colDB_Pairs]="  ";
   if(RS==true){Title_1[colDB_RX]="RX";}
   if(NS==true){Title_1[colDB_YX] = "YX";}
   if(RX==true){Title_1[colDB_YWX] = "YWX";}
   if(RYT_X==true){ Title_1[colDB_RYT_X]="RYT X";}
   if(AO_Peak==true){Title_1[colDB_AO_Peak]="AO Peak";}   
   if(YS_Needed==true){Title_1[colDB_YS_Needed]="YS Needed";}
   if(SA==true){Title_1[colDB_SA]="SA";}
   if(Pinch==true){Title_1[colDB_Pinch]="Pinch";}
   if(SB==true){ Title_1[colDB_SB]="SB";}   


//---- x Columns ..................................................  
   int iCol=iColDB_First+1;
   xCol[iCol]=xCol[iCol-1]+ColumnSpacing;

   for(i=iCol+1; i<nCustomIndicatorTitles; i++)
      xCol[i]=xCol[i-1]+ColumnSpacing;

//---- y Rows .....................................................
   yRow[0]=yTitle_1+rowStep;
   for(i=1; i<=NumberSymbols; i++)
      yRow[i]=yRow[i-1]+rowStep;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Show_TitlesUpper()
  {
   int xx1;
   for(int i=1; i<nTitles; i++) 
     {
      xx1=xCol[i];
      //-- Adjust xCol
      if(i==colDB_Pairs) xx1=xx1-10;

      if(Title_1[i]!="")
         SetLabelObject(sLabelCode+"Title1_"+i,Title_1[i],colorTitle,xx1,yTitle_1);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Show_TitlesLeft()
  {
   for(int i=0; i<NumberSymbols; i++)
     {
      string sSymbol=Pair[i];
      int j=i+1;
      if(j<10) string sNr="0"+j+". "; else sNr=j+". ";
      string sNrSymbol=sNr+sSymbol;
      //-- Names
      SetLabelObject(sLabelCode+sSymbol,sNrSymbol,colorInstrument,xLeftTitle,yRow[i]);

     }
  }
//####################################################################
//+------------------------------------------------------------------+
//| Create Titles
//+------------------------------------------------------------------+
void Write_CurrentTime(int xx,int yy)
  {
   string sTime=TimeToStr(TimeCurrent(),TIME_DATE|TIME_MINUTES);
   string s_TimeFrame=Get_sPeriod(TimeFrame);
   string st=sTime+"   "+Symbol()+", "+s_TimeFrame;
   SetTimeObject(sLabelCode+"time",st,colorTime,xx,yy);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetLabelObject(string sName,string sText,color dColor,int xx,int yy) //Sets the size of the fonts
  {
   ObjectCreate(sName,OBJ_LABEL,iWindow,0,0);
   ObjectSetText(sName,sText,FontSize,"Arial Bold",dColor);
   ObjectSet(sName,OBJPROP_CORNER,iCorner);
   ObjectSet(sName,OBJPROP_XDISTANCE,xx);
   ObjectSet(sName,OBJPROP_YDISTANCE,yy);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetTimeObject(string sName,string sText,color dColor,int xx,int yy)
  {
   ObjectCreate(sName,OBJ_LABEL,iWindow,0,0);
   ObjectSetText(sName,sText,10,"Arial Bold",dColor);
   ObjectSet(sName,OBJPROP_CORNER,iCorner);
   ObjectSet(sName,OBJPROP_XDISTANCE,xx);
   ObjectSet(sName,OBJPROP_YDISTANCE,yy);
  }
//+------------------------------------------------------------------+
//| Set Arrow Object
//+------------------------------------------------------------------+
void SetArrowObject(string sName,int ArrowCode,int iHeight,color dColor,int xx,int yy)
  {
   ObjectCreate(sName,OBJ_LABEL,iWindow,0,0);
   ObjectSetText(sName,CharToStr(ArrowCode),iHeight,"Wingdings",dColor);
   ObjectSet(sName,OBJPROP_CORNER,iCorner);
   ObjectSet(sName,OBJPROP_XDISTANCE,xx);
   ObjectSet(sName,OBJPROP_YDISTANCE,yy);
  }
//+------------------------------------------------------------------+
//|      Get PairList Names
//+------------------------------------------------------------------+
void Get_PairListNames()
  {
   int i,j,k;
   string CurSymbol;

   for(i=0,j=0,k=1; i<nTitles && k>0;)
     {
      k=StringFind(PairsList,",",j);
      if(k==0) CurSymbol=StringSubstr(PairsList,j,0);
      else CurSymbol=StringSubstr(PairsList,j,k-j);
      CurSymbol=CurSymbol+SymbolSuffix;
      //---- check if the pair is allowable
      double dClose=iClose(CurSymbol,TimeFrame,0);
      if(dClose>0.0)
        {
         Pair[i]=CurSymbol;
         i++;
        }

      j=StringFind(PairsList,",",j)+1;
      if(j==0) break;
     }
   NumberSymbols=i;

   return;
  }
//+------------------------------------------------------------------+
//|    Set the ROWs for the Custom Indicators                        |
//+------------------------------------------------------------------+
//void Get_CustomIndicatorList()
//  {
//   int i,j,k;
//   string CurCustIndicators;
//
//   for(i=0,j=0,k=1; i<nTitles && k>0;)
//     {
//      k=StringFind(CustomIndicatorList,",",j);
//      if(k==0) CurCustIndicators=StringSubstr(CustomIndicatorList,j,0);
//      else CurCustIndicators=StringSubstr(CustomIndicatorList,j,k-j);
//
//      iCI[i]=StrToInteger(CurCustIndicators);
//      i++;
//
//      j=StringFind(CustomIndicatorList,",",j)+1;
//      if(j==0) break;
//     }
//   NumberCustomIndcators=i-1;
//
//   return;
//  }
//####################################################################
//+------------------------------------------------------------------+
//|      GET INDICATOR VALUES                                        |
//+------------------------------------------------------------------+
void Get_IndicatorValues()
{
int iArrow, iHeight=8, iHeightSignal = 10, xStep=8;
color dColor;

for (int i=NumberSymbols-1; i>=0; i--) { 
      string sSymbol = Pair[i];
  for (int col = 0; col <= NumberTimeFrames; col++) {         
         double dClose1 = iClose(sSymbol,iTimeFrame[col],ShiftSignals);
         double dClose2 = iClose(sSymbol,iTimeFrame[col],ShiftSignals+1);
         //---Indicators here
         
         //-- SAR values
         int xSAR = xCol[colDB_RX + col];
         dSAR[i][col][1] = iSAR(sSymbol,iTimeFrame[col],SAR_Step,SAR_Max,ShiftSignals);
         dSAR[i][col][2] = iSAR(sSymbol,iTimeFrame[col],SAR_Step,SAR_Max,ShiftSignals+1);
         if (dClose1 >= dSAR[i][col][1]) int iValue_SAR1 = 1; else iValue_SAR1 = -1;
         if (dClose2 >= dSAR[i][col][2]) int iValue_SAR2 = 1; else iValue_SAR2 = -1;
         switch (iValue_SAR1) {
            case  1: iArrow = 217; dColor = colorPlusIndi;  break;
            case -1: iArrow = 218; dColor = colorMinusIndi; break;
         } 
         SetArrowObject(sLabelCode+sSymbol+"_iSAR"+sTimeFrame[col], iArrow, iHeight, dColor, xSAR, yRow[i]);
         
         //-- RoyalCross - RX
         double xRX = iCustom(NULL, PERIOD_CURRENT, "RX", 144, 89, 55, 1, 0);
         xRX = xCol[colDB_RX + col]+ xStep;
         //dRX[i][col][1][0] = RoyalCross_Signal(sSymbol,iTimeFrame[col],ShiftSignals);
         //dRX[i][col][1][0] = RoyalCross_Signal(sSymbol,iTimeFrame[col],ShiftSignals+1);
         //dRX[i][col][1][0] = RoyalCross_Signal(sSymbol,iTimeFrame[col],ShiftSignals+2);


         //-- Signals
         int xSignal = xCol[colDB_RX + col] + 3*xStep;         
         int iSignal_SAR=0,iOrderType=0;// iSignal_AC=0, iSignal_AO=0, ;
         if (iValue_SAR1 == 1 && iValue_SAR2 ==-1) iSignal_SAR = 1;
         if (iValue_SAR1 == -1 && iValue_SAR2 ==1) iSignal_SAR = -1;
//         
//         if (iValue_AC1 == 1 && iValue_AC2 ==-1) iSignal_AC = 1;
//         if (iValue_AC1 == -1 && iValue_AC2 ==1) iSignal_AC = -1;
//         
//         if (iValue_AO1 == 1 && iValue_AO2 ==-1) iSignal_AO = 1;
//         if (iValue_AO1 == -1 && iValue_AO2 ==1) iSignal_AO = -1;
//         
         if(iSignal_SAR ==1) iOrderType=1;   //      if(iSignal_SAR ==1 && iSignal_AC ==1 && iSignal_AO==1) iOrderType=1;
         if(iSignal_SAR ==-1) iOrderType=-1;//         if(iSignal_SAR ==-1 && iSignal_AC ==-1 && iSignal_AO==-1) iOrderType=-1;
//         
         int xOffset = 15; 
         int yOffset = 2;
         int xx = xSignal + xOffset;         
//         if (iOrderType == 1) {
//            iArrow = 233;
//            dColor = colorPlusSignal;
//            string sPrice = Get_EntryPrice(iOrderType, sSymbol, iTimeFrame[col]);
//            SetArrowObject(sLabelCode+sSymbol+"_iSignal"+sTimeFrame[col], iArrow, iHeightSignal, dColor, xSignal, yRow[i]);
//            int yy = yRow[i];
//            SetLabelObject(sLabelCode+sSymbol+"_dEntry"+sTimeFrame[col], sPrice, dColor, xx, yy);
//            if (SendAlert_Signals)  function_SendAlert(iOrderType, sSymbol, iTimeFrame[col], sTimeFrame[col], sPrice, i, col);
//            else
//            if (PrintAlert_Signals) function_PrintAlert(iOrderType, sSymbol, iTimeFrame[col], sTimeFrame[col], sPrice, i, col);
//         }
//         else
//         if (iOrderType == -1) {
//            iArrow = 234;
//            dColor = colorMinusSignal;
//            sPrice = Get_EntryPrice(iOrderType, sSymbol, iTimeFrame[col]);
//            SetArrowObject(sLabelCode+sSymbol+"_iSignal"+sTimeFrame[col], iArrow, iHeightSignal, dColor, xSignal, yRow[i]);  
//            yy = yRow[i] - yOffset;
//            SetLabelObject(sLabelCode+sSymbol+"_dEntry"+sTimeFrame[col], sPrice, dColor, xx, yy);
//            if (SendAlert_Signals)  function_SendAlert(iOrderType, sSymbol, iTimeFrame[col], sTimeFrame[col], sPrice, i, col);
//            else
//            if (PrintAlert_Signals) function_PrintAlert(iOrderType, sSymbol, iTimeFrame[col], sTimeFrame[col], sPrice, i, col);
//         }
//         else {
//            SetLabelObject(sLabelCode+sSymbol+"_iSignal"+sTimeFrame[col], " ", Black, xSignal, yRow[i]);
//            SetLabelObject(sLabelCode+sSymbol+"_dEntry"+sTimeFrame[col], " ", Black, xx, yy);
//            AlertSignal[i][col] = 0;
//         }
      }
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Get_sPeriod(int timeframe)
  {
   if(timeframe == PERIOD_M1) return("M1");
   if(timeframe == PERIOD_M5) return("M5");
   if(timeframe == PERIOD_M15) return("M15");
   if(timeframe == PERIOD_M30) return("M30");
   if(timeframe == PERIOD_H1) return("H1");
   if(timeframe == PERIOD_H4) return("H4");
   if(timeframe == PERIOD_D1) return("D1");
   if(timeframe == PERIOD_W1) return("W1");
   if(timeframe == PERIOD_MN1) return("MN1");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Get_CI(string c_i)
  {
   if(c_i == "RX") return("RX");
   if(c_i == "YX") return("YX");
   if(c_i == "YWX") return("YWX");
   if(c_i == "RYT_X") return("RYT_X");
   if(c_i == "AO_Peak") return("AO_Peak");   
   if(c_i == "YS_Needed") return("YS_Needed");
   if(c_i == "SA") return("SA");
   if(c_i == "Pinch") return("Pinch");
   if(c_i == "SB") return("SB");
  }
//+------------------------------------------------------------------+
//|   CHART DISPLAY FUNCTIONS                                        |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+ 
//| The function sets chart background color.                        | 
//+------------------------------------------------------------------+ 
bool ChartBackColorSet(const color clr,const long chart_ID=0) 
  { 
//--- reset the error value 
   ResetLastError(); 
//--- set the chart background color 
   if(!ChartSetInteger(chart_ID,CHART_COLOR_BACKGROUND,clr)) 
     { 
      //--- display the error message in Experts journal 
      Print(__FUNCTION__+", Error Code = ",GetLastError()); 
      return(false); 
     } 
//--- successful execution 
   return(true); 
  }
//+------------------------------------------------------------------+ 
//| The function sets the color of axes, scale and OHLC line.        | 
//+------------------------------------------------------------------+ 
bool ChartForeColorSet(const color clr,const long chart_ID=0) 
  { 
//--- reset the error value 
   ResetLastError(); 
//--- set the color of axes, scale and OHLC line 
   if(!ChartSetInteger(chart_ID,CHART_COLOR_FOREGROUND,clr)) 
     { 
      //--- display the error message in Experts journal 
      Print(__FUNCTION__+", Error Code = ",GetLastError()); 
      return(false); 
     } 
//--- successful execution 
   return(true); 
  }
//+------------------------------------------------------------------+ 
//| The function sets color of down bar, its shadow and              | 
//| border of a bearish candlestick's body.                          | 
//+------------------------------------------------------------------+ 
bool ChartDownColorSet(const color clr,const long chart_ID=0) 
  { 
//--- reset the error value 
   ResetLastError(); 
//--- set the color of down bar, its shadow and border of bearish candlestick's body 
   if(!ChartSetInteger(chart_ID,CHART_COLOR_CHART_DOWN,clr)) 
     { 
      //--- display the error message in Experts journal 
      Print(__FUNCTION__+", Error Code = ",GetLastError()); 
      return(false); 
     } 
//--- successful execution 
   return(true); 
  }
//+------------------------------------------------------------------+ 
//| The function sets the color of the chart line and Doji           | 
//| candlesticks.                                                    | 
//+------------------------------------------------------------------+ 
bool ChartLineColorSet(const color clr,const long chart_ID=0) 
  { 
//--- reset the error value 
   ResetLastError(); 
//--- set color of the chart line and Doji candlesticks 
   if(!ChartSetInteger(chart_ID,CHART_COLOR_CHART_LINE,clr)) 
     { 
      //--- display the error message in Experts journal 
      Print(__FUNCTION__+", Error Code = ",GetLastError()); 
      return(false); 
     } 
//--- successful execution 
   return(true); 
  }
//+------------------------------------------------------------------+ 
//| The function sets color of bullish candlestick's body.           | 
//+------------------------------------------------------------------+ 
bool ChartBullColorSet(const color clr,const long chart_ID=0) 
  { 
//--- reset the error value 
   ResetLastError(); 
//--- set the color of bullish candlestick's body 
   if(!ChartSetInteger(chart_ID,CHART_COLOR_CANDLE_BULL,clr)) 
     { 
      //--- display the error message in Experts journal 
      Print(__FUNCTION__+", Error Code = ",GetLastError()); 
      return(false); 
     } 
//--- successful execution 
   return(true); 
  }
//+------------------------------------------------------------------+ 
//| The function sets color of bearish candlestick's body.           | 
//+------------------------------------------------------------------+ 
bool ChartBearColorSet(const color clr,const long chart_ID=0) 
  { 
//--- reset the error value 
   ResetLastError(); 
//--- set the color of bearish candlestick's body 
   if(!ChartSetInteger(chart_ID,CHART_COLOR_CANDLE_BEAR,clr)) 
     { 
      //--- display the error message in Experts journal 
      Print(__FUNCTION__+", Error Code = ",GetLastError()); 
      return(false); 
     } 
//--- successful execution 
   return(true); 
  } 
//+------------------------------------------------------------------+ 
//| The function sets the color of Bid line.                         | 
//+------------------------------------------------------------------+ 
bool ChartBidColorSet(const color clr,const long chart_ID=0) 
  { 
//--- reset the error value 
   ResetLastError(); 
//--- set the color of Bid price line 
   if(!ChartSetInteger(chart_ID,CHART_COLOR_BID,clr)) 
     { 
      //--- display the error message in Experts journal 
      Print(__FUNCTION__+", Error Code = ",GetLastError()); 
      return(false); 
     } 
//--- successful execution 
   return(true); 
  }     
//+------------------------------------------------------------------+ 
//| The function enables/disables the chart grid.                    | 
//+------------------------------------------------------------------+ 
bool ChartShowGridSet(const bool value,const long chart_ID=0) 
  { 
//--- reset the error value 
   ResetLastError(); 
//--- set the property value 
   if(!ChartSetInteger(chart_ID,CHART_SHOW_GRID,0,value)) 
     { 
      //--- display the error message in Experts journal 
      Print(__FUNCTION__+", Error Code = ",GetLastError()); 
      return(false); 
     } 
//--- successful execution 
   return(true); 
  }
//+------------------------------------------------------------------+ 
//| The function enables/disables the mode of the autoscroll         | 
//| of the chart to the right in case of new ticks' arrival.         | 
//+------------------------------------------------------------------+ 
bool ChartAutoscrollSet(const bool value,const long chart_ID=0) 
  { 
//--- reset the error value 
   ResetLastError(); 
//--- set property value 
   if(!ChartSetInteger(chart_ID,CHART_AUTOSCROLL,0,value)) 
     { 
      //--- display the error message in Experts journal 
      Print(__FUNCTION__+", Error Code = ",GetLastError()); 
      return(false); 
     } 
//--- successful execution 
   return(true); 
  }
//+--------------------------------------------------------------------------+ 
//| The function enables/disables the mode of displaying OHLC values in the  | 
//| upper left corner of the chart.                                          | 
//+--------------------------------------------------------------------------+ 
bool ChartShowOHLCSet(const bool value,const long chart_ID=0) 
  { 
//--- reset the error value 
   ResetLastError(); 
//--- set property value 
   if(!ChartSetInteger(chart_ID,CHART_SHOW_OHLC,0,value)) 
     { 
      //--- display the error message in Experts journal 
      Print(__FUNCTION__+", Error Code = ",GetLastError()); 
      return(false); 
     } 
//--- successful execution 
   return(true); 
  }
//+------------------------------------------------------------------+ 
//| The function sets color of up bar, its shadow and                | 
//| border of a bullish candlestick's body.                          | 
//+------------------------------------------------------------------+ 
bool ChartUpColorSet(const color clr,const long chart_ID=0) 
  { 
//--- reset the error value 
   ResetLastError(); 
//--- set the color of up bar, its shadow and border of body of a bullish candlestick 
   if(!ChartSetInteger(chart_ID,CHART_COLOR_CHART_UP,clr)) 
     { 
      //--- display the error message in Experts journal 
      Print(__FUNCTION__+", Error Code = ",GetLastError()); 
      return(false); 
     } 
//--- successful execution 
   return(true); 
  }

