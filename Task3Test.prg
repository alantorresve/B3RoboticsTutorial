Integer TRAY
Integer HB
Integer HT
Integer ITEM_POS
Integer ITEM_TYPE
Integer Token1(3)
Integer Block1(3)
Integer Token2(3)
Integer Block2(3)

Function Task3

''Motor On
''Power High
''Speed 30
''Accel 30, 30
''SpeedS 500
''AccelS 5000
Tool 1


Go START

QuantityCheck()
CallPnP()

Go START

Fend

Function QuantityCheck

For TRAY = 1 To 2
              If TRAY = 1 Then
                            For ITEM_TYPE = 0 To 1
                                          For ITEM_POS = 0 To 2
                                                        Go PT1 +Z(20) +Y(ITEM_POS * 31) +X(ITEM_TYPE * 30) /2 CP
                                                        Go PT1 +Y(ITEM_POS * 31) +X(ITEM_TYPE * 30) /2
                                                        On 8
                                                        Wait 0.5
                                                        If ITEM_TYPE = 0 Then
                                                                      Token1(ITEM_POS) = Sw(17)
                                                                      Print Token1(ITEM_POS)
                                                        Else
                                                                      Block1(ITEM_POS) = Sw(17)
                                                                      Print Block1(ITEM_POS)
                                                        EndIf
                                                        Off 8

                                                        Go PT1 +Z(20) +Y(ITEM_POS * 31) +X(ITEM_TYPE * 30) /2 CP
                                           Next
                            Next
              Else
                            For ITEM_TYPE = 0 To 1
                                                        For ITEM_POS = 0 To 2
                                                                      Go PT2 +Z(20) +Y(ITEM_POS * 31) +X(ITEM_TYPE * 30) /2 CP
                                                                      Go PT2 +Y(ITEM_POS * 31) +X(ITEM_TYPE * 30) +Z(-ITEM_POS) /2
                                                                      On 8
                                                                      Wait 0.5
                                                                      If ITEM_TYPE = 0 Then
                                                                                    Token2(ITEM_POS) = Sw(17)
                                                                                    Print Token1(ITEM_POS)
                                                                      Else
                                                                                    Block2(ITEM_POS) = Sw(17)
                                                                                    Print Block1(ITEM_POS)
                                                                      EndIf
                                                                      Off 8

                                                                      Go PT2 +Z(20) +Y(ITEM_POS * 31) +X(ITEM_TYPE * 30) /2 CP
                                                         Next
                             Next

              EndIf
Next



HB = 6
Go BF +Z(20) +Z(HB * 6) /2
On 8

Do While Sw(17) = 0
	Move BF +Z(HB * 6) /2
	Wait 1.0
	HB = HB - 1
Loop
Off 8
Wait 0.5
Go BF +Z(20) +Z(HT * 6) /2
HB = HB + 1
Print HB

HT = 6
Go TF +Z(20) +Z(HT * 6) +Y(10) /2
On 8

Do While Sw(17) = 0
	
    Move TF +Z(HT * 6) /2
    Wait 1.0
	HT = HT - 1
Loop
Off 8
Wait 0.5
Go TF +Z(20) +Z(HT * 6) /2
HT = HT + 1
Print HT


Fend

Function CallPnP


For TRAY = 1 To 2
              If TRAY = 1 Then
                            For ITEM_TYPE = 0 To 1
                                          For ITEM_POS = 0 To 2
                                                        If ITEM_TYPE = 0 Then
                                                                      If Token1(ITEM_POS) = On Then
                                                                                    PickandPlace()
                                                                                    HT = HT - 1
                                                                      EndIf
                                                        Else
                                                                      If Block1(ITEM_POS) = On Then
                                                                                    PickandPlace()
                                                                                    HB = HB - 1
                                                                      EndIf
                                                        EndIf
                                          Next
                            Next
              Else
                            For ITEM_TYPE = 0 To 1
                                          For ITEM_POS = 0 To 2
                                                        If ITEM_TYPE = 0 Then
                                                                      If Token2(ITEM_POS) = On Then
                                                                                    PickandPlace()
                                                                                    HT = HT - 1
                                                                      EndIf
                                                        Else
                                                                      If Block2(ITEM_POS) = On Then
                                                                                    PickandPlace()
                                                                                    HB = HB - 1
                                                                      EndIf
                                                        EndIf
                                          Next
                            Next

              EndIf
Next
Fend

Function PickandPlace

If TRAY = 1 Then

        Go PT1 +Z(20) +Y(ITEM_POS * 31) +X(ITEM_TYPE * 30) /2 CP ' Secure Pick
        Go PT1 +Y(ITEM_POS * 31) +X(ITEM_TYPE * 30) /2 ' Pick
        On 8
        Wait 0.5
        Go PT1 +Z(20) +Y(ITEM_POS * 31) +X(ITEM_TYPE * 30) /2 CP ' Secure Pick

        If ITEM_TYPE = 0 Then
                Go TF +Z(20) +Z(HT * 6) /2 CP
                Go TF +Z(HT * 6) /2
                Off 8
                Wait 0.5
                Go TF +Z(20) +Z(HT * 6) /2 CP
                HT = HT + 1
        Else
                
                Go BF +Z(20) +Z(HB * 6) /2 CP
                Go BF +Z(HB * 6) /2
                Off 8
                Wait 0.5
                Go BF +Z(20) +Z(HB * 6) /2 CP
                HB = HB + 1
             

        EndIf

Else
        Go PT2 +Z(20) +Y(ITEM_POS * 31) +X(ITEM_TYPE * 30) /2 CP ' Secure Pick
        Go PT2 +Y(ITEM_POS * 31) +X(ITEM_TYPE * 30) /2 ' Pick
        On 8
        Wait 0.5
        Go PT2 +Z(20) +Y(ITEM_POS * 31) +X(ITEM_TYPE * 30) /2 CP ' Secure Pick

        If ITEM_TYPE = 0 Then
                Go TF +Z(20) +Z(HT * 6) /2 CP
                Go TF +Z(HT * 6) /2
                Off 8
                Wait 0.5
                Go TF +Z(20) +Z(HT * 6) /2 CP
                HT = HT + 1
        Else
                
                Go BF +Z(20) +Z(HB * 6) /2 CP
                Go BF +Z(HB * 6) /2
                Off 8
                Wait 0.5
                Go BF +Z(20) +Z(HB * 6) /2 CP
                HB = HB + 1
        EndIf
EndIf
Fend