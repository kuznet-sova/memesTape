//
//  TapeViewCell.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 20.03.2022.
//

import UIKit

protocol CellDelegate: AnyObject {
    func openMessagesVC(messageInfo: Message)
}

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
    var spinnerView: UIActivityIndicatorView?
    weak var cellDelegate: CellDelegate?
    var messageInfo = Message(author: "No name", description: "...")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        Сделать даблтап только по картинке, а не по всей ячейке пока не получилось
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapFunc))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
        scrollViev.delegate = self
        scrollViev.minimumZoomScale = 1.0
        scrollViev.maximumZoomScale = 2.0
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView = SpinnerViewController().showSpinner(in: memeImageViev)
    }
    
    func configure(memeInfo: Meme) {
        likesCount = memeInfo.ups
        memeAuthorLabel.text = memeInfo.author
        memeDescriptionLebel.text = memeInfo.title
        likesCounterLebel.text = likesCountUniversal(count: likesCount)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        selectionStyle = .none
        messageInfo = Message(author: "🥷 @\(memeInfo.author)", description: memeInfo.title)
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
        if isChosen {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likesCount -= 1
            likesCounterLebel.text = likesCountUniversal(count: likesCount)
            isChosen = false
        } else {
            if doubleTap {
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
    
    override func prepareForReuse() {
        memeImageViev.image = nil
    }
    
    @objc func doubleTapFunc() {
        getFullLikesInfo(doubleTap: true)
    }
    
    @IBAction private func likeButtonTap(_ sender: UIButton) {
        getFullLikesInfo(doubleTap: false)
    }
    
    @IBAction private func messageButtonTap(_ sender: UIButton) {
        cellDelegate?.openMessagesVC(messageInfo: messageInfo)
    }
    
}
