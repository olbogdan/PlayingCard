//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by bogdanov on 25.03.21.
//

import UIKit

class PlayingCardView: UIView {
    var rank: Int = 5 {
        didSet { setNeedsDisplay(); setNeedsLayout() }
    }

    var suit: String = "❤️" {
        didSet { setNeedsDisplay(); setNeedsLayout() }
    }

    var isFaceUp: Bool = true {
        didSet { setNeedsDisplay(); setNeedsLayout() }
    }

    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(
            string: string, attributes: [.paragraphStyle: paragraphStyle, .font: font])
    }

    private var cornerString: NSAttributedString {
        return centeredAttributedString(rankString + "\n" + suit, fontSize: cornerFontSize)
    }

    private lazy var upperLeftCornerLabel = createCornerLabel()
    private lazy var lowerRightCornerLabel = createCornerLabel()

    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        addSubview(label)
        return label
    }

    private func configureCornerLabel(_ label: UILabel) {
        label.attributedText = cornerString
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.isHidden = !isFaceUp
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureCornerLabel(upperLeftCornerLabel)
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)

        configureCornerLabel(lowerRightCornerLabel)
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowerRightCornerLabel.frame.width, dy: -lowerRightCornerLabel.frame.height)
        lowerRightCornerLabel.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi)
    }

    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
}

extension PlayingCardView {
    private enum SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }

    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }

    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }

    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }

    private var rankString: String {
        switch rank {
        case 1:
            return "A"
        case 2 ... 10:
            return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default:
            return "?"
        }
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
}
