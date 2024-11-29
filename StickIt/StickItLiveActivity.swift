//
//  StickItLiveActivity.swift
//  StickIt
//
//  Created by Joel Beilis on 2024-11-29.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct StickItAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct StickItLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: StickItAttributes.self) { context in
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

extension StickItAttributes {
    fileprivate static var preview: StickItAttributes {
        StickItAttributes(name: "World")
    }
}

extension StickItAttributes.ContentState {
    fileprivate static var smiley: StickItAttributes.ContentState {
        StickItAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: StickItAttributes.ContentState {
         StickItAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: StickItAttributes.preview) {
   StickItLiveActivity()
} contentStates: {
    StickItAttributes.ContentState.smiley
    StickItAttributes.ContentState.starEyes
}
