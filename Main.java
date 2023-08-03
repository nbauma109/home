import org.w3c.tidy.Tidy;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;

public class Main {
    public static void main(String[] args) throws IOException {
        Path dir = Paths.get("path/to/your/directory"); // Replace with your directory path

        Tidy tidy = new Tidy();
        tidy.setXHTML(true); // Set output format to XHTML
        tidy.setIndentContent(true); // Indent the content
        tidy.setIndentAttributes(true); // Indent the attributes
        tidy.setPrintBodyOnly(true); // Only print the body content

        try (DirectoryStream<Path> stream = Files.newDirectoryStream(dir, "*.html")) { // Process only .html files
            for (Path entry : stream) {
                File file = entry.toFile();
                FileInputStream fis = new FileInputStream(file);
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

                tidy.parseDOM(fis, outputStream);

                String output = new String(outputStream.toByteArray(), StandardCharsets.UTF_8);

                // Write the output to a new file
                Files.write(Paths.get(file.getParent(), "processed_" + file.getName()), output.getBytes(StandardCharsets.UTF_8));
            }
        }
    }
}
