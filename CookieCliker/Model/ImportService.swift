import Foundation

class importService {
	static let shared = importService()
	private init(){}

	var gameName = ""

	func importKey(_ key : String) -> (Bool, String){ //Bool is if code is corrupted
		//String is the reason of why the programm think code is corrupted
		let code = key.compactMap{ $0.wholeNumberValue }

		var i = 0
		while code[i] != 1 {
			gameName = "\(gameName)\(code[i])"
			i += 1
		}
		for i in 0...code.count-1 { //Entering name into variable

		}
		if gameName == "" { //Name corrupted
			return (true, "File name corrupted, unable to load")
		}


		return(false, "") //Default return value
	}
}
