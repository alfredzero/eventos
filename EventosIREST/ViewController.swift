//
//  ViewController.swift
//  EventosIREST
//
//  Created by Alfredo Amezcua on 5/10/24.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    var viewModel = EventosListViewModel()
    
    private lazy var headerView: HeaderView = {
        let v = HeaderView(fontSize: 32)
        return v
    }()
    
    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.tableFooterView = UIView()
        v.register(EventosTableViewCell.self, forCellReuseIdentifier: viewModel.reuseID)
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Call getEventos to fetch event data
        viewModel.getEventos { [weak self] eventos in
            // Handle completion, e.g., update UI
            self?.tableView.reloadData()
            
            
        }
        
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.eventosVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseID, for: indexPath) as?
        EventosTableViewCell
        let eventos = viewModel.eventosVM[indexPath.row]
        cell?.eventosVM = eventos
        return cell ?? UITableViewCell()
    }
    
}

