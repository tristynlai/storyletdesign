//Test Ink file
-> Intro

//----------------------------------------------------------------------------------//

//Text Blocks
VAR enterBuilding = "Well, it’s time to find out."
VAR moveRoom = "Finally, you approach the next area."
VAR shrimpBar = "Finally you make it"
TODO change Leave, fail, and leaveShrimpBar
VAR leave = "Leave the building"
VAR leaveShrimpBar = "time to go"
VAR fail = "Are those Security Guards approaching?"

//StoryletHolder
TODO Put Storylet condition, entry statement, and knot name here ending with "(ret)"
===TableofContents(->ret)===
// <- Storylet name(ret)
+{room<4}[Oops broke the table of contents] <- TESTStorylet1(ret)
*{room<3&& not entry}[Wait is that a seagull?] <- TESTSeagullStorylet(ret)
*{room==1} [A nervous man in a suit] <- SpyIntro(ret)
->DONE

//Storylets
TODO Put Storylets here as knots, they should have options for accept, reject, deflect that check variables, a silent answer that checks for all variable being 0, and end with "--> ret"
===TESTStorylet1(->ret)===
This is the initial setup for Test Storylet1
+{acceptToken > 0}[Accept]
    ~acceptToken --
    You accepted
+{rejectToken>0}[Reject]
    ~rejectToken --
    You rejected
+{deflectToken > 0}[Deflect]
    ~deflectToken--
    You deflected
+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You stayed Silent
-->StatusUpdate->
-> ret

===TESTSeagullStorylet(->ret)===

{
-TESTSeagullStorylet < 2:
You've been attacked by a seagull
-TESTSeagullStorylet >= 1:
You're still being attacked by a seagull
}
+{acceptToken > 0}[Accept]
    ~acceptToken --
    You accepted
    -> TESTSeagullStorylet(ret)
+{rejectToken>0}[Reject]
    ~rejectToken --
    You rejected
+{deflectToken > 0}[Deflect]
    ~deflectToken --
    You deflected
+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You stayed Silent
--> ret

===SpyIntro(->ret)===
You saunter further into the party, trying to appear like an unassuming human. Interestingly, you quickly notice someone else doing the same. He wears a similar suit and tie to yours, and keeps checking his watch and glancing around nervously, until his eyes and yours meet.

He walks over to you. It seems a conversation is inevitable.

“Hello, my... friend? Boy, the stars sure are *BERGUNDY* tonight huh?”

--> SpyIntro2 (ret)

===SpyIntro2 (->ret) ===

He winks, then waits for a response.

+{acceptToken > 0}[Accept]
    ~acceptToken --
    “THEY ARE GOOD, AREN’T THEY? BEAUTIFUL NIGHT FOR A PARTY.”

The man looks at you, winks a few more times for good measure, then his hopeful smile turns forlorn.

“Oh, apologies. I mistook you for someone else.”

You get out before they have time to reconsider.
~ credibility --
->StatusUpdate->

*{rejectToken>0}[Reject]
    ~rejectToken --
    “I’M NOT INTERESTED IN THE STARS AND I HAVE NEVER BEEN THERE-”

“Well I-”

“-AND YOU AND YOUR PEOPLE SHOULD NOT GO THERE EITHER.”


“Well that’s alright with me. How about wine? In my opinion the best wines are... *BERGUNDY.* And yours?
->StatusUpdate->
->SpyIntro2(ret) 

+{deflectToken > 0}[Deflect]
    ~deflectToken--
    “ACTUALLY I THINK I LEFT MY STOVE ON.”

You turn to leave, but the man grabs you.

“The codephrase! Agent F, you look different than expected, but of course you are a master of disguise.”

Oh shit. Shit shit shit this is so awkward. You stand stunned as a little mechanism is slipped into your palm.

“Your mission, Agent F, is to tag the Ivory Falcon with this covert tracking beacon. I trust a man of your... tastes will remember her photograph from the briefing? In any case, slip the beacon in her clothing so we can follow her back to base, and you will be handsomely rewarded.”

You stumble out, beacon in pocket.
->StatusUpdate->

+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You stayed Silent
    TODO
-->ret

//----------------------------------------------------------------------------------//


=== Intro ===
Silver Tongue
*[begin]
Your name is K'Thk'L'P'Le'Apl'T'Dd. You look exactly like an unassuming human, with the sole exception of the notable lack of a mouth beneath your nose. You breathe through your eyes, of course, as any sensible creature would - but here, at a ritzy penthouse cocktail party in the human colony Earth in the human town New York in the human year 2025, this will not do.
** [continue]

You NEED to be at this party. You NEED to infiltrate, mingle, and get out without being identified as the extraterrestrial you are. So you wear a translator across your lower face, a set of mechanical lips and tongue you’ve strapped across your upper chin.
*** [continue]

You bought their cheapest model. It translates three vague commands contextually to match human conversation.  ACCEPT for engaging when prompted, REJECT for fighting against the flow, and DEFLECT for changing subject. After buying a suit, you only afford {money} lines of dialogue. 

<-ShopStart(->Intro2)
-->DONE


