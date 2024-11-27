//
//  SectionHeaderBackground.swift
//  myBattleTalk
//
//  Created by 张海 on 2024/11/25.
//

import SwiftUI

struct SectionHeaderBackground: View {
  let color: Color

  init(_ color: Color = .app_bg) {
    self.color = color
  }

  var body: some View {
    color
      .listRowInsets(.zero)
      .listRowSeparator(.hidden)
  }
}

struct SectionHeaderBackground_Previews: PreviewProvider {
  static var previews: some View {
    SectionHeaderBackground()
  }
}
