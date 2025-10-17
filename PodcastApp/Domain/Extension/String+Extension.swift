import Foundation

extension String {
 
    func toAttributedText() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            // NSAttributedString correctly parses the HTML, including <p>, <br>, and <a> tags
            return try NSAttributedString(
                data: data,
                options: options,
                documentAttributes: nil
            )
        } catch {
            print("HTML parsing failed: \(error)")
            return NSAttributedString(string: self)
        }
    }
}
