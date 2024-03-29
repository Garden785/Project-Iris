//
//  PasscodeView.swift
//  Project Iris Watch App
//
//  Created by 雷美淳 on 2023/10/21.
//

import SwiftUI

struct PasscodeView: View {
    @AppStorage("isPasscodeRequired") var isPasscodeRequired = false
    @AppStorage("isBookmarkRequiringPassword") var isBookmarkRequiringPassword = false
    @AppStorage("passcode1") var passcode1 = 0
    @AppStorage("passcode2") var passcode2 = 0
    @AppStorage("passcode3") var passcode3 = 0
    @AppStorage("passcode4") var passcode4 = 0
    @State var inputCode1 = 0
    @State var inputCode2 = 0
    @State var inputCode3 = 0
    @State var inputCode4 = 0
    @State var isUnlocked = false
    var destination: Int
    var body: some View {
        if #available(watchOS 10.0, *) {
            if isPasscodeRequired && !isUnlocked && (isBookmarkRequiringPassword || destination != 1) {
                VStack {
                    Text("Passcode.enter")
                        .bold()
                        .multilineTextAlignment(.center)
                  PasscodeInputView(digit1: $inputCode1, digit2: $inputCode2, digit3: $inputCode3, digit4: $inputCode4)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            if inputCode1 == passcode1 && inputCode2 == passcode2 && inputCode3 == passcode3 && inputCode4 == passcode4 {
                                isUnlocked = true
                            } else {
                                showTip("Passcode.incorrect", symbol: "lock")
                            }
                        } label: {
                            Label("Passcode.submit", systemImage: "checkmark")
                                .foregroundStyle(.primary)
                        }
                    }
                }
            } else {
                if destination == 0 {
                    HistoryView()
                } else if destination == 1 {
                    BookmarksView()
                } else if destination == 2 {
                    VStack {
                        if isBookmarkRequiringPassword {
                            Image(systemName: "lock")
                                .font(.largeTitle)
                            Text("Settings.passcode.bookmarks.required")
                                .multilineTextAlignment(.center)
                        } else {
                            Image(systemName: "lock.open")
                                .font(.largeTitle)
                            Text("Settings.passcode.bookmarks.no-require")
                                .multilineTextAlignment(.center)
                        }
                    }
                    .onAppear {
                        isBookmarkRequiringPassword.toggle()
                    }
                }
            }
        }
    }
}

struct PasscodeChangeView: View {
    @AppStorage("isPasscodeRequired") var isPasscodeRequired = false
    @AppStorage("passcode1") var passcode1 = 0
    @AppStorage("passcode2") var passcode2 = 0
    @AppStorage("passcode3") var passcode3 = 0
    @AppStorage("passcode4") var passcode4 = 0
    @State var newCode1 = 0
    @State var newCode2 = 0
    @State var newCode3 = 0
    @State var newCode4 = 0
    @State var inputCode1 = 0
    @State var inputCode2 = 0
    @State var inputCode3 = 0
    @State var inputCode4 = 0
    @State var step = 1
    @State var offset: CGFloat = 0
    var body: some View {
        if #available(watchOS 10.0, *) {
            VStack {
                ZStack {
                    Text("Passcode.change.old")
                        .multilineTextAlignment(.center)
                        .offset(x: offset)
                    Text("Passcode.change.new")
                        .multilineTextAlignment(.center)
                        .offset(x: offset+500)
                    Text("Passcode.change.verify")
                        .multilineTextAlignment(.center)
                        .offset(x: offset+1000)
                    Text("Passcode.change.success")
                        .offset(x: offset+1500)
                }
                .bold()
                .animation(.easeInOut(duration: 0.5), value: offset)
              PasscodeInputView(digit1: $inputCode1, digit2: $inputCode2, digit3: $inputCode3, digit4: $inputCode4)
                .disabled(step==4)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        if inputCode1 == passcode1 && inputCode2 == passcode2 && inputCode3 == passcode3 && inputCode4 == passcode4 && step == 1 {
                            inputCode1 = 0
                            inputCode2 = 0
                            inputCode3 = 0
                            inputCode4 = 0
                            step = 2
                            offset = -500
                        } else if step == 2 {
                            newCode1 = inputCode1
                            newCode2 = inputCode2
                            newCode3 = inputCode3
                            newCode4 = inputCode4
                            inputCode1 = 0
                            inputCode2 = 0
                            inputCode3 = 0
                            inputCode4 = 0
                            step = 3
                            offset = -1000
                        } else if inputCode1 == newCode1 && inputCode2 == newCode2 && inputCode3 == newCode3 && inputCode4 == newCode4 && step == 3 {
                            passcode1 = newCode1
                            passcode2 = newCode2
                            passcode3 = newCode3
                            passcode4 = newCode4
                            step = 4
                            offset = -1500
                        } else {
                            if step == 3 {
                                showTip("Passcode.mismatch", symbol: "xmark")
                            } else {
                                showTip("Passcode.incorrect", symbol: "lock")
                            }
                        }
                    } label: {
                        Label("Passcode.next-step", systemImage: "chevron.forward")
                    }
                    .disabled(step == 4)
                }
            }
        }
    }
}

