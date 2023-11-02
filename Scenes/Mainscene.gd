extends Node2D

var database = PostgreSQLClient.new()

var user = "vjtetiso"
var password = "UkLFQ8AhWtBdS14t9VhrUeF5Bj13aQWx"
var host = "cornelius.db.elephantsql.com"
var port = 5432
var databaseConnection = "vjtetiso"

func _ready():
	#database.connect("connection_established",self,"selectFromDB")
	database.connect("connection_error",self,"error")
	database.connect("connection_closed",self,"closedConnection")
	
	database.connect_to_host("postgresql://%s:%s@%s:%d/%s" % [user, password, host, port, databaseConnection])

func insertIntoDB(id, username, email, adgangskode):
	print("running select query")
	
	var data = database.execute("""
	BEGIN;
	INSERT INTO login (id, username, email, adgangskode) values (%s, '%s', '%s', '%s');
	commit;
	""" % [id, username, email, adgangskode])
	
	#database.close()


func selectFromDB():
	print("running select query")
	
	var data = database.execute("""
	BEGIN;
	SELECT * FROM login
	""")
	
	for d in data[1].data_row:
		print(d)
	#database.close()


func _process(delta):
	database.poll()

func closedConnection():
	print("database has closed")

func _exit_tree():
	database.close()
	


func _on_Button_button_down():
	insertIntoDB($TextEdit.text,$TextEdit2.text,$TextEdit3.text,$TextEdit4.text)
	get_tree().change_scene("res://Scenes/Login.tscn")


func _on_Button2_button_down():
	selectFromDB()
	pass # Replace with function body.
