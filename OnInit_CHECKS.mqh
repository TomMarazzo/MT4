//+------------------------------------------------------------------+
//|                                                OnInit_CHECKS.mqh |
//|                                               Capstone Group 23A |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Capstone Group 23A"
#property link      "https://www.mql5.com"
#property strict

//+---------------------------------------------------------------------------------+
//|    1. User must enter Password to use EA                                        |
//|    2. Check to ensure EA is enabled                                             |
//|    3. Save as template for ALL Custom EAs                                       |
//|    4. Use for all 4 of EnableEA, Live trading, DLL allowed and Library allowed  |  
//|    5. Optional to add EA expiry                                                 |                          
//+---------------------------------------------------------------------------------+

//---Date Expiry
   if(TimeLocal()>D'30.04.2018' && Password!="Capstone")
     {
      MessageBox("This File has EXPIRED! Please update Purchase to the latest Version!","Expired File");
      Comment("The File was REMOVED because it is past it's expiration date.  Please Contact Programmer for a new Password!");
      ExpertRemove();
      return(INIT_FAILED);
     }

//---Password
   if(Password!="Capstone")
     {
      MessageBox("Please RELOAD the EA with the proper Password","Wrong Password Entered!");
      Comment(WindowExpertName(),"is NOT running becasue you entered the WRONG PASSWORD!"+
              "\nPlease REMOVE the EA and RELOAD with the CORRECT Password.");
      ExpertRemove();
      return(INIT_FAILED);
     }

//---AutoTrading Enabled
   if(!IsExpertEnabled())
     {
      MessageBox("You need to ENABLE AutoTrading","Please enable AutoTrading!");
      Comment(WindowExpertName(),"is NOT running becasue you have Autotrading DIS-abled!"+
              "\nPlease ENABLE AutoTrading and RELOAD the EA.");
      ExpertRemove();
      return(INIT_FAILED);
     }

//---Allow Live Trading
   if(!IsTradeAllowed())
     {
      MessageBox("You need to \"ALLOW Live Trading\"","Please check \"Allow Live Trading\"!");
      Comment(WindowExpertName(),"is NOT running becasue you don't have \"Allow Live Trading\" enabled!"+
              "\nPlease ENABLE \"Allow Live Trading\" and RELOAD the EA.");
      ExpertRemove();
      return(INIT_FAILED);
     }

//---DLLs
   if(!IsDllsAllowed())
     {
      MessageBox("DLLs are NOT enabled","Please enable DLLs!");
      Comment(WindowExpertName(),"is NOT running becasue you have DLLs DIS-abled!"+
              "\nPlease ENABLE DLLs and RELOAD the EA.");
      ExpertRemove();
      return(INIT_FAILED);
     }

//---Library EAs Allowed
   if(!IsLibrariesAllowed())
     {
      MessageBox("Allow import of external experts is NOT ENABLE","Please enable it!");
      Comment(WindowExpertName(),"is NOT running becasue you have external experts DIS-abled!"+
              "\nPlease ENABLE them and RELOAD the EA.");
      ExpertRemove();
      return(INIT_FAILED);
     }

