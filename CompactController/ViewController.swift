//
//  ViewController.swift
//  CompactController
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttton: UIButton!

    @IBAction func buttonTapped(_ sender: UIButton) {
        showPopup()
    }
    
    let popupViewController = ChildViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc func showPopup() {
        addChild(popupViewController)
        
//        let overlayView = UIView(frame: parentViewController.view.bounds)
//        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        overlayView.tag = 100 // Add a tag to the overlay view for later removal

        setupChildSize(isFirst: true, animated: false)
        self.view.addSubview(popupViewController.view)
        popupViewController.didMove(toParent: self)
        setupChildVC()
    }
    
    private func setupChildVC() {
        popupViewController.onCloseButtonTapped = { [weak self] in
            self?.closePopup()
        }
        popupViewController.onFirstSegmentSelected = { [weak self] in
            self?.setupChildSize(isFirst: true, animated: true)
        }
        popupViewController.onSecondSegmentSelected = { [weak self] in
            self?.setupChildSize(isFirst: false, animated: true)
        }
    }
    
    private func closePopup() {
        popupViewController.willMove(toParent: nil)
        popupViewController.view.removeFromSuperview()
        popupViewController.removeFromParent()
    }
    
    private func setupChildSize(isFirst: Bool, animated: Bool) {
        let positionPoint = CGPoint(x: (view.frame.width - 300) / 2, y: buttton.frame.maxY)

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.popupViewController.view.frame = CGRect.init(origin: positionPoint, size: CGSize(width: 300, height: isFirst ? 280 : 150))
            }
        } else {
            popupViewController.view.frame = CGRect.init(origin: positionPoint, size: CGSize(width: 300, height: isFirst ? 280 : 150))
        }
    }

}

class ChildViewController: UIViewController {
    
    var onCloseButtonTapped: (() -> Void)?
    var onFirstSegmentSelected: (() -> Void)?
    var onSecondSegmentSelected: (() -> Void)?
    
    let closeButton = UIButton()
    let segmentedControl = UISegmentedControl(items: ["280pt", "150pt"])
    
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
        view.backgroundColor = .yellow
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
    func closeButtonTapped() {
        onCloseButtonTapped?()
    }
    
    @objc
    func segmentedControlValueChanged(_ segmentedControl: UISegmentedControl) {
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
