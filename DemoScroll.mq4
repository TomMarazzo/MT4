//+------------------------------------------------------------------+
//|                                                   DemoScroll.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#property copyright "Copyright 2017, MetaQuotes Software Corp." 
#property link      "https://www.mql5.com" 
#property version   "1.00" 
#property description "Control Panels and Dialogs. Demonstration class CScrollV" 

#resource "\\Include\\Controls\\res\\Up.bmp"
#resource "\\Include\\Controls\\res\\Down.bmp"

#include <Controls\Dialog.mqh> 
#include <Controls\Scrolls.mqh>
#include <Controls/Label.mqh> 
#include <FxTE_Component.mqh>
//CCanvas canvas;

//+------------------------------------------------------------------+ 
//| defines                                                          | 
//+------------------------------------------------------------------+ 
//--- indents and gaps 
#define INDENT_LEFT                         (11)      // indent from left (with allowance for border width) 
#define INDENT_TOP                          (11)      // indent from top (with allowance for border width) 
#define INDENT_RIGHT                        (11)      // indent from right (with allowance for border width) 
#define INDENT_BOTTOM                       (11)      // indent from bottom (with allowance for border width) 
#define CONTROLS_GAP_X                      (5)       // gap by X coordinate 
#define CONTROLS_GAP_Y                      (5)       // gap by Y coordinate 
//--- for buttons 
#define BUTTON_WIDTH                        (100)     // size by X coordinate 
#define BUTTON_HEIGHT                       (20)      // size by Y coordinate 
//--- for the indication area 
#define EDIT_HEIGHT                         (20)      // size by Y coordinate 
//--- for group controls 
#define GROUP_WIDTH                         (150)     // size by X coordinate 
#define LIST_HEIGHT                         (600)     // size by Y coordinate - This is the vertical height setting of the Scroll Bar.  Can't be biger than the Comp Box
#define RADIO_HEIGHT                        (56)      // size by Y coordinate 
#define CHECK_HEIGHT                        (93)      // size by Y coordinate 

CAppDialog                    CompBox[];
CBmpButton        ComponentBoxBmpButton;

CLabel            RS,NS,RX,AO_Peak,RYT_X,YS_Needed,SA,Pinch,SB;

//screen bounds 
int DialogSx,DialogSy,DialogEx,DialogEy;
int CompBox_Total=0;
//+------------------------------------------------------------------+ 
//| Class CControlsDialog                                            | 
//| Usage: main dialog of the Controls application                   | 
//+------------------------------------------------------------------+ 
class CControlsDialog : public CAppDialog 
  { 
private: 
   CScrollV          m_scroll_v;                     // CScrollV object 
  
public: 
                     CControlsDialog(void); 
                    ~CControlsDialog(void); 
   //--- create 
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2); 
   //--- chart event handler 
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam); 
  
protected: 
   //--- create dependent controls 
   bool              CreateScrollV(void); 
   //--- handlers of the dependent controls events 
   void              OnScrollInc(void); 
   void              OnScrollDec(void); 
  }; 
//+------------------------------------------------------------------+ 
//| Event Handling                                                   | 
//+------------------------------------------------------------------+ 
EVENT_MAP_BEGIN(CControlsDialog) 
ON_EVENT(ON_SCROLL_INC,m_scroll_v,OnScrollInc) 
ON_EVENT(ON_SCROLL_DEC,m_scroll_v,OnScrollDec) 
EVENT_MAP_END(CAppDialog) 
//+------------------------------------------------------------------+ 
//| Constructor                                                      | 
//+------------------------------------------------------------------+ 
CControlsDialog::CControlsDialog(void) 
  { 
  } 
//+------------------------------------------------------------------+ 
//| Destructor                                                       | 
//+------------------------------------------------------------------+ 
CControlsDialog::~CControlsDialog(void) 
  { 
  } 
//+------------------------------------------------------------------+ 
//| Create                                                           | 
//+------------------------------------------------------------------+ 
bool CControlsDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2) 
  { 
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2)) 
      return(false); 
