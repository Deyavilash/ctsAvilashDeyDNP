package factories;

import documents.*;
public class WordFactory extends DocumentFactory {
    public Document createDocument() {
        return new WordDocument();
    }
}
