//
//  AppDelegate.swift
//  Q TTS
//
//  Created by Qerope Santos on 1/4/21.
//

import Cocoa
import SwiftUI
import AVFoundation

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusBarItem: NSStatusItem!
    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        
        let statusBar = NSStatusBar.system
                statusBarItem = statusBar.statusItem(
                    withLength: NSStatusItem.squareLength)
                statusBarItem.button?.image = NSImage(named: "icon")
                statusBarItem.button?.imageScaling = .scaleProportionallyDown
        
                statusBarItem.button?.action = #selector(AppDelegate.readMe)
    }
    
    @objc func readMe() {
        let def = UserDefaults.standard
        let lang = def.string(forKey: "lang")
        let utterance = AVSpeechUtterance(string: (NSPasteboard.general.pasteboardItems?.first?.string(forType: .string))! )
        utterance.voice = AVSpeechSynthesisVoice(language: lang)
        utterance.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

