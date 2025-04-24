//
//  TodoRepository.swift
//  ToDo
//
//  Created by Ogul Ayvaci on 21.04.2025.
//

import Foundation
import RxSwift

class TodoRepository {
    var todosList = BehaviorSubject<[Todo]>(value: [Todo]())
    
    let db: FMDatabase?
    
    init () {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniYolu = URL(fileURLWithPath: hedefYol).appendingPathComponent("todoApp.sqlite")
        
        db = FMDatabase(path: veritabaniYolu.path)
    }
    
    func update(id: Int, name: String){
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE todos SET name=? WHERE id=?", values: [name, id])
            
        } catch {
            print(error.localizedDescription)
            
        }
        
        db?.close()
    }
    
    
    func kaydet(name: String){
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT INTO todos (name) VALUES (?)", values: [name])
            
        } catch {
            print(error.localizedDescription)
            
        }
        
        db?.close()
    }
    
    
    func search(searchText: String) {
        db?.open()
        
        do {
            var list = [Todo]()
            
            let result = try db!.executeQuery("SELECT * FROM todos WHERE name LIKE '%\(searchText)%'", values: nil)
            
            while result.next() {
                let id = Int(result.string(forColumn: "id"))!
                let name = result.string(forColumn: "name")!
                
                let todo = Todo(id: id, name: name)
                
                list.append(todo)
            }
            
            todosList.onNext(list) // trigger - tetikleme
            
        } catch {
            print(error.localizedDescription)
            
        }
        
        db?.close()
    }
    
    
    func delete(id: Int){
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM todos WHERE id=?", values: [id])
            
        } catch {
            print(error.localizedDescription)
            
        }
        
        db?.close()
    }
    
    
    func loadTodos(){
        db?.open()
        
        do {
            var list = [Todo]()
            
            let result = try db!.executeQuery("SELECT * FROM todos", values: nil)
            
            while result.next() {
                let id = Int(result.string(forColumn: "id"))!
                let name = result.string(forColumn: "name")!
                
                let todo = Todo(id: id, name: name)
                
                list.append(todo)
            }
            
            todosList.onNext(list) // trigger - tetikleme
            
        } catch {
            print(error.localizedDescription)
            
        }
        
        db?.close()
    }
}
