//
//  Snippet.swift
//  snippet-manager
//
//  Created by Manu on 03/07/2019.
//  Copyright © 2019 Manu Marchand. All rights reserved.
//

import Foundation

class Snippet {
    
    var title: String
    var content: String
    var language: String?
    var theme: String?
    
    init(title: String, content: String, language: String? = nil, theme: String? = nil) {
        self.title = title
        self.content = content
        self.language = language
        self.theme = theme
    }
    
}
