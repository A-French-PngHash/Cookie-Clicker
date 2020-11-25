////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.
import  UIKit
import Foundation

class Portal {

}

extension Portal : cookieClickerUpgrade {
	var name: String {
		return "Portal"
	}

	var logo: UIImage {
		return UIImage(named: "Portal")!
	}

	var baseCost: Int {
		return 1000000000000
	}

	var cookPerUnitPerSecond: Double {
		return 10000000
	}

	var description: String {
		return "Opens a door to the cookieverse."
	}
}
