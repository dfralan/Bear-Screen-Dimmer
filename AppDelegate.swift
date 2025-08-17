import SwiftUI
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    var windows: [NSWindow] = []
    var statusItem: NSStatusItem!
    var isWindowMovable = false
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        // Load and set the bear icon
        if let iconImage = loadBearIcon() {
            iconImage.size = NSSize(width: 18, height: 18)
            statusItem.button?.image = iconImage
        } else {
            // Fallback to emoji if SVG fails to load
            statusItem.button?.title = "🐻"
        }
        
        statusItem.button?.action = #selector(statusBarButtonClicked)
        statusItem.button?.target = self
        
        // Create menu
        let menu = NSMenu()
        
        // Add toggle menu item
        let toggleItem = NSMenuItem(title: "Edit Mode: OFF", action: #selector(toggleEditMode), keyEquivalent: "")
        toggleItem.target = self
        menu.addItem(toggleItem)
        
        // Add new window menu item
        let newWindowItem = NSMenuItem(title: "+ New Overlay", action: #selector(createNewWindow), keyEquivalent: "n")
        newWindowItem.target = self
        menu.addItem(newWindowItem)
        

        
        menu.addItem(NSMenuItem.separator())
        
        // Add quit item
        let quitItem = NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        menu.addItem(quitItem)
        
        statusItem.menu = menu
        
        // Create initial window
        createNewOverlayWindow()
    }
    
    private func loadBearIcon() -> NSImage? {
        // Load the pre-generated ICNS file
        if let iconPath = Bundle.main.path(forResource: "bear-icon", ofType: "icns") {
            return NSImage(contentsOfFile: iconPath)
        }
        
        // Fallback to emoji if ICNS fails to load
        return nil
    }
    
    @objc func toggleEditMode() {
        isWindowMovable.toggle()
        
        // Check if there are any windows before proceeding
        guard !windows.isEmpty else {
            // Update menu item even if no windows exist
            statusItem.menu?.item(at: 0)?.title = isWindowMovable ? "Edit Mode: ON" : "Edit Mode: OFF"
            return
        }
        
        for window in windows {
            if isWindowMovable {
                // Enable resize and drag
                window.styleMask = [.resizable, .miniaturizable, .closable, .titled, .fullSizeContentView]
                window.isMovableByWindowBackground = true
                window.ignoresMouseEvents = false
                statusItem.menu?.item(at: 0)?.title = "Edit Mode: ON"
            } else {
                // Disable resize and drag
                window.styleMask = [.borderless]
                window.isMovableByWindowBackground = false
                window.ignoresMouseEvents = true
                statusItem.menu?.item(at: 0)?.title = "Edit Mode: OFF"
            }
        }
        
        // Notify the content view about the edit mode change
        NotificationCenter.default.post(name: NSNotification.Name("EditModeChanged"), object: isWindowMovable)
    }
    
    @objc func statusBarButtonClicked() {
        // If in edit mode, exit edit mode when clicking the status bar button
        if isWindowMovable {
            toggleEditMode()
        }
    }
    
    func createNewOverlayWindow() {
        let window = NSWindow(
            contentRect: NSRect(x: 200 + CGFloat(windows.count * 50), y: 200 + CGFloat(windows.count * 50), width: 300, height: 200),
            styleMask: isWindowMovable ? [.resizable, .miniaturizable, .closable, .titled, .fullSizeContentView] : [.borderless],
            backing: .buffered,
            defer: false
        )
        
        // Make window transparent
        window.isOpaque = false
        window.backgroundColor = .clear
        
        // Set window level to always be on top
        window.level = .statusBar
        
        // Make window visible on all Spaces
        window.collectionBehavior = [.canJoinAllSpaces]
        
        // Hide from screen sharing
        window.sharingType = .none
        
        // Set window properties based on edit mode
        if isWindowMovable {
            window.isMovableByWindowBackground = true
            window.ignoresMouseEvents = false
        } else {
            window.isMovableByWindowBackground = false
            window.ignoresMouseEvents = true
        }
        
        // Set content to custom View
        let contentView = OverlayContentView()
        window.contentView = NSHostingView(rootView: contentView)
        
        // Show the window
        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()
        
        // Add to windows array
        windows.append(window)
    }
    
    @objc func createNewWindow() {
        createNewOverlayWindow()
    }
    

}