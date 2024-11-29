//
//  StickItBundle.swift
//  StickIt
//
//  Created by Joel Beilis on 2024-11-29.
//

import WidgetKit
import SwiftUI

@main
struct StickItBundle: WidgetBundle {
    var body: some Widget {
        StickIt()
        StickItControl()
        StickItLiveActivity()
    }
}
