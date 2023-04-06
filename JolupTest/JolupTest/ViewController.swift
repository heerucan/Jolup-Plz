//
//  ViewController.swift
//  JolupTest
//
//  Created by heerucan on 2023/04/03.
//

import UIKit

import Moya

final class ViewController: UIViewController {
    
    private let provider = MoyaProvider<NaverAPI>()
    private let chatProvider = MoyaProvider<ChatAPI>()
        
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var gptLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var positiveLabel: UILabel!
    @IBOutlet weak var negativeLabel: UILabel!
    @IBOutlet weak var neutralLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func analyzeButton(_ sender: Any) {
        guard let text = textField.text else { return }
        requestNaverAPI(text: text)
        requestChatAPI(prompt: text)
    }

    // MARK: - NAVER Sentiment API
    
    private func requestNaverAPI(text: String) {
        
        let text = NaverRequest(content: text)
        
        provider.request(.analyze(text: text)) { result in
            switch result {
            case let .success(response):
                do {
                    let analysisResult = try response.map(NaverResponse.self)
                    self.handleAnalysisResult(analysisResult)
                } catch {
                    self.handleAnalysisError()
                    print(error)
                }
            case let .failure(error):
                self.handleAnalysisError()
                print(error)
            }
        }
    }
    
    private func handleAnalysisResult(_ result: NaverResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.resultLabel.text = "감정결과: \(result.document.sentiment)"
            self?.positiveLabel.text = "긍정비율: \(result.document.confidence.positive)"
            self?.negativeLabel.text = "부정비율: \(result.document.confidence.negative)"
            self?.neutralLabel.text = "중립비율: \(result.document.confidence.neutral)"
        }
    }
    
    private func handleAnalysisError() {
        print("Error occurred while analyzing sentiment")
    }
    
    // MARK: - CHAT GPT API
    
    private func requestChatAPI(prompt: String) {
        
        let message = Messages(role: "user", content: prompt)
        let request = ChatRequest(model: "gpt-3.5-turbo", messages: [message])
        
        chatProvider.request(.chat(request: request)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = try response.map(ChatResponse.self)
                    self.handleResult(result)
                } catch {
                    self.handleApiError()
                    print(error)
                }
            case let .failure(error):
                self.handleApiError()
                print(error)
            }
        }
    }
    
    private func handleResult(_ result: ChatResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.gptLabel.text = "Chat GPT 왈: \n" + result.resultText
        }
    }
    
    private func handleApiError() {
        print("Error occurred while calling ChatGPT API")
    }
}
