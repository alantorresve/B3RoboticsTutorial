Integer TRAY
Integer HB
Integer HT
Integer ITEM_POS
Integer ITEM_TYPE
Integer Token1(3)
Integer Block1(3)
Integer Token2(3)
Integer Block2(3)
Integer H

Function Task3
	

Wait Sw(2) = On

If Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
	GoTo Init
EndIf

Init:

Motor On
Power High
Speed 30
Accel 30, 30
SpeedS 500
AccelS 5000
Tool 1
Go START
If Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
 GoTo Checking
EndIf

Checking:
Xqt QuantityCheck()

Wait Sw(3) = On Or Sw(4) = On Or Sw(0) = On

If Sw(3) = On Then
	Quit QuantityCheck
	GoTo Repositioning
EndIf
If Sw(4) = On Then
	Quit QuantityCheck
	GoTo Random
EndIf
If Sw(0) = On Then
	Wait Sw(1) = On
	If Sw(1) = On Then
		Quit QuantityCheck
		Reset
		GoTo Init
	EndIf
EndIf



Repositioning:
Xqt CallPnP()
Print "Executing Call PnP"
If Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
	If Sw(0) = On Then
		Halt CallPnP
		Wait Sw(0) = Off Or Sw(1) = On
		If Sw(0) = Off Then
			Resume CallPnP
		EndIf
		If Sw(1) = On Then
			Quit CallPnP
			Reset
			GoTo Init
		EndIf
	EndIf
		
	Quit CallPnP
	Wait Sw(4) = On
	If Sw(4) = On Then
		GoTo Random
	EndIf
Else
	Print "Check your buttons"
EndIf


Random:
If Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
	Do While HB > 3 And HT > 3
		RandomStack()

'		If Sw(0) = On Then
'			Halt RandomStack
'			Wait Sw(0) = Off Or Sw(1) = On
'			If Sw(0) = Off Then
'				Resume RandomStack
'			EndIf
'			If Sw(1) = On Then
'				
'				Quit RandomStack
'				Reset
'				GoTo Init
'			EndIf
'		EndIf
	Loop
		
	If H > 0 Then
		Xqt PartCheck()
		
		If Sw(0) = On Then
			Halt PartCheck
			
		EndIf
		Wait Sw(0) = Off Or Sw(1) = On
		If Sw(0) = Off Then
			Resume PartCheck()
			
		EndIf
		If Sw(1) = On Then
			Reset
			GoTo Init
		EndIf
		Wait Sw(3) = On
		If Sw(3) = On Then
			GoTo Repositioning
		EndIf
	EndIf
	
	
Wait Sw(0) = On Or Sw(1) = On Or Sw(3) = On
If Sw(0) = On Then
	Wait Sw(1) = On
	Reset
	GoTo Init
EndIf
If Sw(1) = On Then
	Reset
	GoTo Init
EndIf
If Sw(3) = On Then
	GoTo Repositioning
EndIf
EndIf

Fend

Function QuantityCheck

For TRAY = 1 To 2
              If TRAY = 1 Then
                            For ITEM_TYPE = 0 To 1
                                          For ITEM_POS = 0 To 2
                                          			If Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
	                                                        Go PT1 +Z(20) +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 30) /2 CP
	                                                        Go PT1 +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 30) /2
	                                                        On 8
	                                                        Wait 0.5
                                                     
                                                                                                               
                                                        If ITEM_TYPE = 0 Then
                                                                      Token1(ITEM_POS) = Sw(17)
                                                                      If Token1(ITEM_POS) = 1 Then
                                                                      	Print "Token detected"
                                                                      Else
                                                                      	Print "Token not detected"
                                                                      EndIf
                                                        Else
                                                                      Block1(ITEM_POS) = Sw(17)
                                                                      If Block1(ITEM_POS) = 1 Then
                                                                      	Print "Block detected"
                                                                      Else
                                                                      	Print "Block not detected"
                                                                      EndIf
                                                        EndIf
                                                        Off 8

                                                        Go PT1 +Z(20) +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 30) /2 CP
                                                        
                                                     EndIf
                                           Next
                            Next
              Else
                            For ITEM_TYPE = 0 To 1
                                            For ITEM_POS = 0 To 2
                                            	If Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
                                                          Go PT2 +Z(20) +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 30) /2 CP
                                                          Go PT2 +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 30) +Z(-ITEM_POS / 2) /2
                                                          On 8
                                                          Wait 0.5
                                                          If ITEM_TYPE = 0 Then
                                                                        Token2(ITEM_POS) = Sw(17)
                                                                        If Token2(ITEM_POS) = 1 Then
                                                                      		Print "Token detected"
                                                                      	Else
                                                                      		Print "Token not detected"
                                                                      	EndIf
                                                          Else
                                                                      Block2(ITEM_POS) = Sw(17)
                                                                      If Block2(ITEM_POS) = 1 Then
                                                                      	Print "Block detected"
                                                                      Else
                                                                      	Print "Block not detected"
                                                                      EndIf
                                                          EndIf
                                                          Off 8
                                                
                                                          Go PT2 +Z(20) +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 30) /2 CP
                                                EndIf
                                             Next
                             Next

              EndIf
