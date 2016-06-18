//
//  Artist.swift
//  ApiJsonSwift
//
//  Created by Taylor Frost on 6/17/16.
//  Copyright © 2016 Taylor Frost. All rights reserved.
//

import UIKit

class Artist: NSObject {
    
    var href: String = ""
    var artistId: String = ""
    var name: String = ""
    var popularity: Int = 0
    var type: String = ""

    override init () {
        super.init()
        
    self.href = ""
    self.artistId = ""
    self.name = ""
    self.popularity = 0
    self.type = ""
    
    }
}
