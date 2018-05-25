//+------------------------------------------------------------------+
//|                                                   DemoScroll.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#property copyright "Copyright 2017, MetaQuotes Software Corp." 
#property link      "https://www.mql5.com" 
#property version   "1.00" 
#property description "Control Panels and Dialogs. Demonstration class CScrollV" 
#include <Controls\Dialog.mqh> 
#include <Controls\Scrolls.mqh> 
#include <Canvas\Canvas.mqh>
CCanvas canvas;

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
#define LIST_HEIGHT                         (179)     // size by Y coordinate 
#define RADIO_HEIGHT                        (56)      // size by Y coordinate 
#define CHECK_HEIGHT                        (93)      // size by Y coordinate 

CAppDialog TomBox[];
//screen bounds 
int DialogSx,DialogSy,DialogEx,DialogEy;
int TomBox_Total=0;
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
   m_scroll_v.MaxPos(10); 
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
   for(int x=0;x<TomBox_Total;x++)
   {
   TomBox[x].Shift(0,-6);
   int psy,pey;
   psy=TomBox[x].Top();
   pey=TomBox[x].Bottom();
   //if out of bounds 
   if((psy<DialogSy||pey>DialogEy)&&TomBox[x].IsVisible()==true) TomBox[x].Hide();
   //if in bounds 
   if(psy>=DialogSy&&pey<=DialogEy&&TomBox[x].IsVisible()==false) TomBox[x].Show();
   }
  } 
//+------------------------------------------------------------------+ 
//| Event handler                                                    | 
//+------------------------------------------------------------------+ 
void CControlsDialog::OnScrollDec(void) 
  { 
   Comment("Position of the scrollbar ",m_scroll_v.CurrPos()); 
   for(int x=0;x<TomBox_Total;x++)
   {
   TomBox[x].Shift(0,10);
   int psy,pey;
   psy=TomBox[x].Top();
   pey=TomBox[x].Bottom();
   //if out of bounds 
   if((psy<DialogSy||pey>DialogEy)&&TomBox[x].IsVisible()==true) TomBox[x].Hide();
   //if in bounds 
   if(psy>=DialogSy&&pey<=DialogEy&&TomBox[x].IsVisible()==false) TomBox[x].Show();
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
   if(!ExtDialog.Create(0,"Controls",0,40,40,380,344)) 
      return(INIT_FAILED); 
   DialogSx=40;
   DialogSy=40;
   DialogEx=380;
   DialogEy=344;
//--- run application 
   ExtDialog.Run(); 
//--- Create 4 tom boxes
  ArrayResize(TomBox,4,0);
  TomBox_Total=4;
  int px=120;
  int py=40;
  int sx=120;
  int sy=40;
  for(int x=0;x<4;x++)
  {
  TomBox[x].Create(0,"Tom's Box",0,px,py,px+sx,py+sy);
  ExtDialog.Add(TomBox[x]);  
  px=px+10;
  py=py+10;
  }
  //Create 4 tom boxes ends here 

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
