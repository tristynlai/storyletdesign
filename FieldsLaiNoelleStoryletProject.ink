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

//VAR for Storylet Conditions
VAR spydeflect = false
VAR returning = false
VAR hasBeacon = false
VAR imhungieaccept = false
VAR hasFood = false
VAR photographaccept = false
VAR photographdeflect = false
VAR pushysalesmanaccept = false
VAR drunkspillreject = false

//StoryletHolder
TODO Put Storylet condition, entry statement, and knot name here ending with "(ret)"
===TableofContents(->ret)===
// <- Storylet name(ret)
+{room<4}[Oops broke the table of contents] <- TESTStorylet1(ret)
*{room<3&& not entry}[Wait is that a seagull?] <- TESTSeagullStorylet(ret)
*{room==1} [A nervous man in a suit] <- SpyIntro(ret)
*{room==2} [An argument] <- DrunkSpill(ret)
*{room==3} [A photographer] <- Photos(ret)
*{room==4} [A woman in pain] <- ImHungie(ret)
*{room==4 && imhungieaccept && returning} [A familiar hungry woman] <- ImHungie2(ret)
*{room==5} [An elegant dancer] <- AskForDance(ret)
*{room==6 && photographaccept && returning} [A photo printing station] <- PrintPhoto(ret)
*{room==7} [A salesman] <- PushySalesman(ret)
*{room==8 && drunkspillreject} [A familar stranger] <- KindStranger(ret)
*{room==9} [A group of rich-looking younger men] <- WhereSummer(ret)
*{room==10} [An awkward-looking young woman] <- AwkwardLady(ret)
*{room==11} [A kind soul] <- Napkin(ret)
*{room==12 && returning} [A bird] <- SeagullAttack(ret)

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

~hasBeacon = true

->StatusUpdate->

+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You try to respond, but your translator is out of juice. The lips hang limply on your lower chin as you draw more and more suspicion for your awkward silence.

You slink off in shame, the eyes of the whole party on you.
~ credibility -= 20
-->ret

===DrunkSpill(->ret)===
You stroll through these throngs of humans, taking the quickest path. But a loud argument is taking place along the way. One arguer is a drunk-seeming young man wearing an elaborate suit stained with red, and the other is an older man with an empty glass.

“Well I ain’t paying for it! It’s your mistake!” The older man is adamant.

“Heyyyyy, you!” The drunk man calls you in. “Thissss jerk spilled shit on my brrrrrrrand new shirt! He owes me, right?”

“You bumped me first, don’t misrepresent the facts.”

“Hey, I’m talkinnnnn to this guy now. He owes me, RIGHT?”


+{acceptToken > 0}[Accept]
    ~acceptToken --
    “YEAH, I’D SAY SO.”

“Hey, come on man!” the older man cries. “The hell?”

It seems the general crowd’s perception has changed. At first he was a victim of a drunk bully, but now he’s an ass who assaulted a helpless drunk. He skulks away toward the elevator.

“You... I llllllike you. You’ve made a powerful ally. My family is in a... certain bus. Busis. Bininess.” He pulls a coin from his pocket, and, even as drunk as he is, effortlessly rolls it across his knuckles. “You did me a good turn, weeeee do you. A one.”

He flips you the coin and you grab it by instinct. You don’t like the sound of that, but leave before any followup.

->StatusUpdate->

+{rejectToken>0}[Reject]
    ~rejectToken --
    ~drunkspillreject = true
    “THIS PREMISE IS SO DUMB I’M NOT GOING TO DIGNIFY IT WITH A RESPONSE.”

“So wait...” The drunk man pauses to think, brain working at minimum efficiency. “That means you. You don’t think hhhhe owes me?”

“What’d I tell you,” says the older man. “I’m out of here.” He slides through the throng effortlessly. You take that as leave for you to go too.

“Hey. HEY! You’ve BOTH made a powerful enemy! Don’t you know my. Who my mom is!”
~ credibility --
    
->StatusUpdate->


+{deflectToken > 0}[Deflect]
    ~deflectToken--
    “HEY YOU BOTH HAVE THE SAME NOSE! ISN’T THAT INTERESTING!”

