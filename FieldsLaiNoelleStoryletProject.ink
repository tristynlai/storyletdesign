//Test Ink file
-> Intro

//----------------------------------------------------------------------------------//

//Text Blocks
VAR enterBuilding = "Enter the building"
VAR moveRoom = "Move to the next room"
VAR leave = "Leave the building"
VAR fail = "Are those Security Guards approaching?"

//StoryletHolder
TODO Put Storylet condition, entry statement, and knot name here ending with "(ret)"
===TableofContents(->ret)===
// <- Storylet name(ret)
+{room<4}[I trigger the test story1] <- TESTStorylet1(ret)
*{room<3&& not entry}[Wait is that a seagull?] <- TESTSeagullStorylet(ret)
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
--> ret

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

//----------------------------------------------------------------------------------//


=== Intro ===
Silver Tongue

{
-not shopped:
<-ShopStart(->Intro)
->DONE
}

-You approach the building
~nextRoomStr = enterBuilding
+[{nextRoomStr}]->Rooms

==ShopStart(->exit)===
+[decision 1]
    are you sure?
    ++ [yes]
    ++ [no]
        ->ShopStart(exit)
+[decision 2]
    are you sure?
    ++ [yes]
    ++ [no]
        ->ShopStart(exit)
+[decision 3]
    are you sure?
    ++ [yes]
    ++ [no]
        ->ShopStart(exit)
- You're done shopping
~ shopped = true
->exit


=== Ending ===
You've escaped
->END

===Failure===
You were caught
-> END

//----------------------------------------------------------------------------------//

//Variables
VAR credibility = 100
VAR shopped = false
VAR entry = true
VAR room = 0
VAR nextRoomVar = ->Rooms
VAR nextRoomStr = ""
VAR acceptToken = 5
VAR rejectToken = 0
VAR deflectToken = 0
VAR roomEntry = "You enter room "
VAR roomReturn = "You're still in room "

//----------------------------------------------------------------------------------//


//Generic Exit Room prompt
===RoomExit===
    {roomReturn}{room}
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
    - room == 3: ~entry = false
    }
    {roomEntry}{room}
    {
    - room > 0:
        <- TableofContents(->RoomExit)
        -> DONE
    }
}


