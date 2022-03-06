VAR NoiseComplain = false
VAR Dressed = false
VAR Time = 0
VAR CloseOutsideTime = 1260
VAR BedTime = 1380
VAR Day = 0
VAR Money = 0

VAR ExistenceFee = 0
VAR SocialScore = 0

VAR WorkTime = 0
VAR WorkFloor = 0
VAR WorkHallway = ""
VAR WorkMessageChecked = false

VAR WantsToInvestInLGCDP = false
VAR InvestPriceLGCDP = 0
VAR InvestedInLGCDP = false

VAR NeedsMap = false
VAR MapInDrawer = false
{RANDOM(1,2):
-1: ~MapInDrawer = true
-2: ~MapInDrawer = false
}
VAR HasMap = false
VAR MapRequest = false
VAR MapRequestDay = 0

VAR Accessory = ""

VAR FridgeGooTea = 0
~FridgeGooTea = RANDOM(0,1)
VAR FridgeIceScream = 0
~FridgeIceScream = RANDOM(0,1)
VAR FridgeNoodles = 0
VAR FridgeVoidBiscuits = 0
~FridgeVoidBiscuits = RANDOM(0,2)
VAR FridgeCrippleCrackers = 0
~FridgeCrippleCrackers = RANDOM(0,1)
VAR FridgeWater = 0
~FridgeWater = RANDOM(0,3)
VAR FridgeInfiniteParty = 0
~FridgeInfiniteParty = RANDOM(0,1)
VAR FridgeFuzzyBuzz = 0
~FridgeFuzzyBuzz = RANDOM(0,1)
VAR FridgeBottleInAJar = 0
VAR FridgeJarFlower = 0

VAR InventoryGooTea = 0
VAR InventoryIceScream = 0
VAR InventoryNoodles = 0
VAR InventoryVoidBiscuits = 0
VAR InventoryCrippleCrackers = 0
VAR InventoryWater = 0
VAR InventoryInfiniteParty = 0
VAR InventoryFuzzyBuzz = 0
VAR InventoryBottleInAJar = 0

VAR ConsumedNutrients = 0

VAR AtHome = false

VAR HasSpiralFlower = false
VAR PlantState = 0
VAR PlantStateNextDay = 0

VAR PermissionDeniedNeighboringDistrict = false
VAR Worked = false

VAR GooTeaPrice = 0
~GooTeaPrice = RANDOM(30, 50)
VAR IceScreamPrice = 0
~IceScreamPrice = RANDOM(35, 60)
VAR NoodlesPrice = 0
~NoodlesPrice = RANDOM(50, 90)
VAR VoidBiscuitsPrice = 0
~VoidBiscuitsPrice = RANDOM(25, 30)
VAR CrippleCrackersPrice = 0
~CrippleCrackersPrice = RANDOM(45, 80)
VAR WaterPrice = 0
~WaterPrice = RANDOM(10, 20)
VAR InfinitePartyPrice = 0
~InfinitePartyPrice = RANDOM(120, 180)
VAR FuzzyBuzzPrice = 0
~FuzzyBuzzPrice = RANDOM(90, 120)
VAR BottleInAJarPrice = 0
~BottleInAJarPrice = RANDOM(10,15)

VAR ArrestedOutside = false
VAR GoSleep = false
-> waking_up

=== function ShowTime(t) ===
    ~ temp hour = INT(t/60)
    ~ temp minutes = INT(t%60)
    {minutes < 10:
        ~ minutes = ":0" + minutes
    -else:
        ~ minutes = ":" + minutes
    }
    ~ return (hour + minutes)

=== function ShowTimeMoney ===
    <b>Time: {ShowTime(Time)}; Money: {Money} GGT</b>
    <hr>
    {
        -!AtHome && Time > CloseOutsideTime:
            ~ArrestedOutside = true
            
        -AtHome && Time > BedTime:
            ~GoSleep = true
    }

=== function AnythingInFridge ===
    ~ return FridgeGooTea || FridgeIceScream || FridgeNoodles || FridgeVoidBiscuits || FridgeCrippleCrackers || FridgeWater || FridgeInfiniteParty || FridgeFuzzyBuzz || FridgeBottleInAJar || FridgeJarFlower

=== function AnythingInInventory ===
    ~ return InventoryGooTea || InventoryIceScream || InventoryNoodles || InventoryVoidBiscuits || InventoryCrippleCrackers || InventoryWater || InventoryInfiniteParty || InventoryFuzzyBuzz || InventoryBottleInAJar || HasMap

=== function GiveMoneyToShadyBeggar ===
    ~ temp x = 0
    {Money < 10:
        ~x = 1
    -else:
        ~x = INT(Money * 0.25)
    }
    ~Money -= x
    ~ return x
    
=== function EnoughMoney(productPrice, productName)
{Money >= productPrice:
    After a moment of hesitation you insert your wrist into the machine and immediately are notified by a robotic voice “Transaction complete, {productPrice} amount of GGTs was taken from your account.”. Now {productName} is legally yours.
    ~return true
-else:
    You don't have enough GGTs for {productName}
    ~return false
}

===waking_up===
~NoiseComplain = false
~Dressed = false
~Time = 360.001
~Day += 1
~Money = RANDOM(0,20)

~ExistenceFee = RANDOM(15,30)
~SocialScore = 0

~WorkTime = 510.001 + RANDOM(1,60)
~WorkFloor = RANDOM(1, 5)
{RANDOM(1,5):
-1: ~WorkHallway = "A"
-2: ~WorkHallway = "B"
-3: ~WorkHallway = "C"
-4: ~WorkHallway = "D"
-5: ~WorkHallway = "E"
}
~WorkMessageChecked = false

~WantsToInvestInLGCDP = false
~InvestPriceLGCDP = RANDOM(10,20)
~InvestedInLGCDP = false

