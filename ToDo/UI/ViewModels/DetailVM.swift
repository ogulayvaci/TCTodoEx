//
//  DetailVM.swift
//  ToDo
//
//  Created by Ogul Ayvaci on 21.04.2025.
//

import Foundation

class DetailVM {
    var todoRepository = TodoRepository()
    
    func update(id: Int, name: String){
        todoRepository.update(id: id, name: name)
    }
}
