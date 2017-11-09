//
//  NSData+HexString.swift
//  HexString
//
//  Created by Alex Tran-Qui on 07/08/2017.
//  Copyright © 2017 Katalysis / Alex Tran Qui (alex@katalysis.io). All rights reserved.
//
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//
//  Inspired by CryptoCoinSwift by Sjors (https://github.com/CryptoCoinSwift/RIPEMD-Swift/ )
//  Inspired by http://stackoverflow.com/questions/26501276/converting-hex-string-to-nsdata-in-swift/26502285
//  Changes copyright © 2016 Katalysis / Alex Tran Qui  (alex.tranqui@gmail.com). All rights reserved.
//

import Foundation

extension Data {
    public func toHexString () -> String? {
        
        var hexadecimalString = ""
        self.forEach {ui in hexadecimalString += String(format: "%02X", ui)}
        return hexadecimalString
    }
}

extension String {
    
    /// Create Data from hexadecimal string representation
    ///
    /// This takes a hexadecimal representation and creates a Data object. http://codereview.stackexchange.com/questions/135424/hex-string-to-bytes-nsdata  ///
    /// - returns: Data represented by this hexadecimal string or nil.
    
    public func toData() -> Data? {
        // Convert 0 ... 9, a ... f, A ...F to their decimal value,
        // return nil for all other input characters
        func decodeNibble(_ u: UInt16) -> UInt8? {
            switch(u) {
            case 0x30 ... 0x39:
                return UInt8(u - 0x30)
            case 0x41 ... 0x46:
                return UInt8(u - 0x41 + 10)
            case 0x61 ... 0x66:
                return UInt8(u - 0x61 + 10)
            default:
                return nil
            }
        }
        
        let utf16 = self.utf16
        var data = Data(capacity: utf16.count/2)
        
        var i = utf16.startIndex
        while i != utf16.endIndex {
            guard let hi = decodeNibble(utf16[i]),
                let nxt = utf16.index(i, offsetBy:1, limitedBy: utf16.endIndex),
                let lo = decodeNibble(utf16[nxt])
                else {
                    return nil
            }
            #if os(Linux)
                var value = hi << 4 + lo
                let buffer = UnsafeBufferPointer(start: &value, count:1)
                data.append(buffer)
            #else
                let value = hi << 4 + lo
                data.append(value)
            #endif
            
            guard let next = utf16.index(i, offsetBy:2, limitedBy: utf16.endIndex) else {
                break
            }
            i = next
        }
        
        return data
    }
    
    public func toByteArray() -> Array<UInt8>? {
        guard let data = self.toData() else {
            return nil
        }
        let array: [UInt8] = data.filter { (u) -> Bool in
            return true
        }
        return array
    }
}
