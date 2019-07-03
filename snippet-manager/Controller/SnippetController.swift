//
//  SnippetController.swift
//  snippet-manager
//
//  Created by Manu on 03/07/2019.
//  Copyright © 2019 Manu Marchand. All rights reserved.
//

import UIKit
import Highlightr

class SnippetController: UIViewController, UITextViewDelegate {
    
    var textView = UITextView()
    var highlightr : Highlightr!
    let textStorage = CodeAttributedString()
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    var snippet: Snippet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layoutManager = NSLayoutManager()
        textStorage.highlightr.setTheme(to: "solarized-dark")
        
        if let language = snippet.language {
            textStorage.language = language.lowercased()
        }
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: view.bounds.size)
        layoutManager.addTextContainer(textContainer)
        
        highlightr = textStorage.highlightr
        
        textView = UITextView(frame: contentTextView.bounds, textContainer: textContainer)
        textView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textView.autocorrectionType = UITextAutocorrectionType.no
        textView.autocapitalizationType = UITextAutocapitalizationType.none
        textView.textColor = UIColor(white: 1, alpha: 1.0)
        textView.backgroundColor = .clear
        
    
        if let contentView = contentTextView.superview {
            contentTextView.removeFromSuperview()
           
            contentView.addSubview(textView)
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.isScrollEnabled = false
            
            let topConstraint = NSLayoutConstraint(item: textView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleTextView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 8)
            let leadingConstraint = NSLayoutConstraint(item: textView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 16)
            let widthConstraint = NSLayoutConstraint(item: textView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleTextView, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
            
            
            //There is a layout issue when using the trailling
            //constraint, using the width constraint instead
            NSLayoutConstraint.activate([topConstraint, leadingConstraint, widthConstraint])
            textView.text = snippet.content
        }
        
        titleTextView.text = snippet.title
        textView.layoutIfNeeded()
        
        //titleTextView.delegate = self
        //contentTextView.delegate = self
    }
}
