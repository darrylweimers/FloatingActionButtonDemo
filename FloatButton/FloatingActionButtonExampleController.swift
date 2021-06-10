//
//  FloatingActionButtonExampleController.swift
//  FloatButton
//
//  Created by Darryl Weimers on 2020-12-26.
//

import UIKit


class FloatingActionButtonExampleController : UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus")!
        button.makeFloatingButtonAction(image: image)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews(){
        let superview: UIView = self.view

        superview.addSubview(button)

        // pin FAB to right bottom corner
        let insetToCorner: CGFloat = 30
        let buttonSize: CGFloat = 56
        button.layer.cornerRadius = buttonSize / 2
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: buttonSize),
            button.widthAnchor.constraint(equalToConstant: buttonSize),
            button.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insetToCorner),
            button.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insetToCorner),
        ])

    }
}
