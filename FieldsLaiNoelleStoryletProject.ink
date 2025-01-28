//Test Ink file
-> Intro

//----------------------------------------------------------------------------------//


//Text Blocks
VAR enterBuilding = "Enter the building"
VAR moveRoom = "Move to the next room"
VAR leave = "Leave the building"
VAR fail = "Are those Security Guards approaching?"

===Storylet1 ===
TODO Change end to return to knot
->END

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
~credibility -= 25
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

+[{nextRoomStr}] -> nextRoomVar