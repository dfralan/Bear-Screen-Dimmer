import SwiftUI

@main
struct TransparentOverlayApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        // Keep scene empty – we're manually managing the window
        Settings {
            EmptyView()
        }
    }
}
