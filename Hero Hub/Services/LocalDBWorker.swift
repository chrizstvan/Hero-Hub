//
//  LocalDBWorker.swift
//  Hero Hub
//
//  Created by Chris on 29/09/21.
//

import Foundation
import RealmSwift

class LocalDBWorker {
    var realm: Realm? {
        do {
            let realm = try Realm()
            return realm
        } catch(let error) {
            debugPrint("Error load from local: \(error.localizedDescription)")
            return nil
        }
    }
}
