//
//  CategoryEntity.swift
//  Game
//
//  Created by Ikhwan Setyo on 26/12/25.
//


import Foundation
import RealmSwift

public class GameModuleEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var rawDescription: String = ""
    @objc dynamic var favorite: Bool = false
        
    public override static func primaryKey() -> String? {
        return "id"
    }
}
