//
//  Location.swift
//  rainyShinyCloudy
//
//  Created by park kyung suk on 2017/05/11.
//  Copyright © 2017年 park kyung suk. All rights reserved.
//

import CoreLocation

//Singletonクラス
class Location {
    static var sharedInstance = Location()
    //明示的にしなくても暗黙的にinitされる。
    private init() { }
    
    //Defalut set value for tokyo
    var latitude: Double! = 35.6915
    var longitude: Double! = 139.7081
    
    
}
