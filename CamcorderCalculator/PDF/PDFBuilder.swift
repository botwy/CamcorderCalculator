import Foundation

public struct PDFBuilder {
	let author: String
	let title: String
    
    public init(author: String, title: String) {
        self.author = author
        self.title = title
    }
    
    private struct Topic {
        let title: String?
        let items: [String]
    }
    
    private var topics: [Topic] = []
    
    mutating func addTopic(title: String?, items: [String]) {
        let topic = Topic(title: title, items: items)
        topics.append(topic)
    }
    
    func buildPDF() -> PDF {
        let header = PDF.Header(header: title)
        var body: [ContentBlock] = []
        topics.forEach {
            if let listTitle = $0.title {
                body.append(PDF.ListHeader(text: listTitle))
            }
            for (index, listItem) in $0.items.enumerated() {
                let item = PDF.ListItem(text: listItem, preface: "\(index + 1). ", indentLevel: 2)
                body.append(item)
            }
        }
        let content = PDF.Content(header: header, footer: PDF.Footer(), body: body)
        let meta = PDF.Meta(author: author, title: title)
        return PDF(meta: meta, content: content)
    }
}
