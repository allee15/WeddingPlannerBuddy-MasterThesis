//
//  WeddingPlannerBuddyWidgetLiveActivity.swift
//  WeddingPlannerBuddyWidget
//
//  Created by Alexia Aldea on 30.01.2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WeddingPlannerBuddyWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WeddingPlannerBuddyWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WeddingPlannerBuddyWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WeddingPlannerBuddyWidgetAttributes {
    fileprivate static var preview: WeddingPlannerBuddyWidgetAttributes {
        WeddingPlannerBuddyWidgetAttributes(name: "World")
    }
}

extension WeddingPlannerBuddyWidgetAttributes.ContentState {
    fileprivate static var smiley: WeddingPlannerBuddyWidgetAttributes.ContentState {
        WeddingPlannerBuddyWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WeddingPlannerBuddyWidgetAttributes.ContentState {
         WeddingPlannerBuddyWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WeddingPlannerBuddyWidgetAttributes.preview) {
   WeddingPlannerBuddyWidgetLiveActivity()
} contentStates: {
    WeddingPlannerBuddyWidgetAttributes.ContentState.smiley
    WeddingPlannerBuddyWidgetAttributes.ContentState.starEyes
}