struct PasscodeCreateView: View {
    @AppStorage("isPasscodeRequired") var isPasscodeRequired = false
    @AppStorage("passcode1") var passcode1 = 0
    @AppStorage("passcode2") var passcode2 = 0
    @AppStorage("passcode3") var passcode3 = 0
    @AppStorage("passcode4") var passcode4 = 0
    @State var newCode1 = 0
    @State var newCode2 = 0
    @State var newCode3 = 0
    @State var newCode4 = 0
    @State var inputCode1 = 0
    @State var inputCode2 = 0
    @State var inputCode3 = 0
    @State var inputCode4 = 0
    @State var step = 1
    @State var offset: CGFloat = 0
    var body: some View {
        if #available(watchOS 10.0, *) {
            VStack {
                ZStack {
                    Text("Passcode.create.new")
                        .multilineTextAlignment(.center)
                        .offset(x: offset)
                    Text("Passcode.create.verify")
                        .offset(x: offset+500)
                    Text("Passcode.create.success")
                        .offset(x: offset+1000)
                }
                .bold()
                .animation(.easeInOut(duration: 0.5), value: offset)
              PasscodeInputView(digit1: $inputCode1, digit2: $inputCode2, digit3: $inputCode3, digit4: $inputCode4)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        if step == 1 {
                            newCode1 = inputCode1
                            newCode2 = inputCode2
                            newCode3 = inputCode3
                            newCode4 = inputCode4
                            inputCode1 = 0
                            inputCode2 = 0
                            inputCode3 = 0
                            inputCode4 = 0
                            step = 2
                            offset = -500
                        } else if inputCode1 == newCode1 && inputCode2 == newCode2 && inputCode3 == newCode3 && inputCode4 == newCode4 && step == 2 {
                            passcode1 = newCode1
                            passcode2 = newCode2
                            passcode3 = newCode3
                            passcode4 = newCode4
                            step = 3
                            offset = -1000
                            isPasscodeRequired = true
                        } else {
                            showTip("Passcode.mismatch", symbol: "xmark")
                        }
                    } label: {
                        Label("Passcode.next-step", systemImage: "chevron.forward")
                    }
                    .disabled(step == 3)
                }
            }
        }
    }
}

