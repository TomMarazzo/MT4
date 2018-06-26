//+------------------------------------------------------------------+
//|                                                 FxTE_CI_DBv3.mq4 |
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
extern string SymbolSuffix ="";//- If your broker names the currency pairs with a suffix for a mini account (like an "m", for example), enter the suffix here
extern string PairsList1   = "AUDCAD,AUDJPY,AUDUSD,CADJPY,CHFJPY,EURAUD,EURCAD,EURCHF,EURGBP,EURJPY,EURUSD,";
extern string PairsList2   = "GBPCHF,GBPJPY,GBPUSD,NZDCHF,NZDJPY,NZDUSD,USDCAD,USDCHF,USDJPY,";
extern string PairsList3   = "GLD,SLV,OIL";//- This is where you add the currency pairs you want

//---Custom Indicator variables
extern string CustomIndicatorList="RS,NS,RX,AO_Peak,RYT_X,YS_Needed,SA,Pinch,SB";
int NumberCustomIndcators;
int colStepCustomIndicators=85;
double iCI[10];
string sCI[10];

//---Timeframe Variables
extern string TimeFrameList="5,15,30,60,240,1440";

extern int ShiftSignals=1;
extern int refreshPeriod=PERIOD_M1; // refresh calcultion
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
int iColDB_First,colDB_RS,colDB_NS,colDB_RX,colDB_AO_Peak,colDB_RYT_X,colDB_YS_Needed,colDB_SA,colDB_Pinch,colDB_SB;

int xLeftTitle=20;
int xCurrentTime=3;

int yCurrentTime=15;
int yTitle_1 = 30;
int yTitle_2 = 50;

int rowStep=30;             //Vertical height of each row
int colStep= 150;
int colStepTimeFrames=85;

