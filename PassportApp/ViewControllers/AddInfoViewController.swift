//
//  AddInfoViewController.swift
//  PassportApp
//
//  Created by Surgeont on 22.11.2021.
//

import UIKit

 final class AddInfoViewController: UIViewController {
     
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
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headLabel: UILabel = {
        let label = UILabel()
        label.text = "Персональные данные"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let childrenLabel: UILabel = {
        let label = UILabel()
        label.text = "Дети (макс.5)"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addChildButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.setTitle("Добавить", for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor.systemBlue
        button.layer.cornerRadius = 25
        button.frame.size.width = 250
        button.frame.size.height = 100
        button.addTarget(self, action: #selector(addChildButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Очистить", for: .normal)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 2
        button.tintColor = .red
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints =  false
        return button
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.layer.borderWidth = 0
        tableView.register(ChildTableViewCell.self, forCellReuseIdentifier: "ChildTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
     private var parentStackView = UIStackView()
     private var childrenFields: [String] = []
     private var mainTextFields = UIView()
     
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupDelegate()
        setConstraints()
        
    }
    // MARK: - Clear Button Setup
    @objc private func clearButtonTapped() {
            let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
            let clearMode = UIAlertAction(title: "Очистить", style: .default) { (action) in
            self.childrenFields.removeAll()
            self.tableView.reloadData()
            self.addChildButton.isHidden = false
        }
            let cancelMode = UIAlertAction(title: "Отмена", style: .default, handler: nil)
            alert.addAction(clearMode)
            alert.addAction(cancelMode)
            present(alert, animated: true, completion: nil)
    }
    // MARK: - Add Button Setup
    @objc private func addChildButtonTapped() {
        if childrenFields.count == 4 {
            addChildButton.isHidden = true
        }
        if childrenFields.count < 5 {
            tableView.performBatchUpdates {
                self.childrenFields.append("child \(childrenFields.count)")
                print(childrenFields)
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            } completion: { (result) in
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(headLabel)
        
        mainTextFields = createNameAndAgeTextFieldsView(nameTextField: nameTextField, ageTextField: ageTextField)
        parentStackView = UIStackView(arrangedSubviews: [childrenLabel, addChildButton],
                                      axis: .horizontal,
                                      spacing: 20,
                                      distribution: .fillProportionally)
        backgroundView.addSubview(parentStackView)
        backgroundView.addSubview(mainTextFields)
        backgroundView.addSubview(clearButton)
        backgroundView.addSubview(tableView)
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Set Constraints
extension AddInfoViewController {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headLabel.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 20),
            headLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            headLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            mainTextFields.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 20),
            mainTextFields.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            mainTextFields.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40),
            mainTextFields.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: mainTextFields.bottomAnchor, constant: 20),
            parentStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            parentStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            parentStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: parentStackView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            clearButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            clearButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -40),
            clearButton.widthAnchor.constraint(equalToConstant: 200),
            clearButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
// MARK: - TableView Setups
extension AddInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChildTableViewCell", for: indexPath) as? ChildTableViewCell {
            cell.cellDelegate = self
            cell.index = indexPath
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
// MARK: - Deletion Protocol
extension AddInfoViewController: DeleteCellProtocol {
    func deleteButtonTapped(indexPath: IndexPath) {
        addChildButton.isHidden = false
        let number: Int = indexPath[1]
        let indexToDeletion = childrenFields.count - number - 1
        tableView.performBatchUpdates {
            self.childrenFields.remove(at: indexToDeletion)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
