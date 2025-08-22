//
//  CurrencyTip.swift
//  LTORConverter
//
//  Created by Javier Jara Montoya on 31/7/25.
//

import TipKit
struct CurrencyTip: Tip {
    var title = Text("Change Currency")
    var message: Text? = Text("You can tap the left or right currency")
    var image:Image? = Image(systemName: "hand.tap.fill")
}
