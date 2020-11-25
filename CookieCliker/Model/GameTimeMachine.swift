////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.
import UIKit
import Foundation

class TimeMachine {

}

extension TimeMachine : cookieClickerUpgrade {
	var name: String {
		return "Time Machine"
	}

	var logo: UIImage {
		return UIImage(named: "TimeMachine")!
	}

	var baseCost: Int {
		return 14000000000000
	}

	var cookPerUnitPerSecond: Double {
		return 65000000
	}

	var description: String {
		return "Brings cookies from the past, before they were even eaten."
	}


}
