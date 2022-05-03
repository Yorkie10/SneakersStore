//
//  GatalogView.swift
//  Sneakers
//
//  Created by Yerkebulan Sharipov on 25.04.2022.
//

import UIKit
import SnapKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class CatalogView:  UIViewController {
    private let text : String
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageView : UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var button : ButtonFactory = {
        let button = ButtonFactory()
        button.configure(with: BottonViewModel(text: "Sign Up", backgroundColor: Colors.basicColors.black))
        return button
    }()
    
    init(text: String){
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.basicColors.grayBackground
        setupHierarchy()
        setupView()
        setUI()
        firebaseImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        label.text = "Hello, \(text)"
        navigationItem.titleView = label
    }
    private func setupHierarchy(){
        [label, imageView, button].forEach{
            view.addSubview($0)
        }
     }
    private func setUI(){
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

    }
     private func firebaseImage(){
        let storageRef = Storage.storage().reference(withPath: "shoes/Shoe.png")
        storageRef.getData(maxSize: 4 * 1024 * 1024) {[weak self] (data, error) in
            if let error = error {
                print("Got an error fetching data : \(error.localizedDescription)")
                return
            }
            if let data = data {
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
}

