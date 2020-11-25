////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.
import UIKit
import Foundation

class AntimatterCondenser {

}

extension AntimatterCondenser : cookieClickerUpgrade {
	var name: String {
		return "Antimatter Condenser"
	}

	var logo: UIImage {
		return UIImage(named: "AntimatterCondenser")!
	}

	var baseCost: Int {
		return 170000000000000
	}

	var cookPerUnitPerSecond: Double {
		return 430000000
	}

	var description: String {
		return "Condenses the antimatter in the universe into cookies."
	}


}
