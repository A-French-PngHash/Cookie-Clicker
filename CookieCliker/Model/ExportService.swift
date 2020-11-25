////This file was created on 30/08/2019 by Titouan Blossier. Do not reproduce without permission.

import Foundation

class ExportService {
	static var shared = ExportService()
	private init() { }

	var save = SaveServices.shared

	func export() -> String {
		let value = save.getValue(forKey: save.names[save.actualGame]) as! Array<Any>
		let stringScore = "\(floor(value[0] as! Double))"
		let buildings = value[1] as! Array<Int>
		var digits = stringScore.compactMap{ $0.wholeNumberValue }
		digits.removeLast() //Remove the .0 after the score
		var returnString = "\(save.names[save.actualGame])1"
		
		var letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

		for i in 0...digits.count - 1 {
			if Int.random(in: 1...2) == 1 {
				returnString = "\(returnString)\(letters[digits[i]])"
			} else {
				returnString = "\(returnString)\(letters[digits[i]+10])"
			}
		}

		for i in 0...buildings.count - 1 {
			returnString = "\(returnString)1"
			let string = "\(buildings[i])"
			let digitBuilding = string.compactMap{ $0.wholeNumberValue }

			for c in 0...digitBuilding.count - 1 {
				if Int.random(in: 1...2) == 1 {
					returnString = "\(returnString)\(letters[digitBuilding[c]])"
				} else {
					returnString = "\(returnString)\(letters[digitBuilding[c]+10])"
				}
			}
		}
		return returnString
	}
}
