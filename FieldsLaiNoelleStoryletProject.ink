//Test Ink file
-> Intro

//----------------------------------------------------------------------------------//


//Text Blocks
VAR enterBuilding = "Enter the building"
VAR moveRoom = "Move to the next room"
VAR leave = "Leave the building"
VAR fail = "Are those Security Guards approaching?"

===TESTStorylet1===
TODO Change end to return to knot
Test Storylet1
+[Accept]
+[Reject]
+[Deflect]
TODO replace w/ return to top knot AFTER choices
-->DONE
//----------------------------------------------------------------------------------//

=== Intro ===
Silver Tongue
You approach the building
~nextRoomStr = enterBuilding
+[{nextRoomStr}]->Rooms()

=== Ending ===
You've escaped
->END

===Failure===
You were caught
-> END

//----------------------------------------------------------------------------------//

//Variables
VAR credibility = 100
VAR entry = true
VAR room = 0
VAR nextRoomVar = ->Rooms
VAR nextRoomStr = ""

//Generic Room Template
=== Rooms ===
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

You're in Room {room}
{
- room > 0:
<- TESTStorylet1
-> DONE
}

+[{nextRoomStr}] -> nextRoomVar