////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.
import UIKit
import Foundation

class Chancemaker {
}

extension Chancemaker : cookieClickerUpgrade {
	var name: String {
		return "Chance Maker"
	}

	var logo: UIImage {
		return UIImage(named: "ChanceMaker")!
	}

	var baseCost: Int {
		return 26000000000000000
	}

	var cookPerUnitPerSecond: Double {
		return 21000000000
	}

	var description: String {
		return "Generates cookies out of thin air through sheer luck."
	}


}
