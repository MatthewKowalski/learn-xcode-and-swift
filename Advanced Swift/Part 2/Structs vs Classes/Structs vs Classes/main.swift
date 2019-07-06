//
//  main.swift
//  Structs vs Classes
//
//  Created by Matt on 7/6/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import Foundation

let hero = ClassHero(name: "Iron Man", universe: "Marvel")
//hero.name = "Iron Mann" // valid even though "hero" is a let-constant (name property is a var)

let heroTwo = StructHero(name: "Hulk", universe: "Marvel")
//heroTwo.name = "Hulke"  // invalid -> heroTwo is a let-constant (even though the name property is a var)
print(heroTwo.reverseName())
