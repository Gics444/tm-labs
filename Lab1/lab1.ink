VAR NoiseComplain = false
VAR Dressed = false
VAR Time = 0

VAR WorkTime = 0
VAR WorkFloor = 0
VAR WorkHallway = ""
VAR WorkMessageChecked = false

VAR InvestInLGCDP = false
VAR InvestPriceLGCDP = 0
VAR InvestedInLGCDP = false
VAR NeedsMap = false
-> waking_up

=== function ShowTime(t) ===
    ~ temp hour = INT(t/60)
    ~ temp minutes = INT(t%60)
    {minutes < 10:
        ~ minutes = ":0" + minutes
    -else:
        ~ minutes = ":" + minutes
    }
    ~ return ("<" + hour + minutes +">")
    
===waking_up===
~NoiseComplain = false
~Dressed = false
~Time = 360.001

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

~InvestInLGCDP = false
~InvestPriceLGCDP = RANDOM(10,20)
~InvestedInLGCDP = false
~NeedsMap = false

#audio: insert appropriate soundtrack image:black screen
{~You are sitting at a cafe, talking to your friends about recent events in the city and enjoying above average cuisine…but then you wake up and realize that you don’t have any friends, all local cafes went out of business due to the lack of paying customers.|You are rushing through the storm with your fellow sailors on your employers cargo ship, sea creatures washing aboard from the waves, suddenly one of your coworkers falls overboard…but then you wake up and realize that all of the large water bodies are too toxic for any sea life to thrive there, also you are unemployed… yet.|You are walking through the woods, collecting curious looking herbs and odd looking berries, after some time you hear something in nearby bushes. You decide to take a closer look, but while you are approaching a wild animal jumps at you…but then you wake up and realize that due to aggressive deforestation there are no woods and no woodland animals to ambush you on the island. Good.|Nothing. Emptiness. Desolation. Void… but then you wake up realizing that you’ll have to continue existing today.|You were preparing for this your whole life, you stretch your extremities, take a deep breath and start running, preparing to jump. You are about to jump…but then you wake up and realize that you’d probably get tired even from stretching your extremities, yet alone running or jumping.}

    + [Open your eyes] -> continue
    
    =continue
        #audio: silence image: spiral clock
        
        Taking a glimpse at the clock on the wall, it is {ShowTime(Time)}. You woke up before the alarm. “Maybe it would be a good idea to get up right now.” you tell yourself, while starting closing your eye and falling back into slumber.
    
    
        + [Sleep some more] -> sleep_some_more(1)
        
        + [Turn off the alarm and wake up] -> turn_off_alarm_and_wake_up
        
            =sleep_some_more(slept_more)
                { 
                - slept_more == 1:
                # audio: silence image: balck screen
                
                    You slumber for 1 more hour, not feeling like it helped much.<br><br> 
                    + [Continue] -> alarm_rings(slept_more)
                
                - slept_more == 2: 
                    # audio: quieter alarm image: black screen
                    Being way too tired to wake up right now. Ignoring the alarm you try to fall back into slumber…
                    + [What is that noise] -> noise_complain
                }
                
            =alarm_rings(slept_more)
                #  audio: alarm image: spiral clock(glowing)
                Suddenly the spiral clock starts buzzing that loud alarm tone. Time to wake up and turn this thing off.
                    + [Ignore the alarm] -> sleep_some_more(slept_more + 1)
                    + [Turn off the alarm and wake up] -> turn_off_alarm_and_wake_up
                    
            =noise_complain
                # audio: quieter alarm + smacking through the wall sound
                … until you hear your neighbor screaming through the wall: “Turn that @\#!\*@!+ alarm off, you lazy schmuck!”.
                ~ NoiseComplain = true
                
                Not knowing who your neighbor actually is, and thinking that you won’t get to sleep any more anyway, you decide to finally turn the alarm off.
                
                
                + [Turn off the alarm and wake up] -> turn_off_alarm_and_wake_up
                
===turn_off_alarm_and_wake_up===
# audio: turning off a huge generator image: spiral clock (glow off)
Concentrating all of your willpower you get out of bed and turn off the alarm. Day is now officially started. Being moved into this apartment recently, you’ll have to familiarize yourself with its contents.
    + [Look around apartment] -> look_around_apartment
    
    =look_around_apartment
        # audio: muffled rain image: apartment
        Taking a look around. This whole apartment consists from just one square room, where besides your bed you can see: a huge metal machine with the label “PCT Personal Citizen Terminal ™ ”, a small drawer, a door leading out of your apartment, a small gray fridge, a potted plant on a tall stool, a mirror, and a double glass door leading to the balcony. 
            +[Continue] -> apartment_choices
    
===apartment_choices===
    + [Use PCT] You approach the PCT(Personal Citizen Terminal ™) -> apartment_use_pct
    
===apartment_use_pct===
    + [Check inbox] -> check_pct_inbox
    {InvestInLGCDP:
    + [Invest in Low Grade Citizen Disposal Program™ (LGCDP)] -> apartment_choices
    }
    + [Leave PCT] -> apartment_choices
    
        =check_pct_inbox
        After a few seconds of staring at the loading screen you are informed that you have one message from “The Factory ™” ... it’s a job offer!
            {WorkMessageChecked: 
            +  [Go back] -> apartment_use_pct
            }
            + [Open message] -> message
            = message
                ~ WorkMessageChecked = true
                —
                “Thanks to the GG’s (Great Government’s) social programs you’ve received this wonderful opportunity to be employed at THE FACTORY  in your district, please arrive at {ShowTime(WorkTime)}, Floor: {WorkFloor}, Hallway: {WorkHallway}, today.
                
                We also remind you that you need to pay a daily fee for your existence of [FEE AMOUNT] GGT (Great Government’s Token)  units.
                
                \*Failing to arrive at the destination will result in unemployment. Income tax is determined by your social score.\*
                —
                
                It would be a good idea to not miss this offer.
        
            + [Go back] -> apartment_use_pct
        
        =invest_in_lgcdp
        #image: PCT audio: dial up sound
            User interface of the PCT for investing is quite intuitive, since the government is always happy to take your hard earned GGTs. You choose the LGCDP investment category, since you also need your GGT for goods and services you decide to invest the minimum amount of {InvestPriceLGCDP}. You let PCT scan the barcode on your wrist and confirm the transaction, after it is done the terminal displays a message “Thanks for investing in a better society!”. Somehow this message makes your contribution seem even less meaningful.
            ~InvestedInLGCDP = true
            + [Continue] -> apartment_use_pct

===apartment_use_drawer===
Opening the drawer you see 3 sets of dark pants, gray shirts. There is also a small compartment where you find a red tie, an orange tie with black stripes and a blue butterfly tie. 

->DONE

===leave_apartment===
->DONE

===apartment_use_fridge===
->DONE

===apartment_check_plant===
->DONE

===apartment_look_in_the_mirror===
->DONE

===apartment_check_balcony===
->DONE
