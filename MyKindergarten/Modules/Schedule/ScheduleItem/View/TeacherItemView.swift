//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import AutoLayoutSugar
import UIKit

final class TeacherView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        makeConstraints()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGestureRecognizer)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Internal

    var tapAction: ((Teacher) -> Void)?

    var person: Teacher? {
        didSet {
            guard let person = person else { return }
            personImageView.loadImage(url: person.photos.first?.url)
            personNameLabel.text = person.name
        }
    }

    // MARK: Private

    private lazy var personImageView = UIImageView().configureWithAutoLayout {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 24
        $0.image = Asset.profilePlaceholder.image
    }

    private lazy var personNameLabel = Label(.body2Regular()).prepareForAutoLayout()

    private func configureSubviews() {
        addSubviews([personImageView, personNameLabel])
    }

    private func makeConstraints() {
        personImageView
            .top(4)
            .bottom(4)
            .width(48)
            .height(48)
            .left()

        personNameLabel
            .centerY(to: personImageView)
            .left(to: .right(14), of: personImageView)
            .compressionResistance(253, .horizontal)
    }

    @objc
    private func viewTapped() {
        guard let person = person else { return }
        tapAction?(person)
    }
}
