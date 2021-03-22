//
//  ViewController.swift
//  NotesApp
//
//  Created by Malik Arachiche on 3/22/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.reUse)
        tableView.rowHeight = 60
        tableView.separatorColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        title = "Notes"
        view.backgroundColor = .white
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.reUse) as! NotesTableViewCell
        cell.titleLabel.text = "Title"
        cell.subTitleLabel.text = "Subtitle"
        return cell
    }
    
    
}
