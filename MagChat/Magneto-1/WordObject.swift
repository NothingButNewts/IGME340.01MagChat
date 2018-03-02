//
//  WordObject.swift
//  MagChat
//
//  Created by Student on 2/28/18.
//  Copyright © 2018 Isaac Walerstein & Peter Woodsum. All rights reserved.
//

import Foundation

class WordObject {
    var xPosition: Float
    var yPosition: Float
    var wordText: String
    
    init (xPosition: Float, yPosition: Float, wordText: String) {
        self.xPosition = xPosition
        self.yPosition = yPosition
        self.wordText = wordText
    }
}
