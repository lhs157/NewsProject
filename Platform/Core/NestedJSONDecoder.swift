//
//  NestedJSONDecoder.swift
//  Platform
//
//  Created by Luu Hong Son on 9/12/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import Alamofire

class NestedJSONDecoder: DataDecoder {
    let keyPath: String
    let readingOptions: JSONSerialization.ReadingOptions
    let decoder: DataDecoder
    
    init(keyPath: String,
         decoder: DataDecoder,
         readingOptions: JSONSerialization.ReadingOptions) {
        self.keyPath = keyPath
        self.readingOptions = readingOptions
        self.decoder = decoder
    }
    
    func decode<D: Decodable>(_ type: D.Type, from data: Data) throws -> D {
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)
     
        guard let nestedJson = (json as AnyObject).value(forKeyPath: keyPath) else {
            throw NetworkError.responseSerializationFailed(reason: .nilDataAtKeyPath(keyPath: keyPath))
        }
        
        guard JSONSerialization.isValidJSONObject(nestedJson) else {
            throw NetworkError.responseSerializationFailed(reason: .invalidJSONAtKeyPath(keyPath: keyPath, value: nestedJson))
        }
        
        let nestedData = try JSONSerialization.data(withJSONObject: nestedJson)
        return try decoder.decode(type, from: nestedData)
    }
}
