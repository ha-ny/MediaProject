//
//  IntroViewController.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/27.
//

import UIKit
import SnapKit

class IntroViewController: UIViewController {

    let introLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .white
        view.font = .systemFont(ofSize: 15)
        view.textAlignment = .center
        return view
    }()
    
    init(description: String){
        super.init(nibName: nil, bundle: nil)
        self.introLabel.text = description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(introLabel)
        introLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
