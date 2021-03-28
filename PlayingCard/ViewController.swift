//
//  ViewController.swift
//  PlayingCard
//
//  Created by bogdanov on 24.03.21.
//

import UIKit

class ViewController: UIViewController {
    var deck = PlayingCardDeck()

    @IBOutlet var playingCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
        }
    }

    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            playingCardView.isFaceUp = !playingCardView.isFaceUp
        default:
            break
        }
    }

    @objc func nextCard() {
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1 ... 10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }
}
