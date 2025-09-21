extends Node

# Store the current index of ongoing dialog
var dialog_index: int = 0
# Store the current indeex of current customer
var customer_index: int = 0
# Stores the current customer name
var customer_name: String = "default"
# Stores the current dialog lines after formatting
var current_dialog: Array[String] = []
# Store the current state of serving
var drink_ready: bool = false
# Store the state of having customer
var current_has_customer: bool = false
# default set of dialog
var default_dialog: Array = []

var tutorial_has_played = false
#region tutorial_dialog
const tutorial_dialog: Array[String] = [
		"Tutorial: Hello, and welcome to Pour Some Love!",
		"Tutorial: We already have a customer, but let's ignore him for a moment as we introduce you to our game!",
		"Tutorial: Saigon, our main character, has recently purchased a coffee shop to fulfill her dreams of being a barista!",
		"Tutorial: It was a great deal, mostly because it's not entirely hers; the *$ corporation owns the Pour Some Love franchise!",
		"Tutorial: Now we were supposed to have a tutorial section showing this story, but I'm writing this 3 hours before submission deadline, so please, bear with me!",
		"Tutorial: Saigon quickly realized that Head Office has no care for the quality of their drinks, just profit and advertisements!",
		"Tutorial: As such, the shop's menu is only one drink, a Pumpkin Spice Latte!",
		"Saigon: Yeah, that's horrible! Horrible horrible drink!",
		"Tutorial: Please, wait for your turn Saigon, you've plenty of dialogue soon.",
		"Tutorial: ..Anyway! Rebellious Saigon wasn't going to let things be this way, of course!",
		"Tutorial: In this game, customers only want pumpkin spice lattes! But Saigon doesn't want to serve them that, and her composure takes a hit when she does!",
		"Tutorial: Serve too many pumpkin spice lattes in a row, and poor Saigon is liable to have a mental breakdown!",
		"Tutorial: To avoid that, Saigon can sabotage customer's drinks and make them actually taste good! Or so she says, anyway...",
		"Tutorial: For that purpose, you can earn some funds serving the pumpkin spice lattes, then go to the shop and buy new ingredients!",
		"Tutorial: Once the ingredients are purchased, you can change the contents of the drink during the coffee creation process, and if it's anything else than a pumpkin spice latte, Saigon will be happy!",
		"Tutorial: But the customers will notice something off, and will complain to head office for free coupons! Head office will then penalize Saigon's funds, so make sure not to sabotage too many drinks!",
		"Tutorial: You can also expand the coffee shop's menu through the menu expansion screen!",
		"Saigon: Yeah! I'll make that menu so big, nobody will even see those stinky pumpkin BLEGH lattes on there!!",
		"Tutorial: Great enthusiam Saigon!",
		"Tutorial: We didn't implement a win condition yet, so menu expansion is just for fun, despite being the whole theme and goal of the jam. Sorry!",
		"Tutorial: Please enjoy our game!",
		"Tutorial: ...",
		"Saigon: Welcome to Pour Some Love! What can we brew together today?",
		"Customer: I'll have your finest pumpkin spice latte, please.",
		"Saigon: Of course, coming right up!",
]

const introduction_dialog: Array = [
		"Narration: The shop's window clinks gently as Saigon turns the \"Open!\" side of the panel to face outside.",
		"Saigon: Aaaaand done! We're finally ready for our opening day!",
		"Saigon: Once the customers start pouring in, I'll finally be able to share the joy of artisanal and experimental coffee!",
		"Saigon: Whatever that head office lady says...",
		"Nuttyraphale: Squeek squeeeeek squeek! (Don't worry Saigon, you'll definitely have hordes of coffee fans pouring in any minute now!)",
		"Saigon: No ideas what you said buddy. As usual... but I appreciate the encouragement!",
		#*The door bell chime should play at the end of above text, then a customer appears*		
]

