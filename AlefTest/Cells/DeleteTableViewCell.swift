//
//  DeleteTableViewCell.swift
//  AlefTest
//
//  Created by Ruslan Kerimov on 26.10.2022.
//

import UIKit

protocol DeleteTableViewCellDelegate: AnyObject {
    
    func deleteAll()
    
}
class DeleteTableViewCell: UITableViewCell {
    
    weak var delegate: DeleteTableViewCellDelegate?
    @IBAction func deleteBtnAct(_ sender: UIButton) {
        print("Dellete all")
        delegate?.deleteAll()
        
    }
    
}
