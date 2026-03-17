use quick_xml::Reader;
use quick_xml::events::Event;

fn main() {
    let xml = r#"<?xml version="1.0"?>
<!DOCTYPE root [<!ENTITY xxe SYSTEM "file:///etc/passwd">]>
<root>&xxe;</root>"#;
    let mut reader = Reader::from_str(xml);
    reader.trim_text(true);
    let mut buf = Vec::new();
    loop {
        match reader.read_event_into(&mut buf) {
            Ok(Event::Text(e)) => println!("{}", e.unescape().unwrap()),
            Ok(Event::Eof) => break,
            Err(e) => panic!("Error: {}", e),
            _ => (),
        }
        buf.clear();
    }
}
