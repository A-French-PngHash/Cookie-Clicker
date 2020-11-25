////This file was created on 25/08/2019 by Titouan Blossier. Do not reproduce without permission.

import Foundation
import UIKit

class WizardTower {

}

extension WizardTower : cookieClickerUpgrade {
	var name: String {
		return "Wizard Tower"
	}

	var logo: UIImage {
		return UIImage(named: "WizardTower")!
	}

	var baseCost: Int {
		return 330000000
	}

	var cookPerUnitPerSecond: Double {
		return 44000
	}

	var description: String {
		return "Summons cookies with magic spells."
	}


}
