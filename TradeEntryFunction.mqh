//+------------------------------------------------------------------+
//|                                           TradeEntryFunction.mqh |
//|                                               Capstone Group 23A |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Capstone Group 23A"
#property link      "https://www.mql5.com"
#property strict
//---TRADE PLACING FUNCTION---

//void EnterTrade(int type)
//  {
//   int err=0;
//   double price=Bid;
//   double sl=0;
//   double tp=0;
//   if(type==OP_BUY)
//     {
//      price=Ask;
//     }
//----
//   int ticket=OrderSend(Symbol(),type,LotSize,price,Slippage,0,0,"MAEA Trade",MagicNumber,0,Magenta);
//   if(ticket>0)
//     {
//      if(OrderSelect(ticket,SELECT_BY_TICKET))
//        {
//         //---SELL---        
//         sl = OrderOpenPrice()+(StopLoss*pips);
//         tp = OrderOpenPrice()-(TakeProfit*pips);
//         //---BUY---
//         if(OrderType()==OP_BUY)
//           {
//            sl = OrderOpenPrice()-(StopLoss*pips);
//            tp = OrderOpenPrice()+(TakeProfit*pips);
//           }
//         if(!OrderModify(ticket,price,sl,tp,0,Magenta))
//           {
//            err=GetLastError();
//            Print("Encountered an error during modification!"+(string)err+" "+ErrorDescription(err));
//           }
//
//        
//
//        }
//      else
//        {//in case it fails to select the order for some reason 
//         Print("Failed to Select Order ",ticket);
//         err=GetLastError();
//         Print("Encountered an error while seleting order "+(string)ticket+" error number "+(string)err+" "+ErrorDescription(err));
//        }
//     }
//   else
//     {//in case it fails to place the order and send us back a ticket number.
//      err=GetLastError();
//      Print("Encountered an error during order placement!"+(string)err+" "+ErrorDescription(err));
//      if(err==ERR_TRADE_NOT_ALLOWED)MessageBox("You can not place a trade because \"Allow Live Trading\" is not checked in your options. Please check the \"Allow Live Trading\" Box!","Check Your Settings!");
//     }
//  }
////+------------------------------------------------------------------+
