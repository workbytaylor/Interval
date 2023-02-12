//
//  LogoView.swift
//  Interval
//
//  Created by Nilakshi Roy on 2023-02-08.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Text("0")
            .font(
                .system(size: 96).width(.condensed)
            )
            .rotationEffect(.degrees(90))
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
