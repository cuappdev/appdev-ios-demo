//
//  ViewController.swift
//  appdev-demo
//
//  Created by Drew Dunne on 2/19/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit
import FutureNova
import SnapKit

class ViewController: UIViewController {

    // MARK: Networking Variables
    let networking: Networking = URLSession.shared.request

    // MARK: UIViews
    var redSquare: UIView!

    // MARK: File Constants
    private enum FileConstants {
        // Use this enum for constants used in multiple places in this file only
        static let redSquareBottomPadding: CGFloat = 30
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        view.backgroundColor = .white

        redSquare = UIView()
        redSquare.backgroundColor = .red
        view.addSubview(redSquare)

        makeConstraints()

        // somewhere else where we call loadUser
        loadUser(withID: 1).observe {[weak self] result in
            switch result {
            case .value(let user):
                self?.finishLogin(with: user)
            case .error(let error):
                print(error.localizedDescription)
                //assertionFailure(error.localizedDescription) // will only crash on development, not production
                // self?.presentError(with: error)
            }
        }

    }

    private func makeConstraints() {

        let redSquareLeadingPadding = 12
        let redSquareTrailingPadding: CGFloat = 18

        redSquare.snp.makeConstraints { make in

            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                .offset(redSquareLeadingPadding)

            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(Constants.RedSquareView.topPadding)

            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
                .inset(redSquareTrailingPadding)

            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                .inset(FileConstants.redSquareBottomPadding)

        }

    }

    func finishLogin(with user: User) {
        // Do something
    }

    func loadUser(withID id: Int) -> Future<User> {
        return networking(Endpoint.user(from: id)).decode()
    }

}