Next


If Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
	HB = 6
	Go BF +Z(20) +Z(HB * 6) /2
	On 8
	
	Do While Sw(17) = 0
		Go BF +Z(HB * 6) /2
		Wait 0.5
		HB = HB - 1
	Loop
	Off 8
	Wait 0.5
	Go BF +Z(20) +Z(HB * 6) /2
	HB = HB + 2
	Print "Number of Blocks in the feeder", HB
	
	
	HT = 6
	Go TF +Z(20) +Z(HT * 6) +Y(10) /2
	On 8
	
	Do While Sw(17) = 0
		
	    Go TF +Z(HT * 6) /2
	    Wait 0.5
		HT = HT - 1
	Loop
	Off 8
	Wait 0.5
	Go TF +Z(20) +Z(HT * 6) /2
	HT = HT + 2
	Print "Number of Tokens in the feeder", HT
EndIf
Go START

Fend

Function CallPnP

For TRAY = 1 To 2
              If TRAY = 1 Then
                            For ITEM_TYPE = 0 To 1
                                          For ITEM_POS = 0 To 2
                                                        If ITEM_TYPE = 0 Then
                                                                      If Token1(ITEM_POS) = On And Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
                                                                                    Print "Repositioning Parts"
                                                                                    PickandPlace()
                                                                                    
                                                                      EndIf
                                                        Else
                                                                      If Block1(ITEM_POS) = On And Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
                                                                                    Print "Repositioning Parts"
                                                                                    PickandPlace()
                                                                                    
                                                                      EndIf
                                                        EndIf
                                          Next
                            Next
              Else
                            For ITEM_TYPE = 0 To 1
                                          For ITEM_POS = 0 To 2
                                                        If ITEM_TYPE = 0 Then
                                                                      If Token2(ITEM_POS) = On And Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
                                                                                    Print "Repositioning Parts"
                                                                                    PickandPlace()
                                                                                    
                                                                      EndIf
                                                        Else
                                                                      If Block2(ITEM_POS) = On And Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
                                                                                    Print "Repositioning Parts"
                                                                                    PickandPlace()
                                                                                    
                                                                      EndIf
                                                        EndIf
                                          Next
                            Next

              EndIf
Next
Fend

Function PickandPlace
Print "Executing Pick and Place operation"
If TRAY = 1 And Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
		
        Go PT1 +Z(20) +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 30) /2 CP ' Secure Pick
        Go PT1 +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 30) +Z(-ITEM_POS / 2) /2 ' Pick
        On 8
        Wait 0.5
        Go PT1 +Z(20) +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 30) /2 CP ' Secure Pick

        If ITEM_TYPE = 0 Then
        		Go TA +Z(15) +Y(5) +X(5) /2 CP ' Secure Token Aligner
    			Go TA ' Token Aligner
			    Off 8
			    Go TA +Y(-10) /2
			    Go TA +Y(-10) +Z(10) /2 CP
			    Go TA +Z(10) /2 CP ' Secure Token Aligner
			    Go TA /2 ' Token Aligner
			    On 8
			    Wait 0.5
			    Go TA +Z(10) /2 CP ' Secure Token Aligner
                Go TF +Z(20) +Z(HT * 6) +Y(10) /2 CP
                Go TF +Z(HT * 6) +Z(5) /2
                Off 8
                Wait 0.5
                Go TF +Z(20) +Z(HT * 6) +Y(10) /2 CP
                HT = HT + 1
        Else
        
                Go BA +Z(10) +Y(5) +X(5) /2 ' Secure Block Aligner
			    Go BA +Y(1) /2 '' Block Aligner
			    Go BA +Y(-1) +X(-1) /2
			    Off 8
			    Go BA +Y(-1) +X(-1) +Z(10) /2
			    Go BA +Z(10) /2 ' Secure Block Aligner
			    Go BA /2 ' Block Aligner
			    On 8
			    Wait 0.5
			    Go BA +Z(10) /2 ' Secure Block Aligner
                Go BF +Z(20) +Z(HB * 6) +Y(5) +X(5) /2 CP
                Go BF +Z(HB * 6) +Z(5) /2
                Off 8
                Wait 0.5
                Go BF +Z(20) +Z(HB * 6) /2 CP
                HB = HB + 1
             
        EndIf