“We do?” they both ask simultaneously.

The drunk one squints and suddenly laughs.

“We do! Come here Nose Bro!” He slumps forward in a big hug around the other man, who shrugs and hugs back.

“I mean, why not.”

->StatusUpdate->

+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You try to respond, but your translator is out of juice. The lips hang limply on your lower chin as you draw more and more suspicion for your awkward silence.

You slink off in shame, the eyes of the whole party on you.
~ credibility -= 20

-->ret

===Photos(->ret)===
A redheaded photographer approaches, camera around her neck and hand bag at her hip. She tracks you down and gets in your way. You catch a flash of some landscape photos in the bag, before it bends out of sight. She asks, bluntly, if you want a photo of yourself.

“You’ll be able to print them out by the dance floor, up ahead. Make some New Year’s memories!”

+{acceptToken > 0}[Accept]
    ~acceptToken --
    ~photographaccept = true
    “CAN’T HURT.”

A bright flash! Your eyes are flooded, blinded, broken - you blink instinctively, and  feel like you can hardly breathe. But, painfully, it fades.

The photographer looks down at her camera’s viewfinder, then at you, concerned.  You use the only Earth gesture you can remember - a thumbs up.

The photographer warily moves on, and you do too.

~ credibility --
->StatusUpdate->

+{rejectToken>0}[Reject]
    ~rejectToken --
    “NOT GONNA HAPPEN.”

“Well, that’s one way to put it, but fine.”

The photographer walks off, red hair bobbing away. She seems much more annoyed now. Was it something you said?

“What am I even doing here?” she mutters.

Well in any case, the floor is clear to keep going.

->StatusUpdate->


+{deflectToken > 0}[Deflect]
    ~deflectToken--
    ~photographdeflect = true
    “YOU MAKE BEAUTIFUL LANDSCAPES, SO WHAT ARE YOU DOING TAKING PICTURES OF PEOPLE?”

	“Oh!” She blushes, hand going to her bag. “You... really think they’re beautiful?”

	You reach a hand out. She gives you some pictures from the bag. They are genuinely very intriguing to you. Then again, you’ve never seen Earth art before... so it’s all quite novel. You nod.
	
She takes the pictures back, and fiddles with a ring on her finger. “Landscapes don’t always pay the bills, you know. Sometimes I need to take jobs I don’t love to care for the people I do. Love, I mean.”

	You offer a thumbs up, the only Earth gesture you can remember. It seems to help, as she laughs.

“Well, back to work then!” You go your separate ways. Only after losing sight of her in the crowd do you realize you still have one landscape - a green mountain range. You pocket it for now.

->StatusUpdate->

+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You try to respond, but your translator is out of juice. The lips hang limply on your lower chin as you draw more and more suspicion for your awkward silence.

You slink off in shame, the eyes of the whole party on you.
~ credibility -= 20

-->ret

===ImHungie(->ret)===
You duck and weave gracefully through the party until you bump into a woman who turns to you with an expression of desperate pain.

“I’m hungie I’m hungie I’m hungie...” She groans as she slumps down. Her stomach gurgles agreement.

“Hey you! I’m hungie, can you bring me back a pizza?”


+{acceptToken > 0}[Accept]
    ~acceptToken --
    ~imhungieaccept = true
    “ONE PIZZA, COMING RIGHT UP.”

Her eyes light up and she stares at you, awestruck.

“Ohmygosh thanks so muuuuuuuch. I’m just so hungie you don’t even know! I’ll wait here.”

You continue on. You may or may not bring her a pizza, but either way she has certainly  expanded your vocabulary.
->StatusUpdate->

+{rejectToken>0}[Reject]
    ~rejectToken --
    “WHY ASK ME TO GET YOU FOOD? I DON’T EVEN KNOW YOU.”


“I’m just really hungie, man! Lady! I dunno, I can't think right now the HUNGIE is in my braaaiiinnnsss...”
	
	You don’t have time for this, and leave her in a gurgling heap on the floor.
->StatusUpdate->


