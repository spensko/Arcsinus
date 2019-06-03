//
//  SearchViewModel.swift
//  Arcsinus
//
//  Created by spens on 03/06/2019.
//  Copyright © 2019 arcsinus.com. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {

    let persons: BehaviorRelay<[SWPerson]> = BehaviorRelay(value: [])

    func search(query: String?, completion: ((_ error: Error?) -> Void)?) {
        if let query = query, query.count > 1 {
            if RequestManager.shared.reachability?.isReachable ?? false {
                RequestManager.shared.search(with: query) { [weak self] (result, error) in
                    if let results = result?["results"] as? [[String:Any]] {
                        let arr = results.compactMap({ $0.decode(as: SWPerson.self) })
                        self?.persons.accept(arr)
                        RealmManager.shared.save(objects: arr)
                    }
                    completion?(error)
                }
            } else if let cache = RealmManager.shared.persons(with: query) {
                persons.accept(cache)
                completion?(nil)
            }
        } else {
            persons.accept([])
        }
    }

}
