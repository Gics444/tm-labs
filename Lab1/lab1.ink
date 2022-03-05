VAR NoiseComplain = false
VAR Dressed = false
VAR time = 360

* [Start] -> waking_up

===waking_up===
{~You are sitting at a cafe, talking to your friends about recent events in the city and enjoying above average cuisine…but then you wake up and realize that you don’t have any friends, all local cafes went out of business due to the lack of paying customers.|You are rushing through the storm with your fellow sailors on your employers cargo ship, sea creatures washing aboard from the waves, suddenly one of your coworkers falls overboard…but then you wake up and realize that all of the large water bodies are too toxic for any sea life to thrive there, also you are unemployed… yet.|You are walking through the woods, collecting curious looking herbs and odd looking berries, after some time you hear something in nearby bushes. You decide to take a closer look, but while you are approaching a wild animal jumps at you…but then you wake up and realize that due to aggressive deforestation there are no woods and no woodland animals to ambush you on the island. Good.|Nothing. Emptiness. Desolation. Void… but then you wake up realizing that you’ll have to continue existing today.|You were preparing for this your whole life, you stretch your extremities, take a deep breath and start running, preparing to jump. You are about to jump…but then you wake up and realize that you’d probably get tired even from stretching your extremities, yet alone running or jumping.}

Taking a glimpse at the clock on the wall, it is <6:00>. You woke up before the alarm. “Maybe it would be a good idea to get up right now.” you tell yourself, while starting closing your eye and falling back into slumber.
    + Sleep some more -> sleep_some_more
    + Turn off the alarm and wake up -> turn_off_alarm_and_wake_up
    =sleep_some_more
        { 
        - sleep_some_more%2 == 1:
            You slumber for 1 more hour, not feeling like it helped much.<br><br> -> alarm_rings
        - sleep_some_more%2 == 0: 
            Being way too tired to wake up right now. Ignoring the alarm you try to fall back into slumber…
            … until you hear your neighbor screaming through the wall: “Turn that @\#!\*@!+ alarm off, you lazy schmuck!”.
            Not knowing who your neighbor actually is, and thinking that you won’t get to sleep any more anyway, you decide to finally turn the alarm off.
            ~ NoiseComplain = true
            
            + Turn off the alarm and wake up -> turn_off_alarm_and_wake_up
            
        }
    =alarm_rings
        Suddenly the spiral clock starts buzzing that loud alarm tone. Time to wake up and turn this thing off.
            + Ignore the alarm -> sleep_some_more
            + Turn off the alarm and wake up -> turn_off_alarm_and_wake_up




===turn_off_alarm_and_wake_up===
Concentrating all of your willpower you get out of bed and turn off the alarm. Day is now officially started. Being moved into this apartment recently, you’ll have to familiarize yourself with its contents.
    *Look around apartment-> look_around_apartment

    =look_around_apartment
        Taking a look around. This whole apartment consists from just one square room, where besides your bed you can see: a huge metal machine with the label “PCT Personal Citizen Terminal ™ ”, a small drawer, a door leading out of your apartment, a small gray fridge, a potted plant on a tall stool, a mirror, and a double glass door leading to the balcony. 
            -> apartment_choices
    
===apartment_choices===
    + Use PCT -> apartment_use_pct
    
===apartment_use_pct===
{!You approach the PCT(Personal Citizen Terminal ™).<br><br>With a light press of the power button the machine bursts into life, it’s low frequency screen starts flashing, presenting you with the option to check your inbox or submit a request.}
    + Check inbox -> check_pct_inbox
    + Leave PCT -> apartment_choices
    
        =check_pct_inbox
        After a few minutes of staring at the loading screen you are informed that you have one {!new} message from “The Factory ™”{!... it’s a job offer!}
            + {check_pct_inbox > 1} Go back -> apartment_use_pct
            + Open message -> message
            = message
                —
                “Thanks to the GG’s (Great Government’s) social programs you’ve received this wonderful opportunity to be employed at THE FACTORY  in your district, please arrive at [WORK TIME] [FLOOR] [HALLWAY] today.
                
                We also remind you that you need to pay a daily fee for your existence of [FEE AMOUNT] GGT (Great Government’s Token)  units.
                
                \*Failing to arrive at the destination will result in unemployment. Income tax is determined by your social score.\*
                —
                
                It would be a good idea to not miss this offer.
        
            + Go back -> apartment_use_pct

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
