//
//  ViewController.swift
//  ToDo
//
//  Created by Ogul Ayvaci on 18.04.2025.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var todoTableView: UITableView!
    
    var todosList = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        todoTableView.dataSource = self
        todoTableView.delegate = self
        
        let t1 = Todo(id: 1, name: "Su")
        let t2 = Todo(id: 2, name: "Ekmek")
        let t3 = Todo(id: 3, name: "Diş Fırçası")
        let t4 = Todo(id: 4, name: "Çöp")
        let t5 = Todo(id: 5, name: "Macun")
        
        todosList.append(t1)
        todosList.append(t2)
        todosList.append(t3)
        todosList.append(t4)
        todosList.append(t5)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            
            if let todo = sender as? Todo {
                let destinationVC = segue.destination as! DetailVC
                destinationVC.todo = todo
            }
        }
    }
}

//MARK: - TableView Delegate & DataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! TodoViewCell
        let todo = todosList[indexPath.row]
        
        cell.nameLabel.text = todo.name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todosList[indexPath.row]
        
        performSegue(withIdentifier: "toDetail", sender: todo)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("todo ara: \(searchText)")
    }
}
