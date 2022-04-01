//
//  TapeViewCell.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.03.2022.
//

import UIKit

class TapeViewCell: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet var scrollViev: UIScrollView!
    @IBOutlet var memeImageViev: UIImageView!
    @IBOutlet var likesCounterLebel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var memeAuthorLabel: UILabel!
    @IBOutlet var memeDescriptionLebel: UILabel!
    
    static let reuseIdentifier = String(describing: TapeViewCell.self)
    private var likesCount = 0
    private var isChosen = false
//    Не успеваю нарисовать картинку с UIBezierPath, пока просто готовое изображение
    private let likeImageView = UIImageView(image: UIImage(named: "heart50.png"))
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        Сделать даблтап только по картинке, а не по всей ячейке пока не получилось
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapFunc))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
//        Тут еще осталось разобраться как поправить скачущие размеры imageView при масштабировании (схлопывается картинка при увеличении, скрываются лейблы с автором/описанием, картинка дергается при приближении)
        scrollViev.delegate = self
        scrollViev.minimumZoomScale = 1.0
        scrollViev.maximumZoomScale = 10.0
        memeImageViev.image = UIImage(named: "defaultImage.jpg")
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(memeInfo: Meme) {
        NetworkManager.shared.getMemeImage(with: memeInfo.url) { memeImage in
            self.memeImageViev.image = memeImage
        }
        likesCount = memeInfo.ups
        memeAuthorLabel.text = memeInfo.author
        memeDescriptionLebel.text = memeInfo.title
        likesCounterLebel.text = likesCountUniversal(count: likesCount)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        selectionStyle = .none
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return memeImageViev
    }
    
    private func likesCountUniversal(count: Int) -> String {
        let formatString = NSLocalizedString("likes count",
                                                      comment: "likes count string format to be found in Localized.stringsdict")
        let resultString = String.localizedStringWithFormat(formatString, count)
    
        return resultString
    }
    
    private func getFullLikesInfo(doubleTap: Bool) {
        if isChosen == true {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likesCount -= 1
            likesCounterLebel.text = likesCountUniversal(count: likesCount)
            isChosen = false
        } else {
            if doubleTap == true {
                memeImageViev.addSubview(likeImageView)
                animateImageView(animateView: likeImageView)
                likeImageView.centerXAnchor.constraint(equalTo: memeImageViev.centerXAnchor).isActive = true
                likeImageView.centerYAnchor.constraint(equalTo: memeImageViev.centerYAnchor).isActive = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.likeImageView.removeFromSuperview()
                }
            }
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likesCount += 1
            likesCounterLebel.text = likesCountUniversal(count: likesCount)
            isChosen = true
        }
    }
    
    private func animateImageView(animateView: UIImageView) {
        let animateSide = (animateView.frame.width + animateView.frame.height) / 2
        let multiplier: CGFloat = animateView.frame.width == animateSide ? 1 : 2
        let animations = {
            animateView.frame.size = .init(width: animateSide * multiplier, height: animateSide * multiplier)
        }
        UIView.animate(withDuration: 0.2, animations: animations)
    }
    
    @objc func doubleTapFunc() {
        getFullLikesInfo(doubleTap: true)
    }
    
    @IBAction private func likeButtonTap(_ sender: Bool) {
        getFullLikesInfo(doubleTap: false)
    }
    
}
