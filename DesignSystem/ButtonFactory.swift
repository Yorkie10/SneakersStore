//
//  ButtonFactory.swift
//  Sneakers
//
//  Created by Yerkebulan Sharipov on 22.04.2022.
//

import UIKit

struct BottonViewModel {
    let text : String
    let backgroundColor : UIColor?
}

final class ButtonFactory: UIButton {
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        clipsToBounds = true
        layer.cornerRadius = 32
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with viewModel: BottonViewModel){
        label.text = viewModel.text
        backgroundColor = viewModel.backgroundColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
}
