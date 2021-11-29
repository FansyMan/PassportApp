//
//  ChildTableViewCell.swift
//  PassportApp
//
//  Created by Surgeont on 22.11.2021.
//

import UIKit

final class ChildTableViewCell: UITableViewCell {
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let deleteCellButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.tintColor = UIColor.systemBlue
        button.translatesAutoresizingMaskIntoConstraints =  false
        return button
    }()
    
    weak var cellDelegate: DeleteCellProtocol?  // делегат для удаления ячейки
    var index: IndexPath?
    private var childTextFieldsView = UIView()
        
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
        deleteCellButton.addTarget(self, action: #selector(deleleCell), for: .touchUpInside)
    }
    
    override func prepareForReuse() {   // переиспользование ячеек, удаление содержимого
        super.prepareForReuse()
        nameTextField.text = nil
        ageTextField.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder")
    }
    
    @objc private func deleleCell() {
        guard let index = index else { return }
        cellDelegate?.deleteButtonTapped(indexPath: index)
    }
            
    private func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        childTextFieldsView = createCellFields(nameTextField: nameTextField, ageTextField: ageTextField)
        self.contentView.addSubview(childTextFieldsView)
        self.contentView.addSubview(deleteCellButton)
    }
}
// MARK: - Setup Constraints
extension ChildTableViewCell {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            childTextFieldsView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            childTextFieldsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            childTextFieldsView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2),
            childTextFieldsView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            deleteCellButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            deleteCellButton.leadingAnchor.constraint(equalTo: childTextFieldsView.trailingAnchor, constant: 10),
            deleteCellButton.widthAnchor.constraint(equalToConstant: 100),
            deleteCellButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
