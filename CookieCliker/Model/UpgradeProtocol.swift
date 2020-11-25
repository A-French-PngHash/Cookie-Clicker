////This file was created on 23/08/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit
protocol cookieClickerUpgrade {
	var name : String {get}
	var logo : UIImage {get}
	var baseCost : Int {get}
	var cookPerUnitPerSecond : Double {get}
	var description : String {get}
}

// Price=Base cost×1.15M−F (M est le nombre d'améliorations du type déja acheté
