////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.
import UIKit
import Foundation

class Factory {
}

extension Factory: cookieClickerUpgrade {
	var name: String {
		return "Factory"
	}

	var logo: UIImage {
		return UIImage(named: "Factory")!
	}

	var baseCost: Int {
		return 130000
	}

	var cookPerUnitPerSecond: Double {
		return 260
	}

	var description: String {
		return "Produces large quantities of cookies."
	}


}