//--- create dependent controls 
   if(!CreateScrollV()) 
      return(false); 
//--- succeed 
   return(true); 
  } 
//+------------------------------------------------------------------+ 
//| Create the CScrollsV object                                      | 
//+------------------------------------------------------------------+ 
bool CControlsDialog::CreateScrollV(void) 
  { 
//--- coordinates 
   int x1=INDENT_LEFT; 
   int y1=INDENT_TOP; 
   int x2=x1+18; 
   int y2=y1+LIST_HEIGHT; 
//--- create 
   if(!m_scroll_v.Create(m_chart_id,m_name+"ScrollV",m_subwin,x1,y1,x2,y2)) 
      return(false); 
//--- set up the scrollbar 
   m_scroll_v.MinPos(0); 
//--- set up the scrollbar 
   m_scroll_v.MaxPos(20); 
   if(!Add(m_scroll_v)) 
      return(false); 
   Comment("Position of the scrollbar ",m_scroll_v.CurrPos()); 
//--- succeed 
   return(true); 
  } 
//+------------------------------------------------------------------+ 
//| Event handler                                                    | 
//+------------------------------------------------------------------+ 
void CControlsDialog::OnScrollInc(void) 
  { 
   Comment("Position of the scrollbar ",m_scroll_v.CurrPos()); 
   for(int x=0;x<CompBox_Total;x++)
   {
   CompBox[x].Shift(0,-10);
   int psy,pey;
   psy=CompBox[x].Top();
   pey=CompBox[x].Bottom();
   //if out of bounds 
   if((psy<DialogSy||pey>DialogEy)&&CompBox[x].IsVisible()==true) CompBox[x].Hide();
   //if in bounds 
   if(psy>=DialogSy&&pey<=DialogEy&&CompBox[x].IsVisible()==false) CompBox[x].Show();
   }
  } 
//+------------------------------------------------------------------+ 
//| Event handler                                                    | 
//+------------------------------------------------------------------+ 
void CControlsDialog::OnScrollDec(void) 
  { 
   Comment("Position of the scrollbar ",m_scroll_v.CurrPos()); 
   for(int x=0;x<CompBox_Total;x++)
   {
   CompBox[x].Shift(0,10);
   int psy,pey;
   psy=CompBox[x].Top();
   pey=CompBox[x].Bottom();
   //if out of bounds 
   if((psy<DialogSy||pey>DialogEy)&&CompBox[x].IsVisible()==true) CompBox[x].Hide();
   //if in bounds 
   if(psy>=DialogSy&&pey<=DialogEy&&CompBox[x].IsVisible()==false) CompBox[x].Show();
   }
  } 
