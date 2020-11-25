////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.
import UIKit
import Foundation

class Temple {

}

extension Temple: cookieClickerUpgrade {
	var name: String {
		return "Temple"
	}

	var logo: UIImage {
		return UIImage(named: "Temple")!
	}

	var baseCost: Int {
		return 20000000
	}

	var cookPerUnitPerSecond: Double {
		return 7800
	}

	var description: String {
		return "Full of precious, ancient chocolate."
	}


}