+{deflectToken > 0}[Deflect]
    ~deflectToken--
    “WHAT’S YOUR NAME, LADY?”
	
	“Uuuuugggghhhh my name is Isabella. Don’t worry about the last name. I’m really fancy and belong, okay? What, you wanna know everything about me? I’m hungie, I just need a pizza. Get me a pizza, I’m hungie.”

You look expectantly. She matches your gaze then moans and slumps into a chair.

“Okay, fine. So maybe I snuck into this party for free food. But the snack bar is all the way over there, and I’m over here, you know?”

You do know. You nod in sympathy.

“Alright, guess we both gotta just go over there, huh? See ya.”

You both step forward into the crowds. Maybe you’ll see her again?
->StatusUpdate->

+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You try to respond, but your translator is out of juice. The lips hang limply on your lower chin as you draw more and more suspicion for your awkward silence.

You slink off in shame, the eyes of the whole party on you.
~ credibility -= 20

-->ret

===ImHungie2(->ret)===
You’re nearly out - but you see that hungry woman again. Despite her having several small crumb-covered plates beside her now, her stomach still groans and she still grumbles.

She lights up when she sees you and stomps up into your way. Oh shit, you forgot to grab her something from the snack bar.

“Yooooo I’m SOOOO hungie! You brought me back some shrimp?! Can I have em?”

+{acceptToken > 0}[Accept]
    ~acceptToken --
    “OF COURSE, FRIEND!”
You really, really, really don’t want to do this. This goes against everything you’re here to do, everything you believe in, your VERY BEING. She reaches forward hungrily for the Holiest Ones and you quickly pull your fist back out of the way, sweating heavily.

“What the hell? I’m so hungie I could dieee! Gimme! I’m hungie I’m hungie I’M HUNGIE!!!”

You run, leaving a very angry woman behind and making a huge scene.

“Hey, they stole my food!” she shouts from behind.
~ credibility -= 20

->StatusUpdate->

+{rejectToken>0}[Reject]
    ~rejectToken --
    “SORRY, NO TIME.”

You shove her out of the way before she can even attempt to snatch at the Holiest Ones.

From behind, you hear a quiet “Aww man!”

->StatusUpdate->


+{deflectToken > 0}[Deflect]
    ~deflectToken--
   “I THINK THERE’S STILL PLENTY OF SNACKS AT THE SNACK BAR!”

“Alright, alright, I’ll go myself! But I thought you said you’d get me something! Kinda a jerk move to leave a lady expecting food when she’s hungie...” she grumbles.

You run out. So close to the exit.

->StatusUpdate->

