//
//  Todo.swift
//  ToDo
//
//  Created by Ogul Ayvaci on 19.04.2025.
//

import Foundation

class Todo {
    var id: Int?
    var name: String?
    
    init(){
        
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
