////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.
import UIKit
import Foundation

class Prism {

}

extension Prism : cookieClickerUpgrade {
	var name: String {
		return "Prism"
	}

	var logo: UIImage {
		return UIImage(named: "Prism")!
	}

	var baseCost: Int {
		return 2100000000000000
	}

	var cookPerUnitPerSecond: Double {
		return 2900000000
	}

	var description: String {
		return "Converts light itself into cookies."
	}


}
