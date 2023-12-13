Integer TRAY
Integer ITEM_TYPE
Integer ITEM_POS
Integer HEIGHT
'Points needed : TT1, TT2, TF, BF, START
''ITEM_TYPE = 0 //Token
''ITEM_TYPE = 1 //Block

Function Task2

Motor On
Power High
Speed 30
Accel 30, 30
SpeedS 500
AccelS 5000
Tool 1

Go START

HEIGHT
For TRAY = 1 To 2
              
              For ITEM_POS = 0 To 2
                            For ITEM_TYPE = 0 To 1
                                          PickPlace()
                            Next ITEM_TYPE
              Next ITEM_POS

Next
Go START
Fend

Function PickPlace

              If Tray = 1 Then

                            Go TT1 +Z(20) +Y(ITEM_POS * 30) +X(ITEM_TYPE*30) /2
                            Go TT1 +Y(ITEM_POS * 30) +X(ITEM_TYPE*30) /2
                            On 8
                            Wait 0.5
                            Go TT1 +Z(20) +Y(ITEM_POS * 30) +X(ITEM_TYPE*30) /2

                            Go BF +Z(50) +Y(10) /2 ' Secure Block Feeder
                            Go BF +Z(HEIGHT * 6) /2 ' Block Feeder
                            Off 8
                            Wait 0.5
                            Go BF +Z(50) +Y(5) /2 ' Secure Block Feeder
                            HEIGHT = HEIGHT + 1
                            

              Else
              
                            Go TT2 +Z(20) +Y(ITEM_POS * 30) +X(ITEM_TYPE*30) /2
                            Go TT2 +Y(ITEM_POS * 30) +X(ITEM_TYPE*30) /2
                            On 8
                            Wait 0.5
                            Go TT2 +Z(20) +Y(ITEM_POS * 30) +X(ITEM_TYPE*30) /2

                            Go BF +Z(50) +Y(10) /2 ' Secure Block Feeder
                            Go BF +Z(HEIGHT * 6) /2 ' Block Feeder
                            Off 8
                            Wait 0.5
                            Go BF +Z(50) +Y(5) /2 ' Secure Block Feeder
                            HEIGHT = HEIGHT + 1
              EndIf

Fend