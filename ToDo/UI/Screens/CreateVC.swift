//
//  CreateVC.swift
//  ToDo
//
//  Created by Ogul Ayvaci on 19.04.2025.
//

import UIKit

class CreateVC: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func createButton(_ sender: Any) {
        if let name = nameTF.text {
            kaydet(name: name)
        }
    }
    
    
    func kaydet(name: String){
        print("Todo Kaydet: \(name)")
    }
}
