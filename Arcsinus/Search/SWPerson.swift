//
//  SWPerson.swift
//  Arcsinus
//
//  Created by spens on 03/06/2019.
//  Copyright © 2019 arcsinus.com. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

@objcMembers
class SWPerson: Object, Decodable {
    dynamic var name: String = ""
    dynamic var height: String = ""
    dynamic var mass: String = ""
    dynamic var hairColor: String = ""
    dynamic var skinColor: String = ""
    dynamic var eyeColor: String = ""
    dynamic var birthYear: String = ""
    dynamic var gender: String = ""
    dynamic var homeworld: String = ""
    dynamic var created: Date?
    dynamic var edited: Date?
    dynamic var url: String = ""
    var films = List<String>()
    var species = List<String>()
    var vehicles = List<String>()
    var starships = List<String>()
    
    override static func primaryKey() -> String? {
        return "url"
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, height, mass, gender, homeworld, films, species, vehicles, starships, created, edited, url
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(String.self, forKey: .height)
        mass = try container.decode(String.self, forKey: .mass)
        hairColor = try container.decode(String.self, forKey: .hairColor)
        skinColor = try container.decode(String.self, forKey: .skinColor)
        eyeColor = try container.decode(String.self, forKey: .eyeColor)
        birthYear = try container.decode(String.self, forKey: .birthYear)
        gender = try container.decode(String.self, forKey: .gender)
        homeworld = try container.decode(String.self, forKey: .homeworld)
        url = try container.decode(String.self, forKey: .url)
        created = try container.decode(Date.self, forKey: .created)
        edited = try container.decode(Date.self, forKey: .edited)
        
        let filmsArray = try container.decode([String].self, forKey: .films)
        films.append(objectsIn: filmsArray)
        
        let speciesArray = try container.decode([String].self, forKey: .species)
        species.append(objectsIn: speciesArray)
        
        let vehiclesArray = try container.decode([String].self, forKey: .vehicles)
        vehicles.append(objectsIn: vehiclesArray)
        
        let starshipsArray = try container.decode([String].self, forKey: .starships)
        starships.append(objectsIn: starshipsArray)
        
        super.init()
    }

    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
