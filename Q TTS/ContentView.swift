//
//  ContentView.swift
//  Q TTS
//
//  Created by Qerope Santos on 1/4/21.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var text: String = ""
    @State var lang: Int = 1
    @State var clipboard: Bool = true
    @State var speed: Float = 0.5
    var langs = ["English", "French", "German", "Spanish", "Italian", "Arabic", "Russian", "Thai"]
    var langCodes = ["en-US", "fr-FR", "de-DE", "es-ES", "it-IT", "ar-SA", "ru-RU", "th-TH"]

    var body: some View {
        VStack(alignment: .center)
        {
            HStack(alignment: .center) {
                Text("Text:")
                    .font(.callout)
                    .bold()
                TextField("Enter Text...", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding().frame(width: 500, height: .infinity)
            Button("Speak") {
                let tx: String
                if(clipboard){
                    tx = (NSPasteboard.general.pasteboardItems?.first?.string(forType: .string))!
                }else{
                    tx = text
                }
                
                readMe(myText: tx , myLang: langCodes[lang], speed: speed)
            }.padding()
            Text("Speed")
            Slider(value: $speed).padding()
            Picker(selection: $lang, label: Text("Language")) {
                            ForEach(0..<langs.count) { index in
                                Text(self.langs[index]).tag(index)
                            }
            }.pickerStyle(DefaultPickerStyle())
            .padding()
            Toggle(isOn: $clipboard) {
                Text("Get Text From ClipBoard")
            }.padding()
        }
    }
}

func readMe( myText: String , myLang : String, speed : Float) {
    let utterance = AVSpeechUtterance(string: myText )
    utterance.voice = AVSpeechSynthesisVoice(language: myLang)
    let def = UserDefaults.standard
    def.set(speed, forKey: "speed")
    utterance.rate = def.float(forKey: "speed")
    
    let synthesizer = AVSpeechSynthesizer()
    def.set(myLang, forKey: "lang")
    
    synthesizer.speak(utterance)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
