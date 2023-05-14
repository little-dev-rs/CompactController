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
    let triangeView = UIView()
    let triangleLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc func showPopup() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        addChild(popupViewController)
        self.view.addSubview(popupViewController.view)
        popupViewController.didMove(toParent: self)
        setupChildVC()
    }
    
    private func setupTriangle() {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 0, y: 0))
        trianglePath.addLine(to: CGPoint(x: 20, y: 20))
        trianglePath.addLine(to: CGPoint(x: -20, y: 20))
        trianglePath.close()
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = UIColor.white.cgColor
    }
    
    private func setupChildVC() {
        setupTriangle()
        setupChildSize(isFirst: true, animated: false)
        popupViewController.onCloseButtonTapped = { [weak self] in
            self?.closePopup()
        }
        popupViewController.onFirstSegmentSelected = { [weak self] in
            self?.setupChildSize(isFirst: true, animated: true)
        }
        popupViewController.onSecondSegmentSelected = { [weak self] in
            self?.setupChildSize(isFirst: false, animated: true)
        }
        popupViewController.view.layer.addSublayer(triangleLayer)
        triangleLayer.frame = CGRect(x: 150, y: -20, width: 20, height: 20)
    }
    
    private func closePopup() {
        view.backgroundColor = .white
        popupViewController.willMove(toParent: nil)
        popupViewController.view.removeFromSuperview()
        popupViewController.removeFromParent()
    }
    
    private func setupChildSize(isFirst: Bool, animated: Bool) {
        let positionPoint = CGPoint(x: (view.frame.width - 300) / 2, y: buttton.frame.maxY + 15)

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.popupViewController.view.frame = CGRect.init(origin: positionPoint, size: CGSize(width: 300, height: isFirst ? 280 : 150))
            }
        } else {
            popupViewController.view.frame = CGRect.init(origin: positionPoint, size: CGSize(width: 300, height: isFirst ? 280 : 150))
        }
    }

}