const general_conversation_dialog: Array = [
	[
		"Saigon: Hi, welcome to Pour Some Love! What can we brew together today?",
		"{customer}: O-Oh... hello.. I saw the ad outside about a newly opened Pour Some Love location, is this it?",
		"Saigon: Yes ma'am! This is Pour Some Love, where there's no limits to the art of the brew! Together, we can explore new flavours and go where no taste bud has gone!",
		"Saigon's thoughts: Hah... I did it, I said it perfectly! All that practice is paying off.. they're going to order something so creative for sure!",
		"{customer}: Err.. oooooookay.. well, do you think.. do you think I could get a pumpkin spice latte? Like the one in the ad! It seemed so delicious..",
		"Saigon: ...",
		#*A -1 composure should happen here*
		"Saigon: But of course, coming right up for you ma'am!",
		"Nuttyraphale: Squeek, squeek squeeek? (Saigon, do you even remember how that machine works?)",
		"Saigon: Shush Nutty, I have a.. pumpkin spice latte.. to make. Should be easy, I just need to pour the pumpkin, the spice, and the latte. Nothing's easier.. or more boring..",
	],
	[
		#*Door bell chime, customer appears*
		"Saigon: Oh! Welcome to Pour Some Love! What can I.. uh, what can we brew together today?",
		"{customer}: Oh, you must be new here.",
		"Saigon: The entire shop is new, sir!",
		"{customer}: Oh really? I wouldn't have guessed, what with the fresh paint outside staining my boots!",
		"Saigon: Oh, uh.. I'm sorry?",
		"{customer}: I bet you are. Anyway, get me a pumpkin spice latte, please and thank you.",
		#*A -2 composure should happen here, and the combo meter raises to 2*
		"Saigon: Right, yes, of course, just a minute!",
		"{customer}: Make it less than that, I've got places to be!",
		#*A -4 composure should happen here, and the combo meter raises to 3*
		"Saigon: R-Right....",
	],
	[
		#*Door bell chime, customer appears*
		"Saigon: Welcome to Pour Some Love, what can we brew together today?",
		"{customer}: Pumpkin Spice Latte.",
		#*A -16 composure should happen here, and the combo meter raises to 5*
		"Saigon:... Yes, of course.",
	],
	[
		#*Door bell chime, customer appears*
		"Saigon: Welcome to Pour Some Love..",
		"{customer}: Oh, hello there young lady! I would love it if you could brew me one of those famous pumpkin spice lattes, I hear they're in season! Would you be so kind?",
		"Saigon: Certainly sir, coming right up.",
		"Saigon's thoughts: At least this one is nice..",
	]
]

const serving_drink_dialog: Array = [
	[
		"Saigon: Coming right up, your pumpkin spice latte!",
		"{customer}: Oh wonderful, thank you miss!",
		"Saigon: Of course! Please enjoy the love I've poured for you!",
		"{customer}: Uh.. sure..?",
		"Saigon's thoughts: Such a stupid tagline... but I have to say it..",
		#*Door bell chime, customer leaves*
	],
	[
		"Saigon: Here you go, pumpkin spice latte to go!",
		"{customer}: And not a second too soon. You should respect your customer's time more! The Pour Some Love branch in my hometown would've served it faster!",
		#*A -8 composure should happen here, and the combo meter raises to 4*
		"Saigon: Apologies.. please enjoy the love I've poured.. he's gone..",
		#*Door bell chime, customer leaves*
		"Saigon:..No, I'm okay. I can't let this get to me. I'll have great regulars in no time!",

	],
	[
		"Saigon: Here you are. Please enjoy the love I've poured for you today.",
		"{customer}: At this price? That's plain robbery. If you want me to enjoy it, it should really be half that price. Your competitors sell it cheaper!",
		#*A -32 composure should happen here, and the combo meter raises to 6*
		"Saigon: I'm sorry sir, all prices are set by head office. You can peruse the other items on the menu if you want, they're cheaper and I'll be happy to make you another dri-",
		"{customer}: No, I want a pumpkin spice latte. Ah, forget it, I'll just call head office, they always give me coupons when I complain! Better hope it doesn't come back down on you!",
		#*Door bell chime, customer leaves*
		"Saigon:...",
		"Saigon:.....",

	],
	[
		"Saigon: Here's your drink, please enjoy it!",
		"{customer}: I'll try! Sure would be easier if you smiled a little more, young lady. You'd be so much prettier!",
		#*A -64 composure should happen here, and the combo meter raises to 7*
		"{customer}: Anyway, goodbye!",
		#*door bell chimes, customer leaves*
	]
]