==Intro2 ===
Your mission is that of a rescue - and you’re the only one coming. You cannot afford to screw up. You sigh from your eyes as you shake out your joints, bouncing on the soles of your feet alone in the elevator. It dings, opening to a crowded rooftop. Men and women in fancy outfits laugh and banter in packs around the space. The air tastes like sweat and spilled champagne. Frantic lights strobe the sky from a dance floor further in, and beyond that are food and drink tables.

You can do this, K’Thk. You have {acceptToken} ACCEPTs, {rejectToken} REJECTs and {deflectToken} DEFLECTs. That should be enough for a simple party, right?

~nextRoomStr = enterBuilding
+[{nextRoomStr}]->Rooms

==ShopStart(->exit)===
You press a button on the machine and grab the datachip that vends out. 
{
-money > 0:
You can still afford {money} lines of dialogue. Might as well spend it all.
+[Buy an ACCEPT]
    ~acceptToken ++
    ~money --
    You purchased one ACCEPT response
    ->ShopStart(exit)
+[Buy a REJECT]
    ~rejectToken ++
    ~money --
    You purchased one REJECT response
    ->ShopStart(exit)
+[Buy a DEFLECT]
    ~deflectToken ++
    ~money --
    You purchased one DEFLECT response
    ->ShopStart(exit)
+{money == 10}[Buy a QuikStart Pak]
    This will give you 4 ACCEPTS, 3 DEFLECTS, and 3 REJECTS
    This will cost 10 credits
    Are you sure you want to purchase this?
    **[yes]
    You've purchased One (1) QuikStartPak
    ~money = 0
    ~acceptToken = 4
    ~rejectToken = 3
    ~deflectToken = 3
    ->ShopStart(exit)
    ++[no]
    ->ShopStart(exit)
-money <=0:
    You buy your last line of dialogue, hoping it will be enough.
    ->exit
        }
        
===StatusUpdate===
You now have {acceptToken} ACCEPTS, {rejectToken} REJECTS, and {deflectToken} DEFLECTS.
TODO Remove Debugs
DEBUG you are currently in room {room}
->->

===ShrimpBar=== 

~room ++
Under a sign labelled “shrimp bar,” you see it. A feast of horrors.

You see Holiest Ones, plated and served in a variety of awful ways. Holiest One ceviche, Holiest One and cocktail sauce, Holiest One scampi...

It takes all your willpower to not vomit and fall to your knees sobbing. But of course... These are not Holiest Ones. They are mostly Earth shrimp, which coincidentally bear a striking resemblance to your most holy of holy creatures.

But not all of them are shrimp. You lean over a tub, and see five Holiest Ones stare up at you from among the refuse.

You reach forward and, in your fist, grab all five. You turn to leave. It’s time to sprint out of here.

~nextRoomVar = -> Rooms
~entry = false
~nextRoomStr = leaveShrimpBar
        
->StatusUpdate->

--> RoomExit

=== Ending ===
You've escaped
->END

===Failure===
You start to move to the next room, but wait... some people are approaching immediately. Uh oh, they’re security guards.

“We’re going to need to ask you to leave.”

Seems like you made enough of an ass of yourself to get kicked out. Well... shit.

{
- not entry:
Actually... wait, this is what you want! Now they’ll escort you and the Holiest Ones out of here.

One guard grabs your arm. “And no free food!”

He snatches the Holiest Ones from your hand, and, in horror, you watch him swallow them whole.
}
-> END

//----------------------------------------------------------------------------------//

//Variables
VAR money = 10
VAR credibility = 5
VAR entry = true
VAR room = 0
VAR nextRoomVar = ->Rooms
VAR nextRoomStr = ""
VAR acceptToken = 0
VAR rejectToken = 0
VAR deflectToken = 0
VAR roomEntry = "You enter room "
VAR roomReturn = "You're still in room "

//----------------------------------------------------------------------------------//


//Generic Exit Room prompt
===RoomExit===
    +[{nextRoomStr}] -> nextRoomVar

//Generic Room Template
=== Rooms ===
//{
//-not returning: //checks if new room or returning from storylet
    ~nextRoomStr = moveRoom
    //Sets up next room
    {
        - entry: ~room ++
        - not entry: ~room --
    }
    // Handles special Cases
    {
    - credibility < 1: ~nextRoomVar = -> Failure
     ~nextRoomStr = fail
    - room == 1 && not entry:~nextRoomVar = -> Ending 
       ~nextRoomStr = leave
    - room == 3 && entry:
        ~nextRoomStr = shrimpBar
        ~nextRoomVar = ->ShrimpBar
    - room == 3&& not entry:
        ~nextRoomStr = nextRoomStr
    }
    {
    -room == 1: You enter the throng and move towards...
    -room == 2: The bass thrums through your body as you approach the covered dancefloor. Strobes and colors assault your eyes and crowds of flailing humans cover the space, making traversal through near impossible. 

You shudder, but steel yourself. Time to go in.

    -room == 3&& entry: You exit a crowd of dancers and finally see it - the snack bar. Your ultimate goal.
You’re nearly to your goal.
TODO change exit room 3 text
    -room == 3&& not entry: You start heading back the way you came, through the dance floor.

    }
    {
    - room > 0:
        <- TableofContents(->RoomExit)
        -> DONE
    }
}


