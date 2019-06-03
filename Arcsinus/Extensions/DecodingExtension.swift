//
//  DecodingExtension.swift
//  Arcsinus
//
//  Created by spens on 03/06/2019.
//  Copyright © 2019 arcsinus.com. All rights reserved.
//

import Foundation

extension Dictionary {
    func decode<T: Decodable>(as: T.Type) -> T? {
        if let data = data {
            return data.decode(as: T.self)
        }
        return nil
    }
    
    var data: Data? {
        if JSONSerialization.isValidJSONObject(self) {
            return try? JSONSerialization.data(withJSONObject: self, options: [])
        } else {
            return nil
        }
    }
}

extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
}

extension Data {
    func decode<T: Decodable>(as: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
            return try decoder.decode(T.self, from: self)
        } catch {
            return nil
        }
    }
}
