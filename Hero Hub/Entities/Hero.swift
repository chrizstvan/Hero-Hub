//
//  Hero.swift
//  Hero Hub
//
//  Created by Chris on 27/09/21.
//

import Foundation
import RealmSwift

class Hero: Object, Codable {
    @objc dynamic var id: Int = Int()
    @objc dynamic var name: String = String()
    @objc dynamic var localizedName: String = String()
    @objc dynamic var primaryAttr: String = String()
    @objc dynamic var attackType: String = String()
    let roles: RealmSwift.List<String> = RealmSwift.List<String>()
    @objc dynamic var img: String = String()
    @objc dynamic var icon: String = String()
    @objc dynamic var baseHealth: Int = Int()
    @objc dynamic var baseHealthRegen: Double = Double()
    @objc dynamic var baseMana: Int = Int()
    @objc dynamic var baseManaRegen: Double = Double()
    @objc dynamic var baseArmor: Double = Double()
    @objc dynamic var baseMr: Int = Int()
    @objc dynamic var baseAttackMin: Int = Int()
    @objc dynamic var baseAttackMax: Int = Int()
    @objc dynamic var baseStr: Int = Int()
    @objc dynamic var baseAgi: Int = Int()
    @objc dynamic var baseInt: Int = Int()
    @objc dynamic var strGain: Double = Double()
    @objc dynamic var agiGain: Double = Double()
    @objc dynamic var intGain: Double = Double()
    @objc dynamic var attackRange: Int = Int()
    @objc dynamic var projectileSpeed: Int = Int()
    @objc dynamic var attackRate: Double = Double()
    @objc dynamic var moveSpeed: Int = Int()
    @objc dynamic var cmEnable: Bool = Bool()
    @objc dynamic var legs: Int = Int()
    @objc dynamic var heroId: Int = Int()
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles = "roles"
        case img = "img"
        case icon = "icon"
        case baseHealth = "base_health"
        case baseHealthRegen = "base_health_regen"
        case baseMana = "base_mana"
        case baseManaRegen = "base_mana_regen"
        case baseArmor = "base_armor"
        case baseMr = "base_mr"
        case baseAttackMin = "base_attack_min"
        case baseAttackMax = "base_attack_max"
        case baseStr = "base_str"
        case baseAgi = "base_agi"
        case baseInt = "base_int"
        case strGain = "str_gain"
        case agiGain = "agi_gain"
        case intGain = "int_gain"
        case attackRange = "attack_range"
        case projectileSpeed = "projectile_speed"
        case attackRate = "attack_rate"
        case moveSpeed = "move_speed"
        case cmEnable = "cm_enabled"
        case legs = "legs"
        case heroId = "hero_id"
    }
    
    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try value.decode(Int.self, forKey: .id)
        self.name = try value.decode(String.self, forKey: .name)
        self.localizedName = try value.decode(String.self, forKey: .localizedName)
        self.primaryAttr = try value.decode(String.self, forKey: .primaryAttr)
        self.attackType = try value.decode(String.self, forKey: .attackType)
        let roles = try value.decode([String].self, forKey: .roles)
        self.roles.append(objectsIn: roles)
        self.img = try value.decode(String.self, forKey: .img)
        self.icon = try value.decode(String.self, forKey: .icon)
        self.baseHealth = try value.decode(Int.self, forKey: .baseHealth)
        self.baseHealthRegen = try value.decode(Double.self, forKey: .baseHealthRegen)
        self.baseMana = try value.decode(Int.self, forKey: .baseMana)
        self.baseManaRegen = try value.decode(Double.self, forKey: .baseManaRegen)
        self.baseArmor = try value.decode(Double.self, forKey: .baseArmor)
        self.baseMr = try value.decode(Int.self, forKey: .baseMr)
        self.baseAttackMin = try value.decode(Int.self, forKey: .baseAttackMin)
        self.baseAttackMax = try value.decode(Int.self, forKey: .baseAttackMax)
        self.baseStr = try value.decode(Int.self, forKey: .baseStr)
        self.baseInt = try value.decode(Int.self, forKey: .baseInt)
        self.baseAgi = try value.decode(Int.self, forKey: .baseAgi)
        self.strGain = try value.decode(Double.self, forKey: .strGain)
        self.agiGain = try value.decode(Double.self, forKey: .agiGain)
        self.intGain = try value.decode(Double.self, forKey: .intGain)
        self.attackRange = try value.decode(Int.self, forKey: .attackRange)
        self.projectileSpeed = try value.decode(Int.self, forKey: .projectileSpeed)
        self.attackRate = try value.decode(Double.self, forKey: .attackRate)
        self.moveSpeed = try value.decode(Int.self, forKey: .moveSpeed)
        self.cmEnable = try value.decode(Bool.self, forKey: .cmEnable)
        self.legs = try value.decode(Int.self, forKey: .legs)
        self.heroId = try value.decode(Int.self, forKey: .heroId)
        
        super.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required override init() {
        super.init()
    }
}
