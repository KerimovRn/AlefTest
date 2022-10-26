//
//  PersonTableViewCell.swift
//  AlefTest
//
//  Created by Ruslan Kerimov on 24.10.2022.
//

import UIKit

enum TextFieldType {
    case name
    case age
}

protocol PersonTableViewCellDelegate: AnyObject {
    
    func textChanged(newText: String, type: TextFieldType, indexPath: IndexPath)
    func delete(indexPath: IndexPath)
}

class PersonTableViewCell: UITableViewCell {

    weak var delegate: PersonTableViewCellDelegate?
    var indexPath: IndexPath?
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var ageView: UIView!
    
    func setupCell(person: Person) {
        [nameView, ageView].forEach {
            $0?.layer.cornerRadius = 8
            $0?.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
            $0?.layer.borderWidth = 1
        }
        nameTF.addTarget(self, action: #selector(textChanged(_ :)), for: .editingChanged)
        ageTF.addTarget(self, action: #selector(textChanged(_ :)), for: .editingChanged)

        nameTF.text = person.name
        ageTF.text = person.age
    }
    
    @objc func textChanged(_ sender: UITextField) {
        guard let indexPath = indexPath else { return }
        switch sender {
        case nameTF:
            if let text = nameTF.text {
                delegate?.textChanged(newText: text, type: .name, indexPath: indexPath)
            }
        case ageTF:
            if let text = ageTF.text {
                delegate?.textChanged(newText: text, type: .age, indexPath: indexPath)
            }
        default: break
        }
    }
    @IBAction func deleteBtnAct(_ sender: UIButton) {
        print("delete")
        if let indexPath = indexPath {
            delegate?.delete(indexPath: indexPath)
        }
    }
    
}
