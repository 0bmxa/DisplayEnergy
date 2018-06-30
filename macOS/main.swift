//
//  main.swift
//  DisplayEnergy
//
//  Created by mxa on 19.04.2018.
//  Copyright © 2018 0bmxa. All rights reserved.
//

import Foundation

func main() {
    let notificationManager = NotificationManager()
    _ = BrightnessMonitor(notificationManager: notificationManager, warningThreshold: 0.8, updateInterval: 0.1)
    
    RunLoop.current.run()
}
main()
