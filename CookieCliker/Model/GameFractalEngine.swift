////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.
import UIKit
import Foundation

class FractalEngine {

}

extension FractalEngine : cookieClickerUpgrade {
	var name: String {
		return "Fractal Engine"
	}

	var logo: UIImage {
		return UIImage(named: "cursor")!
	}

	var baseCost: Int {
		return 310000000000000000
	}

	var cookPerUnitPerSecond: Double {
		return 150000000000
	}

	var description: String {
		return "Turns cookies into even more cookies"
	}


}
