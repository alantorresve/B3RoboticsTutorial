Integer ITEM_TYPE
Integer ITEM_POS
Integer DIRECTION
Integer HEIGHT

' Task1
Function Main
    Home

    DIRECTION = 2

    If DIRECTION = 1 Then ' Forward direction
        HEIGHT = 2
        For ITEM_POS = 0 To 2
            ITEM_TYPE = 0 ' Token
            PickAlignPlace()
        Next
        HEIGHT = 2
        For ITEM_POS = 0 To 2
            ITEM_TYPE = 1 ' Block
            PickAlignPlace()
        Next

    Else ' Reverse direction
        HEIGHT = 0
        For ITEM_POS = 0 To 2
            
            ITEM_TYPE = 0 ' Token
            PickAlignPlace()
        Next
        
        HEIGHT = 0
        For ITEM_POS = 0 To 2
        	
            ITEM_TYPE = 1 ' Block
            PickAlignPlace()
        Next
    EndIf
    Home
Fend


' Function to pick, align, and place an item

Function PickAlignPlace
    
    If DIRECTION = 1 Then ' Forward direction
    
        If ITEM_TYPE = 0 Then
            Go TF +Z(50) +Y(10) /2 ' Secure Token Feeder
            Go TF +Z(HEIGHT * 6) /2 ' Token Feeder
            On 8
            Wait 0.5
            Go TF +Z(50) +Y(5) /2 ' Secure Token Feeder
            HEIGHT = HEIGHT - 1
            Go TA +Z(50) +Y(5) /2 ' Secure Token Aligner
            Go TA ' Token Aligner
            Off 8
            Go TA +Y(-10) /2
            Go TA +Z(10) /2 ' Secure Token Aligner
            Go TA /2 ' Token Aligner
            On 8
            Wait 0.5
            Go TA +Z(10) /2 ' Secure Token Aligner
            
        Else ' Block
        	
            Go BF +Z(50) +Y(10) /2 ' Secure Block Feeder
            Go BF +Z(HEIGHT * 6) /2 ' Block Feeder
            On 8
            Wait 0.5
            Go BF +Z(50) +Y(5) /2 ' Secure Block Feeder
            HEIGHT = HEIGHT - 1
            Go BA +Z(50) +Y(5) /2 ' Secure Block Aligner
            Go BA ' Block Aligner
            Off 8
            Go BA +Y(-10) +X(-10) /2
            Go BA +Z(10) /2 ' Secure Block Aligner
            Go BA /2 ' Block Aligner
            On 8
            Wait 0.5
            Go BA +Z(10) /2 ' Secure Block Aligner
            
        EndIf
              
        Go PT1 +Z(20) +Y(ITEM_POS * 30) +X(ITEM_TYPE * 30) /2 ' Secure Place
        Go PT1 +Y(ITEM_POS * 30) +X(ITEM_TYPE * 30) /2 ' Place
        Off 8
        Wait 0.5
        Go PT1 +Z(20) +Y(ITEM_POS * 30) +X(ITEM_TYPE * 30) /2 ' Secure Place
        

    Else ' Reverse direction
    	
        Go PT1 +Z(20) +Y(ITEM_POS * 30) +X(ITEM_TYPE * 30) /2 ' Secure Pick
        Go PT1 +Y(ITEM_POS * 30) +X(ITEM_TYPE * 30) /2 ' Pick
        On 8
        Wait 0.5
        Go PT1 +Z(20) +Y(ITEM_POS * 30) +X(ITEM_TYPE * 30) /2 ' Secure Pick

        If ITEM_TYPE = 0 Then
        
            Go TF +Z(50) +Y(5) /2 ' Secure Token Feeder
            Go TF +Z(HEIGHT * 6) /2 ' Token Feeder
            Off 8
            Wait 0.5
            Go TF +Z(50) +Y(5) /2 ' Secure Token Feeder
            HEIGHT = HEIGHT + 1
            
        Else ' Block
            Go BF +Z(50) +Y(5) +X(5) /2 ' Secure Block Feeder
            Go BF +Z(HEIGHT * 6) /2 ' Block Feeder
            Off 8
            Wait 0.5
            Go BF +Z(HEIGHT * 6) +Y(-2) +X(-2) /2
            Go BF +Z(50) +Y(5) /2 ' Secure Block Feeder
            HEIGHT = HEIGHT + 1
            
        EndIf
    EndIf
Fend
