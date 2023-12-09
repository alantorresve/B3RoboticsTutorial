Integer ITEM_TYPE
Integer ITEM_POS
Integer DIRECTION
Integer HEIGHT

// Task1
Function Task1
    Home

    DIRECTION = 1

    If DIRECTION = 1 Then // Forward direction
              
              For ITEM_POS = 0 To 2
                            HEIGHT = 3
                            ITEM_TYPE = 0 // Token
                            PickAlignPlace()
              Next
              For ITEM_POS = 0 To 2
                            HEIGHT = 3
                            ITEM_TYPE = 1 // Block
                            PickAlignPlace()

    Else // Reverse direction
              
              For ITEM_POS = 0 To 2
                            HEIGHT = 0
                            ITEM_TYPE = 0 // Token
                            PickAlignPlace()
              Next
                            HEIGHT = 0
                            For ITEM_POS = 0 To 2
                            ITEM_TYPE = 1 // Block
                            PickAlignPlace()
    End If
    Home
Fend


// Function to pick, align, and place an item

Function PickAlignPlace
    
        If DIRECTION = 1 Then // Forward direction
              If ITEM_TYPE = 0 // Token
                            Go TF +Z(HEIGHT * 6 + 10) /4 // Secure Token Feeder
                            Go TF +Z(HEIGHT * 6)/4 //Token Feeder
                            On 8
                            Wait 0.5
                            Go TF +Z(HEIGHT * 6 + 10) /4 // Secure Token Feeder
                            HEIGHT = HEIGHT - 1
                            Go TA +Z(10) /4 // Secure Token Aligner
                            Go TA // Token Aligner
                            Off 8
                            Go TA +X(10) /4 
                            Go TA +Z(10) /4 // Secure Token Aligner
                            Go TA /4 // Token Aligner
                            On 8
                            Wait 0.5
                            Go TA +Z(10) /4 // Secure Token Aligner
              Else // Block
                            Go BF +Z(HEIGHT * 6 + 10) /4 // Secure Block Feeder
                            Go BF +Z(HEIGHT * 6)/4 //Block Feeder
                            On 8
                            Wait 0.5
                            Go BF +Z(HEIGHT * 6 + 10) /4 // Secure Block Feeder
                            HEIGHT = HEIGHT - 1
                            Go BA +Z(10) /4 // Secure Block Aligner
                            Go BA // Block Aligner
                            Off 8
                            Go BA +X(10) /4 
                            Go BA +Z(10) /4 // Secure Block Aligner
                            Go BA /4 // Block Aligner
                            On 8
                            Wait 0.5
                            Go BA +Z(10) /4 // Secure Block Aligner
                                          
              Go PT1 +Z(10) +Y(-ITEM_POS * 30) + X(ITEM_TYPE * 30) /5 // Secure Placer
              Go PT1 +Y(-ITEM_POS * 30) /5 // Placer
              Off 8
              Wait 0.5

        Else // Reverse direction
              Go PT1 +Z(10) +Y(-ITEM_POS * 30) + X(ITEM_TYPE * 30) /5 // Secure Pick
              Go PT1 +Y(-ITEM_POS * 30) + X(ITEM_TYPE * 30) /5 //Pick
              On 8
              Wait 0.5
              Go PT1 +Z(10) +Y(-ITEM_POS * 30) + X(ITEM_TYPE * 30) /5 // Secure Pick

              If ITEM_TYPE = 0 //Token

                            Go TF +Z(HEIGHT * 6 + 10) /4 // Secure Token Feeder
                            Go TF +Z(HEIGHT * 6)/4 //Token Feeder
                            Off 8
                            Wait 0.5
                            Go TF +Z(HEIGHT * 6 + 10) /4 // Secure Token Feeder
                            HEIGHT = HEIGHT + 1
              Else //Block
                            Go BF +Z(HEIGHT * 6 + 10) /4 // Secure Block Feeder
                            Go BF +Z(HEIGHT * 6)/4 //Block Feeder
                            Off 8
                            Wait 0.5
                            Go BF +Z(HEIGHT * 6 + 10) /4 // Secure Block Feeder
                            HEIGHT = HEIGHT + 1
Fend