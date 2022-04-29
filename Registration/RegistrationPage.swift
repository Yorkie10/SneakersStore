//
//  RegistrationPage.swift
//  Sneakers
//
//  Created by Yerkebulan Sharipov on 24.04.2022.
//

import UIKit
import SnapKit
import Firebase

class RegistrationPage : UIViewController {
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.text = "New User"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = Colors.basicColors.black
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .equalSpacing
        view.alignment = .center
        return view
    }()
    
    func textFieldGenerator(placeholder: String) -> UITextField {
        let textfiled = UITextField()
        textfiled.placeholder = placeholder
        textfiled.backgroundColor = Colors.basicColors.grayBackground
        textfiled.layer.cornerRadius = 8
        textfiled.clearButtonMode = .always
        textfiled.returnKeyType = .done
        textfiled.delegate = self
        return textfiled
    }
    
    lazy var textfieldUserName = textFieldGenerator(placeholder: "Username")
    lazy var textfieldEmail = textFieldGenerator(placeholder: "Email")
    lazy var textfieldPassword = textFieldGenerator(placeholder: "Password")
    
    public var completion : ((String?) -> Void)?
    
    lazy var button : ButtonFactory = {
        let button = ButtonFactory()
        button.configure(with: BottonViewModel(text: "Sign Up", backgroundColor: Colors.basicColors.black))
        button.addTarget(self, action: #selector(signUpButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        textfieldPassword.delegate = self
        setupHierarchy()
        setUI()
    }

    private func setupHierarchy(){
        [label, stackView, button].forEach{
            view.addSubview($0)
        }
        [textfieldUserName,textfieldEmail,textfieldPassword].forEach {
            stackView.addArrangedSubview($0)
        }
     }
    private func setUI(){
        navigationItem.titleView = label
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(112)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        textfieldUserName.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-17)
            make.height.equalTo(48)
        }
        textfieldEmail.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-17)
            make.height.equalTo(48)
        }
        textfieldPassword.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-17)
            make.height.equalTo(48)
        }
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(358)
            make.height.equalTo(54)
            make.top.equalTo(textfieldPassword.snp.bottom).offset(58)
        }
    }
    
    
    @objc private func signUpButton() {
        if textfieldEmail.text != nil {
            Auth.auth().createUser(withEmail: textfieldEmail.text!, password: textfieldPassword.text!) { data, error in
                if error != nil {
                    self.showAlert()
                } else {
                    guard let text = self.textfieldUserName.text else { return }
                    let vc = UINavigationController(rootViewController: TabBarController(text: text))
                    vc.modalPresentationStyle = .fullScreen
                    self.navigationController?.present(vc, animated: true)
                }
            }
        }
        
    }

     func showAlert(){
        let alert = UIAlertController(title: "Error", message: "Complete all fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

extension RegistrationPage : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2.0
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0.0
    }
    private func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
      textField.resignFirstResponder()
     return true
    }
}

