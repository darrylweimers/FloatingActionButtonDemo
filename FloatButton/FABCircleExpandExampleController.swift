//
//  FABExpandCircleController.swift
//  FloatButton
//
//  Created by Darryl Weimers on 2020-12-26.
//

import UIKit



class FABCircleExpandExampleController : UIViewController {
    
    public enum ButtonType : Int, CaseIterable {
        case main = 0
        case secondary1 = 1
        case secondary2 = 2
        case secondary3 = 3
    }
    
    private enum TransformState {
        case transformed
        case normal
    }
    
    private let spaceBetweenButton: CGFloat = 16
    private let buttonSize: CGFloat = 45//56
    private var secondary1ButtonXTranslation: CGFloat {
        get {
            return (buttonSize * 5 / 2) - buttonSize / 2
        }
    }
    private var secondary2ButtonXTranslation: CGFloat  {
        get {
            return (buttonSize/2 * 5 / 2)  //buttonSize + spaceBetweenButton
        }
    }
    private var secondary2ButtonYTranslation: CGFloat {
        get {
            return (buttonSize/2 * 5 / 2)  //buttonSize + spaceBetweenButton
        }
    }
    
    private var secondary3ButtonYTranslation: CGFloat {
        get {
            return (buttonSize * 5 / 2) - buttonSize / 2
        }
    }
    private var menuViewTransform: TransformState = .normal
    private var buttonTransforms: [TransformState] = [TransformState]()
    
    private lazy var menuView: UIView = {
        let view = UIView()
        view.makeRectangleViewWithDropShadow(backgroundColor: .clear)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttons: [UIButton] = {
        var buttons = [UIButton]()
        for buttonType in ButtonType.allCases {
            let button = createFloatingActionButton(tag: buttonType.rawValue)
            if buttonType.rawValue != ButtonType.main.rawValue {
                button.backgroundColor = .lightGray
            }
            buttonTransforms.append(.normal)
            buttons.append(button)
        }
        return buttons
    }()
    
    private func createFloatingActionButton(tag: Int) -> UIButton {
        let button = UIButton()
        let image = UIImage(systemName: "plus")!
        button.makeFloatingButtonAction(image: image)
        button.tag = tag
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    // MARK: button tapped
    @objc func buttonTapped(_ button: UIButton) {
        guard let buttonType = ButtonType(rawValue: button.tag) else {
            return
        }
        
        if buttonType == .main {
            animateMainButtonRotation()
            animateMenuViewVisibility()
            animateSecondayButtonTranslation()
        }
    }

    private func animateSecondayButtonTranslation() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            switch self.buttonTransforms[ButtonType.secondary1.rawValue] {
            case .transformed:
                for buttonType in ButtonType.secondary1.rawValue...ButtonType.secondary3.rawValue {
                    self.buttons[buttonType].transform = .identity
                    self.buttonTransforms[buttonType] = .normal
                }
                break
                
            case .normal:
                for buttonType in ButtonType.secondary1.rawValue...ButtonType.secondary3.rawValue {
                    if buttonType == ButtonType.secondary1.rawValue {
                        self.buttons[buttonType].transform = CGAffineTransform(translationX: -self.secondary1ButtonXTranslation, y: 0)
                        
                    } else if buttonType == ButtonType.secondary2.rawValue {
                        self.buttons[buttonType].transform = CGAffineTransform(translationX: -self.secondary2ButtonXTranslation, y: -self.secondary2ButtonYTranslation)
                        
                    } else if buttonType == ButtonType.secondary3.rawValue {
                        self.buttons[buttonType].transform = CGAffineTransform(translationX: 0, y: -self.secondary3ButtonYTranslation)
                        
                    }
                    
                    self.buttonTransforms[buttonType] = .transformed
                }
                break
            }
        }, completion: nil)
    }
    
    private func animateMainButtonRotation() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            switch self.buttonTransforms[ButtonType.main.rawValue] {
            case .transformed:
                self.buttons[ButtonType.main.rawValue].transform = .identity
                self.buttonTransforms[ButtonType.main.rawValue] = .normal
                break

            case .normal:
                self.buttons[ButtonType.main.rawValue].transform = CGAffineTransform(rotationAngle: -CGFloat.pi * 0.75)
                self.buttonTransforms[ButtonType.main.rawValue] = .transformed
                break
            }
        }, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setDefaultMenuState()
    }

    private func setDefaultMenuState() {
        menuView.isHidden = false
    }

    private func animateMenuViewVisibility() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            switch self.menuViewTransform {
            case .transformed:
                self.menuView.transform = .identity
                self.menuViewTransform = .normal
                break

            case .normal:
                self.menuView.transform = CGAffineTransform(scaleX: 5, y: 5)
                self.menuViewTransform = .transformed
                break
            }
            
        }, completion: nil)
        
    }

    private func setupViews(){
        let superview: UIView = self.view

        superview.addSubview(menuView)
        
        let insetToCorner: CGFloat = 16
        
        // add main button last
        for button in buttons.reversed() {
            superview.addSubview(button)

            // pin FAB to right bottom corner
            button.layer.cornerRadius = buttonSize / 2
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: buttonSize),
                button.widthAnchor.constraint(equalToConstant: buttonSize),
                button.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insetToCorner),
                button.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insetToCorner),
            ])
        }

        // menu view
        menuView.layer.cornerRadius = buttonSize/2
        // drop shadow
        menuView.layer.shadowOpacity = 0.25
        menuView.layer.shadowRadius = 5
        menuView.layer.shadowOffset = CGSize(width: 0, height: 5) // move down by 5 points
        NSLayoutConstraint.activate([
            menuView.heightAnchor.constraint(equalToConstant: buttonSize),
            menuView.widthAnchor.constraint(equalToConstant: buttonSize),
//            menuView.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insetToCorner),
            menuView.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insetToCorner),
            menuView.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insetToCorner),
        ])
    }
}
