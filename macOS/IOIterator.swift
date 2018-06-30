//
//  IOIterator.swift
//  DisplayEnergy
//
//  Created by mxa on 30.06.2018.
//  Copyright © 2018 0bmxa. All rights reserved.
//

import IOKit.graphics

/// A Swifty, ARCy io_iterator_t wrapper.
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
