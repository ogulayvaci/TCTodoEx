//
//  DetailVC.swift
//  ToDo
//
//  Created by Ogul Ayvaci on 19.04.2025.
//

import UIKit

class DetailVC: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    
    var detailVM = DetailVM()
    var todo: Todo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            nameTF.text = todo.name
        }
    }
    
    
    @IBAction func updateButton(_ sender: Any) {
        if let name = nameTF.text, let tempTodo = todo {
            detailVM.update(id: tempTodo.id!, name: name)
        }
    }
}