//---- colors
extern color colorTitle=clrDodgerBlue;
extern color colorTimeFrame=clrWhite;
extern color colorInstrument=clrBlue;
color colorTime = clrWhite;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {

   PairsList=StringConcatenate(PairsList1,PairsList2,PairsList3);
   iCorner=Corner_LeftUp;
   CurrentTimeFrameOK=false;
   TimeFrame=Period();
   CI= CustomIndicatorList;
   oldTime=0;
//----   
   IndicatorShortName(windowsName);
   SetIndexLabel(0,windowsName);
//-- clear Titles
   for(int i=0; i<=50; i++)
     {
      Title_1[i] = "";
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
   Get_CustomIndicatorList();
  
//---- indicators 
//Get_IndicatorValues();
Write_CurrentTime(xCurrentTime, yCurrentTime);

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
   
   colDB_RS = iCol; iCol = iCol +1;          //Begining of CIs
   colDB_NS = iCol; iCol = iCol +1;
   colDB_RX = iCol; iCol = iCol +1;
   colDB_AO_Peak  = iCol; iCol = iCol +1;
   colDB_RYT_X = iCol; iCol = iCol +1;
   colDB_YS_Needed = iCol; iCol = iCol +1;
   colDB_SA  = iCol; iCol = iCol +1;
   colDB_Pinch  = iCol; iCol = iCol +1;
   colDB_SB  = iCol; iCol = iCol +1;   

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
   //Title_1[iColDB_First] = "Chicken";
   Title_1[colDB_Pairs] = "  ";   
   Title_1[colDB_RS] = "RS";
   Title_1[colDB_NS] = "NS";
   Title_1[colDB_RX] = "RX";
   Title_1[colDB_AO_Peak] = "AO Peak";
   Title_1[colDB_RYT_X] = "RYT_X";
   Title_1[colDB_YS_Needed] = "YS_Needed";
   Title_1[colDB_SA] = "SA";
   Title_1[colDB_Pinch] = "Pinch";
   Title_1[colDB_SB] = "SB";
   colDB_Pairs=colDB_Pairs + 1;
   for(i=0; i<=NumberCustomIndcators; i++)
     {
      sCI[i]=Get_CI(iCI[i]);
      Title_1[iColDB_First+i]=sCI[i];
     }

//---- x Columns ..................................................  


   xCol[iColDB_First]= xLeftTitle;
   xCol[colDB_RS] = xCol[iColDB_First] + colStep + 10;
   xCol[colDB_NS]  = xCol[colDB_RS] + colStep;
   int iCol=iColDB_First+1;
   xCol[iCol]=xCol[iCol-1]+colStepCustomIndicators;

   for (i=iCol+1; i<nCustomIndicatorTitles; i++)
   xCol[i] = xCol[i-1] + colStepCustomIndicators;   

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
   for (int i=1; i<nTitles; i++) {
      xx1 = xCol[i];
      //-- Adjust xCol
      if (i==colDB_Pairs) xx1 = xx1 - 10;
     
      if (Title_1[i] != "") 
        SetLabelObject(sLabelCode+"Title1_"+i, Title_1[i],  colorTitle, xx1, yTitle_1);
   }      
}

void Show_TitlesLeft()
  {
   for(int i=0; i<NumberSymbols; i++) 
     {
      string sSymbol=Pair[i];
      int j=i+1;
      if(j<10) string sNr="0"+j+". "; else sNr=j+". ";
      string sNrSymbol=sNr+sSymbol;
      //-- Names
      SetLabelObject(sLabelCode+sSymbol,sNrSymbol,colorTitle,xLeftTitle,yRow[i]);

     }
  }
//####################################################################
//+------------------------------------------------------------------+
//| Create Titles
//+------------------------------------------------------------------+
void Write_CurrentTime(int xx, int yy)
{
   string sTime = TimeToStr(TimeCurrent(),TIME_DATE|TIME_MINUTES);
   string s_TimeFrame = Get_sPeriod(TimeFrame);
   string st = sTime+"   "+Symbol() + " ," + s_TimeFrame;
   SetTimeObject(sLabelCode+"time", st, colorTime, xx, yy);
}

void SetLabelObject(string sName,string sText,color dColor,int xx,int yy) //Sets the size of the fonts
  {
   ObjectCreate(sName,OBJ_LABEL,iWindow,0,0);
   ObjectSetText(sName,sText,8,"Arial Bold",dColor);
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
void Get_CustomIndicatorList()
  {
   int i,j,k;
   string CurCustIndicators;

   for(i=0,j=0,k=1; i<nTitles && k>0;)
     {
      k=StringFind(CustomIndicatorList,",",j);
      if(k==0) CurCustIndicators=StringSubstr(CustomIndicatorList,j,0);
      else CurCustIndicators=StringSubstr(CustomIndicatorList,j,k-j);

      iCI[i]=StrToInteger(CurCustIndicators);
      i++;

      j=StringFind(CustomIndicatorList,",",j)+1;
      if(j==0) break;
     }
   NumberCustomIndcators = i-1;

   return;
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
  
  string Get_CI(string c_i)
  {
   if(c_i == "RS") return("RS");
   if(c_i == "NS") return("NS");
   if(c_i == "RX") return("RX");
   if(c_i == "AO_Peak") return("AO_Peak");
   if(c_i == "RYT_X") return("RYT_X");
   if(c_i == "YS_Needed") return("YS_Needed");
   if(c_i == "SA") return("SA");
   if(c_i == "Pinch") return("Pinch");
   if(c_i == "SB") return("SB");
  }

//GET THIS LATER IF YOU STILL NEED TO USE IT

////---Instrument Labels Adjustments  
//   int Inst_x        =  20;
//   int Inst_y        =  25;
//   int Inst_font     =  12; 
////---Timeframe Labels Adjustments  
//   int TF_x          =  40;
//   int TF_y          =  10;
//   //---Indicator Labels Adjustments  
//   int TI_x          =  200; 
//   int TI_y          =  25;
//   int CI_font       =  12;     

////---Instrument
//   Instrument.Create(0,"Instrument",0,0,0,0,0);
//   Instrument.Text("Instrument");
//   Instrument.Color(colorInstrument);
//   Instrument.FontSize(Inst_font);
//   Instrument.Font("Arial Bold");
//   //Dashboard.Add(SB);
//   Instrument.Shift((Inst_x),Inst_y); 
//
//   RS.Create(0,"RS",0,0,0,0,0);
//   RS.Text("RS");
//   RS.Color(colorTitle);
//   RS.FontSize(CI_font);
//   RS.Font("Arial Bold");
//   //Dashboard.Add(RS);
//   RS.Shift((TI_x+40),TI_y);
//
////---NS Label
//
//   NS.Create(0,"NS",0,0,0,0,0);
//   NS.Text("NS");
//   NS.Color(colorTitle);
//   NS.FontSize(CI_font);
//   NS.Font("Arial Bold");
//   //Dashboard.Add(NS);
//   NS.Shift(TI_x+(160),TI_y);
//
////---RX Label
//
//   RX.Create(0,"RX",0,0,0,0,0);
//   RX.Text("RX");
//   RX.Color(colorTitle);
//   RX.FontSize(CI_font);
//   RX.Font("Arial Bold");
//   //Dashboard.Add(RX);
//   RX.Shift((TI_x+240),TI_y);
//
////---AO Peak Label
//
//   AO_Peak.Create(0,"AO Peak",0,0,0,0,0);
//   AO_Peak.Text("AO Peak");
//   AO_Peak.Color(colorTitle);
//   AO_Peak.FontSize(CI_font);
//   AO_Peak.Font("Arial Bold");
//   //Dashboard.Add(AO_Peak);
//   AO_Peak.Shift((TI_x+340),TI_y);
//
////---RYT_X  Label
//
//   RYT_X.Create(0,"RYT X",0,0,0,0,0);
//   RYT_X.Text("RYT X");
//   RYT_X.Color(colorTitle);
//   RYT_X.FontSize(CI_font);
//   RYT_X.Font("Arial Bold");
//   //Dashboard.Add(RYT_X);
//   RYT_X.Shift((TI_x +470),TI_y);
//
////---YS_Needed  Label
//
//   YS_Needed.Create(0,"YS Needed",0,0,0,0,0);
//   YS_Needed.Text("YS Needed");
//   YS_Needed.Color(colorTitle);
//   YS_Needed.FontSize(CI_font);
//   YS_Needed.Font("Arial Bold");
//   //Dashboard.Add(YS_Needed);
//   YS_Needed.Shift((TI_x+570),TI_y);
//
////---SA Label
//
//   SA.Create(0,"SA",0,0,0,0,0);
//   SA.Text("SA");
//   SA.Color(colorTitle);
//   SA.FontSize(CI_font);
//   SA.Font("Arial Bold");
//   //Dashboard.Add(SA);
//   SA.Shift((TI_x+700),TI_y);
//
////---Pinch Label
//
//   Pinch.Create(0,"Pinch",0,0,0,0,0);
//   Pinch.Text("Pinch");
//   Pinch.Color(colorTitle);
//   Pinch.FontSize(CI_font);
//   Pinch.Font("Arial Bold");
//   //Dashboard.Add(Pinch);
//   Pinch.Shift((TI_x +770),TI_y);
//
////---SB Label
//
//   SB.Create(0,"SB",0,0,0,0,0);
//   SB.Text("SB");
//   SB.Color(colorTitle);
//   SB.FontSize(CI_font);
//   SB.Font("Arial Bold");
//   //Dashboard.Add(SB);
//   SB.Shift((TI_x+870),TI_y);  