//+------------------------------------------------------------------+ 
//| Global Variables                                                 | 
//+------------------------------------------------------------------+ 
CControlsDialog ExtDialog; 
//+------------------------------------------------------------------+ 
//| Expert initialization function                                   | 
//+------------------------------------------------------------------+ 
int OnInit() 
  { 
  
  
//--- create application dialog 
   if(!ExtDialog.Create(0,"Controls",0,40,40,1380,800)) 
      return(INIT_FAILED); 
   DialogSx=40;
   DialogSy=40;
   DialogEx=1380;
   DialogEy=600;
//--- run application 

   ExtDialog.Run(); 
   //---Indicator Labels Adjustments  
   int TI_x=50;
   int TI_y=0;                         

//--- Create 4 comp boxes
  ArrayResize(CompBox,4,0);
  CompBox_Total=4;
  int px=50;
  int py=20;
  int sx=1200;
  int sy=210;
  for(int x=0;x<4;x++)
  {
      CompBox[x].Create(0,"Comp Box",0,px,py,px+sx,py+sy)&&(
  
  //---Bmp Up/Down Arrow button 
      ComponentBoxBmpButton.Create(0,"ComponentBoxBmpButton",0,0,0,0,0));
      ComponentBoxBmpButton.BmpNames("::Include\\Controls\\res\\Up.bmp","::Include\\Controls\\res\\Down.bmp");
      CompBox[x].Add(ComponentBoxBmpButton);
      ComponentBoxBmpButton.Shift(sx-65,sy-18); //Dashboard_Width-68,-18 
      ExtDialog.Add(CompBox[x]);  
      
      px=px+0;//Offset dist from previous box above
      py=py+212;
 //--- Indicator -Horizontal Labels--//

//---RS Label

   RS.Create(0,"RS",0,0,0,0,0);
   RS.Text("RS");
   RS.Color(clrBlack);
   RS.FontSize(10);
   RS.Font("Arial Bold");
   CompBox[x].Add(RS);
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
   CompBox[x].Add(NS);
   NS.Shift((TI_x+295),-22);

//---RX Label

   RX.Create(0,"RX",0,0,0,0,0);
   RX.Text("RX");
   RX.Color(clrBlack);
   RX.FontSize(10);
   RX.Font("Arial Bold");
   CompBox[x].Add(RX);
   RX.Shift((TI_x+370),-22);

//---AO Peak Label

   AO_Peak.Create(0,"AO Peak",0,0,0,0,0);
   AO_Peak.Text("AO Peak");
   AO_Peak.Color(clrBlack);
   AO_Peak.FontSize(10);
   AO_Peak.Font("Arial Bold");
   CompBox[x].Add(AO_Peak);
   AO_Peak.Shift((TI_x+445),-22);

//---RYT_X  Label

   RYT_X.Create(0,"RYT X",0,0,0,0,0);
   RYT_X.Text("RYT X");
   RYT_X.Color(clrBlack);
   RYT_X.FontSize(10);
   RYT_X.Font("Arial Bold");
   CompBox[x].Add(RYT_X);
   RYT_X.Shift((TI_x+570),-22);

//---YS_Needed  Label

   YS_Needed.Create(0,"YS Needed",0,0,0,0,0);
   YS_Needed.Text("YS Needed");
   YS_Needed.Color(clrBlack);
   YS_Needed.FontSize(10);
   YS_Needed.Font("Arial Bold");
   CompBox[x].Add(YS_Needed);
   YS_Needed.Shift((TI_x+670),-22);

//---SA Label

   SA.Create(0,"SA",0,0,0,0,0);
   SA.Text("SA");
   SA.Color(clrBlack);
   SA.FontSize(10);
   SA.Font("Arial Bold");
   CompBox[x].Add(SA);
   SA.Shift((TI_x+825),-22);

//---Pinch Label

   Pinch.Create(0,"Pinch",0,0,0,0,0);
   Pinch.Text("Pinch");
   Pinch.Color(clrBlack);
   Pinch.FontSize(10);
   Pinch.Font("Arial Bold");
   CompBox[x].Add(Pinch);
   Pinch.Shift((TI_x+910),-22);

//---SB Label

   SB.Create(0,"SB",0,0,0,0,0);
   SB.Text("SB");
   SB.Color(clrBlack);
   SB.FontSize(10);
   SB.Font("Arial Bold");
   CompBox[x].Add(SB);
   SB.Shift((TI_x+1020),-22);

  
 
   }
//--- succeed 
   return(INIT_SUCCEEDED); 
  } 
//+------------------------------------------------------------------+ 
//| Expert deinitialization function                                 | 
//+------------------------------------------------------------------+ 
void OnDeinit(const int reason) 
  { 
//--- clear comments 
   Comment(""); 
//--- destroy dialog 
   ExtDialog.Destroy(reason); 
  } 
//+------------------------------------------------------------------+ 
//| Expert chart event function                                      | 
//+------------------------------------------------------------------+ 
void OnChartEvent(const int id,         // event ID   
                  const long& lparam,   // event parameter of the long type 
                  const double& dparam, // event parameter of the double type 
                  const string& sparam) // event parameter of the string type 
  { 
   ExtDialog.ChartEvent(id,lparam,dparam,sparam); 
  }

//--- END OF ChartEvent function   
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