~NeedsMap = false
~HasMap = false

~Accessory = "Nothing"

~FridgeJarFlower = 0
~InventoryGooTea = 0
~InventoryIceScream = 0
~InventoryNoodles = 0
~InventoryVoidBiscuits = 0
~InventoryCrippleCrackers = 0
~InventoryWater = 0
~InventoryInfiniteParty = 0
~InventoryFuzzyBuzz = 0
~InventoryBottleInAJar = 0

~ConsumedNutrients = 0

~AtHome = true

~HasSpiralFlower = false

~PermissionDeniedNeighboringDistrict = false
~Worked = false

~ArrestedOutside = false
~GoSleep = false

{Day > 1:
    Day {Day}
    A new citizen moved in for testing
    <hr>
}

#audio: insert appropriate soundtrack image:black screen
{~You are sitting at a cafe, talking to your friends about recent events in the city and enjoying above average cuisine…but then you wake up and realize that you don’t have any friends, all local cafes went out of business due to the lack of paying customers.|You are rushing through the storm with your fellow sailors on your employers cargo ship, sea creatures washing aboard from the waves, suddenly one of your coworkers falls overboard…but then you wake up and realize that all of the large water bodies are too toxic for any sea life to thrive there, also you are unemployed… yet.|You are walking through the woods, collecting curious looking herbs and odd looking berries, after some time you hear something in nearby bushes. You decide to take a closer look, but while you are approaching a wild animal jumps at you…but then you wake up and realize that due to aggressive deforestation there are no woods and no woodland animals to ambush you on the island. Good.|Nothing. Emptiness. Desolation. Void… but then you wake up realizing that you’ll have to continue existing today.|You were preparing for this your whole life, you stretch your extremities, take a deep breath and start running, preparing to jump. You are about to jump…but then you wake up and realize that you’d probably get tired even from stretching your extremities, yet alone running or jumping.}

    + Open your eyes 
        <hr>
        -> continue 
    
    =continue
        #audio: silence image: spiral clock
        Taking a glimpse at the clock on the wall, it is {ShowTime(Time)}. You woke up before the alarm. “Maybe it would be a good idea to get up right now.” you tell yourself, while starting closing your eye and falling back into slumber.
    
    
        + Sleep some more 
            -> sleep_some_more
        
        + Turn off the alarm and wake up 
            -> turn_off_alarm_and_wake_up
        
            =sleep_some_more
                # audio: silence image: balck screen
                    You slumber for 1 more hour, not feeling like it helped much. 
                    ~Time += 60
                    + [Continue] 
                        -> alarm_rings
                
            =alarm_rings
                #  audio: alarm image: spiral clock(glowing)
                Suddenly the spiral clock starts buzzing that loud alarm tone. Time to wake up and turn this thing off.
                    + Ignore the alarm 
                    -> ignore_alarm
                    + Turn off the alarm and wake up 
                    -> turn_off_alarm_and_wake_up
            
            =ignore_alarm
            # audio: quieter alarm image: black screen
                ~Time += RANDOM(10,30)
                Being way too tired to wake up right now. Ignoring the alarm you try to fall back into slumber…
                + [What is that noise] 
                    -> noise_complain
            
            =noise_complain
                # audio: quieter alarm + smacking through the wall sound
                … until you hear your neighbor screaming through the wall: “Turn that @\#!\*@!+ alarm off, you lazy schmuck!”.
                ~ NoiseComplain = true
                
                Not knowing who your neighbor actually is, and thinking that you won’t get to sleep any more anyway, you decide to finally turn the alarm off.
                ~SocialScore -=5
                
                + Turn off the alarm and wake up 
                    -> turn_off_alarm_and_wake_up
                
