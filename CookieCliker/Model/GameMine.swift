////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.

import Foundation
import UIKit

class Mine {
}

extension Mine : cookieClickerUpgrade {
	var name: String {
		return "Mine"
	}

	var logo: UIImage {
		return UIImage(named: "Mine")!
	}

	var baseCost: Int {
		return 12000
	}

	var cookPerUnitPerSecond: Double {
		return 47
	}

	var description: String {
		return "Mines out cookie dough and chocolate chips."
	}


}
