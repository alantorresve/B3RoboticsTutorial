Integer TRAY
Integer ITEM_TYPE
Integer ITEM_POS
Integer HEIGHT
Integer H
'Points needed : PT1, PT2, TF, BF, START
''ITEM_TYPE = 0 //Token
''ITEM_TYPE = 1 //Block

Function Task2n

'Motor On
'Power High
'Speed 30
'Accel 30, 30
'SpeedS 500
'AccelS 5000
'Tool 1

Go START

HEIGHT = 0
For H = 5 To 0
	For ITEM_TYPE = 0 To 1
	              PickPlaceT()
	Next ITEM_TYPE
Next
Go START
Fend

Function PickPlaceT

              If ITEM_TYPE = 0 Then

                            Go TF +Z(15) +Z(H * 6) /2 CP
                            Move TF +Z(H * 6) /2
                            On 8
                            Wait 0.5
                            Move TF +Z(15) +Z(H * 6) /2
                            Move TF +Z(15) +Z(H * 6) +Y(15) /2
                            
                           

              Else
                            Go BF +Z(15) +Z(H * 6) /2 CP
                            Move BF +Z(H * 6) /2
                            On 8
                            Wait 0.5
                            Move BF +Z(15) +Z(H * 6) +Y(15) /2
                            
              EndIf
              
            Go BA +Z(15) +Z(HEIGHT * 6) /2 CP
            Move BA +Z(HEIGHT * 6) /2
            Off 8
            Wait 0.5
            Move BA +Z(15) +Z(HEIGHT * 6) /2 CP
            HEIGHT = HEIGHT + 1
           
Fend