const tutorial_game_over_dialog = [
		"Narration: *The shop's window clinks once more, not so gently this time, as Saigon closes shop early*",
		"Saigon: Okay.. breathe in.. breathe out.. I need, I need a moment. This can't go on!",
		"Saigon: I just.. I just don't get it. I spent so long on making an appealing menu, full of my perfectly hand-crafted drinks...",
		"Saigon: And they just.. they keep ordering pumpkin spice lattes! The one drink on the menu forced by Head Office!",
		"Saigon: Those drinks, they're.. they're HORRIBLE!! The taste is all off, it's like watered down pumpkin juice!",
		"Saigon: Which wouldn't be so bad if it wasn't for the disgustingly thick whipped cream and the stupid amount of sugar!",
		"Saigon: They're just drinking expensive sugar water with shaving cream! It doesn't make any sense!!",
		"Saigon: It's.. it's even more expensive than my other drinks.. I thought by making them cheaper I could compete with the advertisements from head office.. but nobody even looked at the menu before ordering!",
		"Saigon: I thought I had finally achieved my dream of owning a coffee shop, and being a franchised store in the *$ corporation was just a small hickup..",
		#*A phone ringing sound happens here*
		"Saigon: Oh, it's head office.. I better pick up..",
		"Saigon: Hello?",
		"Head Office Lady: Hello, this is Francine. Am I speaking to the manager of branch number 751?",
		"Saigon: Y-Yes, that's me! Nice to meet you, Fra-",
		"Francine: I have been informed that you have not met the required logged hour count for this period. Is this correct?",
		"Saigon: Yes ma'am!",
		"Francine: You are reminded that your franchise of the *$ corporation must remain open for the full twelve hour period it is mandated.",
		"Saigon: Oh.. Yes, of course.. I'm sorry Francine, I just go so tired of everyone ordering the same drink, I needed a pause!",
		"Francine: The *$ corporation finds the most value within our Pumpkin Spice Latte home blend of real pumpkin, signature espresso and spiced whipped cream. You would do well do take this to heart.",
		"Francine: Furthermore, it has come to my attention that you have appended your provided menu with additional drinks underpricing the Pumpkin Spice Latte home blend. Is this correct?",
		"Saigon: Oh, yeah, about that.. I wanted to offer some variety of my own home blends, and thought it could be nice options at a cheaper price, to bring in the people! But nobody ordered it...",
		"Francine: And it will remain as such. Your menu has been updated to reflect proper corporate guideline, as you may not compete directly with the Pumpkin Spice Latte home blend.",
		"Saigon: No! My.. my menu! Why would you remove my drinks from there? Nobody even ordered them!",
		"Francine: It is corporate guideline. That is all.",
		"Francine: This concludes my business with branch number 751's manager. May your day be full of love!",
		#*A phone hanging up sound happens here*
		"Saigon: ... ... ...",
		"Saigon: *sigh*",
		"Squeekly: Squeek. (Saigon.)",
		"Squeekly: Squeeeeeeeek. (Saiiiigoooooooon.)",
		"Saigon: What do you want, Squeekley?",
		"Squeekly: The mean head office lady. You can take her on at her own game. Look at this..",
		"Narration: *Squeekly leaves shortly and climbs back on the counter, holding in his mouth a suspiciously large stack of paper, bookmarked*",
		"Saigon: What are you doing, what's this?",
		"Narration: *Saigon grabs the stack of papers and turns it to the bookmarked page. On it, a section is circled in messy highliner*",
		"Saigon: \"... head office reserves the right to remove any menu item in Direct Competition with the Pumpkin Spice Latte.. See section 52A on \"Direction Competition\"",
		"Saigon: 52A, 52A, 52A... 51.. 52, 52A!",
		"Saigon: \"any menu item advertised as a replacement for Pumpkin Spice Latte, priced lower than Pumpkin Spice Latte, or proposed instead of Pumpkin Spice Lattes are considered in Direct Competition\"",
		"Squeekly: Squeek. (You know what that means, Saigon.)",
		"Saigon: Hey, this gives me an idea..",
		"Saigon: This doesn't say anything about putting items on the menu at the same price as a pumpkin spice latte! So now all I have to do..",
		"Nuttyraphale: Squeek, squeek squeek! (You put some of your own items back, at the same price as a Pumpkin Spice Latte, and compete through your superior flavour!)",
		"Saigon: ..is put some of my own items back.. so many of them, that the menu expands forever and ever and ever, and nobody can find the stupid pumpkin BLEGH latte on there!",
		"Squeekly: Squeak, squeak.. (Yess... you're starting to see..)",
		"Saigon: And, and, and.. in the meantime.. if people order those horrible drinks.. I'll sabotage them! With good tasting ingredients, for once!",
		"Nuttyraphale: Squeeeek... (Oh, Saigon.. you shouldn't break the rules like that!)",
		"Saigon: You're right, Nutty! It is a good idea! With your undecypherable but ever understood support, I'm certain I'm making the right call!",
		"Saigon: Tomorrow, we brew!",
		#*transition to a black screen, with the text "The next day...", then transition back to customer service screen*	
]
#endregion