+{pushysalesmanaccept}[Offer Salesman's snack box instead]
    You wordlessly hold out the box you’d bought from that pushy salesman, back at the dance floor. She grabs it from you and chows down.

“Mmmf, thif if great,” she gets out between bites. 

“Hey, make way! Party Hero coming through!” she shouts, and the crowd parts for you.
~ credibility += 20
->StatusUpdate->

+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You try to respond, but your translator is out of juice. The lips hang limply on your lower chin as you draw more and more suspicion for your awkward silence.

You slink off in shame, the eyes of the whole party on you.
~ credibility -= 20

-->ret

//Zone 2-------------------------------------------------------------------------------//
===AskForDance(->ret)===
You shoulder through the throng of dancers, but one woman interrupts your pushes, twirling into your way with an elegant skill. She wears a flowing white robe that matches her artificially pale hair. 

The music changes, and she holds out a hand.

“May I have this dance?”


+{acceptToken > 0}[Accept]
    ~acceptToken --
    “OF COURSE, LEAD THE WAY.”

You two flow across the dancefloor, a swirling binary star surrounded by an  inky blackness of talent.

You’re captivating, brilliant, an excellent pair. Who knew old K’Thk still had it?

For timeless moments you dance... but you have a mission. You pull away.

“Goodbye, friend,” the pale woman says. “Until another dance.”

You leave, duty on your mind.


->StatusUpdate->

+{rejectToken>0}[Reject]
    ~rejectToken --
    “I MUCH PREFER DANCING BY MYSELF.”
“Of course.  So long, stranger.” She twirls off, and so do you.

You sense some stares on you, as you leave this woman behind. Some burly men watch from nearby. Could they be suitors? Or... bodyguards?

Whoever they are, they didn’t like this interaction and certainly don’t like you.

You leave double-time.
~ credibility --
->StatusUpdate->


+{deflectToken > 0}[Deflect]
    ~deflectToken--
    “HEY, YOU EVER NOTICE HOW THERE’S A TON OF BIG INTIMIDATING GUYS WATCHING YOU?”
She cocks an eyebrow. Damn this translator mouth! What the hell is it doing?!

You- wait, it’s right. There *are* many burly, hidden men watching this conversation. They glower at you.

She smiles. “Why, even an Ivory Falcon needs her... flight feathers, mm?”

The men approach and pull her away. Bodyguards? “Another dance, perhaps.”

You leave double-time.
~ credibility --

->StatusUpdate->

+{hasBeacon} [Plant Tracker Beacon]
    That spy person asked you to plant this on a “white falcon,” right? There is clearly a... white motif going on here. This is probably what he wanted. You assume.

You reach forward and covertly stick the beacon to a hem of her dress. She doesn’t appear to notice, as she’s currently lost in your eyes. You hold your breath.

“Well, I’ll take your silence as a no. So long, stranger.” She twirls off, and so do you.
~hasBeacon = false

->StatusUpdate->

+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You try to respond, but your translator is out of juice. The lips hang limply on your lower chin as you draw more and more suspicion for your awkward silence.

You slink off in shame, the eyes of the whole party on you.
~ credibility -= 20

-->ret

===PrintPhoto(->ret)===
You see a stand of photographs that the photographer has taken over the course of the party. Many happy people... and you. Looking closer, you can just about make out the breathing vents in your irises. You... should probably grab that one.

You snatch it up, and move on.

-->ret

===PushySalesman(->ret)===
“Party surprise pack! Get your perfect party food pack here!” A loud, pushy man is yelling over the din, hawking his wares. Everyone around him is giving him dirty looks but he is paying them no mind.

He approaches you with some shoddily constructed plastic boxes of food. “Hey, you want one! I know it!”

This man appears to be reselling hors d'oeuvres he’s snatched from various waiters. He keeps pestering you for an answer.


+{acceptToken > 0}[Accept]
    ~acceptToken --
    ~pushysalesmanaccept = true
    “LET ME GET MY WALLET, GOOD SIR!”

You buy some ripoff meal, to get him to leave you alone. It seems to work, at least, as he moves out of your way satisfied.

{imhungieaccept == true:
    That hungry woman from earlier would probably appreciate this... even if it’s not pizza.
    ~hasFood = true
}

->StatusUpdate->

+{rejectToken>0}[Reject]
    ~rejectToken --
    “NO THANK YOU.”
--> PushySalesman2 (ret)


+{deflectToken > 0}[Deflect]
    ~deflectToken--
    “WHY ARE YOU DOING THIS?”
--> PushySalesman2 (ret)

+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You try to respond, but your translator is out of juice. The lips hang limply on your lower chin as you draw more and more suspicion for your awkward silence.

You slink off in shame, the eyes of the whole party on you.
~ credibility -= 20

-->ret

===PushySalesman2(->ret)===
“Hey come on, don’t be like that!” he shouts over the thumping beats.

“This is GOOD STUFF, buddy! You want to buy!”

+{acceptToken > 0}[Accept]
    ~acceptToken --
    ~pushysalesmanaccept = true
    “LET ME GET MY WALLET, GOOD SIR!”

You buy some ripoff meal, to get him to leave you alone. It seems to work, at least, as he moves out of your way satisfied.

{imhungieaccept == true:
    That hungry woman from earlier would probably appreciate this... even if it’s not pizza.
    ~hasFood = true
}

->StatusUpdate->

+{rejectToken>0}[Reject]
    ~rejectToken --
    “GET OUT OF MY WAY.”

“Alright, FINE! Have it your way, but you’ll regret it!”
The man wanders off.

->StatusUpdate->


+{deflectToken > 0}[Deflect]
    ~deflectToken--
    “YOU KNOW, THOSE MEAL BOXES LOOK AN AWFUL LOT LIKE REPACKAGED APPETIZERS FROM THIS VERY PARTY.”

	He pales. “Alright, FINE! Have it your way, but you’ll regret it!”
The man wanders off.

->StatusUpdate->

+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You try to respond, but your translator is out of juice. The lips hang limply on your lower chin as you draw more and more suspicion for your awkward silence.

You slink off in shame, the eyes of the whole party on you.
~ credibility -= 20

-->ret

===KindStranger(->ret)===

As you desperately try to push through, the crowds condense around you. You’re trapped, you can’t go forward, can’t complete the mission!

Just then... A familiar face emerges from the mosh of bodies. The older man, who had been arguing with the younger drunk person. He sees you in distress, and offers you a hand.

+[Take it]
    You grab his hand and he pulls you through the churning mash of flesh to the other side of the crowd.

“Now we’re even. Thanks, stranger.” He leaves, and you turn and march on.

-->ret

//Zone 3-------------------------------------------------------------------------------//

===WhereSummer(->ret)===
A gaggle of rich-seeming younger men gather in a thoroughfare, gesturing with their cups. You need to get through that thoroughfare. One talks animatedly.

“Fiji is a classic, of course. Most Caribbean islands are excellent, but Fiji holds a special place in my heart.”

A notification appears on your Heads Up Display - “Fiji is located in the southern Pacific region of Earth, not in the Caribbean.”

The HUD - you’d forgotten you bought that thing, much less had it installed. It was even cheaper than the translator. Guess they could only fit one factoid on it.


“And you,” says the rich man, drawing you back to the present. “Where do you summer?”

+{acceptToken > 0}[Accept]
    ~acceptToken --
    “I SUMMER AT THE LOUVRE, USUALLY.”

The men relax. “Ah, a good choice! But you haven’t really experienced the Louvre until you’ve brought a painting or two home.”

“Eh, they’re tacky but it gets me respect when people see it in my foyer,” another man adds. “You should see my TEDex talk, it’s all about the importance of a good foyer.”

You are nobody’s “mans,” but you hold your comment. No use spending more translations. Instead you nod.

The conversation shifts to gaudy details added to their homes, and you feel it’s time to go.

“Hey, have a good one.” You roll your eyes and leave. Seems the rich are the same, no matter what planet they’re from. And now that you’ve been seen kindly associating with them... you’re getting some dirty looks from the crowd.

~ credibility --
->StatusUpdate->

+{rejectToken>0}[Reject]
    ~rejectToken --
    “I DON’T HAVE TIME FOR SUMMERING, BECAUSE I’M ALWAYS WORKING HARD.”

One man nods. “Ah, the grind never stops, right? I respect it.”

Another. “I work 22 hour days, y’know. It’s how I got my billions - hard work!”

Yet another “These lazy poors just want handouts! Completely unlike us, of course!”

He gets a round of nods and murmured approval. You take that opportunity to dash away.

Jerks. Seems like the rich are the same, no matter their planet of origin.

->StatusUpdate->

+{deflectToken > 0}[Deflect]
    ~deflectToken--
    “FIJI IS LOCATED IN THE SOUTHERN PACIFIC REGION OF EARTH, NOT IN THE CARIBBEAN.”

The conversation stalls, before the man chimes back in. 

“Well, of course. That’s what I said.” He most certainly did not.

Another. “Yeah, are you dumb or something?” 

The group turns to you, asserting their superiority between themselves by calling you names and insulting your intelligence. You don’t have time for this.

You leave, allowing them to think they won a victory here.

->StatusUpdate->

+{photographdeflect}[Show them the landscape photograph.]
    You pull the photographer’s picture from your pocket and show it to the group.

The men smirk and nod.

“Excellent choice, excellent. I could see a lovely getaway being built there.”

“Do you know if it’s up for sale?”

“What’s the internet situation like there? I can’t go without my stocks.”


“Wait, so they just carry around a polaroid of their-”

“Shut it, Glenn.”

“Right, sorry.”

You grin mysteriously and leave the conversation, which has moved beyond you, for more important pastures.

->StatusUpdate->

+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You try to respond, but your translator is out of juice. The lips hang limply on your lower chin as you draw more and more suspicion for your awkward silence.

You slink off in shame, the eyes of the whole party on you.
~ credibility -= 20

-->ret

===AwkwardLady(->ret)===
You bump into someone who clearly does not belong at this party. A woman with long curly hair and glasses askew, who seems eager to talk to you.

“H-hey! I’m supposed to talk to people and get out there, so... uh.... you wanna hear about this really cool book I like?”


+{acceptToken > 0}[Accept]
    ~acceptToken --
    “SURE, LAY IT ON ME CHIEF.“

Her eyes light up. She’s been waiting for someone to respond like this. Oh no.

“Okay, so basically it’s this really cool web serial - a web serial is like a giant story that’s published weekly on the internet, or maybe bi-weekly or something, and it’s like carrying on that serial publication method of, like, Mark Twain stories and Dracula and stuff - well anyways it’s a giant web serial called Pale, and it’s really great!”

Brother.

“And okay so Pale is basically a huge urban fantasy web serial about these three teenagers who are investigating the murder of a dead god in their Canadian hometown, and- well actually it’s a dead Judge, gods are technically a different thing in-universe but. I mean maybe first I should explain that, uh, the world is like ours and there’s a secret magic world with magic ‘Practitioners’ and magical creatures called ‘Others’ and-”

You maintain circular breathing through your eyes, tapping your foot. When will this conversation end?

“-drop is the best one, but as I was saying the story is all about how they learn to survive and grow their power as compassionate outsiders, and, like, what do you do when the justice system is broken, and do you fix it from the inside or tear it down and rebuild? And all these other interesting questions about morality but it’s not boring at all, it’s super exciting because the girls all-”

You wonder if your mission is worth this.

“-agic system is basically all about Karma, and Law and sorta storybook logic so sometimes fights are big spells but othertimes it’s more of a life or death legal battle with both sides trying to convince the spirits they’re in the right to get a magic powerup and screw with their enemy, which is just absolutely gripping to read! And the bad guys are crazy and great!”

She barely even seems to know you’re there, lost in remembrance as she is.

“Oh, and don’t even get me started on-”

You don’t. In the midst of her babbling you manage to slip away. 

Yeesh.

->StatusUpdate->

+{rejectToken>0}[Reject]
    ~rejectToken --
    “NOPE, I’M OUT.”

The woman looks so awkward she could burst.

“W-well... what about... uh...”

You stare at her, for several silent seconds, and she caves.

“Oh, forget it. Um, I’m so sorry...”

You leave, and feel sorta bad about it.

~ credibility --
->StatusUpdate->


+{deflectToken > 0}[Deflect]
    ~deflectToken--
    “MY FAVORITE BOOK IS WEBSTER’S 1828 AMERICAN DICTIONARY OF THE ENGLISH LANGUAGE!”

You have no idea what that means but assume it must be quite popular here on Earth, because the woman’s eyes widen.

“W...well that’s- It’s uh, a very long book. And if you’re into very long books you might like... eh, forget it.”

She sighs. “I’m just not cut out for this networking thing, huh? You have a good night.”

You leave her.

->StatusUpdate->

+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You try to respond, but your translator is out of juice. The lips hang limply on your lower chin as you draw more and more suspicion for your awkward silence.

You slink off in shame, the eyes of the whole party on you.
~ credibility -= 20

-->ret

===Napkin(->ret)===
You stumble through this crowded space, squeezing past suited people carrying plates of hors d'oeuvres and occasionally spilling some on yourself. You’re so close to your goal it hardly matters to you at this point.

But one kind soul stops you - a frazzled looking man, with askew glasses, a tropically patterned suit jacket, and two napkins in his pocket.

“Hi, sorry, you’ve got some schmutz on your shirt! Can I get it for you?”

He pulls one of the napkins out and gestures to you. You’re astonished to see that, on it, there’s a crude pen sketch of what is obviously a Gg’Knl’Prb Drive. This man must have invented it in a fit of genius earlier in the night, writing down the design on this napkin. But now, he is accidentally offering the key to the cosmos... to clean a mayo stain.


+{acceptToken > 0}[Accept]
    ~acceptToken --
    “THANK YOU.”

You hesitantly take the napkin, and wipe it across your face and clothes. The napkin is a smeared blur when you’re done.

You’ll probably be more palatable to the partygoers, but it cost... humanity’s future. The man smiles up at you, oblivious.

“It’s no problem at all.”

You go, feeling sick.

->StatusUpdate->

+{rejectToken>0}[Reject]
    ~rejectToken --
    “KEEP THE NAPKIN, I LIKE IT LIKE THIS.”

He pulls back, confused. “O..okay?”

The napkin goes back into his pocket. You let out a sigh - humanity’s future is secured.

And yet... now he thinks you’re weird, and you’re still covered in mayo. Fantastic.

~ credibility --
->StatusUpdate->


+{deflectToken > 0}[Deflect]
    ~deflectToken--
    “WHAT’S A GUY LIKE YOU DOING AT A PARTY LIKE THIS?”
		
		“Now what’s that supposed to mean?” He pulls back the hand with the napkin, smirking. “Is it that clear I’d rather be back in the lab?”

		You shrug.
		“Perhaps you’d be interested in seeing it sometime?” He grins widely. “I’m always happy to show people around. Especially... someone like you.”

Does he know you’re an alien? You panic briefly, before thinking it through. No, this is simply human flirting. Awkward, awkward flirting. What a relief.

You give a thumbs up. He laughs.

“Here’s my cell,” he says, handing you a paper square with some numbers on it. “Call me later?”

You’ve already interfered enough in this planet, so there’s no way you’ll-

He suddenly wipes your face with the drawn-on napkin. Shit.

		...Maybe you’ll leave him a reminder, you think, as you saunter away.
->StatusUpdate->

+{acceptToken <= 0 && rejectToken <= 0 && deflectToken <= 0}[Stay Silent]
    You try to respond, but your translator is out of juice. The lips hang limply on your lower chin as you draw more and more suspicion for your awkward silence.

You slink off in shame, the eyes of the whole party on you.
~ credibility -= 20

-->ret

===SeagullAttack(->ret)===
A loud whitish bird with an orange beak flies into your way and caws loudly. From your research, you know this is a seagull - one of the threats you hoped not to face.

It waddles forward, wings extended and cawing at you. It wants the Holiest Ones in your hand. But perhaps you can reason with it?

+{acceptToken > 0}[Accept]
    ~acceptToken --
    “CAW CAW CAW, MY FRIEN-”
--> Seagull2 (ret)

+{rejectToken>0}[Reject]
    ~rejectToken --
    “I AM TERRIBLY SORRY BUT I’M AFRAID THESE ARE MIN-”
->StatusUpdate->
--> Seagull2 (ret)

+{deflectToken > 0}[Deflect]
    ~deflectToken--
    “MY, HOW SHINY YOUR BEAK IS LOOKING TODA-”
--> Seagull2 (ret)

+{hasBeacon}[Plant tracker beacon on the seagull]
    You were supposed to put this tracking beacon on the “Ivory Falcon,” right?
Well, this is a white bird too. Probably close enough.

You wordlessly, snap forward with your other hand and stick the tracking beacon to the seagull’s feathers. It caws loudly and takes off, beacon blipping quietly.

Threat resolved, you head on.
    ~hasBeacon = false
-->ret

===Seagull2(->ret)===

+{acceptToken > 0}[Accept]
    ~acceptToken --


->StatusUpdate->

Before your translator can finish, the bird flies at your face, pecking and clawing. You scuffle briefly and frantically before it takes off again. Luckily, it doesn’t seem to have grabbed any Holiest Ones. 

You shake your fist at the sky as it flies off. Jerk!

You leave before anything else picks up the smell.

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
~returning = true
        
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


