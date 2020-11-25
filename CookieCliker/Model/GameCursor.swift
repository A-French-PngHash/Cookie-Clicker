////This file was created on 23/08/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit

class Cursor {
}

extension Cursor: cookieClickerUpgrade {
	var name: String {
		return "Cursor"
	}

	var logo: UIImage {
		return UIImage(named: "cursor")!
	}
	var baseCost: Int {
		return 15
	}

	var cookPerUnitPerSecond: Double {
		return 0.1
	}

	var description: String {
		return "Autoclick for you once every 10 seconds"
	}

}
