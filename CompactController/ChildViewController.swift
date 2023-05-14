//
//  ChildViewController.swift
//  CompactController
//

import UIKit

class ChildViewController: UIViewController {
    
    var onCloseButtonTapped: (() -> Void)?
    var onFirstSegmentSelected: (() -> Void)?
    var onSecondSegmentSelected: (() -> Void)?
    
    private let closeButton = UIButton()
    private let segmentedControl = UISegmentedControl(items: ["280pt", "150pt"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupController()
        setupButton()
        setupSegmentedControl()

        view.addSubview(closeButton)
        view.addSubview(segmentedControl)
        
        setPositions()
    }
    
    private func setupController() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
    }
    
    private func setupButton() {
        closeButton.setImage(UIImage(systemName: "xmark") ?? UIImage(), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    private func setPositions() {
        closeButton.sizeToFit()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        segmentedControl.widthAnchor.constraint(equalToConstant: 140).isActive = true
    }

    @objc
    private func closeButtonTapped() {
        onCloseButtonTapped?()
    }
    
    @objc
    private func segmentedControlValueChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            onFirstSegmentSelected?()
        case 1:
            onSecondSegmentSelected?()
        default:
            break
        }
    }

}
