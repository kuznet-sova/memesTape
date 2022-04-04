//
//  AddCommentView.swift
//  memesTape
//
//  Created by Ирина Кузнецова on 04.04.2022.
//

import UIKit

protocol AddCommentViewDelegate {
    func didSubmit(comment: String)
}

class AddCommentView: UIView {
    
    var delegate: AddCommentViewDelegate?
    
    private let commentTextView: CommentInputTextView = {
        let commentTextView = CommentInputTextView()
        commentTextView.placeholderLabel.text = "Add a comment"
        commentTextView.isScrollEnabled = false
        commentTextView.layer.cornerRadius = 12
        commentTextView.font = UIFont.systemFont(ofSize: 18)
        commentTextView.autocorrectionType = .no
        return commentTextView
    }()
    
    private let sendButton: UIButton = {
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        sendButton.setTitleColor(.systemGray, for: .normal)
        sendButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        sendButton.isEnabled = false
        return sendButton
    }()
    
    func clearCommentTextField() {
        commentTextView.text = nil
        commentTextView.showPlaceHolderLabel()
        sendButton.isEnabled = false
        sendButton.setTitleColor(.systemGray, for: .normal)
    }
    
    private func sharedInit() {
        backgroundColor = .secondarySystemBackground
        autoresizingMask = .flexibleHeight
        
        addSubview(sendButton)
        sendButton.anchor(top: nil, left: nil, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 50)
        
        addSubview(commentTextView)
        commentTextView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: sendButton.leftAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 8, paddingRight: 12, width: 0, height: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    override var intrinsicContentSize: CGSize { return .zero }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    @objc private func handleSubmit() {
        guard let commentText = commentTextView.text else { return }
        commentTextView.resignFirstResponder()
        delegate?.didSubmit(comment: commentText)
    }
    
    @objc private func handleTextChange() {
        guard let text = commentTextView.text else { return }
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            sendButton.isEnabled = false
            sendButton.setTitleColor(.systemGray, for: .normal)
        } else {
            sendButton.isEnabled = true
            sendButton.setTitleColor(.systemBlue, for: .normal)
        }
    }
    
}
