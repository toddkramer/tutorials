
//  Copyright © 2018 Todd Kramer. All rights reserved.

import UIKit

class ProfileHeaderView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!

    var imageRequest: URLSessionDataTask?

    override func awakeFromNib() {
        super.awakeFromNib()

        setupImageView()
    }

    func setupImageView() {
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
    }

    func reset() {
        imageRequest?.cancel()
        imageRequest = nil
    }

    func configure(with profile: Profile) {
        nameLabel.text = profile.name
        blogLabel.text = profile.blog
        loadImage(for: profile)
    }

    func loadImage(for profile: Profile) {
        guard let url = URL(string: profile.avatarURL) else { return }
        imageRequest = APIService.shared.requestImage(withURL: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.imageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }

}
