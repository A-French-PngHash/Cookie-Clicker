////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.

import Foundation
import UIKit
class AlchemyLab {
}

extension AlchemyLab: cookieClickerUpgrade {
	var name: String {
		return "Alchemy Lab"
	}

	var logo: UIImage {
		return UIImage(named: "AlchemyLab")!
	}

	var baseCost: Int {
		return 75000000000
	}

	var cookPerUnitPerSecond: Double {
		return 1600000
	}

	var description: String {
		return "Turns gold into cookies!"
	}


}
