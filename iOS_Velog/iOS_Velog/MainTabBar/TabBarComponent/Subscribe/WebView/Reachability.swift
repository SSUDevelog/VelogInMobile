//
//  Reachability.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/10.
//

import Foundation
import SystemConfiguration

class Reachability {
    
    class func networkConnected() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isRachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let neddsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0

        
        return (isRachable && !neddsConnection)
    }
    
}
