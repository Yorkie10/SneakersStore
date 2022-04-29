//
//  GatalogView.swift
//  Sneakers
//
//  Created by Yerkebulan Sharipov on 25.04.2022.
//

import UIKit
import SnapKit

class CatalogView: UIViewController {
    private let text : String
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    init(text: String){
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        label.text = "Hello, \(text)"
        navigationItem.titleView = label
    }
    private func setupHierarchy(){
        [label].forEach{
            view.addSubview($0)
        }
     }
    private func setUI(){
       
    }
}

