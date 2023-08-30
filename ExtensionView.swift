//
//  ExtensionView.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/12.
//

import UIKit

extension UIViewController{
    static var identifier: String{
        return String(describing: self)
    }
}

extension UIView{
    static var identifier: String {
        return String(describing: self)
    }
}


protocol ViewSettingFuncsProtocol{
    func addSubViews()
    func constraintsView()
}

protocol ProfileDataSendProtocol{
    func profileEditData(title: String, placeHolder: String)
}

