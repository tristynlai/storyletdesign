//Test Ink file
-> Intro

//----------------------------------------------------------------------------------//

//Text Blocks
VAR enterBuilding = "Enter the building"
VAR moveRoom = "Move to the next room"
VAR leave = "Leave the building"
VAR fail = "Are those Security Guards approaching?"

===TESTStorylet1===
This is the initial setup for Test Storylet1
+{acceptToken > 0}[Accept]
    You accepted
+{rejectToken>0}[Reject]
    You rejected
+{deflectToken > 0}[Deflect]
    You deflected
+[Stay Silent]
    You stayed Silent
    ~credibility -= 52
-->Rooms(true)
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
+[{nextRoomStr}]->Rooms(false)

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
VAR acceptToken = 0
VAR rejectToken = 0
VAR deflectToken = 0
VAR roomEntry = "You enter room "
VAR roomReturn = "You're still in room "

//----------------------------------------------------------------------------------//

//Generic Room Template
=== Rooms (returning)===
{
-not returning: //checks if new room or returning from storylet
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
        <- TESTStorylet1
        -> DONE
    }
- returning:
    {roomReturn}{room}
    +[{nextRoomStr}] -> nextRoomVar(false)
}


