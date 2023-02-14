//
//  ViewController.swift
//  Comebine Users
//
//  Created by Sandeep Reddy on 13/02/23.
//

import UIKit
import Combine


class DataManager {
    private let  urlString = "https://jsonplaceholder.typicode.com/users"
    
    var UsersPublisher: AnyPublisher<[User], Error> {
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}

class UsersTableViewController: UITableViewController {
    
    private var userSubscriber: AnyCancellable?
    
    private var users = [User]() {
        
        
        didSet {
            tableView.reloadData()
            
            
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        
    }
    
    private func fetchUsers() {
        userSubscriber = DataManager().UsersPublisher.sink(receiveCompletion: { _ in }, receiveValue: { (users) in
            self.users = users
        })
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let user = self.users[indexPath.item]
        //cell.textLabel?.text = "\(indexPath.item)"
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text =  user.company.name
        return cell
        
    }

}

