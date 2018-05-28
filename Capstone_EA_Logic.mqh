//+------------------------------------------------------------------+
//|                                            Capstone_EA_Logic.mqh |
//|                                               Capstone Group 23A |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Capstone Group 23A"
#property link      "https://www.mql5.com"
#property strict


extern string High12_Ma_Settings;
extern int High_EMA              =     12;
extern string Methods            =     "0=SMA, 1=EMA, 2=SMMA, 3=LWMA";
extern int High_Method           =     1;
extern string AppliedOptions     =     "0=Close, 1=Open, 2=High";
extern string AppliedOptions2    =     "3=Low, 4=Typical, 5=Weighted Close";
extern int fastMaAppliedTo1      =     2;
extern int fastMaShift           =     0;
//----
extern string Close10_Ma_Settings;
extern int Close_EMA             =     10;
extern string Methods2           =     "0=SMA, 1=EMA, 2=SMMA, 3=LWMA";
extern int Close_Method          =     1;
extern string AppliedOptions5    =     "0=Close, 1=Open, 2=High";
extern string AppliedOptions6    =     "3=Low, 4=Typical, 5=Weighted Close";
extern int slowMaAppliedTo2      =     0;
extern int slowMaShift2          =     0;
//----
extern string Low12_Ma_Settings;
extern int Low_EMA               =     12;
extern string Methods1           =     "0=SMA, 1=EMA, 2=SMMA, 3=LWMA";
extern int Low_Method            =     1;
extern string AppliedOptions3    =     "0=Close, 1=Open, 2=High";
extern string AppliedOptions4    =     "3=Low, 4=Typical, 5=Weighted Close";
extern int fastMaAppliedTo3      =     3;
extern int fastMaShift1          =     0;
//+------------------------------------------------------------------+
//|              Trend Trader Plus Logic                             |
//+------------------------------------------------------------------+
//void CheckForSignal()
//  {
//   double curHigh=iMA(NULL,0,High_EMA,fastMaShift,High_Method,fastMaAppliedTo1,0);
//
//   double curClose=iMA(NULL,0,Close_EMA,slowMaShift2,Close_Method,slowMaAppliedTo2,0);
//
//   double curLow=iMA(NULL,0,Low_EMA,fastMaShift1,Low_Method,fastMaAppliedTo3,0);
//
////---BUY--- 
//   if(( iOpen(Symbol(),PERIOD_H4,0)>iClose(Symbol(),PERIOD_H4,0)) && (iOpen(Symbol(),PERIOD_H1,0)>iClose(Symbol(),PERIOD_H1,0)))
//      if(curClose>iClose(NULL,0,1))
//         if(curHigh>iClose(NULL,0,1))
//            if(curLow>iClose(NULL,0,1))
//               if(iClose(NULL,0,0)>curLow)
//                  if((curClose-curLow)>(curHigh-curClose))
//
//                     //EnterTrade(OP_BUY);
//
////---SELL---  
//   if(( iOpen(Symbol(),PERIOD_H4,0)<iClose(Symbol(),PERIOD_H4,1)) && (iOpen(Symbol(),PERIOD_H1,0)<iClose(Symbol(),PERIOD_H1,1)))
//      if(curClose<iClose(NULL,0,1))
//         if(curHigh<iClose(NULL,0,1))
//            if(curLow<iClose(NULL,0,1))
//               if(iClose(NULL,0,0)<curHigh)
//                  if((curHigh-curClose)>(curClose-curLow))
//
//                    // EnterTrade(OP_SELL);
//
//  }
//+------------------------------------------------------------------+
void CheckForTrend()
  {
   double curHigh=iMA(NULL,0,High_EMA,fastMaShift,High_Method,fastMaAppliedTo1,0);
   double curClose=iMA(NULL,0,Close_EMA,slowMaShift2,Close_Method,slowMaAppliedTo2,0);
   double curLow=iMA(NULL,0,Low_EMA,fastMaShift1,Low_Method,fastMaAppliedTo3,0);

   double curHighW1=iMA(NULL,PERIOD_W1,High_EMA,fastMaShift,High_Method,fastMaAppliedTo1,0);
   double curCloseW1=iMA(NULL,PERIOD_W1,Close_EMA,slowMaShift2,Close_Method,slowMaAppliedTo2,0);
   double curLowW1=iMA(NULL,PERIOD_W1,Low_EMA,fastMaShift1,Low_Method,fastMaAppliedTo3,0);

   double curHighD1=iMA(NULL,PERIOD_D1,High_EMA,fastMaShift,High_Method,fastMaAppliedTo1,0);
   double curCloseD1=iMA(NULL,PERIOD_D1,Close_EMA,slowMaShift2,Close_Method,slowMaAppliedTo2,0);
   double curLowD1=iMA(NULL,PERIOD_D1,Low_EMA,fastMaShift1,Low_Method,fastMaAppliedTo3,0);

   double curHighH4=iMA(NULL,PERIOD_H4,High_EMA,fastMaShift,High_Method,fastMaAppliedTo1,0);
   double curCloseH4=iMA(NULL,PERIOD_H4,Close_EMA,slowMaShift2,Close_Method,slowMaAppliedTo2,0);
   double curLowH4=iMA(NULL,PERIOD_H4,Low_EMA,fastMaShift1,Low_Method,fastMaAppliedTo3,0);

   double curHighH1=iMA(NULL,PERIOD_H1,High_EMA,fastMaShift,High_Method,fastMaAppliedTo1,0);
   double curCloseH1=iMA(NULL,PERIOD_H1,Close_EMA,slowMaShift2,Close_Method,slowMaAppliedTo2,0);
   double curLowH1=iMA(NULL,PERIOD_H1,Low_EMA,fastMaShift1,Low_Method,fastMaAppliedTo3,0);

   double curHighM15=iMA(NULL,PERIOD_M15,High_EMA,fastMaShift,High_Method,fastMaAppliedTo1,0);
   double curCloseM15=iMA(NULL,PERIOD_M15,Close_EMA,slowMaShift2,Close_Method,slowMaAppliedTo2,0);
   double curLowM15=iMA(NULL,PERIOD_M15,Low_EMA,fastMaShift1,Low_Method,fastMaAppliedTo3,0);

   double curHighM5=iMA(NULL,PERIOD_M5,High_EMA,fastMaShift,High_Method,fastMaAppliedTo1,0);
   double curCloseM5=iMA(NULL,PERIOD_M5,Close_EMA,slowMaShift2,Close_Method,slowMaAppliedTo2,0);
   double curLowM5=iMA(NULL,PERIOD_M5,Low_EMA,fastMaShift1,Low_Method,fastMaAppliedTo3,0);

   double curHighM1=iMA(NULL,PERIOD_M1,High_EMA,fastMaShift,High_Method,fastMaAppliedTo1,0);
   double curCloseM1=iMA(NULL,PERIOD_M1,Close_EMA,slowMaShift2,Close_Method,slowMaAppliedTo2,0);
   double curLowM1=iMA(NULL,PERIOD_M1,Low_EMA,fastMaShift1,Low_Method,fastMaAppliedTo3,0);

//---BUY Weekly--- 
   if((iClose(NULL,PERIOD_W1,1)>curHighW1))
     {
      Comment("W  Trend is UP");
     }
   if((iClose(NULL,PERIOD_W1,1)<curHighW1) && (iClose(NULL,PERIOD_W1,1)>curCloseW1))
     {
      Comment("W  Trend is B-Sideways");
     }
//---SELL Weekly---  
   if((iClose(NULL,PERIOD_W1,1)<curLowW1))
     {
      Comment("W  Trend is DOWN");
     }
   if((iClose(NULL,PERIOD_W1,1)>curLowW1) && (iClose(NULL,PERIOD_W1,1)<curCloseW1))
     
      Comment("W  Trend is S-Sideways");


//---BUY Daily--- 
   if((iClose(NULL,PERIOD_D1,1)>curHighD1))
      Comment("D  Trend is UP");
   if((iClose(NULL,PERIOD_D1,1)<curHighD1) && (iClose(NULL,PERIOD_D1,1)>curCloseD1))
      Comment("D  Trend is B-Sideways");

//---SELL Daily---  
   if((iClose(NULL,PERIOD_D1,1)<curLowD1))
      Comment("D  Trend is DOWN");
   if((iClose(NULL,PERIOD_D1,1)>curLowD1) && (iClose(NULL,PERIOD_D1,1)<curCloseD1))
      Comment("D  Trend is S-Sideways");

//---BUY H4--- 
   if((iClose(NULL,PERIOD_H4,1)>curHighH4))
      Comment("H4  Trend is UP");
   else if((iClose(NULL,PERIOD_H4,1)<curHighH4) && (iClose(NULL,PERIOD_H4,1)>curCloseH4))
      Comment("H4  Trend is B-Sideways");

//---SELL H4---  
   if((iClose(NULL,PERIOD_H4,1)<curLowH4))
      Comment("H4  Trend is DOWN");
   else if((iClose(NULL,PERIOD_H4,1)>curLowH4) && (iClose(NULL,PERIOD_H4,1)<curCloseH4))
      Comment("H4  Trend is S-Sideways");

//---BUY H1--- 
   if((iClose(NULL,PERIOD_H1,1)>curHighH1))
      Comment("H1  Trend is UP");
   else if((iClose(NULL,PERIOD_H1,1)<curHighH1) && (iClose(NULL,PERIOD_H1,1)>curCloseH1))
      Comment("H1  Trend is B-Sideways");

//---SELL H1---  
   if((iClose(NULL,PERIOD_H1,1)<curLowH1))
      Comment("H1  Trend is DOWN");
   else if((iClose(NULL,PERIOD_H1,1)>curLowH1) && (iClose(NULL,PERIOD_H1,1)<curCloseH1))
      Comment("H1  Trend is S-Sideways");

//---BUY M15--- 
   if((iClose(NULL,PERIOD_M15,1)>curHighM15))
      Comment("M15  Trend is UP");
   else if((iClose(NULL,PERIOD_M15,1)<curHighM15) && (iClose(NULL,PERIOD_M15,1)>curCloseM15))
      Comment("M15  Trend is B-Sideways");

//---SELL M15---  
   if((iClose(NULL,PERIOD_M15,1)<curLowM15))
      Comment("M15  Trend is DOWN");
   else if((iClose(NULL,PERIOD_M15,1)>curLowM15) && (iClose(NULL,PERIOD_M15,1)<curCloseM15))
      Comment("M15  Trend is S-Sideways");

//---BUY M5--- 
   if((iClose(NULL,PERIOD_M5,1)>curHighM5))
      Comment("M5  Trend is UP");
   else if((iClose(NULL,PERIOD_M5,1)<curHighM5) && (iClose(NULL,PERIOD_M5,1)>curCloseM5))
      Comment("M5  Trend is B-Sideways");

//---SELL M5---  
   if((iClose(NULL,PERIOD_M5,1)<curLowM5))
      Comment("M5  Trend is DOWN");
   else if((iClose(NULL,PERIOD_M5,1)>curLowM5) && (iClose(NULL,PERIOD_M5,1)<curCloseM5))
      Comment("M5  Trend is S-Sideways");

//---BUY M1--- 
   if((iClose(NULL,PERIOD_M1,1)>curHighM1))
      Comment("M1  Trend is UP");
   else if((iClose(NULL,PERIOD_M1,1)<curHighM1) && (iClose(NULL,PERIOD_M1,1)>curCloseM1))
      Comment("M1  Trend is B-Sideways");

//---SELL M1---  
   if((iClose(NULL,PERIOD_M1,1)<curLowM1))
      Comment("M1  Trend is DOWN");
   else if((iClose(NULL,PERIOD_M1,1)>curLowM1) && (iClose(NULL,PERIOD_M1,1)<curCloseM1))
      Comment("M1  Trend is S-Sideways");

  }
//+------------------------------------------------------------------+