struct PasscodeDeleteView: View {
    @AppStorage("isPasscodeRequired") var isPasscodeRequired = false
    @AppStorage("isBookmarkRequiringPassword") var isBookmarkRequiringPassword = false
    @AppStorage("passcode1") var passcode1 = 0
    @AppStorage("passcode2") var passcode2 = 0
    @AppStorage("passcode3") var passcode3 = 0
    @AppStorage("passcode4") var passcode4 = 0
    @State var inputCode1 = 0
    @State var inputCode2 = 0
    @State var inputCode3 = 0
    @State var inputCode4 = 0
    @State var step = 1
    @State var offset: CGFloat = 0
    var body: some View {
        if #available(watchOS 10.0, *) {
            VStack {
                ZStack {
                    Text("Passcode.delete.enter")
                        .multilineTextAlignment(.center)
                        .offset(x: offset)
                    Text("Passcode.delete.confirm")
                        .multilineTextAlignment(.center)
                        .offset(x: offset+500)
                    Text("Passcode.delete.success")
                        .offset(x: offset+1000)
                }
                .bold()
                .animation(.easeInOut(duration: 0.5), value: offset)
              PasscodeInputView(digit1: $inputCode1, digit2: $inputCode2, digit3: $inputCode3, digit4: $inputCode4)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        if inputCode1 == passcode1 && inputCode2 == passcode2 && inputCode3 == passcode3 && inputCode4 == passcode4 && step == 1 {
                            inputCode1 = 0
                            inputCode2 = 0
                            inputCode3 = 0
                            inputCode4 = 0
                            step = 2
                            offset = -500
                        } else if inputCode1 == 1 && inputCode2 == 2 && inputCode3 == 3 && inputCode4 == 4 && step == 2 {
                            step = 3
                            isPasscodeRequired = false
                            //                        isBookmarkRequiringPassword = false
                            offset = -1000
                        } else {
                            if step == 2 {
                                showTip("Passcode.mismatch", symbol: "xmark")
                            } else {
                                showTip("Passcode.incorrect", symbol: "lock")
                            }
                        }
                    } label: {
                        Label("Passcode.next-step", systemImage: "chevron.forward")
                    }.disabled(step == 3)
                }
            }
        }
    }
}

struct PasscodeInputView: View {
  @Binding var digit1: Int
  @Binding var digit2: Int
  @Binding var digit3: Int
  @Binding var digit4: Int
//  @State var rotation1: Double = 0.0
  var body: some View {
    HStack {
      Picker("Passcode.digit.1", selection: $digit1) {
        Text("0").tag(0)
        Text("1").tag(1)
        Text("2").tag(2)
        Text("3").tag(3)
        Text("4").tag(4)
        Text("5").tag(5)
        Text("6").tag(6)
        Text("7").tag(7)
        Text("8").tag(8)
        Text("9").tag(9)
      }
//      .digitalCrownRotation($rotation1, from: 0.0, through: 9.0, sensitivity: .low)
      Picker("Passcode.digit.2", selection: $digit2) {
        Text("0").tag(0)
        Text("1").tag(1)
        Text("2").tag(2)
        Text("3").tag(3)
        Text("4").tag(4)
        Text("5").tag(5)
        Text("6").tag(6)
        Text("7").tag(7)
        Text("8").tag(8)
        Text("9").tag(9)
      }
      Picker("Passcode.digit.3", selection: $digit3) {
        Text("0").tag(0)
        Text("1").tag(1)
        Text("2").tag(2)
        Text("3").tag(3)
        Text("4").tag(4)
        Text("5").tag(5)
        Text("6").tag(6)
        Text("7").tag(7)
        Text("8").tag(8)
        Text("9").tag(9)
      }
      Picker("Passcode.digit.4", selection: $digit4) {
        Text("0").tag(0)
        Text("1").tag(1)
        Text("2").tag(2)
        Text("3").tag(3)
        Text("4").tag(4)
        Text("5").tag(5)
        Text("6").tag(6)
        Text("7").tag(7)
        Text("8").tag(8)
        Text("9").tag(9)
      }
    }
    .bold()
    .labelsHidden()
//    .onAppear(perform: {
//      Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
//          digit1 = Int(rotation1)
//
//      }
//    })
  }
}
