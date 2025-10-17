//
//  MoreDetailsViewController.swift
//  PodcastApp
//
//  Created by Abrar on 16/10/2025.
//

import Foundation
import UIKit

class MoreDetailsViewController: UIViewController {
    @IBOutlet weak var descriptionTextView: UITextView?
    
    var content: ViewableContent? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStyle()
        configureTextView()
        getReadableDescription()
    }
    
    private func viewStyle() {
        self.overrideUserInterfaceStyle = .dark
        self.view.backgroundColor = .clear
    }
    
    private func configureTextView() {
        descriptionTextView?.isEditable = false
        descriptionTextView?.isSelectable = true
        descriptionTextView?.dataDetectorTypes = .link // Makes links clickable
        descriptionTextView?.isScrollEnabled = true // If content is long
        descriptionTextView?.backgroundColor = .clear
        descriptionTextView?.textColor = .white
    }
    
    private func getReadableDescription() {
        guard let content = content?.description else {
                descriptionTextView?.text = "Content not set."
                return
            }
            
            let desiredDefaultFont = UIFont.systemFont(ofSize: 20)
            
            if let attributedText = content.toAttributedText() {
                
                descriptionTextView?.attributedText = attributedText

                descriptionTextView?.textStorage.addAttributes(
                    [.font: desiredDefaultFont,
                     .foregroundColor: UIColor.white
                    ],
                    range: NSRange(location: 0, length: attributedText.length)
                )
                
                descriptionTextView?.linkTextAttributes = [
                    .foregroundColor: descriptionTextView?.tintColor ?? .systemBlue,
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ]
                
            } else {
                descriptionTextView?.text = content
            }
    }
}