#region all_general_conversation_dialog (exclulde the one on tutorial)
const conversation_at_state_76_100: Array = [
	[
		"Saigon: Welcome to Pour Some Love! What can we brew together today?",
		"{customer}: I'll have your finest pumpkin spice latte, please.",
		"Saigon: Of course, coming right up!"
	],
	[
		"Saigon: Welcome to Pour Some Love! What can we brew together today?",
		"{customer}: Pumpkin Spice Latte.",
		"Saigon: ..Certainly, I'm on it!"
	],
	[
		"Saigon: Welcome to Pour Some Love! What can we brew together today?",
		"{customer}: Oh, love the menu! I'll have something different today.. How about a pumpkin spice latte?",
		"Saigon: Of course!",
		"Saigon's thoughts: ...THAT'S DIFFERENT? Where are you the other days!"
	],
	[
		"Saigon: Welcome to Pour Some Love! What can we brew together today?",
		"{customer}: I'll have the usual.",
		"Saigon: Certainly, pumpkin spice latte, on its way",
		"Saigon's thoughts: ..I have never met this man."
	]
]
	
const conversation_at_state_51_75: Array = [
	[
		"Saigon: Welcome to Pour Some Love! How can I help?",
		"{customer}: I'll have your finest pumpkin spice latte, please.",
		"Saigon: Of course, right away."
	],
	[
		"Saigon: Welcome to Pour Some Love! What would you like to drink?",
		"{customer}: Pumpkin Spice Latte.",
		"Saigon: ..Sure, it's on its way."
	],
	[
		"Saigon: Welcome to Pour Some Love! What can I get you?",
		"{customer}: I'll have the usual.",
		"Saigon: Ah, yes, the usual. Of course."
	],
	[
		"Saigon: Welcome to Pour Some Love! What do you want?",
		"{customer}: What do I want? What kind of question is that? Bit rude..",
		"Saigon: O-oh, sorry, slip of the tongue. What can we brew together today?",
		"{customer}: That's better. How about a pumpkin spice latte?",
		"Saigon: ..Certainly.",
		"Saigon's thoughts: Why so rude?"
	]
]

const conversation_at_state_26_50: Array = [
	[
		"Saigon: Welcome, how can I help you..?",
		"{customer}: Oh, I'll have a uh, pumpkin spice latte?",
		"Saigon: Sounds about right."
	],
	[
		"Saigon: Hello and welcome..",
		"{customer}: I'll have a pumpkin spice latte.. but maybe you need it more than me?",
		"Saigon: No, I'm good, thank you. Yours is coming up."
	],
	[
		"Saigon: Hi, welcome to Pour Some Love.",
		"{customer}: Do you serve pumpkin spice lattes here?",
		"Saigon: What do you think?",
		"{customer}:..yes?",
		"Saigon: It's.. on the way.."
	],
	[
		"Saigon: Welcome to.. Pour Some Love.. What can we brew.. together today..",
		"{customer}: You don't seem okay.",
		"Saigon: I assure you, I am doing.. awesome.",
		"{customer}: Oh, okay! I'll have a pumpkin spice latte, please!",
		"Saigon's thoughts: I am not okay."
	]
]

