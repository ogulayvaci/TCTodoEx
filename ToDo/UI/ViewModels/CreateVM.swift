//
//  CreateVM.swift
//  ToDo
//
//  Created by Ogul Ayvaci on 21.04.2025.
//

import Foundation

class CreateVM {
    var todoRepository = TodoRepository()
    
    func kaydet(name: String){
        todoRepository.kaydet(name: name)
    }
}
