////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.
import UIKit
import Foundation

class Bank {

}

extension Bank: cookieClickerUpgrade {
	var name: String {
		return "Bank"
	}

	var logo: UIImage {
		return UIImage(named: "Bank")!
	}

	var baseCost: Int {
		return 1400000
	}

	var cookPerUnitPerSecond: Double {
		return 1400
	}

	var description: String {
		return "Generates cookies from interest."
	}


}
