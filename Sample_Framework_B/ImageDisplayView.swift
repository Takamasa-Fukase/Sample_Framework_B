//
//  ImageDisplayView.swift
//  Sample_Framework_B
//
//  Created by ウルトラ深瀬 on 11/12/24.
//

import UIKit

public final class ImageDisplayView: UIView {
    private var count: Int = 0
    private let imageUrls = [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2AFuVo5dMHzUFzooE8JgOzg4NhAuvR2qEVA&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSl61pSsEmx2dY1SAg_Yo7cm39tfLmLf5iqdH2zNE_Xh7TFILLFSJ0M5Hj_o-NgHKJNBrg&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9zCxkxxa1DAr0LbE8iOJK1FhcnEPAT67zGhlNT3sJ2d83B2j_oAZj8ydLtvUvjPWFh_8&usqp=CAU"
    ]

    @IBOutlet var networkImageView: UIImageView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        loadNib()
        showImage()
    }
    
    public func updateImage() {
        print("FW_B updateImage 現在のcount")
        if count == 2 {
            count = 0
        }else {
            count += 1
        }
        print("FW_B updateImage 更新後のcount")
        
        showImage()
    }
    
    private func showImage() {
        print("FW_B showImage")
        Task {
            do {
                networkImageView.image = try await getImage(from: URL(string: imageUrls[count])!)
                print("FW_B 取得した画像を表示した count' \(count)")
            }catch {
                
            }
        }
    }
    
    private func getImage(from url: URL) async throws -> UIImage {
        print("FW_B getImage")
        let session = URLSession(configuration: .default)
        let (data, _) = try await session.data(from: url)
        return UIImage(data: data) ?? UIImage()
    }
}
