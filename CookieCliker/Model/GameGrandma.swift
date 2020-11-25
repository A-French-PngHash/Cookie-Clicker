////This file was created on 23/08/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit

class GrandMa {
}

extension GrandMa: cookieClickerUpgrade {
	var name: String {
		return "Grandma"
	}

	var logo: UIImage {
		return UIImage(named: "Grandma")!
	}

	var baseCost: Int {
		return 100
	}

	var cookPerUnitPerSecond: Double {
		return 1
	}

	var description: String {
		return "A nice grandma to bake more cookies"
	}

}