const conversation_at_state_1_25: Array = [
	[
		"Saigon: Welcome..",
		"{customer}: Uhh, are you okay?",
		"Saigon: Your order, please..",
		"{customer}: Oh, uh, a pumpkin sp-",
		"Saigon: Pumpkin spice latte, coming right up.."
	],
	[
		"Saigon: ...",
		"{customer}: Pumpkin.",
		"Saigon: ...",
		"{customer}: Spice.",
		"Saigon: ...",
		"{customer}: Latte.",
		"Saigon: ..."
	],
	[
		"Saigon: Here's another..",
		"{customer}: Hello my good madam, I would be in your debt if you could serve me a simple pumpkin spice latte!",
		"Saigon: ..yes, of course."
	],
	[
		"Saigon: Welcome to Pumpkin Spice Latte..",
		"{customer}: Hi, yes, can I have a Pour Some Love please?",
		"Saigon: PSL, coming right up"
	]
]
#endregion

#region all_good_drink_dialog (exclude the one on tutorial)
const good_drink_76_100: Array = [
	[        
		"Saigon: Here's your drink! Please enjoy the love I've poured for you today!",
		"{customer}: o..okay? Thank you..",],
	[
		"Saigon: Your pumpkin spice latte, coming right up! Please enjoy the love I've poured for you today!",
		"{customer}: Aw, thank you miss! I will!",		
	],
	[
		"Saigon: Here you go, pumpkin spice latte! Please enjoy the love I've poured for you today!",
		"{customer}: Uh, sure I will. Good day.",		
	],
	[
		"Saigon: Pumpkin spice latte, here and ready! Please enjoy the love I've poured for you today!",
		"{customer}: Oh, that was fast. And it smells great! Thank you!",		
	]
]

const good_drink_51_75: Array = [
	[        
		"Saigon: Here's your latte, just what you ordered!",
		"{customer}: Perfect, thank you!",
	],
	[
		"Saigon: Pumpkin spice latte, as you wished!",
		"{customer}: About time!",		
	],
	[
		"Saigon: The usual, coming right up!",
		"{customer}: Oh, this is my first time here actually. But this drink might become my usual, I love it!",
		"Saigon's thoughts: Oh, I sure hope it doesn't..",		
	],
	[
		"Saigon: Your drink, ready to go.",
		"{customer}: Finally, a good drink. Thank you!",		
	]
]

const good_drink_26_50: Array = [
	[        
		"Saigon: Here's your drink.",
		"{customer}: Just as I like it. Aren't these great?",
		"Saigon: Yes.",
		"Saigon's thoughts: No.",
	],
	[
		"Saigon: Here's your order.",
		"{customer}: About time, I gotta bounce!",
		"Saigon's thoughts: ..please trip and spill the horrible concoction from hell..",		
	],
	[
		"Saigon: Your coffee.",
		"{customer}: Thank you.",
		"Saigon: You're welcome.",
	],
	[
		"Saigon: The drink you've ordered.",
		"{customer}: Are you sure that's what I ordered?",
		"Saigon: Yes.",
		"{customer}: Oh, okay, thank you!",
		"Saigon: ..I didn't do anything wrong with that one, did I? Maybe I should have.. Would've felt good, at least.",
	]
]

const good_drink_1_25: Array = [
	[        
		"Saigon: Here you go..",
		"{customer}: Nice drink! A nice smile would be a great topping, however!",
		"Saigon: You may leave.",
	],
	[
		"Saigon: Here's your latte...",
		"{customer}: Are you fit to work?",
		"Saigon: Of course.",
		"Saigon's thoughts: Of course not.",	
	],
	[
		"Saigon:...",
		"{customer}:...",
	],
	[
		"Saigon: Here it is..",
		"{customer}: Thank.. you?",
	]
]
#endregion

#region all_bad_drink_dialog (exclude the one on tutorial)
const bad_drink_76_100: Array = [
	[        
		"Saigon: Here's a delicious drink for you! Please enjoy the love I've poured for you today!",
		"{customer}: Are you sure this is what I ordered..? Actually, nevermind, this tastes great, it's definitely what I ordered!",
		"Saigon's thoughts: Of course it is.. hah! Get served!",
	],
	[
		"Saigon: Here's the drink of your dreams! Please enjoy the love I've poured for you today!",
		"{customer}: Really? It smells off.. ah, it smells good though, so whatever. New blend?",
		"Saigon: You could call it that!",	
	],
	[
		"Saigon: Perfect drink, just for you! Please enjoy the love I've poured for you today!",
		"{customer}: This.. is not what I ordered. Or, well, is it?",
		"Saigon: It's exactly what you ordered, good sir!",
		"{customer}: Well then. Alright!",
	],
	[
		"Saigon: Just what you ordered! Please enjoy the love I've poured for you today!",
		"{customer}: Oh yeah, that smells exactly like a pumpkin spice latte! Thank you!",
		"Saigon's thoughts: ..and the fell for it again award goes to..",
	]
]

