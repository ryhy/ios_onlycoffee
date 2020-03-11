//
//  YPPicker.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/03.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import Foundation
import YPImagePicker

class YPPicker {
    
    private var selectedItems = [YPMediaItem]()
    
    private func initConfig() -> YPImagePickerConfiguration {
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photo
        config.shouldSaveNewPicturesToAlbum = true
        config.startOnScreen = .library
        config.screens = [.library, .photo]
        config.showsCrop = YPCropType.rectangle(ratio: 4/3)
        config.wordings.libraryTitle = "Gallery"
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.library.maxNumberOfItems = 5
        return config
    }
    
    func finish(from: UIViewController,completion: @escaping (YPMediaPhoto) -> Void) {
        let picker = YPImagePicker(configuration: initConfig())
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            
            if cancelled {
                print("Picker was canceled")
                picker.dismiss(animated: true, completion: nil)
                return
            }
            
            _ = items.map { print("🧀 \($0)") }
            self.selectedItems = items
            if let firstItem = items.first {
                switch firstItem {
                case .photo(let photo):
                    picker.dismiss(animated: true, completion: nil)
                    completion(photo)
                case .video(let video):
                    print(video.fromCamera)
                    break;
                }
            }
        }
        
        from.present(picker, animated: true, completion: nil)
    }
    
    
}