Else

        Go PT2 +Z(20) +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 30) /2 CP ' Secure Pick
        Go PT2 +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 30) +Z(-ITEM_POS / 2) /2 ' Pick
        On 8
        Wait 0.5
        Go PT2 +Z(20) +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 30) /2 CP ' Secure Pick

        If ITEM_TYPE = 0 Then
        		Go TA +Z(15) +Y(5) +X(5) /2 CP ' Secure Token Aligner
    			Go TA ' Token Aligner
			    Off 8
			    Go TA +Y(-10) /2
			    Go TA +Y(-10) +Z(10) /2 CP
			    Go TA +Z(10) /2 CP ' Secure Token Aligner
			    Go TA /2 ' Token Aligner
			    On 8
			    Wait 0.2
			    Go TA +Z(10) /2 CP ' Secure Token Aligner
                Go TF +Z(20) +Z(HT * 6) +Y(10) /2 CP
                Go TF +Z(HT * 6) +Z(5) /2
                Off 8
                Wait 0.5
                Go TF +Z(20) +Z(HT * 6) /2 CP
                HT = HT + 1
        Else
                Go BA +Z(10) +Y(5) +X(5) /2 ' Secure Block Aligner
			    Go BA +Y(1) /2 '' Block Aligner
			    Go BA +Y(-1) +X(-1) /2
			    Off 8
			    Go BA +Y(-1) +X(-1) +Z(10) /2
			    Go BA +Z(10) /2 ' Secure Block Aligner
			    Go BA /2 ' Block Aligner
			    On 8
			    Wait 0.5
			    Go BA +Z(10) /2 ' Secure Block Aligner
                Go BF +Z(20) +Z(HB * 6) +Y(5) +X(5) /2 CP
                Go BF +Z(HB * 6) +Z(5) /2
                Off 8
                Wait 0.5
                Go BF +Z(20) +Z(HB * 6) /2 CP
                HB = HB + 1
        EndIf
EndIf
Go START
Fend
Function RandomStack
Integer RandomTorB
Integer Shift

Do While HT > 0 And HB > 0
	
	RandomTorB = Int(Rnd(2))
	If RandomTorB = 0 Then 'Token
	    Print "Token was randomly chosen"
	    If HT > 0 And Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
	        Go TF +Z((HT - 1) * 6) +Z(20) +Y(10) /2 CP
	        Go TF +Z((HT - 1) * 6) /2
	        On 8
	        Wait 0.5
	        Go TF +Z((HT - 1) * 6) +Z(10) /2
	        Go TF +Z((HT - 1) * 6) +Z(10) +Z(H * 6) +Y(10) /2 CP
	        HT = HT - 1
	        Go TA1 +Z(20) +Z(H * 6) /2 CP
	        Go TA1 +Z(H * 6) +Z(1) +X(-1) /2
	        Off 8
	        Go TA1 +Z(20) +Z(H * 6) /2 CP
	        H = H + 1
	    EndIf
	    If HT = 0 Then
	    	Print "No more tokens available"
	    	
	    EndIf
	Else
		Shift = Int(Rnd(2))
		If Shift = 0 Then
		    Print "Block was randomly chosen"
		    If HB > 0 And Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
		        Go BF +Z((HB - 1) * 6) +Z(10) +Y(10) /2 CP
		        Go BF +Z((HB - 1) * 6) /2
		        On 8
		        Wait 0.5
		        Go BF +Z((HB - 1) * 6) +Z(10) /2
		        Go BF +Z((HB - 1) * 6) +Z(10) +Z(H * 6) +Y(10) /2 CP
		        HB = HB - 1
		        Go BA +Z(20) +Z(H * 6) +Y(5) +X(5) /2 CP
		        Go BA +Z(H * 6) +Z(1) +X(-1.5) /2
		        Off 8
		        Go BA +Z(20) +Z(H * 6) /2 CP
	        	H = H + 1
	        EndIf
	        If HB = 0 Then
	        
	    		Print "No more blocks available"
	    		
	    	EndIf
		 Else 'Shifted Block
		    Print "Shifted Block was randomly chosen"
		    If HB > 0 And Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
		        Go BF +Z((HB - 1) * 6) +Z(10) +Y(10) /2 CP
		        Go BF +Z((HB - 1) * 6) /2
		        On 8
		        Wait 0.5
		        Go BF +Z((HB - 1) * 6) +Z(10) /2
		        Go BF +Z((HB - 1) * 6) +Z(10) +Z(H * 6) +Y(10) +X(5) /2 CP
		        HB = HB - 1
		        Go BA +Z(20) +Z(H * 6) /2 CP
		        Go BA1 +Z(20) +Z(H * 6) +Y(5) +X(5) /2
		        Go BA1 +Z(H * 6) /2
		        Off 8
		        Go BA1 +Z(20) +Z(H * 6) /2 CP
		        H = H + 1
		    EndIf
		    If HB = 0 Then
	    		Print "No more blocks available"
	    		
		    EndIf
		EndIf
	EndIf
