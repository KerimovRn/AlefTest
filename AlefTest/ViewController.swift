//
//  ViewController.swift
//  AlefTest
//
//  Created by Ruslan Kerimov on 24.10.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var persons: [Person] = []
    
    @IBOutlet weak var surnameView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var patronymicView: UIView!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var surenameTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var patronymicTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupUI()
    }
    
    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupUI() {
        [surnameView, nameView, ageView, patronymicView].forEach {
            $0?.layer.cornerRadius = 8
            $0?.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
            $0?.layer.borderWidth = 1
        }
        addBtn.layer.cornerRadius = addBtn.frame.height / 2
        addBtn.layer.borderColor = UIColor.tintColor.cgColor
        addBtn.layer.borderWidth = 2
    }
    
    
    
    @IBAction func addBtcAct(_ sender: Any) {
        let person = Person()
        persons.append(person)
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == persons.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteCell", for: indexPath) as! DeleteTableViewCell
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath) as! PersonTableViewCell
        cell.setupCell(person: persons[indexPath.row])
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
}

extension ViewController: PersonTableViewCellDelegate, DeleteTableViewCellDelegate {
    func textChanged(newText: String, type: TextFieldType, indexPath: IndexPath) {
        switch type {
        case .name:
            persons[indexPath.row].name = newText
        case .age:
            persons[indexPath.row].age = newText
        }
        
        print(persons[indexPath.row])
    }
    
    
    func delete(indexPath: IndexPath) {
        print("delete in VC")
        persons.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func deleteAll() {
        persons.removeAll()
        surenameTF.text = ""
        nameTF.text = ""
        patronymicTF.text = ""
        ageTF.text = ""
        tableView.reloadData()
    }
}
