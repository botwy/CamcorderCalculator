//
//  FirebaseStore.swift
//  CamcorderCalculator
//
//  Created by Гончаров Денис Васильевич on 27.09.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class FirebaseStore {
    static let shared = FirebaseStore()
    
    var isSyncPricesSuccess = false
    
    private let database = Database.database().reference()
    
    var registratorPrice: Int? = nil
    var cablePrice: Int? = nil
    var workPrice: Int? = nil
    
    func fetchCameraPriceRange(completion: @escaping ((_ result: (min:Float, max:Float, step:Float)) -> Void)) {
        database.observeSingleEvent(of: .value, with: { (snapshot) in
            let body = snapshot.value as? NSDictionary
            if let cameraPriceMin = body?["cameraPriceMin"] as? Float,
               let cameraPriceMax = body?["cameraPriceMax"] as? Float,
               let cameraPriceStep = body?["cameraPriceStep"] as? Float {
                
                let userDefaults = UserDefaults.standard
                userDefaults.set(cameraPriceMin, forKey: "cameraPriceMin")
                userDefaults.set(cameraPriceMax, forKey: "cameraPriceMax")
                userDefaults.set(cameraPriceStep, forKey: "cameraPriceStep")
                
                completion((min:cameraPriceMin, max:cameraPriceMax, step:cameraPriceStep))
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func syncPrices() {
        database.observeSingleEvent(of: .value, with: { (snapshot) in
            let body = snapshot.value as? NSDictionary
            self.registratorPrice = body?["registratorPrice"] as? Int
            self.cablePrice = body?["cablePrice"] as? Int
            self.workPrice = body?["workPrice"] as? Int
            self.isSyncPricesSuccess = true
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func saveUser(id: String, name: String, phone: String) {
        let user = ["name" : name, "phone" : phone]
        database.child("users/\(id)").setValue(user)
    }
}
