////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.

import Foundation
import UIKit
class Farm{
}

extension Farm : cookieClickerUpgrade {
	var name: String {
		return "Farm"
	}

	var logo: UIImage {
		return UIImage(named: "Farm")!
	}

	var baseCost: Int {
		return 1100
	}

	var cookPerUnitPerSecond: Double {
		return 8
	}

	var description: String {
		return "Grows cookie plants from cookie seeds."
	}


}
