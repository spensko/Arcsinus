//
//  RealmManager.swift
//  Arcsinus
//
//  Created by spens on 03/06/2019.
//  Copyright © 2019 arcsinus.com. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private let realm = try! Realm()
    
    func save(objects: [Object]) {
        do {
            try realm.write {
                realm.add(objects, update: true)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func persons(with name: String?) -> [SWPerson]? {
        guard let name = name else { return nil }
        return realm.objects(SWPerson.self).filter({ $0.name.lowercased().contains(name.lowercased()) })
    }
}