const bad_drink_51_75: Array = [
	[        
		"Saigon: Your magnificient drink, ready to go.",
		"{customer}: Finally, someone who can do a good pumpkin spice latte. Truly tastes exactly like the best of $*'s classic pumpkin spice latte!",
		"Saigon's thoughts: You.. you know NOTHING!!",
	],
	[
		"Saigon: The drink of your dreams, just for you",
		"{customer}: This tastes nothing like a pumpkin spice latte.",
		"Saigon: Oh, but it does, as it is one!",
		"{customer}: Ah, no point arguing about it..",
	],
	[
		"Saigon: The perfect concoction, here to please!",
		"{customer}: Oh, so you think pumpkin spice lattes are the perfect concoction, too? Twins!!",
		"Saigon's thoughts: I hate it here.",	
	],
	[
		"Saigon: The tastiest pumpkin spice latte in town, coming right up!",
		"{customer}: Oh, this tastes different.. is there a special ingredient in here? I love it!",
		"Saigon: You could call it that! You sure could..",	
	]
]

const bad_drink_26_50: Array = [
	[        
		"Saigon: Here comes your drink!",
		"{customer}: My drink? Well, must be, I'm the only one here. Thank you!",
		"Saigon's thoughts: You are.. just oh so welcome.",
	],
	[
		"Saigon: Your order, blended to perfection!",
		"{customer}: I ordered this? I actually don't remember what I ordered. Do you have receipts?",
		"Saigon: No, they don't fit the corporation's environmental goals, I think",
		"{customer}: I don't know if that's legal..",
		"Saigon's thoughts: It really isn't..",
	],
	[
		"Saigon: Enjoy your beautiful drink!",
		"{customer}: Is there really beauty to be found in such a generic drink?",
		"Saigon's thoughts: Why would you order it if you think that...",
	],
	[
		"Saigon: Here's your drink!",
		"{customer}: Awesome, just what I ordered. Thank you!",
		"Saigon: You're welcome!",
		"Saigon's thoughts: Oh, oh so welcome..",
	]
]

const bad_drink_1_25: Array = [
	[        
		"Saigon: Hope you enjoy the bestest drink eveeeeer!",
		"{customer}: Oh, you look cheery! Of course I will!",
		"Saigon's thoughts: Of course you will! I'm a great barista! Way better than this place deserves!",
	],
	[
		"Saigon: Here comes a legendary brew!",
		"{customer}: Oh, this.. doesn't smell like what I ordered.",
		"Saigon's thoughts: SERVES YOU RIGHT!",
	],
	[
		"Saigon: I finally did it! I made the ultimate pumpkin spice latte!",
		"{customer}: Is this what that tastes like?",
		"Saigon's thoughts: NO! THIS TASTES WAY BETTER!",
	],
	[
		"Saigon: Oh no, I messed up your order!",
		"{customer}: Oh, can you redo it?",
		"Saigon: NO! But if you call head office to complain, ask for Francine and complain a looooooooooot, she'll give you a coupon!",
		"{customer}: w..what?",
		"Saigon: Make sure to really vent to her, tell her how you feel, how HORRIBLE the service was!!",
		"{customer}: I'm.. just gonna go.. the drink tastes better than what I ordered anyway..",
		"Saigon: YOU BET IT DOES!",
	]
]
#endregion

const game_over_dialog: Array[String] = [
	"Narration: The shop's window clinks once more, not so gently this time, as Saigon closes shop early",
	"Saigon: This.. okay, this is NOT happening! I don't care what penalties I get, I NEED A BREAK!!"
]