Loop
Fend
Function PartCheck
Integer Check1
Integer Check2
Motor On
Power High
Speed 15
Accel 15, 15
SpeedS 250
AccelS 2500
Tool 1

Do While H >= 0
	If Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
		Go TA1 +Z(20) +Z((H - 1) * 6) /2 CP
		Go TA1 +Z(20) +Z((H - 1) * 6) +Y(6) /2 CP 'Check for normal block
		On 8
		Go TA1 +Z((H - 1) * 6) +Y(7) /2 'Distance
		Wait 0.5
		Check1 = Sw(17)
		Off 8
		Wait 0.5
		Go TA1 +Z(20) +Z((H - 1) * 6) +Y(8) /2 CP
		
		Go TA1 +Z(20) +Z((H - 1) * 6) /2 CP
		Go TA1 +Z(20) +Z((H - 1) * 6) +X(7) /2 CP 'Check for Shifted block
		On 8
		Go TA1 +Z((H - 1) * 6) +X(7) /2 'Distance
		Wait 0.5
		Check2 = Sw(17)
		Off 8
		Wait 0.5
		Go TA1 +Z(20) +Z((H - 1) * 6) /2
		
		
		If Check1 = 1 And Check2 = 0 And Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
		    Print "Non-shifted Block Detected"
		    Go BA +Z((H - 1) * 6) +Z(10) /2
		    Go BA +Z((H - 1) * 6) /2
		    On 8
		    Wait 0.5
		    Go BA +Z((H - 1) * 6) +Z(HB * 6) +Z(20) /2
		    Go BF +Z(HB * 6) +Z(10) +Z((H - 1) * 6) +X(5) +Y(5) /2 CP
		    Go BF +Z(HB * 6) +Z(2) /2
		    Off 8
		    Wait 0.5
		    Go BF +Z(HB * 6) +Z(10) +Z((H - 1) * 6) +X(5) +Y(5) /2 CP
		    
		    HB = HB + 1
		    H = H - 1
		
		EndIf
		If Check1 = 0 And Check2 = 1 And Sw(2) = On And Sw(0) = Off And Sw(1) = Off Then
		    Print "Shifted Block Detected"
		    Go BA1 +Z((H - 1) * 6) +Z(10) /2
		    Go BA1 +Z((H - 1) * 6) /2
		    On 8
		    Wait 0.5
		    Go BA1 +Z((H - 1) * 6) +Z(HB * 6) +Z(20) /2
		    Go BF +Z(HB * 6) +Z(10) +Z((H - 1) * 6) +X(5) +Y(5) /2 CP
		    Go BF +Z(HB * 6) +Z(2) /2
		    Off 8
		    Wait 0.5
		    Go BF +Z(HB * 6) +Z(10) +Z((H - 1) * 6) +X(5) +Y(5) /2 CP
		    
		    HB = HB + 1
		    H = H - 1
		
		EndIf
		If Check1 = 0 And Check2 = 0 Then
		    Print "Token Detected"
		    Go TA1 +Z((H - 1) * 6) +Z(10) /2
		    Go TA1 +Z((H - 1) * 6) /2
		    On 8
		    Wait 0.5
		    Go TA1 +Z((H - 1) * 6) +Z(HT * 6) +Z(20) /2
		    Go TF +Z(HT * 6) +Z(10) +Z((H - 1) * 6) +Y(5) /2 CP
		    Go TF +Z(HT * 6) +Z(2) /2
		    Off 8
		    Wait 0.5
		    Go TF +Z(HT * 6) +Z(10) +Y(5) /2 CP
		
		    HT = HT + 1
		    H = H - 1
		   
		EndIf
	EndIf
		
Loop

Fend