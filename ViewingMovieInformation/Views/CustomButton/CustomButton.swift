//
//  CustomButton.swift
//  ViewingMovieInformation
//
//  Created by Денис Набиуллин on 30.04.2023.
//

import UIKit

final class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init(systemName: String) {
        super.init(frame: .zero)
        let setButton = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
        let largeBoldDoc = UIImage(systemName: "\(systemName)", withConfiguration: setButton)
        setImage(largeBoldDoc, for: .normal)
        tintColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