# Extract SpeakerName, Dialogue from the {customer} and Player
func extract_line(line: String) -> Dictionary:
	var line_info := line.split(":", false, 2) # split into max 2 parts
	if line_info.size() < 2:
		push_error("Invalid line format, missing ':' → " + line)
		return {}
	
	#Extract the info and remove trailing space
	var speaker_name := line_info[0].strip_edges()
	var dialog := line_info[1].strip_edges()
	
	#Check for the value of speaker_name and dialog to make sure they are not empty
	if speaker_name == "" or dialog == "":
		push_error("Invalid line format, empty speaker or dialog → " + line)
		return {}
	
	return {
		"speaker_name": speaker_name,
		"dialog": dialog
	}
	
# Get the current customer index
func get_current_customer_index(customer_i: int) -> void:
	customer_index = customer_i

# Get the current line of the dialog	
func get_current_dialog_speaker_and_dialog() -> Dictionary:
	var current_line = current_dialog[dialog_index]
	var current_speaker_and_dialog = extract_line(current_line)
	return current_speaker_and_dialog

func get_tutorial_dialog():
	current_dialog = tutorial_dialog 
	#var temp_dialog: Array = tutorial_dialog
	# Convert to Array[String] explicitly
	#current_dialog.clear()
	#for line in temp_dialog:
	#	if typeof(line) == TYPE_STRING:
	#		current_dialog.append(line)
	# Dictionary of variables to replace inside dialog lines
	#var variables: Dictionary = {
	#	"customer": customer_name
	#}
	#format_dialog(current_dialog, variables)
	
# Get the dialog for game over
func get_gameover_dialog():
	current_dialog = game_over_dialog
	
# Selects a random dialog set for a given customer, 
# replaces placeholders (like {customer}) with actual values, 
# and stores the result in `current_dialog`.
func get_current_customer_name(customer: String):
	customer_name = customer


# Selects what dialog to use for conversation
func get_conversation_dialog():
	var temp_dialog: Array = pick_random_dialog(pick_from_set())
		# Convert to Array[String] explicitly
	current_dialog.clear()
	for line in temp_dialog:
		if typeof(line) == TYPE_STRING:
			current_dialog.append(line)
	# Dictionary of variables to replace inside dialog lines
	var variables: Dictionary = {
		"customer": customer_name
	}
	format_dialog(current_dialog, variables)
	
# Determine which set of dialog to be use, those array of hardcode dialogs.
func pick_from_set() -> Array:
	var is_good_drink = Global.is_good_drink
	if drink_ready:
		if is_good_drink:
			match Global.curr_composure:
				_ when Global.curr_composure >= 75:
					return good_drink_76_100
				_ when Global.curr_composure >= 50:
					return good_drink_51_75
				_ when Global.curr_composure >= 25:
					return good_drink_26_50
				_ when Global.curr_composure < 25:
					return good_drink_1_25
		else:
			match Global.curr_composure:
				_ when Global.curr_composure >= 75:
					return bad_drink_76_100
				_ when Global.curr_composure >= 50:
					return bad_drink_51_75
				_ when Global.curr_composure >= 25:
					return bad_drink_26_50
				_ when Global.curr_composure < 25:
					return bad_drink_1_25
	else:
		match Global.curr_composure:
			_ when Global.curr_composure >= 75:
				return conversation_at_state_76_100
			_ when Global.curr_composure >= 50:
				return conversation_at_state_51_75
			_ when Global.curr_composure >= 25:
				return conversation_at_state_26_50
			_ when Global.curr_composure < 25:
				return conversation_at_state_1_25
	return default_dialog
	
# Formats a dialog set by replacing placeholders with variable values.
# Example: "{customer}" → "CustomerA"
func format_dialog(dialog: Array[String], variables: Dictionary) -> void:
	var result: Array[String] = []
	for line in dialog:
		result.append(line.format(variables)) # Replace placeholders
		current_dialog = result
		print(current_dialog)

# Picks a random set of dialog lines from a larger collection of dialog sets.
# If `dialog_sets` is empty, return an empty array.
func pick_random_dialog(dialog_sets: Array) -> Array:
	if dialog_sets.is_empty():
		return []
	
	# Get a random index and return that dialog set
	var random_index = randi() % dialog_sets.size()
	return dialog_sets[random_index]
	
func state_reset() -> void:
		dialog_index = 0
		customer_index = 0
		customer_name = "default"
		current_dialog = []
		drink_ready = false
		current_has_customer = false
		default_dialog = []	
	
