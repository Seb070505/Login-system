extends Node2D


var database = PostgreSQLClient.new()

var user = "vjtetiso"
var password = "UkLFQ8AhWtBdS14t9VhrUeF5Bj13aQWx"
var host = "cornelius.db.elephantsql.com"
var port = 5432
var databaseConnection = "vjtetiso"

var loginSucces = false

func _ready():
	#database.connect("connection_established",self,"selectFromDB")
	database.connect("connection_error",self,"error")
	database.connect("connection_closed",self,"closedConnection")
	
	database.connect_to_host("postgresql://%s:%s@%s:%d/%s" % [user, password, host, port, databaseConnection])


func selectFromDB():
	print("running select query")
	
	var data = database.execute("BEGIN;	SELECT * FROM login WHERE username="+$TextEdit.text+" AND adgangskode= "+$TextEdit2.text)
	
	if data.size()>0:
		print('no access')
	else:
		print('access')
		loginSucces = true
	#for d in data[1].data_row:
	#	print(d)
	#database.close()

func checkDataInDB():
	print("running select query")
	
	var data = database.execute("""
	BEGIN;
	
	""")
	pass


func _process(delta):
	database.poll()

func closedConnection():
	print("database has closed")

func _exit_tree():
	database.close()
	



func _on_Button_button_down():
	get_tree().change_scene("res://Scenes/Mainscene.tscn")


func _on_Button2_button_down():
	selectFromDB()
	if(loginSucces == true):
		get_tree().change_scene("res://Scenes/Login-succes.tscn")
