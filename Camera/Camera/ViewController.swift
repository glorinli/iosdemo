//
//  ViewController.swift
//  Camera
//
//  Created by Glorin Li on 2020/5/14.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var takePictureButton: UIButton!
    var avPlayerVC: AVPlayerViewController!
    var image: UIImage?
    var movieUrl: URL?
    var lastChosenMediaType: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            takePictureButton.isHidden = true
        }
    }
    
    private func updateDisplay() {
        print("UpdateDisplay, mediaType: \(lastChosenMediaType)")
        if let mediaType = lastChosenMediaType {
            if mediaType == kUTTypeImage as String {
                imageView.image = image!
                imageView.isHidden = false
                avPlayerVC?.view.isHidden = true
            } else if mediaType == kUTTypeMovie as String {
                if avPlayerVC == nil {
                    avPlayerVC = AVPlayerViewController()
                    
                    if let avView = avPlayerVC.view {
                        avView.frame = imageView.frame
                        avView.clipsToBounds = true
                        view.addSubview(avView)
                    }
                    
                    setAVPlayerLayoutConstraints()
                }
                
                if let url = movieUrl {
                    imageView.isHidden = true
                    avPlayerVC.player = AVPlayer(url: url)
                    avPlayerVC?.view.isHidden = false
                    avPlayerVC?.player?.play()
                }
            }
        }
    }
    
    private func setAVPlayerLayoutConstraints() {
        if let avView = avPlayerVC?.view {
            avView.translatesAutoresizingMaskIntoConstraints = false
            let views = ["avView": avView, "takePictureButton": takePictureButton!]
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[avView]|", options: .alignAllLeft, metrics: nil, views: views))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[avView]-0-[takePictureButton]|", options: .alignAllLeft, metrics: nil, views: views))
        }
    }

    @IBAction func shootPictureOrVideo(sender: UIButton) {
        pickMediaFromSource(.camera)
    }
    
    @IBAction func selectExistingPictureOrVideo(sender: UIButton) {
        pickMediaFromSource(.photoLibrary)
    }
    
    private func pickMediaFromSource(_ sourceType: UIImagePickerController.SourceType) {
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType)!
        if UIImagePickerController.isSourceTypeAvailable(sourceType) && mediaTypes.count > 0 {
            let picker = UIImagePickerController()
            picker.mediaTypes = mediaTypes
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = sourceType
            present(picker, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: NSLocalizedString("ERROR_ACCESSING_MEDIA_TITLE", comment: "Title of error accessing media dialog"), message: "Unsupported media types", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        lastChosenMediaType = info[UIImagePickerController.InfoKey.mediaType] as? String
        if let mediaType = lastChosenMediaType {
            if mediaType == kUTTypeImage as String {
                image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
                print("Image chosen: \(image)")
            } else if mediaType == kUTTypeMovie as String {
                movieUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            }
        }
        
        picker.dismiss(animated: true, completion: {() -> Void in
            self.updateDisplay()
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

