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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class FxTE_Component : public CDialog
  {
public:
CDialog Component;

public:
                     FxTE_Component();
                    ~FxTE_Component();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
FxTE_Component::FxTE_Component()
  {
  //---Template of First Instrument Box
   Component.Create(0,"",0,0,0,1300,255);                     //This creates the Interior Dialog box.
   Component.Shift(5,50);
  
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
FxTE_Component::~FxTE_Component()
  {
  }
//+------------------------------------------------------------------+
