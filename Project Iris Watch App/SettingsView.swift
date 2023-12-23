//
//  SettingsView.swift
//  Project Iris Watch App
//
//  Created by 雷美淳 on 2023/10/21.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("tipConfirmRequired") var tipConfirmRequired = false
    @AppStorage("isPrivateModeOn") var isPrivateModeOn = false
    @AppStorage("isPrivateModePinned") var isPrivateModePinned = false
    @AppStorage("isPasscodeRequired") var isPasscodeRequired = false
    @AppStorage("isCookiesAllowed") var isCookiesAllowed = false
    @AppStorage("isSettingsButtonPinned") var isSettingsButtonPinned = false
    @AppStorage("tipAnimationSpeed") var tipAnimationSpeed = 1
    @AppStorage("searchEngineSelection") var searchEngineSelection = "Bing"
    @AppStorage("customizedSearchEngine") var customizedSearchEngine = ""
    @State var isCustomizeSearchEngineSheetDisplaying = false
    var body: some View {
        List {
            Section("Settings.search-engine") {
                Picker("Settings.search-engine.default", selection: $searchEngineSelection) {
                    Text("Settings.search-engine.Bing").tag("Bing")
                    Text("Settings.search-engine.Google").tag("Google")
                    Text("Settings.search-engine.Baidu").tag("Baidu")
                    Text("Settings.search-engine.Sougou").tag("Sougou")
                    Text("Settings.search-engine.customize").tag("Customize")
                }
                Button(action: {
                    isCustomizeSearchEngineSheetDisplaying = true
                }, label: {
                    Label("Settings.search-engine.customize...", systemImage: "magnifyingglass")
                })
            }
            
            Section("Settings.tip") {
                Toggle("Settings.tip.confirm", isOn: $tipConfirmRequired)
                Picker("Settings.tip.speed", selection: $tipAnimationSpeed) {
                    Text("Settings.tip.speed.fast")
                        .tag(0)
                    Text("Settings.tip.speed.default")
                        .tag(1)
                    Text("Settings.tip.speed.slow")
                        .tag(2)
                    Text("Settings.tip.speed.very-slow")
                        .tag(3)
                }
            }
            
            Section("Settings.privacy-mode") {
                Toggle(isOn: $isPrivateModeOn, label: {
                    Label("Settings.privacy-mode", systemImage: "hand.raised")
                })
                Toggle(isOn: $isPrivateModePinned, label: {
                    Label("Settings.privacy-mode.pin", systemImage: "pin")
                })
            }
            
            Section(content: {
                if !isPasscodeRequired {
                    NavigationLink(destination: {
                        PasscodeCreateView()
                    }, label: {
                        Label("Settings.passcode.create", systemImage: "lock")
                    })
                } else {
                    NavigationLink(destination: {
                        PasscodeChangeView()
                    }, label: {
                        Label("Settings.passcode.change", systemImage: "lock.open")
                    })
                    NavigationLink(destination: {
                        PasscodeDeleteView()
                    }, label: {
                        Label("Settings.passcode.delete", systemImage: "lock.slash")
                            .foregroundStyle(.red)
                    })
                }
            }, header: {
                Text("Settings.passcode")
            }, footer: {
                Text("Settings.passcode.discription")
            })
            
            Section("Settings.Cookies") {
                Toggle("Settings.cookies.allow", isOn: $tipConfirmRequired)
            }
            
            Section("Settings.interface") {
                Toggle(isOn: $isSettingsButtonPinned, label: {
                    Label("Settings.interface.pin-settings-button", systemImage: "gear")
                })
                Toggle(isOn: $isPrivateModePinned, label: {
                    Label("Settings.privacy-mode.pin", systemImage: "hand.raised")
                })
            }

            Section {
                NavigationLink(destination: {
                    List {
                        VStack {
                            Text("Project Iris")
                                .bold()
                        }
                        //TODO: Expand & Decorate
                    }
                }, label: {
                    Label("Settings.about", systemImage: "info.circle")
                })
            }
        }
        .navigationTitle("Settings")
        .sheet(isPresented: $isCustomizeSearchEngineSheetDisplaying) {
            List {
                HStack {
                    if customizedSearchEngine.contains("\\Iris") {
                        Label("Search.search-engine.customize.replacement-tip", systemImage: "checkmark.circle")
                    } else {
                        Label("Search.search-engine.customize.replacement-tip", systemImage: "exclamationmark.circle")
                    }
                    if !customizedSearchEngine.contains("https://") && !customizedSearchEngine.contains("http://") {
                        Label("Search.search-engine.customize.http-tip", systemImage: "exclamationmark.circle")
                    }
                }
                /* if customizedSearchEngine.isEmpty {
                    Text("Settings.search-engine.customize.none")
                } else {
                    Text(customizedSearchEngine)
                } */
                TextField("Search.search-engine.customize.enter", text: $customizedSearchEngine)
            }
        }
    }
}



#Preview {
    SettingsView()
}
