Integer ITEM_TYPE
Integer ITEM_POS
Integer DIRECTION
Integer HEIGHT

' Task1
Function Main
Motor On
Power High
Speed 30
Accel 30, 30
SpeedS 700
AccelS 5000
Tool 1
    Go START

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


Go START
Fend

' Function to pick, align, and place an item

Function PickAlignPlace

If ITEM_TYPE = 0 Then
    Go TF +Z(50) +Y(10) /2 CP ' Secure Token Feeder
    Go TF +Z(HEIGHT * 6) /2 ' Token Feeder
    On 8
    Wait 0.5
    Go TF +Z(HEIGHT * 6) +Z(10) +Y(5) /2 CP ' Secure Token Feeder
    HEIGHT = HEIGHT - 1
    Go TA +Z(15) +Y(5) /2 CP ' Secure Token Aligner
    Go TA ' Token Aligner
    Off 8
    Go TA +Y(-10) /2
    Go TA +Y(-10) +Z(10) /2 CP
    Go TA +Z(10) /2 CP ' Secure Token Aligner
    Go TA /2 ' Token Aligner
    On 8
    Wait 0.5
    Go TA +Z(10) /2 CP ' Secure Token Aligner
    
Else ' Block
    
    Go BF +Z(50) +Y(10) /2 CP ' Secure Block Feeder
    Go BF +Z(HEIGHT * 6) /2 ' Block Feeder
    On 8
    Wait 0.5
    Go BF +Z(HEIGHT * 6) +Z(10) +Y(10) /2 CP
    HEIGHT = HEIGHT - 1
    Go BA +Z(10) +Y(5) /2 ' Secure Block Aligner
    Go BA +Y(1) /2 '' Block Aligner
    Go BA +Y(-1) +X(-1) /2
    Off 8
    Go BA +Y(-1) +X(-1) +Z(10) /2
    Go BA +Z(10) /2 ' Secure Block Aligner
    Go BA /2 ' Block Aligner
    On 8
    Wait 0.5
    Go BA +Z(10) /2 ' Secure Block Aligner
    
EndIf
        
Go PT1 +Z(10) +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 29.7) +X(-ITEM_POS / 4) /2 CP ' Secure Place
Go PT1 +Z(5) +Y(ITEM_POS * 30.7) +X(ITEM_TYPE * 29.7) +X(-ITEM_POS / 4) /2
''Go PT1 +Y(ITEM_POS * 30) +X(ITEM_TYPE * 31) /2 ' Place
Off 8
Wait 0.5
''Go PT1 +Z(20) +Y(ITEM_POS * 31) +X(ITEM_TYPE * 30) /2 ' Secure Place

Fend




