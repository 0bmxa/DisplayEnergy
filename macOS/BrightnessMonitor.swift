//
//  BrightnessMonitor.swift
//  DisplayEnergy
//
//  Created by mxa on 30.06.2018.
//  Copyright © 2018 0bmxa. All rights reserved.
//

import Foundation

class BrightnessMonitor {
    private let timer: DispatchSourceTimer
    private var previousBrightness: Float = 0
    private let notificationManager: NotificationManager
    private let warningThreshold: Float
    
    private let updateInterval: Double // sec
    private let warningMessage = "Your Display is quite bright and uses a lot of energy."
    
    init(notificationManager: NotificationManager, warningThreshold: Float, updateInterval: Double = 1.0) {
        self.notificationManager = notificationManager
        self.warningThreshold = warningThreshold
        self.updateInterval = updateInterval
        
        self.timer = DispatchSource.makeTimerSource()
        self.timer.setEventHandler(handler: self.updateHandler)
        self.timer.schedule(deadline: DispatchTime.now(), repeating: self.updateInterval)
        self.timer.resume()
    }
    
    private func updateHandler() {
        guard let brightness = IODisplay.brighness else { assertionFailure(); return }
        
        print(brightness)
        
        if brightness >= self.warningThreshold, self.previousBrightness < self.warningThreshold {
            self.notificationManager.show(message: self.warningMessage, replacingOthers: true)
        } else if brightness < self.warningThreshold, self.previousBrightness >= self.warningThreshold {
            self.notificationManager.clearAll()
        }
        
        self.previousBrightness = brightness
    }
    
}
