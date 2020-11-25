////This file was created on 27/08/2019 by Titouan Blossier. Do not reproduce without permission.

import Foundation
import UIKit
class SaveServices {
	static var shared = SaveServices()
	private init() { }

	var games : Array<Game> = [Game()]
	var game = Game() //Game a les valeurs de la game actuel
	var gamesName : Array<String> = []
	var keysForSave :Array<String> { //autodefine in function of game
		get {
			var returnArray : Array<String> = []
			for _ in 0...games.count - 1 {
				returnArray.append("score")
				returnArray.append("buildings")
			}
			return returnArray
		}
	}

	private var dataToSave : [Any] { //AUTODEFIN in function of games
		get {
			var returnArray = [Any]()
			for i in 0...games.count - 1 {
				returnArray.append(game.score)
				returnArray.append(game.numberOfUpgrade)
			}
			return returnArray
		}
	}

	func delete(_ index : Int) {
		updateGameName()
		//Deleting the game
		var value = getObject("games") as! Array<String>
		value.remove(at: index)
		print("just remove game at index \(index)")
		addObject("games", value: value)
		deletObject("\(gamesName[index])\(keysForSave[0])")
		deletObject("\(gamesName[index])\(keysForSave[1])")
		games.remove(at: index)
		updateGameName()

		//Posibility of failure here LOOOOOL
	}

	func rename(_ index : Int, newName : String) {
		var nameOne : String {
			get {
				return "\(gamesName[index])\(keysForSave[0])"
			}
		}
		var nameTwo : String {
			get {
				return "\(gamesName[index])\(keysForSave[1])"
			}
		}
		let score = getObject(nameOne)
		let upgradeList = getObject(nameTwo)

		deletObject(nameOne)
		deletObject(nameTwo)

		gamesName[index] = newName

		addObject(nameOne, value: score)
		addObject(nameTwo, value: upgradeList)
	}

	func updateGameName() {
		gamesName = getObject("games") as? Array<String> ?? []
		if gamesName == [] {
			gamesName.append("My First Game")
			saveNamedGames()
		}
	}
	func addGame(name : String) {
		updateGameName()
		var value = gamesName
		value.append(name)
		games.append(Game())
		addObject("games", value: value)
		updateGameName()
		print("just added game \(name)")
	}

// 2 * (gameToLad) - 2
	func saveData() {
		let index = 2 * gameLoaded - 2
		changeActualGame(gameLoaded)
		for i in index...index + 1 {
			addObject("\(gamesName[gameLoaded - 1])\(keysForSave[i])", value: dataToSave[i])
		}
		print("succesfully saved games \(gameLoaded) with name : \(gamesName[gameLoaded - 1])")
	}

	func load() -> [Any] {
		var returnArray = [Any]()
		let index = 2 * gameLoaded - 2
		for i in index...index + 1 {
			if UserDefaults.standard.object(forKey: "\(gamesName[gameLoaded - 1])\(keysForSave[i])") == nil { //This script execute only when you first load the game that you want to load.
				saveData() //It save the data so you can load it after
			}
		}
		for i in index...index + 1 {
			returnArray.append(getObject("\(gamesName[gameLoaded - 1])\(keysForSave[i])"))
		}
		return returnArray
	}

	func changeActualGame(_ newGame : Int) {
		UserDefaults.standard.set(newGame, forKey: "lastGameLoaded")
	}


	private func deletObject(_ name : String) {
		UserDefaults.standard.removeObject(forKey: name)
	}

	private func addObject(_ name : String, value : Any) {
		UserDefaults.standard.set(value, forKey: name)
	}
	private func getObject(_ name : String) -> Any {
		return UserDefaults.standard.object(forKey: name) as Any
	}

	func saveNamedGames() {
		addObject("games", value: gamesName)
	}
}

//Save format is : "(nameOfThegame)(keys)" for exemple : "MyGamescore"

//TODO : Find a way to store multiple game
