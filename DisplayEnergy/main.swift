//
//  main.swift
//  DisplayEnergy
//
//  Created by mxa on 19.04.2018.
//  Copyright © 2018 0bmxa. All rights reserved.
//

import Foundation
import IOKit.graphics

struct IODisplay {
    static var brighness: Float? {
        var brightness: Float?
        
        let _iterator = IOIterator(serviceName: "IODisplayConnect")
        guard let iterator = _iterator else { return nil }
        
        let options: IOOptionBits = 0
        let key: CFString = kIODisplayBrightnessKey as CFString
        
        iterator.iterate { service in
            var _brightness: Float = 0
            let result = IODisplayGetFloatParameter(service, options, key, &_brightness)
            guard result == kIOReturnSuccess else { fatalError() }
            brightness = _brightness
        }
        
        return brightness
    }
}

class IOIterator {
    private let iterator: io_iterator_t
    
    init?(serviceName: String, masterPort: mach_port_t = kIOMasterPortDefault) {
        var iterator: io_iterator_t = 0
        let matchingServiceDesc = IOServiceMatching(serviceName)
        let result = IOServiceGetMatchingServices(masterPort, matchingServiceDesc, &iterator)
        guard result == kIOReturnSuccess else { fatalError(); return nil }
        self.iterator = iterator
    }
    
    deinit {
        IOObjectRelease(self.iterator)
    }
    
    func iterate(callback: (io_object_t) -> ()) {
        var object = IOIteratorNext(self.iterator)
        while object != 0 {
            callback(object)
            IOObjectRelease(object)
            object = IOIteratorNext(iterator)
        }
    }
}



func main() {
    let start = DispatchTime.now()
    let times = 50000
    for _ in 0..<times {
        _ = IODisplay.brighness!
    }
    let end = DispatchTime.now()
    
    let durationNS = end.uptimeNanoseconds - start.uptimeNanoseconds
    let durationMS = durationNS / 1000000
    print(times, "times took", durationMS, "ms")
}
main()
