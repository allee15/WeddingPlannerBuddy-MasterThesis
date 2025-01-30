//
//  WeddingPlannerBuddyWidgetBundle.swift
//  WeddingPlannerBuddyWidget
//
//  Created by Alexia Aldea on 30.01.2025.
//

import WidgetKit
import SwiftUI

@main
struct WeddingPlannerBuddyWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeddingPlannerBuddyWidget()
        WeddingPlannerBuddyWidgetControl()
        WeddingPlannerBuddyWidgetLiveActivity()
    }
}
