////This file was created on 28/08/2019 by Titouan Blossier. Do not reproduce without permission.

import Foundation

class SaveServices {
	static let shared = SaveServices()
	private init() { }

	var initialLoad = 0
	var game = Game() //This property will be the only instance of game. Value of this instance will change to accord to the actual "game" loaded

	var names : Array<String> {
		get {
			if let returnValue = UserDefaults.standard.object(forKey: "games") as? Array<String> {
				return returnValue
			}
			saveValue(forKey: "games", value: "My First Game")
			return ["My First Game"]
		}
		set {
			saveValue(forKey: "games", value: newValue)
		}
	}

	 var actualGame : Int {
		get {
			if let actual = UserDefaults.standard.object(forKey: "actualGame") as? Int {
				if actual > names.count - 1 {
					saveValue(forKey: "actualGame", value: names.count - 1)
					return names.count - 1
				} else if actual < 0 {
					saveValue(forKey: "actualGame", value: 0)
					return 0
				}
				return actual
			}
			saveValue(forKey: "actualGame", value: 0)
			return 0
		}

		set {
			saveValue(forKey: "actualGame", value: newValue)
		}
	}

	func createNewGame(name : String) {
		names.append(name)
		loadGame(withName: name)
	}

	private func changeActualGame(name : String) {
		for i in 0...names.count - 1 {
			if names[i] == name {
				actualGame = i
			}
		}
	}

	func loadGame(withName : String) { //You can load this function even if all information are not well in memory, there is default value

		changeActualGame(name: withName) //HERE WE NEED TO CHANGE THE ACTUAL GAME

		if getValue(forKey: names[actualGame]) is Array<Any> {
			print("value was well in memory")
		} else {
			print("value was corrupted or inexistant in memory")
			var buildings = [Int]()
			for _ in 0...14 {
				buildings.append(0)
			}
			saveValue(forKey: names[actualGame], value: [0, buildings])
		}
		let returnValue : Array<Any> = getValue(forKey: names[actualGame]) as! Array<Any>
		game.loadNew(data: returnValue)
	}

	func deleteGame(index : Int) {
		names.remove(at: index)
		if index == 0 {
		} else if index >= names.count - 1{
			actualGame -= 1
		}
		print(actualGame, names)
		loadGame(withName : names[actualGame])
	}

	func renameGAme(index : Int, newName: String) {
		let value = getValue(forKey: names[index]) //Getting data
		deleteValue(key: names[index]) //Deleting data with the previous name key
		names[index] = newName //Changing name
		saveValue(forKey: names[index], value: value) //Saving data with the new key
	}

	func saveData() {
		let saveArray : Array<Any> = [game.score, game.numberOfUpgrade]
		print("save score : \(game.score)")
		saveValue(forKey: names[actualGame], value: saveArray)
		saveValue(forKey: "actualGame", value: actualGame)
	}

	func deleteValue(key : String) {
		UserDefaults.standard.removeObject(forKey: key)
	}
	private func saveValue(forKey key: String, value : Any) {
		UserDefaults.standard.set(value, forKey: key)
	}
	func getValue(forKey key: String) -> Any {
		return UserDefaults.standard.object(forKey: key) as Any
	}
}

//The value that was last saved is deleted (possibilité de bug du simulateur)

