//
//  Album.swift
//  ArtistAPIApp
//
//  Created by don't touch me on 6/18/16.
//  Copyright © 2016 trvl, LLC. All rights reserved.
//

import UIKit

class Album: NSObject {

    var href: String = ""
    var artistID: String = ""
    var name: String = ""
    var type: String = ""
    var uri: String = ""
    
    override init () {
        super.init()
        
        self.href = ""
        self.artistID = ""
        self.name = ""
        self.type = ""
        self.uri = ""
        
    }
    
}


