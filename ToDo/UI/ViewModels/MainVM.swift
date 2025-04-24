//
//  MainVM.swift
//  ToDo
//
//  Created by Ogul Ayvaci on 21.04.2025.
//

import Foundation
import RxSwift

class MainVM {
    var todoRepository = TodoRepository()
    var todosList = BehaviorSubject<[Todo]>(value: [Todo]())
    
    init() {
        veritabaniKopyala()
        
        todosList = todoRepository.todosList
    }
    
    func search(searchText: String) {
        todoRepository.search(searchText: searchText)
    }
    
    
    func delete(id: Int){
        todoRepository.delete(id: id)
    }
    
    
    func loadTodos(){
        todoRepository.loadTodos()
    }
    
    
    func veritabaniKopyala() {
        let bundleYolu = Bundle.main.path(forResource: "todoApp", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("todoApp.sqlite")
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("Veritabanı zaten var")
            
        } else {
            do {
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                
            } catch {}
        }
    }
}
