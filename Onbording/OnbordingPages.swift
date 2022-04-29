//
//  OnbordingPages.swift
//  Sneakers
//
//  Created by Yerkebulan Sharipov on 22.04.2022.
//

import UIKit
import SnapKit

class OnbordingImages : UIViewController {
    
    let imageView : UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    init(named: String){
        super.init(nibName: nil, bundle: nil)
        imageView.image = UIImage(named: named)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    func setUI(){
        view.addSubview(imageView)
        imageView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
}