===turn_off_alarm_and_wake_up===
# audio: turning off a huge generator image: spiral clock (glow off)
Concentrating all of your willpower you get out of bed and turn off the alarm. Day is now officially started. Being moved into this apartment recently, you’ll have to familiarize yourself with its contents.
    ~Time+=1
    + Look around apartment 
        <hr>
        -> look_around_apartment
    
    =look_around_apartment
        # audio: muffled rain image: apartment
        Taking a look around. This whole apartment consists from just one square room, where besides your bed you can see: a huge metal machine with the label “PCT Personal Citizen Terminal ™ ”, a small drawer with some money on it, a door leading out of your apartment, a small gray fridge, a potted plant on a tall stool, a mirror, and a double glass door leading to the balcony. 
            +[Continue] 
                {ShowTimeMoney()}
                {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                -> apartment_choices
    
===apartment_choices===
    You decide to...
    + Use PCT  
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        # image: PCT
        You approach the PCT(Personal Citizen Terminal ™)
        ++ Press the power button 
            -> apartment_pre_use_pct
    
    + Open drawer
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> apartment_use_drawer
    
    + Go to the fridge
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> apartment_use_fridge
    + Check plant
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> apartment_check_plant
    + Look in the mirror
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> apartment_look_in_the_mirror
    + Check the balcony
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> apartment_check_balcony
    + Check inventory
        -> check_inventory(-> apartment_choices)
    + {Dressed} Leave apartment
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> leave_apartment
        
    =apartment_pre_use_pct
    # image: PCT audio: HDD sounds
        With a light press of the power button the machine bursts into life, it’s low frequency screen starts flashing, presenting you with the option to check your inbox or submit a request. 
        ~Time += 1
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> apartment_use_pct
        
===apartment_use_pct===
    PCT Screen:
    + Check inbox 
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> check_pct_inbox
    + {WantsToInvestInLGCDP && !InvestedInLGCDP}Invest in Low Grade Citizen Disposal Program™ (LGCDP) \[Requires {InvestPriceLGCDP} GGT\]
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> invest_in_lgcdp
    + {NeedsMap && !HasMap && !MapRequest}Submit a map request 
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> map_request
    + Turn off PCT 
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> apartment_choices
    
        =check_pct_inbox
        After a few seconds of staring at the loading screen you are informed that you have one message from “The Factory ™” ... it’s a job offer!: 
            +{WorkMessageChecked} Go back 
                ~Time += 1
                {ShowTimeMoney()}
                {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                -> apartment_use_pct
            + Open message 
                <hr>
                -> message
                
            = message
                ~Time += 1
                ~ WorkMessageChecked = true
                —
                “Thanks to the GG’s (Great Government’s) social programs you’ve received this wonderful opportunity to be employed at THE FACTORY  in your district, please arrive at {ShowTime(WorkTime)}, Floor: {WorkFloor}, Hallway: {WorkHallway}, today.
                
                We also remind you that you need to pay a daily fee for your existence of {ExistenceFee} GGT (Great Government’s Token)  units.
                
                \*Failing to arrive at the destination will result in unemployment. Income tax is determined by your social score.\*
                —
                
                It would be a good idea to not miss this offer.
            {MapRequest && MapRequestDay < Day :
                !!
                There is also a notification that a map request on this PCT was approved. 
                ++ Print a map 
                    {ShowTimeMoney()}
                    {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                    -> print_map
            }
            + Go back 
                {ShowTimeMoney()}
                {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                -> apartment_use_pct
        
        =invest_in_lgcdp
        #image: PCT audio: dial up sound
        {Money > InvestPriceLGCDP :
            User interface of the PCT for investing is quite intuitive, since the government is always happy to take your hard earned GGTs. You choose the LGCDP investment category, since you also need your GGT for goods and services you decide to invest the minimum amount of {InvestPriceLGCDP} GGT. You let PCT scan the barcode on your wrist and confirm the transaction, after it is done the terminal displays a message “Thanks for investing in a better society!”. Somehow this message makes your contribution seem even less meaningful.
            ~InvestedInLGCDP = true
            ~Money -= InvestPriceLGCDP
            ~SocialScore += 5
        -else:
            You do not have enough GGTs to be able to invest in LGCDP, what a shame.
        }
            + [Continue] 
                ~Time += 1
                {ShowTimeMoney()}
                {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                -> apartment_use_pct
            
        =map_request
        #image: PCT audio: dial up sound
            User interface of the PCT for request submission is quite intuitive, since you can’t request much from the government anyway. You submit a map request, immediately you receive an automated response: “Your map request will be processed in accordance with your district’s policy. Estimated processing time: 24 hours. Please return to this PCT when your request will be approved to receive your map copy.”.
            ~MapRequest = true
            ~MapRequestDay = Day
            ~Time += 1
            +[Continue] 
                {ShowTimeMoney()}
                {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                -> apartment_use_pct
        
        =print_map
            You print yourself a map of the district.
            ~Time += 1
            ~HasMap = true
            ~NeedsMap = false
            +[Continue] 
                {ShowTimeMoney()}
                {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                -> apartment_use_pct
                
===apartment_use_drawer===
    # audio: hermetic door opening image: opened drawer with 3 sets
    In the drawer you see some sets of dark pants and gray shirts. There is also a small compartment where you find some accesories.
    {MapInDrawer:
        Under accessories there is a small map of your district. Useful.
        + Take the map
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            -> take_map_drawer
    }
    + {!Dressed} Put on a pair of dark pants and a gray shirt
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        ->dress
    + Close drawer
        ~Time += 1
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        ->apartment_choices
        
    =take_map_drawer
        ~Time += 1
        ~HasMap = true
        ~NeedsMap = false
        ~MapInDrawer = false
        You took the map, now you won't get lost.
        -> apartment_use_drawer
    
    =dress
        #image: opened drawer with 2 sets
        ~Dressed = true
        You hastily get into dark pants and put on a gray shirt, for the accessory you pick…
        #image: all 3 accessories
        ~Time += 2
        + Red tie
            #image red tie
            ~Accessory = "Red tie"
            let’s show everyone you mean business.
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            ->apartment_use_drawer
        + Orange tie with black stripes
            ~Accessory = "Orange tie with black stripes"
            #image orange tie
            the orange one looks good, nothing wrong with going a little funky.
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            ->apartment_use_drawer
        + Blue butterfly tie
            ~Accessory = "Blue butterfly tie"
            #image blue tie
            a stylish blue butterfly tie, it just looks good on you.
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            ->apartment_use_drawer
        + Nothing
            {~why bother|you are already beautiful|let’s keep it simple}.
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            ->apartment_use_drawer

===apartment_use_fridge===
    # image: fridge audio: fridge buzzing
    You approach the small gray fridge.
    + Open fridge 
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        ->open_fridge
    =open_fridge
        #image: fridge with contents audio: fridge opens
        You open the fridge and are presented with a garbage vent and two shelves
        ->fridge_contents
        
    
===fridge_contents
        Contents of the fridge:
        {AnythingInFridge():
            {FridgeGooTea: 
                Goo Tea({FridgeGooTea})
                + Take Goo Tea
                    ~Time += 0.5
                    {ShowTimeMoney()}
                    {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                    -> take_goo_tea
            }
            {FridgeIceScream: 
                Ice Scream({FridgeIceScream})
                + Take Ice Scream
                ~Time += 0.5
                {ShowTimeMoney()}
                {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                -> take_ice_scream
            }
            {FridgeNoodles: 
                Can of Spiral Noodles({FridgeNoodles})
                + Take Can of Spiral Noodles
                    ~Time += 0.5
                    {ShowTimeMoney()}
                    {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                    -> take_noodles
            }
            {FridgeVoidBiscuits: 
                Void Biscuits
                + Take Void Biscuits({FridgeVoidBiscuits})
                    ~Time += 0.5
                    {ShowTimeMoney()}
                    {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                    -> take_void_biscuits
            }
            {FridgeCrippleCrackers: 
                Cripple Crackers({FridgeCrippleCrackers})
                + Take Cripple Crackers
                    ~Time += 0.5
                    {ShowTimeMoney()}
                    {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                    -> take_cripple_crackers
            }
            {FridgeWater: 
                Water ("Moist" brand)({FridgeWater})
                + Take Water
                    ~Time += 0.5
                    {ShowTimeMoney()}
                    {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                    -> take_water
            }
            {FridgeInfiniteParty: 
                Liquid funk: "Infinite Party"({FridgeInfiniteParty})
                + Take "Infinite Party"
                    ~Time += 0.5
                    {ShowTimeMoney()}
                    {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                    -> take_infinite_party
            }
            {FridgeFuzzyBuzz: 
                Liquid funk: "Fuzzy Buz"({FridgeFuzzyBuzz})
                + Take "Fuzzy Buz"
                    ~Time += 0.5
                    {ShowTimeMoney()}
                    {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                    -> take_fuzzy_buz
            }
            {FridgeBottleInAJar: 
                Bottle in a jar
                + Take Bottle in a jar({FridgeBottleInAJar})
                    ~Time += 0.5
                    {ShowTimeMoney()}
                    {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                    -> take_jar
            }
            {FridgeJarFlower:
                Spiral Flower in a jar({FridgeJarFlower})
                + Inspect the flower
                    ~Time += 0.5
                    {ShowTimeMoney()}
                    {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                -> inspect_flower_jar
            }
        -else:
            nothing
        }
        {AnythingInInventory():
            {InventoryGooTea: 
                + Put Goo Tea
                -> put_goo_tea
            }
            {InventoryIceScream: 
                + Put Ice Scream
                -> put_ice_scream
            }
            {InventoryNoodles: 
                + Put Can of Spiral Noodles
                -> put_noodles
            }
            {InventoryVoidBiscuits: 
                + Put Void Biscuits
                -> put_void_biscuits
            }
            {InventoryCrippleCrackers: 
                + Put Cripple Crackers
                -> put_cripple_crackers
            }
            {InventoryWater: 
                + Put Water
                -> put_water
            }
            {InventoryInfiniteParty: 
                + Put "Infinite Party"
                -> put_infinite_party
            }
            {InventoryFuzzyBuzz: 
                + Put "Fuzzy Buz"
                -> put_fuzzy_buz
            }
            {InventoryBottleInAJar: 
                + Put Bottle in a jar
                -> put_jar
            }
        }
        + Check inventory
        -> check_inventory(-> fridge_contents)
        + Close fridge
        ~Time += 0.5
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        ->apartment_choices
        
        =inspect_flower_jar
            # image:before taking audio: fridge buzzing
            You took the jar with the flower from the fridge.
            # image:after taking audio: fridge buzzing
            # image: flower in the jar audio:fridge buzzing
            It looks like very beautiful and without any signs of withering, maybe you should change proffession?
            + Put it back
                {ShowTimeMoney()}
                {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                ->fridge_contents
        
===take_goo_tea
    # image:before taking audio: fridge buzzing
    You grab a transparent canister with green-ish goo-tea
    ~ InventoryGooTea += 1
    {AtHome:
        ~ FridgeGooTea -= 1
        # image:after taking audio: fridge buzzing
        -> fridge_contents
    -else:
        -> DONE
    }
    
===take_ice_scream
    # image:before taking audio: fridge buzzing
    You grab a cone of ice-scream with a frozen spiky top
    ~ InventoryIceScream += 1
    {AtHome:
        ~ FridgeIceScream -= 1
        # image:after taking audio: fridge buzzing
        -> fridge_contents
    -else:
        -> DONE
    }
    
===take_noodles
    # image:before taking audio: fridge buzzing
    You grab a can of spiral noodles
    ~ InventoryNoodles += 1
    {AtHome:
        ~ FridgeNoodles -= 1
        # image:after taking audio: fridge buzzing
        -> fridge_contents
    -else:
        -> DONE
    }

===take_void_biscuits
    # image:before taking audio: fridge buzzing
    You grab a pack of void-biscuits
    ~ InventoryVoidBiscuits += 1
    {AtHome:
        ~ FridgeVoidBiscuits -= 1
        # image:after taking audio: fridge buzzing
        -> fridge_contents
    -else:
        -> DONE
    }

===take_cripple_crackers
    # image:before taking audio: fridge buzzing
    You grab a box of Cripple-Crackers
    ~ InventoryCrippleCrackers += 1
    {AtHome:
        ~ FridgeCrippleCrackers -= 1
        # image:after taking audio: fridge buzzing
        -> fridge_contents
    -else:
        -> DONE
    }

===take_water
    # image:before taking audio: fridge buzzing
    You grab a transparent bag of clean water in form of a cube
    ~ InventoryWater += 1
    {AtHome:
        ~ FridgeWater -= 1
        # image:after taking audio: fridge buzzing
        -> fridge_contents
    -else:
        -> DONE
    }

===take_infinite_party
    # image:before taking audio: fridge buzzing
    You take hold of a Klein bottle with a bright cyan bubbly liquid. 
    ~ InventoryInfiniteParty += 1
    {AtHome:
        ~ FridgeInfiniteParty -= 1
        # image:after taking audio: fridge buzzing
        -> fridge_contents
    -else:
        -> DONE
    }

===take_fuzzy_buz
    # image:before taking audio: fridge buzzing
    You grab a bottle resembling an irregular polygon.
    ~ InventoryFuzzyBuzz += 1
    {AtHome:
        ~ FridgeFuzzyBuzz -= 1
        # image:after taking audio: fridge buzzing
        -> fridge_contents
    -else:
        -> DONE
    }

===take_jar
    # image:before taking audio: fridge buzzing
    You take the bottle in a jar
    {HasSpiralFlower: This looks like a good container for that spiral flower.}
    ~ InventoryBottleInAJar += 1
    {AtHome:
        ~ FridgeBottleInAJar -= 1
        # image:after taking audio: fridge buzzing
        -> fridge_contents
    -else:
        -> DONE
    }

===put_goo_tea
    # image:before put audio: fridge buzzing
    You put the Goo Tea in the fridge
    ~ InventoryGooTea -= 1
    ~ FridgeGooTea += 1
    # image:after put audio: fridge buzzing
    -> fridge_contents
    
===put_ice_scream
    # image:before put audio: fridge buzzing
    You put the Ice Scream in the fridge
    ~ InventoryIceScream -= 1
    ~ FridgeIceScream += 1
    # image:after put audio: fridge buzzing
    -> fridge_contents
    
===put_noodles
    # image:before put audio: fridge buzzing
    You put the Spiral Noodles in the fridge
    ~ InventoryNoodles -= 1
    ~ FridgeNoodles += 1
    # image:after put audio: fridge buzzing
    -> fridge_contents

===put_void_biscuits
    # image:before put audio: fridge buzzing
    You put the Void Biscuits in the fridge
    ~ InventoryVoidBiscuits -= 1
    ~ FridgeVoidBiscuits += 1
    # image:after put audio: fridge buzzing
    -> fridge_contents

===put_cripple_crackers
    # image:before put audio: fridge buzzing
    You put the box of Cripple Crackers in the fridge
    ~ InventoryCrippleCrackers -= 1
    ~ FridgeCrippleCrackers += 1
    # image:after put audio: fridge buzzing
    -> fridge_contents

===put_water
    # image:before put audio: fridge buzzing
    You put the Water in the fridge
    ~ InventoryWater -= 1
    ~ FridgeWater += 1
    # image:after put audio: fridge buzzing
    -> fridge_contents

===put_infinite_party
    # image:before put audio: fridge buzzing
    You put the "Infinite Party" in the fridge
    ~ InventoryInfiniteParty -= 1
    ~ FridgeInfiniteParty += 1
    # image:after put audio: fridge buzzing
    -> fridge_contents

===put_fuzzy_buz
    # image:before put audio: fridge buzzing
    You put the "Fuzzy Buz" in the fridge
    ~ InventoryFuzzyBuzz -= 1
    ~ FridgeFuzzyBuzz += 1
    # image:after put audio: fridge buzzing
    -> fridge_contents

===put_jar
    # image:before put audio: fridge buzzing
    You put the bottle in a jar in the fridge
    ~ InventoryBottleInAJar -= 1
    ~ FridgeBottleInAJar += 1
    # image:after put audio: fridge buzzing
    -> fridge_contents

===check_inventory(-> location)
    ~Time += 0.5
    {ShowTimeMoney()}
    {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        Your belongings:
        
        {AnythingInInventory():
            {HasMap:
                District map
            }
            {InventoryGooTea: 
                Goo Tea({InventoryGooTea})
                + Consume Goo Tea
                -> consume_goo_tea(location)
            }
            {InventoryIceScream: 
                Ice Scream({InventoryIceScream})
                + Consume Ice Scream
                -> consume_ice_scream(location)
            }
            {InventoryNoodles: 
                Can of Spiral Noodles({InventoryNoodles})
                + Consume Can of Spiral Noodles
                -> consume_noodles(location)
            }
            {InventoryVoidBiscuits: 
                Void Biscuits({InventoryVoidBiscuits})
                + Consume Void Biscuits
                -> consume_void_biscuits(location)
            }
            {InventoryCrippleCrackers: 
                Cripple Crackers({InventoryCrippleCrackers})
                + Consume Cripple Crackers
                -> consume_cripple_crackers(location)
            }
            {InventoryWater: 
                Water ("Moist" brand)({InventoryWater})
                + Consume Water
                -> consume_water(location)
            }
            {InventoryInfiniteParty: 
                Liquid funk: "Infinite Party"({InventoryInfiniteParty})
                + Consume "Infinite Party"
                -> consume_infinite_party(location)
            }
            {InventoryFuzzyBuzz: 
                Liquid funk: "Fuzzy Buz"({InventoryFuzzyBuzz})
                + Consume "Fuzzy Buz"
                -> consume_fuzzy_buz(location)
            }
            {InventoryBottleInAJar: 
                Bottle in a jar({InventoryBottleInAJar})
                + Use Bottle in a jar
                -> use_jar(location)
            }
        -else:
            nothing
        }
        + Go back
        ~Time += 0.5
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> location

===consume_goo_tea(location)
    You grab a transparent canister with green-ish goo-tea, and you can see that the wiscous tea in the canister floats unaffected by gravity similar to the liquid inside a lava lamp. Taking a straw attached to the canister you pierce a hexagonal opening on the top, you tilt the straw while drinking to catch the slimy bubbles inside the canister. It tastes like wood, but a little bitter. By the end there are only a few small drops that you didn’t bother catching floating around the canister. Feeling refreshed you throw away the canister in the garbage vent.
    +[Continue]
    
    ~InventoryGooTea -= 1
    ~ConsumedNutrients += 1
    ~Time += 2
    ->check_inventory(location)
    
===consume_ice_scream(location)
    You grab a cone of ice-scream with a frozen spiky top, inside of the ice there is a pulsating dark substance. You start taking bites out of the ice spikes, each bite accompanied with an agonizing scream of the ice-scream and with diminishing of the dark core… tastes fruity. After you’ve devoured all the ice and heard all the screams, you throw the holding cone into the fridge’s garbage vent.
    +[Continue]
    
    ~InventoryIceScream -= 1
    ~ConsumedNutrients += 1
    ~Time += 2
    -> check_inventory(location)

===consume_noodles(location)
    You unspiral the lid, opening a can of spiral noodles. There is no way for you to heat em up and there are no spoons at your apartment, so you’ll have to munch them cold with your bare hands. You grab the end of the noodle and pull it to your head, watching as it unwinds itself in a spiral pattern from the can. Despite being unheated noodles, they feel very dense and nutritious, definitely the best meal you can get for your GGTs. You throw the can into the garbage vent, after consuming all its contents.
    +[Continue]
    
    ~InventoryNoodles -= 1
    ~ConsumedNutrients += 3
    ~Time += 7
    ->check_inventory(location)

===consume_void_biscuits(location)
    Grabbing a pack of void-biscuits from the fridge, you unwrap the top, instead of biscuits there is only a black seemingly endless void inside. You start putting your arm inside the void, when it reaches your elbow you manage to pull it out with a biscuit in your hand. You bite into it, starting to chew you feel it disintegrating in your mouth, biscuit in your hand also has disappeared. On the package it says “Feasibility of void-biscuits out of the package: 10 seconds”...No wonder those biscuits are advertised as diet food. Realizing that those biscuits have zero nutritional value, you throw them into the garbage vent.
    +[Continue]
    
    ~InventoryVoidBiscuits -= 1
    ~Time += 1
    ->check_inventory(location)
    
===consume_cripple_crackers(location)
    Carefully picking up a rectangular box from the fridge, you tear away the top with your shrimpy fingers and take a cracker from the box… it looks like a person in a wheelchair, you put it in your mouth and start munching, then you take another… this one looks like a person without a leg with a crutch. Those crackers are dry and barely have any taste, but you still managed to devour all of them, throwing the empty box into the garbage vent.
    +[Continue]
    
    ~InventoryCrippleCrackers -= 1
    ~ConsumedNutrients += 2
    ~Time += 6
    ->check_inventory(location)
    
===consume_water(location)
    You grab the water cube which represents a tightly sealed thin transparent bag of clean water. Biting into the corner of it you make an opening in the bag, open the compartment on the shoulder of your body and start pouring the liquid inside. Steam comes out of your neck, bringing to you a momentary relaxation. You throw the empty bag into the garbage vent.
    +[Continue]
    
    ~InventoryWater -= 1
    ~Time += 2
    ->check_inventory(location)
    
===consume_infinite_party(location)
    You take hold of a Klein bottle with a bright cyan bubbly liquid. Removing a thin cover from the bottle's opening the liquid immediately starts to move out of the bottle. You have no choice but to drink it to avoid spillage. As soon as you finish the drink you feel slightly energized, but your perception of reality starts distorting, the fridge before you starts melting and the walls seem to flow around you in a plethora of unseen colors and patterns. You start feeling lightheaded, even the flow of time seems to be misshaped, the time on the clock jumping and stopping while you stare into the endless bottle in your hand. You come back to your senses in a couple of hours lying on the floor in the middle of your square room, you pick up the funny looking bottle next to you and throw it into the garbage vent of a still open fridge.
    +[Continue]
    
    ~InventoryInfiniteParty -= 1
    ~Time += RANDOM(123, 169)
    ->check_inventory(location)
    
===consume_fuzzy_buz(location)
    Taking a closer look at the bottle resembling an irregular polygon, you can see a dark green smoking liquid inside. Advocating the value of your purchase you remove the plug at the top and despite the strong repulsing smell of the green smoke that comes out you chug down the contents of the bottle and throw it into the garbage vent. Immediately you feel a burning sensation washes through your mouth, your vision gets blurry and your muscles relax. Slothfully, you get to your bed and drop on its surface, embracing the relaxed state you’ve found yourself in . In this state you’d be unable to perform anything productive, so you take a rest for an hour before resuming other activities.
    +[Continue]
    
    ~InventoryFuzzyBuzz -= 1
    ~Time += 60
    ->check_inventory(location)
    
===use_jar(location)
    {HasSpiralFlower:
        You take the lid off the jar, and take the bottle out of it. You throw the bottle in the garbage vent, there is no use for it, and put the spiral flower in the jar, sealing it tight and put the jar in the fridge. Now the flower is preserved.
        ~Time += 2
        ~HasSpiralFlower = false
        ~FridgeJarFlower += 1
        ~InventoryBottleInAJar -= 1
        ->apartment_choices
    -else:
        What are you gonna do with a bottle in a jar? Better to leave it sealed.
    }
    +[Continue]
    ->check_inventory(location)

===apartment_check_plant===
    You take a closer look at the potted plant, it looks like one of those “hard to kill” types, the plant looks
    {PlantState:
    -0:
        gray-green, lifeless, withered and dry. Right now it consists of a stem and 2 leaves so dry that it feels they would crunch and break apart from a mere touch. Maybe a little watering could fix this pathetic thing.
    -1:
        pale-green with little moisture. Stem and its two leaves are starting to come back to life. A little bud is starting to form at the side of the stem. If watered today, maybe it will have a chance to blossom.
    -2:
        bright-green and full of life. Plant looks to be in perfect condition. 
        {
        -!HasSpiralFlower: 
            A beautiful spiral flower lays atop of a stem with two lively leaves.
            + Take the spiral flower
                {ShowTimeMoney()}
                {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                ->take_spiral_flower
        -else:
            You took the spiral flower from its top.
        }
        
    -else: 
        dark-blue and swollen. It would seem that the plant absorbed too much water and now looks like its stem and two leaves look like water balloons. The pot itself is almost full with water and a broken spiral flower floats atop of it. 
        ~PlantStateNextDay = 0
    }
    #image: [plant’s state] audio: muffled rain
    + {InventoryWater} Water the plant
        ~Time += 1
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        ->water_plant
    + Go back
        You leave the plant to take the responsibility for its own existence.
        ~Time += 1
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> apartment_choices
    
    =water_plant
        You open the cubic bag of water and pour it's contents on the pot. Nothing changed now but maybe tomorrow the plant will look better.
        ~InventoryWater -= 1
        ~PlantStateNextDay += 1
        -> apartment_check_plant
        
    =take_spiral_flower
        ~HasSpiralFlower = true
        ~PlantStateNextDay = 0
        You took a beautiful spiral flower from your potted plant. It's better to store it in a cold place in some sort of container or a transparent jar.
        +{InventoryBottleInAJar} Use bottle in a jar to store the flower
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            -> use_jar(->apartment_check_plant)
        + Do nothing
            Since you don't have a good container to store the flower, you let it be.
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            -> apartment_check_plant

===apartment_look_in_the_mirror===
    # image: player + clothes + accesory audio: silence
    You approach the mirror and take a good look. In the mirror you see a tall figure with a spiral face with medium length dense black hair naturally combed backwards. Your head is attached to MK-45 medium performance body model via the neck magnetic connector. Your arms look like long noodles and have 3 long fingers at the end.
    {Dressed:
        You are wearing dark pants and a gray shirt with {Accessory} around your neck.
    -else:
        Your mechanical body is naked at the moment.
    }
    + Go back
        ~Time += 1
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> apartment_choices

===apartment_check_balcony===
    # image: balcony audio: intense rain
    Through a large glass door you step on the balcony of your tall pyramid-like apartment block. It is raining. From here you can see other similar building blocks, Travel Stream ™ river, and the colossal hexagonal GG’s tower piercing the sky in the distance. You step back inside, it is unpleasant to stay in the rain for long at this altitude.
    + Go back
        ~Time += 1
        {ShowTimeMoney()}
        {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> apartment_choices
        
===leave_apartment===
    ~AtHome = false
    ~Time += 3
    You left the apartment, make sure you get back home before {ShowTime(CloseOutsideTime)} and not consume any substances in public places or outside special zones because you'll be arrested.
    {HasMap:
        -> outside_with_map
        
    -else:
        -> outside_without_map
    }

===outside_with_map
    # image: map audio: rain
    Now that you’ve got a map of this district, navigation to the points of interest is now possible. On the map there are: a few convenience stores nearby where you can buy GG approved nutritional and household products, access points to neighboring districts and most importantly The Factory ™ . There are also other locations on the map like public areas and some narrowly specialized service providers, but you won’t have time to see them today.
    + Go back home
            ~Time += 2
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            Soaking wet from the heavy rain, you return to your apartment block, taking a long climb up the stairs till you reach the door of your apartment. While you enter your room you realize that all the heat generated by your body while climbing dried up your clothes.
            #image: black screen audio: fading rain sound + going up the stairs
            -> apartment_choices
    + {!PermissionDeniedNeighboringDistrict}Go visit neighboring district
        ~Time += 10
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> visit_neighboring_district
    + Check out nearby convenience store
        ~Time += RANDOM(3, 7)
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        -> store
    + {!Worked && Time < 1020}Go to work
        -> work
        
    =visit_neighboring_district
        # image: district border audio:steps in rain
        Having the opportunity you decide to investigate the neighboring district. After some time you reach the district's border: a tall reinforced concrete wall with a sturdy metal gate at the checkpoint. 
        + Approach the gate
            # image:guard audio: STOP RIGHT THERE!
            While advancing to the gate you are stopped by a nearby guard and briefly get interrogated, not giving any definitive answer to why you would want to leave the district. The guard, unsatisfied with your answers, takes your hand and scans the barcode on your wrist and tells you to leave if you don’t have any official business in the other district.
            {~PermissionDeniedNeighboringDistrict = true}
            ~Time += 5
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            -> outside_with_map
        + Wander somewhere else
            ~Time += 1
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            -> outside_with_map
            
===store
    # image: convenience store audio:1975 grocery store music + silent rain
    Soaked in rain, you enter a nearby convenience store. The scenery is filled with a guard at the entrance, repeating aisles of GG approved products and a self checkout terminal, walls are gray and partially missing paint, revealing naked white bricks under it, besides that, the store seems to be in a good condition, even playing a cheerful tune on repeat.
    + Look at goods in stock
        ->store_goods
    + Return outside
        ->outside_with_map
        
    =store_goods
        ~Time += 1
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
        Taking a closer look at the store shelves you observe a following selection of products:
        \- “Goo-tea” First of a kind antigravity goopy refreshment.({GooTeaPrice} GGT)
        \- “Ice-scream” Now with 20% more scream and 5% sweeter ice! ({IceScreamPrice} GGT)
        \- “Can of spiral noodles” Unspiral your hunger.({NoodlesPrice} GGT)
        \- “void-biscuits” Now with negative nutritional value!({VoidBiscuitsPrice} GGT)
        \- “Cripple-crackers” Eat the crippled, consume the poor!({CrippleCrackersPrice} GGT)
        \- “Water (Moist brand”) Cool your body, relax your mind.({WaterPrice} GGT)
        \- “Liquid funk: Infinite party” Need a trip? Just take a sip!({InfinitePartyPrice} GGT)
        \- “Liquid funk: Fuzzy buz” Need a break? Then fuzz you take!({FuzzyBuzzPrice} GGT)
        \- “Bottle in a jar” For all your household needs.({BottleInAJarPrice} GGT)
        + Buy Goo-tea
            {EnoughMoney(GooTeaPrice, "Goo-tea")}
            ++Continue
                -> store
        + Buy Ice-scream
            {EnoughMoney(IceScreamPrice, "Ice-scream")}
            ++Continue
                -> store
        + Buy Can of spiral noodles
            {EnoughMoney(NoodlesPrice, "Can of spiral noodles")}
            ++Continue
                -> store
        + Buy void-biscuits
            {EnoughMoney(VoidBiscuitsPrice, "void-biscuits")}
            ++Continue
                -> store
        + Buy Cripple-crackers
            {EnoughMoney(CrippleCrackersPrice, "Cripple-crackers")}
            ++Continue
                -> store
        + Buy Water (Moist brand)
            {EnoughMoney(WaterPrice, "Water (Moist brand)")}
            ++Continue
                -> store
        + Buy Liquid funk: Infinite party
            {EnoughMoney(InfinitePartyPrice, "Liquid funk: Infinite party")}
            ++Continue
                -> store
        + Buy Liquid funk: Fuzzy buz
            {EnoughMoney(GooTeaPrice, "Goo-tea")}
            ++Continue
                -> store
        + Buy Bottle in a jar
            {EnoughMoney(GooTeaPrice, "Goo-tea")}
            ++Continue
                -> store
    
===work
->outside_with_map

===outside_without_map
    # image: black screen audio: rain
        ~NeedsMap = true
        This district is unknown to you, a map is mandatory for efficient navigation. You could return to your apartment and submit a map request at the PCT or ask strangers for directions to the nearest info booth. Browsing the streets in hopes to find a map by yourself is also an option.
        + Go back home
            ~Time += 2
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            Soaking wet from the heavy rain, you return to your apartment block, taking a long climb up the stairs till you reach the door of your apartment. While you enter your room you realize that all the heat generated by your body while climbing dried up your clothes.
            #image: black screen audio: fading rain sound + going up the stairs
            -> apartment_choices
        + Ask for directions
            ~Time += RANDOM(3,6)
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            -> ask_for_directions
        + Look around by yourself
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            # image: black screen audio: rain and footsteps
            You start walking through narrow streets surrounded by tall pyramid shaped buildings, not unlike your own apartment complex, there are not many local businesses in this area, just a few narrowly specialized shops and repair services.
            ~Time += RANDOM(2,15)
            {ShowTimeMoney()}
            {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
            ~temp x = RANDOM(1,10)
            {
                -x <= 2:
                    -> info_banner
                -x >= 8:
                    -> aimless_wander
                -else:
                    -> shady_alley
            }
        
        =ask_for_directions
            You make yourself noticed by a walker to ask for directions. “Do you know where i can get a city map?” you ask.
            + ... 
                 Silent, the person points his arm towards a nearby street, after a split moment he continues walking towards his original destination.
                ++ Follow the person's suggestion
                    ~Time += 5
                    {ShowTimeMoney()}
                    {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                    ->info_banner
                ++ Go back
                    ~Time += 2
                    {ShowTimeMoney()}
                    {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                    The person looks shady and you decided to be safe and go back to where you started.
                    ->outside_without_map
        =info_banner
            # image: public area audio: rain
            After wandering for some time you find a public area full of benches, statues of various geometric figures and an info booth. 
            + Approach the info booth
                # image: info booth audio: rain
                The info booth is currently not operational, perhaps due to the government workers shortage, but there still are free maps available in the pamphlet holder. Finally, you got a map.
                ~HasMap = true
                ~NeedsMap = false
                {ShowTimeMoney()}
                {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                ->outside_with_map
                
        =aimless_wander
            # image: wall/river/fence/cliff audio: rain and wind
            Walking for some time you arrive at a {~wall|river|fence|cliff} blocking your way forward. You return back to your apartment block, before you get lost in the concrete jungle.
            ->outside_without_map

        =shady_alley
            # image: person in the alley audio: muffled rain
            Passing a narrow dark alley you take a glimpse at the person sitting on the ground. “Got any spare GGTs?” he asks in a menacing tone.
                + A...
                    # image: person walking towards you
                    While you take a moment to consider your options, the person stands up and takes a step towards you.
                    ++{Money == 0} I don't have any...
                        -> ENDING_stabbed
                    ++I am not giving you...
                        -> ENDING_stabbed
                    ++{Money > 0} Give some money
                        ->give_money_to_beggar

        =give_money_to_beggar
            #image: person in the alley audio: muffled rain
            “Sure, i can spare some.” you say. The man shows you his wrist with the standard 24 digit barcode on it, you scan it and transfer {GiveMoneyToShadyBeggar()} GGT on his account. “Thanks, pal” he says, dropping a rusty metal pipe on the ground and sitting back at the wall. Perhaps you should invest more in the Low Grade Citizen Disposal Program™ in the future. (This can be done from PCT)
            ~WantsToInvestInLGCDP = true
            
            + Go back
                ~Time += RANDOM(3,6)
                {ShowTimeMoney()}
                {
                    -ArrestedOutside:
                        ->ENDING_arrested_for_late_outside
                    -GoSleep:
                        ->pre_next_day
                }
                -> outside_without_map
                
        
===ENDING_stabbed
    # image: stabbed audio: stab
    +...
    In the middle of your sentence, the shady figure swiftly and precisely stabs you with a piece of rusty metal pipe. “Too bad…” he says and runs out of the alley. Collapsing on the ground you hear a whistle as a bunch of guard’s start chasing the man… he probably won’t make it far… and so do you.

    <b>GAME OVER</b> 
    Stabbed with a rusty pipe in a shady alley by a homeless man, at least he’ll get arrested, right?
    ->next_day

===ENDING_arrested_for_late_outside
    + ...?
    <b> GAME OVER </b>
    2 surveillance robots caught you for being outside after {ShowTime(CloseOutsideTime)}, you will be relocated to the re-education camp until we decide that you are fit to return into society.
    ->next_day

===pre_next_day
    + (...yawn)
    It's getting too late and you decide to go to sleep
    ->next_day
    
===next_day
    ~PlantState = PlantStateNextDay
    +PROCEED
        # CLEAR
        <big><b>Project Spiral 001: Citizen Testing District<big><b>
        SEND ANOTHER CITIZEN FOR TESTING?
        ++ YES
            ->waking_up
        ++ NO
            GOODBYE
            ->END