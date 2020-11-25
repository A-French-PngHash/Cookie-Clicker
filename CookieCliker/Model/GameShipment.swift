////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.
import UIKit
import Foundation

class Shipment {

}

extension Shipment: cookieClickerUpgrade {
	var name: String {
		return "Shipment"
	}

	var logo: UIImage {
		return UIImage(named: "Shipment")!
	}

	var baseCost: Int {
		return 5100000000
	}

	var cookPerUnitPerSecond: Double {
		return 260000
	}

	var description: String {
		return "Brings in fresh cookies from the cookie planet."
	}


}
