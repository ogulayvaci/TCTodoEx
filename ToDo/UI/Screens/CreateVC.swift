//
//  CreateVC.swift
//  ToDo
//
//  Created by Ogul Ayvaci on 19.04.2025.
//

import UIKit

class CreateVC: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    
    var createVM = CreateVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func createButton(_ sender: Any) {
        if let name = nameTF.text {
            createVM.kaydet(name: name)
        }
    }
}
