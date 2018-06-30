//
//  IODisplay.swift
//  DisplayEnergy
//
//  Created by mxa on 30.06.2018.
//  Copyright © 2018 0bmxa. All rights reserved.
//

import Foundation
import IOKit.graphics

struct IODisplay {
    static let displayConnectServiceName = "IODisplayConnect"
    
    static var brighness: Float? {
        var brightness: Float?
        
        let _iterator = IOIterator(serviceName: displayConnectServiceName)
        guard let iterator = _iterator else { return nil }
        
        let options: IOOptionBits = 0
        let key = kIODisplayBrightnessKey as CFString
        
        iterator.iterate { service in
            var _brightness: Float = 0
            let result = IODisplayGetFloatParameter(service, options, key, &_brightness)
            guard result == kIOReturnSuccess else { assertionFailure(); return }
            brightness = _brightness
        }
        
        return brightness
    }
}
