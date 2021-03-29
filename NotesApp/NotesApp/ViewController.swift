//
//  ViewController.swift
//  NotesApp
//
//  Created by Malik Arachiche on 3/22/21.
//

import UIKit
import SnapKit

protocol NoteDelegate: AnyObject {
    func didCreateNote(note: Note)
    func didEditNote(titleText: String, subtitleText: String, index: Int)
}

class ViewController: UIViewController {
    
    var notes: [Note] = []
    
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
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        title = "Notes"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func goToAddNoteVC(note: Note?, index: Int?) {
        let vc = AddNoteViewController()
        vc.note = note
        vc.index = index
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addTapped() {
        goToAddNoteVC(note: nil, index: nil)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        goToAddNoteVC(note: notes[indexPath.row], index: indexPath.row)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.reUse) as! NotesTableViewCell
        cell.titleLabel.text = notes[indexPath.row].title
        cell.subTitleLabel.text = notes[indexPath.row].subtitle
        return cell
    }
}

extension ViewController: NoteDelegate {
    func didEditNote(titleText: String, subtitleText: String, index: Int) {
        notes[index].title = titleText
        notes[index].subtitle = subtitleText
        tableView.reloadData()
    }
    
    func didCreateNote(note: Note) {
        notes.append(note)
        tableView.reloadData()
    }
}
