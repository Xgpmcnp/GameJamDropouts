extends Control

var mainMenu = 1;
var mmenuAssets =  ["cup","cup2","cup3","cup4","cup5","cup6","cup7","cup8","cup9",
"cup10","cup11","cup12","cup13","cup14","cup15","cup16","cup17","cup18","cup19",
"cup20","cup21","cup22","cup23","cup24","cup25","cup26","cup27","cup28","cup29",
"cup30","cup31","cup32","cup33","cup34","cup35","cup36","cup37","cup38","cup39",
"cup40","cup41","cup42","cup43","cup44","cup45","cup46","cup47","cup48","cup49",
"cup50","cup51","cup52","cup53","cup54","cup55","cup56","cup57","cup58","cup59",
"cup60","cup61","cup62","cup63","cup64","cup65","cup66","cup67","cup68","cup69",
"cup70","cup71","cup72","cup73","cup74","cup75","cup76","cup77","cup78","cup79",
"cup80","cup81","cup82","cup83","cup84","cup85","cup86","cup87","cup88","cup89",
"cup90","cup91","cup92","cup93","cup94","cup95","cup96","cup97","cup98","cup99",
"cup100","cup101","cup102","cup103",
"bean","bean2","bean3","bean4","bean5","bean6","bean7","bean8","bean9",
"bean10","bean11","bean12","bean13","bean14","bean15","bean16","bean17","bean18","bean19",
"bean20","bean21","bean22","bean23","bean24","bean25","bean26","bean27","bean28","bean29",
"bean30","bean31","bean32","bean33","bean34","bean35","bean36","bean37","bean38","bean39",
"bean40","bean41","bean42","bean43","bean44","bean45","bean46","bean47","bean48","bean49",
"bean50","bean51","bean52","bean53","bean54","bean55","bean56","bean57","bean58","bean59",
"bean60","bean61","bean62","bean63","bean64","bean65","bean66","bean67","bean68","bean69",
"bean70","bean71","bean72","bean73","bean74","bean75","bean76","bean77","bean78","bean79",
"bean80","bean81","bean82","bean83","bean84","bean85","bean86","bean87","bean88","bean89",
"bean90","bean91","bean92","bean93","bean94","bean95","bean96","bean97","bean98","bean99",
"bean100"]
func _process(delta: float) -> void:
	for i in mmenuAssets:				#this for loop iterates through the above array and moves the assets
		get_node(i).position += Vector2(0.3,0.3)	 #0.3px down right is an arbitrary value, the higher it is the faster it goes.
		if get_node(i).position.y >= 350:	 #y350 is around when assets become offscreen
			get_node(i).position -= Vector2(772, 772)	 #pushing back x772y772 feels the smoothest in my experience!
