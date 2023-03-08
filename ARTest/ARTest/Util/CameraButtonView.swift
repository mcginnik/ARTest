//
//  CameraButtonView.swift
//  ARTest
//
//  Created by Kyle McGinnis on 3/8/23.
//

import SwiftUI

struct CameraButtonView: View {
    
    let size: CGSize = .init(width: 60, height: 60)
    let didTap: () -> Void
    var body: some View {
        Button {
            didTap()
        } label: {
            Color.red
                .frame(width: size.width, height: size.height)
                .cornerRadius(.infinity)
        }
    }
}

struct CameraButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CameraButtonView(){}
    }
}
