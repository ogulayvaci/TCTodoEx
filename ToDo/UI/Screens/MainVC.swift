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
    var mainVM = MainVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        todoTableView.dataSource = self
        todoTableView.delegate = self
        
        _ = mainVM.todosList.subscribe(onNext: { list in // listening - dinleme
            self.todosList = list
            self.todoTableView.reloadData()
        })
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainVM.loadTodos()
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
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, bool in // closure
            let todo = self.todosList[indexPath.row]
            
            let alert = UIAlertController(title: "Delete '\(todo.name!)'", message: "Do you want to delete \(todo.name!) permanently?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            let okAction = UIAlertAction(title: "Delete", style: .destructive) { action in
                self.mainVM.delete(id: todo.id!)
            }
            alert.addAction(okAction)
            
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}


//MARK: - SearchBar Delegate
extension MainVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        mainVM.search(searchText: searchText)
    }
}
