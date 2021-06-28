//
//  FormTableViewCell.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/28.
//

import UIKit

protocol FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updateModel: EditProfileFormModel?)
}

class FormTableViewCell: UITableViewCell {
    
    static let identifier = "FormTableViewCell"

    
    var delegate: FormTableViewCellDelegate?
        
    private var model: EditProfileFormModel?
    
    private let formLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let field: UITextField = {
       let field = UITextField()
        field.returnKeyType = .done
        return field
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        clipsToBounds = true
        field.delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Assign frames
        formLabel.frame = CGRect(x: 5,
                                 y: 0,
                                 width: contentView.width / 3,
                                 height: contentView.height)
        
        field.frame = CGRect(x: formLabel.right + 5,
                                 y: 0,
                                 width: contentView.width-10-formLabel.width,
                                 height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    func configure(with model: EditProfileFormModel) {
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeHolder
        field.text = model.value
    }
}
extension FormTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        model?.value = textField.text
        
        guard let model = model else {
            return true
        }
        textField.resignFirstResponder()
        delegate?.formTableViewCell(self, didUpdateField: model)
        return true
    }
}
