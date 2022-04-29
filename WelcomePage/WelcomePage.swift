//
//  WelcomePage.swift
//  Sneakers
//
//  Created by Yerkebulan Sharipov on 24.04.2022.
//

import UIKit
import SnapKit

class Welcome : UIViewController {
    
    lazy var bluredBox : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.backgroundColor = UIColor(patternImage: UIImage(named: "4")!)
        return view
    }()

    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 24
        view.distribution = .equalSpacing
        view.alignment = .center
        return view
    }()
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.text = "Welcome to the biggest \nsneakers store app"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Colors.basicColors.black
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        return label
    }()
    
    lazy var button : ButtonFactory = {
        let button = ButtonFactory()
        button.configure(with: BottonViewModel(text: "Sign Up", backgroundColor: Colors.basicColors.black))
        button.addTarget(self, action: #selector(pushToRegistrationPage), for: .touchUpInside)
        return button
    }()
    
    lazy var button2 : UIButton = {
        let button = UIButton()
        button.setTitle("I already have an account", for: .normal)
        button.setTitleColor( Colors.basicColors.black, for: .normal)
        button.addTarget(self, action: #selector(alreadyHaveAccountDidPress), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setUI()
    }
   @objc private func pushToRegistrationPage(){
       self.navigationController?.pushViewController(RegistrationPage(), animated: true)
    }
    @objc private func alreadyHaveAccountDidPress(){
        self.navigationController?.pushViewController(AuthorizationPage(), animated: true)
    }
    
    private func setupHierarchy(){
        [bluredBox, stackView].forEach{
            view.addSubview($0)
        }
        [label,button,button2].forEach {
            stackView.addArrangedSubview($0)
        }
     }
    private func setUI(){
        bluredBox.snp.makeConstraints { make in
            make.width.equalTo(390)
            make.height.equalTo(560)
        }
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bluredBox.snp.bottom).offset(18)
            make.bottom.equalToSuperview().offset(-58)
        }
        button.snp.makeConstraints { make in
            make.width.equalTo(358)
            make.height.equalTo(54)
        }
    }
}
