//
//  AddNoteViewController.swift
//  NotesApp
//
//  Created by Malik Arachiche on 3/25/21.
//

import UIKit
import SnapKit

class AddNoteViewController: UIViewController {
    
    weak var delegate: NoteDelegate?
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        return textView
    }()
    
    lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Note", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(editNoteTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textField, textView, enterButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        view.addSubview(stackView)
        view.backgroundColor = .white
        title = "Edit Note"
        
        stackView.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        textField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        enterButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
    }
    
    @objc func editNoteTapped() {
        if !textField.hasText || !textView.hasText {
            return
        }
        let title = textField.text ?? ""
        let subtitle = textView.text ?? ""
        
        let note = Note(title: title, subtitle: subtitle)
        delegate?.didCreateNote(note: note)
        
        navigationController?.popViewController(animated: true)
    }
}
