//
//  Created by Nikita Borodulin on 20.10.2023.
//

import FloatingPanel
import UIKit

final class ViewController: UIViewController {

    private lazy var button = UIButton(
        configuration: .borderedProminent(),
        primaryAction: .init(
            title: "Update Layout",
            handler: { [weak self] _ in
                self?.updatePanelLayout()
            }
        )
    )

    private let fpc = FloatingPanelController()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        fpc.set(contentViewController: ContentController())
        fpc.layout = FirstLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        present(fpc, animated: true)
    }

    private func updatePanelLayout() {
        if fpc.layout is FirstLayout {
            fpc.layout = SecondLayout()
        } else {
            fpc.layout = FirstLayout()
        }
        fpc.invalidateLayout()
    }
}

final class ContentController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

private final class FirstLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(absoluteInset: 262, edge: .top, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea)
    ]
}

private final class SecondLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] = [
        .half: FloatingPanelLayoutAnchor(absoluteInset: 262, edge: .top, referenceGuide: .safeArea)
    ]
}
