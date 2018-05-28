//+------------------------------------------------------------------+
//|                                                  PanelDialog.mqh |
//|                   Copyright 2009-2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Controls\Edit.mqh>
#include <Controls\ListView.mqh>

//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
//--- indents and gaps
#define INDENT_LEFT                         (11)      // indent from left (with allowance for border width)
#define INDENT_TOP                          (11)      // indent from top (with allowance for border width)
#define INDENT_RIGHT                        (11)      // indent from right (with allowance for border width)
#define INDENT_BOTTOM                       (11)      // indent from bottom (with allowance for border width)
#define CONTROLS_GAP_X                      (10)      // gap by X coordinate
#define CONTROLS_GAP_Y                      (10)      // gap by Y coordinate
//--- for buttons
#define BUTTON_WIDTH                        (100)     // size by X coordinate
#define BUTTON_HEIGHT                       (20)      // size by Y coordinate
//--- for the indication area
#define EDIT_HEIGHT                         (20)      // size by Y coordinate
//+------------------------------------------------------------------+
//| Class CPanelDialog                                               |
//| Usage: main dialog of the SimplePanel application                |
//+------------------------------------------------------------------+
class CPanelDialog : public CAppDialog
  {
private:
   CEdit             m_edit;                          // the display field object
   CListView         m_list_view;                     // the list object

public:
                     CPanelDialog(void);
                    ~CPanelDialog(void);
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   //--- chart event handler
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);

protected:
   //--- create dependent controls
   bool              CreateEdit(void);
   bool              CreateListView(void);
   //--- internal event handlers
   virtual bool      OnResize(void);
   //--- handlers of the dependent controls events
   void              OnChangeListView(void);
   //bool              OnDefault(const int id,const long &lparam,const double &dparam,const string &sparam);
  };
//+------------------------------------------------------------------+
//| Event Handling                                                   |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CPanelDialog)
ON_EVENT(ON_CHANGE,m_list_view,OnChangeListView)
//ON_OTHER_EVENTS(OnDefault)
EVENT_MAP_END(CAppDialog)
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CPanelDialog::CPanelDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CPanelDialog::~CPanelDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool CPanelDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
//--- create dependent controls
   if(!CreateEdit())
      return(false);
   if(!CreateListView())
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the display field                                         |
//+------------------------------------------------------------------+
bool CPanelDialog::CreateEdit(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP;
   int x2=ClientAreaWidth()-(INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X);
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit.Create(m_chart_id,m_name+"Edit",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_edit.ReadOnly(true))
      return(false);
   if(!Add(m_edit))
      return(false);
   m_edit.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
//--- succeed
   return(true);
  }

//+------------------------------------------------------------------+
//| Create the "ListView" element                                    |
//+------------------------------------------------------------------+
bool CPanelDialog::CreateListView(void)
  {
   int sx=(ClientAreaWidth()-(INDENT_LEFT+INDENT_RIGHT+BUTTON_WIDTH))/3-CONTROLS_GAP_X;
//--- coordinates
   int x1=ClientAreaWidth()-(sx+INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+EDIT_HEIGHT+CONTROLS_GAP_Y;
   int x2=x1+sx;
   int y2=ClientAreaHeight()-INDENT_BOTTOM;
//--- create
   if(!m_list_view.Create(m_chart_id,m_name+"ListView",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!Add(m_list_view))
      return(false);
   m_list_view.Alignment(WND_ALIGN_HEIGHT,0,y1,0,INDENT_BOTTOM);
//--- fill out with strings
   for(int i=0;i<16;i++)
      if(!m_list_view.ItemAdd("Item "+IntegerToString(i)))
         return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Handler of resizing                                              |
//+------------------------------------------------------------------+
bool CPanelDialog::OnResize(void)
  {
//--- call method of parent class
   if(!CAppDialog::OnResize()) return(false);
//--- coordinates
   int x=ClientAreaLeft()+INDENT_LEFT;
   int y;
   int sx=(ClientAreaWidth()-(INDENT_LEFT+INDENT_RIGHT+BUTTON_WIDTH))/3-CONTROLS_GAP_X;
//--- move and resize the "RadioGroup" element
   //m_radio_group.Move(x,y);
  // m_radio_group.Width(sx);
//--- move and resize the "CheckGroup" element
   x=ClientAreaLeft()+INDENT_LEFT+sx+CONTROLS_GAP_X;
   //m_check_group.Move(x,y);
   //m_check_group.Width(sx);
//--- move and resize the "ListView" element
   x=ClientAreaLeft()+ClientAreaWidth()-(sx+INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X);
   m_list_view.Move(x,y);
   m_list_view.Width(sx);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CPanelDialog::OnChangeListView(void)
  {
   m_edit.Text(__FUNCTION__+" \""+m_list_view.Select()+"\"");
  }
//+------------------------------------------------------------------+
//| Rest events handler                                                    |
//+------------------------------------------------------------------+
//bool CPanelDialog::OnDefault(const int id,const long &lparam,const double &dparam,const string &sparam)
//  {
////--- restore buttons' states after mouse move'n'click
//   if(id==CHARTEVENT_CLICK)
//      m_list_view.RedrawButtonStates();
////--- let's handle event by parent
//   return(false);
//  }
//+------------------------------------------------------------------+
